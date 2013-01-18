
// Copyright (c) 2013 Nokia, Inc.

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

import NrccSyncBRAM::*;
import BRAMFIFO::*;
import GetPut::*;
import FIFOF::*;
import Vector::*;
import SpecialFIFOs::*;
import AxiMasterSlave::*;
import FrameBuffer::*;

Integer bytesperpixel = 4;

interface FrameBufferBram;
    method Bool running();
    method Bit#(32) base();
    method Action configure(FrameBufferConfig fbc);
    method Action startFrame();
    method Action startLine();
    method Action setSgEntry(Bit#(6) index, Bit#(24) startingOffset, Bit#(20) address, Bit#(20) length);
    method ActionValue#(Bit#(96)) reading();
    interface AxiMasterRead#(64) axir;
    interface AxiMasterWrite#(64,8) axiw;
    interface BRAM#(Bit#(12), Bit#(64)) buffer;
endinterface

typedef struct {
    Bit#(24) startingOffset;
    Bit#(24) limitOffset;
    Bit#(20) address; // these are page aligned, so 12 bits of zeros
    Bit#(20) length;
}  ScatterGather deriving (Bits);

module mkFrameBufferBram#(Clock displayClk, Reset displayRst)(FrameBufferBram);
    Reg#(FrameBufferConfig) nextFbc <- mkReg(FrameBufferConfig {base: 0, lines: 0, pixels: 0, stridebytes: 0});
    Reg#(FrameBufferConfig) fbc <- mkReg(FrameBufferConfig {base: 0, lines: 0, pixels: 0, stridebytes: 0});
    Reg#(Bool) runningReg <- mkReg(False);
    Reg#(Bool) traceReadingReg <- mkReg(False);

    let burstCount = 16;
    let bytesPerWord = 8;
    let busWidth = bytesPerWord * 8;
    let bytesPerPixel = 4;
    let pixelsPerWord = bytesPerWord / bytesPerPixel;

    Reg#(Bit#(7))  sglistIndexReg <- mkReg(0); // which segment we're reading from
    Reg#(Bit#(24)) lineAddrReg <- mkReg(0); // address of start of line
    Reg#(Bit#(24)) readAddrReg <- mkReg(0); // next address to read
    Reg#(Bit#(24)) readLimitReg <- mkReg(0); // address of end of line

    Reg#(Bit#(24)) segmentLimitReg <- mkReg(0);
    Reg#(Bit#(32)) segmentOffsetReg <- mkReg(0);

    Reg#(Bit#(12)) pixelCountReg <- mkReg(0);
    Reg#(Bit#(11)) lineCountReg <- mkReg(0);
    
    Vector#(64, Reg#(ScatterGather)) sglist <- replicateM(mkReg(unpack(0)));

    AxiMaster#(64,8) nullAxiMaster <- mkNullAxiMaster();

    Clock clk <- exposeCurrentClock ;
    Reset rst <- exposeCurrentReset ;
    SyncBRAM#(Bit#(12), Bit#(64)) syncBRAM <- mkSyncBRAM( 4096, displayClk, displayRst, clk, rst );
    //SyncBRAM#(Bit#(12), Bit#(64)) syncBRAM <- mkSimSyncBRAM( 4096, displayClk, displayRst, clk, rst );
    Reg#(Bit#(12)) pixelCountReg2 <- mkReg(0);
    Reg#(Maybe#(Bit#(96))) readingReg <- mkReg(tagged Invalid);

    rule nextent if (readAddrReg != 24'hFFFFFF && readAddrReg > segmentLimitReg);
        $display("nextent readAddrReg %h segmentLimitReg %h", readAddrReg, segmentLimitReg);
        let index = sglistIndexReg+1;
        let sgent = sglist[index];
        sglistIndexReg <= index;
        let segmentOffset = {sgent.address,12'd0} - extend(sgent.startingOffset);
        let segmentLimit = sgent.limitOffset;
        segmentOffsetReg <= segmentOffset;
        segmentLimitReg <= segmentLimit;

        Bit#(96) reading;
        reading[95:64] = segmentOffset;
        reading[63:32] = extend(readAddrReg);
        reading[31:0] = {extend(index), segmentLimit};
        readingReg <= tagged Valid reading;
    endrule

    method Bool running();
        return runningReg;
    endmethod

    method Bit#(32) base();
        return fbc.base;
    endmethod

    method ActionValue#(Bit#(96)) reading() if (traceReadingReg &&& readingReg matches tagged Valid .value);
        readingReg <= tagged Invalid;
        return value;
    endmethod

    method Action configure(FrameBufferConfig newConfig);
        nextFbc <= newConfig;
        traceReadingReg <= True;
    endmethod

    method Action setSgEntry(Bit#(6) index, Bit#(24) startingOffset, Bit#(20) address, Bit#(20) length);
        ScatterGather newEnt = ScatterGather { 
            startingOffset: startingOffset,
            address:  address,
            length:  length,
            limitOffset: startingOffset + truncate({length,12'd0})
        };
        $display("setSgEntry startingOffset %d address %d length %h limitOffset %h",
                 startingOffset, address, length, startingOffset + {length,4'd0});
        sglist[index] <= newEnt;
    endmethod

    method Action startFrame();
        fbc <= nextFbc;
        Bit#(7) segmentIndex = truncate(nextFbc.base);
        ScatterGather sgent = sglist[segmentIndex];
        sglistIndexReg <= segmentIndex;
        let segmentOffset = {sgent.address,12'd0} - extend(sgent.startingOffset);
        let segmentLimit = sgent.limitOffset;
        segmentOffsetReg <= segmentOffset;
        segmentLimitReg <= segmentLimit;
        $display("startFrame address %h startingOffset %h segmentOffset %h readLimit %h",
                 {sgent.address,12'd0}, sgent.startingOffset,
                 segmentOffset,
                 sgent.startingOffset + extend(nextFbc.stridebytes));

        lineAddrReg <= sgent.startingOffset;
        readAddrReg <= 24'hFFFFFF; // indicates have not received first hsync pulse
        readLimitReg <= sgent.startingOffset + extend(nextFbc.stridebytes);
        lineCountReg <= nextFbc.lines;
        pixelCountReg <= nextFbc.pixels;

        Bit#(96) reading;
        reading[95:64] = segmentOffset;
        reading[63:32] = extend(24'hFFFFFF);
        reading[31:0] = { extend(segmentIndex), segmentIndex };
        readingReg <= tagged Valid reading;

        runningReg <= True;
    endmethod

    method Action startLine();
        if (runningReg)
        begin
            let lineAddr = lineAddrReg;
            let readLimit = readLimitReg;
            let lineCount = lineCountReg;
            if (readAddrReg != 24'hFFFFFF) // if not the first line
            begin
                lineAddr = lineAddr + extend(fbc.stridebytes);
                readLimit = readLimit + extend(fbc.stridebytes);
                lineCount = lineCount - 1;
            end
            $display("startLine readAddr %h readLimit %h stridebytes %h", lineAddr, readLimit, fbc.stridebytes);

            lineAddrReg <= lineAddr;
            readAddrReg <= lineAddr;
            readLimitReg <= readLimit;
            lineCountReg <= lineCount;

            if (readAddrReg == 24'hFFFFFF)
            begin
                Bit#(96) reading;
                reading[95:64] = segmentOffsetReg;
                reading[63:32] = extend(lineAddr);
                reading[31:0] = extend(segmentLimitReg);
                readingReg <= tagged Valid reading;
            end

            pixelCountReg2 <= 0;

            if (lineCount == 0)
            begin
                runningReg <= False;
                traceReadingReg <= False;
            end
        end
    endmethod

   interface AxiMasterRead axir;
       method ActionValue#(Bit#(32)) readAddr() if (runningReg
                                                    && readAddrReg != 24'hFFFFFF
                                                    && readAddrReg < readLimitReg
                                                    && readAddrReg <= segmentLimitReg
                                                    );
           Bit#(32) addr = extend(readAddrReg) + segmentOffsetReg;
           // $display("readAddr %h %h", readAddrReg, addr);
           readAddrReg <= readAddrReg + burstCount*bytesPerWord;
           return addr;
       endmethod
       method Bit#(8) readBurstLen();
           return burstCount-1;
       endmethod
       method Bit#(3) readBurstWidth();
           if (busWidth == 32)
               return 3'b010; // 3'b010: 32bit, 3'b011: 64bit, 3'b100: 128bit
           else if (busWidth == 64)
               return 3'b011;
           else
               return 3'b100;
       endmethod
       method Bit#(2) readBurstType();  // drive with 2'b01
           return 2'b01;
       endmethod
       method Bit#(3) readBurstProt(); // drive with 3'b000
           return 3'b000;
       endmethod
       method Bit#(4) readBurstCache(); // drive with 4'b0011
           return 4'b0011;
       endmethod
       method Bit#(1) readId();
           return 0;
       endmethod
       method Action readData(Bit#(64) data, Bit#(2) resp, Bit#(1) last, Bit#(1) id);
           let newPixelCount = pixelCountReg2 + pixelsPerWord;
           pixelCountReg2 <= newPixelCount;

           syncBRAM.portB.write(pixelCountReg2 / pixelsPerWord, data);
       endmethod
   endinterface

   interface AxiMasterWrite axiw = nullAxiMaster.write;
   interface NrccBRAM buffer = syncBRAM.portA;
endmodule
