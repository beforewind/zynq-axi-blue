
// Copyright (c) 2012 Nokia, Inc.

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import FIFOF::*;
import BRAMFIFO::*;
import Clocks::*;
import GetPut::*;
import Connectable::*;

import TypesAndInterfaces::*;
import AxiMasterSlave::*;
import HDMI::*;
import Timer::*;
import FrameBuffer::*;
import FrameBufferBram::*;
import YUV::*;

function Put#(item_t) syncFifoToPut( SyncFIFOIfc#(item_t) f);
    return (
        interface Put
            method Action put (item_t item);
                f.enq(item);
            endmethod
        endinterface
    );
endfunction

module mkDUT#(Clock hdmi_clk)(DUT);

    let busWidthBytes=8;

    Reg#(Bit#(32)) vsyncPulseCountReg <- mkReg(0);
    Reg#(Bit#(32)) frameCountReg <- mkReg(0);

    Reg#(Bool) waitingForVsync <- mkReg(False);
    Reg#(Bool) sendVsyncIndication <- mkReg(False);

    Clock clock <- exposeCurrentClock;
    Reset reset <- exposeCurrentReset;

    Reset hdmi_reset <- mkAsyncReset(2, reset, hdmi_clk);

    Reg#(Bit#(11)) linesReg <- mkReg(1080);
    Reg#(Bit#(12)) pixelsReg <- mkReg(1920);
    Reg#(Bit#(14)) strideBytesReg <- mkReg(1920*4);

    SyncPulseIfc vsyncPulse <- mkSyncHandshake(hdmi_clk, hdmi_reset, clock);
    SyncPulseIfc hsyncPulse <- mkSyncHandshake(hdmi_clk, hdmi_reset, clock);
    //SyncFIFOIfc#(Yuv422) yuv422Fifo <- mkSyncFIFOFromCC(2, hdmi_clk);
    SyncFIFOIfc#(Bit#(64)) rgbrgbFifo <- mkSyncFIFOFromCC(4, hdmi_clk);
    SyncFIFOIfc#(HdmiCommand) commandFifo <- mkSyncFIFOFromCC(2, hdmi_clk);

    Reg#(Bit#(8)) segmentIndexReg <- mkReg(0);
    Reg#(Bit#(24)) segmentOffsetReg <- mkReg(0);
    FIFOF#(Bit#(96)) translationEntryFifo <- mkFIFOF();

    Reg#(Bool) frameBufferEnabled <- mkReg(False);
    FrameBufferBram frameBuffer <- mkFrameBufferBram(hdmi_clk, hdmi_reset);

    HdmiTestPatternGenerator hdmiTpg <- mkHdmiTestPatternGenerator(clocked_by hdmi_clk, reset_by hdmi_reset,
                                                                   commandFifo, frameBuffer.buffer,
                                                                   vsyncPulse, hsyncPulse);

    (* descending_urgency = "vsync, hsync" *)
    rule vsync if (vsyncPulse.pulse());
        $display("vsync pulse received %h", frameBufferEnabled);
        vsyncPulseCountReg <= vsyncPulseCountReg + 1;
        if (waitingForVsync)
        begin
            waitingForVsync <= False;
            sendVsyncIndication <= True;
        end
        if (frameBufferEnabled)
        begin
            $display("frame started");
            frameCountReg <= frameCountReg + 1;
            frameBuffer.startFrame();
        end
    endrule
    rule hsync if (hsyncPulse.pulse());
        frameBuffer.startLine();
    endrule

    method Action setPatternReg(Bit#(32) yuv422);
        commandFifo.enq(tagged PatternColor {yuv422: yuv422});
    endmethod
    method Action hdmiLinesPixels(Bit#(32) value);
        linesReg <= value[10:0];
        pixelsReg <= value[27:16];
        commandFifo.enq(tagged LinesPixels {value: value});
    endmethod
    method Action hdmiStrideBytes(Bit#(32) value);
        strideBytesReg <= value[13:0];
    endmethod
    method Action hdmiBlankLinesPixels(Bit#(32) value);
        commandFifo.enq(tagged BlankLinesPixels {value: value});
    endmethod
    method Action hdmiLineCountMinMax(Bit#(32) value);
        commandFifo.enq(tagged LineCountMinMax {value: value});
    endmethod
    method Action hdmiPixelCountMinMax(Bit#(32) value);
        commandFifo.enq(tagged PixelCountMinMax {value: value});
    endmethod
    method Action hdmiSyncWidths(Bit#(32) value);
        commandFifo.enq(tagged SyncWidths {value: value});
    endmethod

    method Action startFrameBuffer(Bit#(32) base);
        $display("startFrameBuffer %h", base);
        frameBufferEnabled <= True;
        FrameBufferConfig fbc;
        fbc.base = base;
        fbc.pixels = pixelsReg;
        fbc.lines = linesReg;
        Bit#(14) stridebytes = strideBytesReg;
        $display("startFrameBuffer lines %d pixels %d bytesperpixel %d stridebytes %d",
                 linesReg, pixelsReg, bytesperpixel, stridebytes);
        fbc.stridebytes = stridebytes;
        frameBuffer.configure(fbc);
        commandFifo.enq(tagged TestPattern {enabled: False});
        waitingForVsync <= True;
    endmethod

    method Action waitForVsync(Bit#(32) unused);
        waitingForVsync <= True;
    endmethod

    method ActionValue#(Bit#(32)) vsyncReceived() if (sendVsyncIndication);
        sendVsyncIndication <= False;
        return vsyncPulseCountReg;
    endmethod

    method Action beginTranslationTable(Bit#(8) index);
        segmentIndexReg <= index;
        segmentOffsetReg <= 0;
    endmethod
    method Action addTranslationEntry(Bit#(20) address, Bit#(12) length);
        frameBuffer.setSgEntry(segmentIndexReg, segmentOffsetReg, address, extend(length));
        segmentIndexReg <= segmentIndexReg + 1;
        segmentOffsetReg <= segmentOffsetReg + {length,12'd0};
        Bit#(96) entry;
        entry[95:64] = extend(address);
        entry[63:32] = extend(segmentOffsetReg);
        entry[31:0] = extend(length);        
        translationEntryFifo.enq(entry);
    endmethod
    method ActionValue#(Bit#(96)) translationTableEntry();
        translationEntryFifo.deq();
        return translationEntryFifo.first();
    endmethod
    method ActionValue#(Bit#(96)) fbReading() if (False);
        let v <- frameBuffer.reading();
        return v;
    endmethod

    interface AxiMasterWrite axiw0 = frameBuffer.axiw;
    interface AxiMasterWrite axir0 = frameBuffer.axir;
    interface HDMI hdmi = hdmiTpg.hdmi;
endmodule
