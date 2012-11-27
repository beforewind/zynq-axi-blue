//
// Generated by Bluespec Compiler, version 2012.10.beta2 (build 29674, 2012-10.10)
//
// On Mon Nov 26 14:32:59 EST 2012
//
// Method conflict info:
// Method: put
// Conflict-free: error,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
// Sequenced after: get
// Sequenced after (restricted): interrupt, axi_writeAddr
// Conflicts: put
//
// Method: get
// Conflict-free: get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
// Sequenced before: put
//
// Method: error
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
// Method: interrupt
// Conflict-free: get,
// 	       error,
// 	       interrupt,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
// Sequenced before (restricted): put, axi_writeAddr
//
// Method: axi_writeAddr
// Conflict-free: get,
// 	       error,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeDataByteEnable,
// 	       axi_writeResponse
// Sequenced before (restricted): put, axi_writeData
// Sequenced after: axi_writeBurstLen, axi_writeLastDataBeat
// Sequenced after (restricted): interrupt
// Conflicts: axi_writeAddr
//
// Method: axi_writeBurstLen
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
// Sequenced before: axi_writeAddr
// Sequenced before (restricted): axi_writeData
//
// Method: axi_writeBurstWidth
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
// Method: axi_writeBurstType
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
// Method: axi_writeBurstProt
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
// Method: axi_writeBurstCache
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
// Method: axi_writeData
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeDataByteEnable,
// 	       axi_writeResponse
// Sequenced after (restricted): axi_writeAddr,
// 			      axi_writeBurstLen,
// 			      axi_writeLastDataBeat
// Conflicts: axi_writeData
//
// Method: axi_writeDataByteEnable
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
// Method: axi_writeLastDataBeat
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
// Sequenced before: axi_writeAddr
// Sequenced before (restricted): axi_writeData
//
// Method: axi_writeResponse
// Conflict-free: put,
// 	       get,
// 	       error,
// 	       interrupt,
// 	       axi_writeAddr,
// 	       axi_writeBurstLen,
// 	       axi_writeBurstWidth,
// 	       axi_writeBurstType,
// 	       axi_writeBurstProt,
// 	       axi_writeBurstCache,
// 	       axi_writeData,
// 	       axi_writeDataByteEnable,
// 	       axi_writeLastDataBeat,
// 	       axi_writeResponse
//
//
// Ports:
// Name                         I/O  size props
// RDY_put                        O     1 reg
// get                            O    32
// RDY_get                        O     1 const
// error                          O     1 const
// RDY_error                      O     1 const
// interrupt                      O     1
// RDY_interrupt                  O     1 const
// axi_writeAddr                  O    32 reg
// RDY_axi_writeAddr              O     1
// axi_writeBurstLen              O     8 reg
// RDY_axi_writeBurstLen          O     1 const
// axi_writeBurstWidth            O     3 const
// RDY_axi_writeBurstWidth        O     1 const
// axi_writeBurstType             O     2 const
// RDY_axi_writeBurstType         O     1 const
// axi_writeBurstProt             O     3 const
// RDY_axi_writeBurstProt         O     1 const
// axi_writeBurstCache            O     4 const
// RDY_axi_writeBurstCache        O     1 const
// axi_writeData                  O    32 reg
// RDY_axi_writeData              O     1 reg
// axi_writeDataByteEnable        O     4 const
// RDY_axi_writeDataByteEnable    O     1 const
// axi_writeLastDataBeat          O     1
// RDY_axi_writeLastDataBeat      O     1 const
// RDY_axi_writeResponse          O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_addr                       I    12
// put_v                          I    32
// get_addr                       I    12
// axi_writeResponse_responseCode  I     2 unused
// EN_put                         I     1
// EN_axi_writeResponse           I     1 unused
// EN_get                         I     1 unused
// EN_axi_writeAddr               I     1
// EN_axi_writeData               I     1
//
// Combinational paths from inputs to outputs:
//   get_addr -> get
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkIpSlaveWithMaster(CLK,
			   RST_N,

			   put_addr,
			   put_v,
			   EN_put,
			   RDY_put,

			   get_addr,
			   EN_get,
			   get,
			   RDY_get,

			   error,
			   RDY_error,

			   interrupt,
			   RDY_interrupt,

			   EN_axi_writeAddr,
			   axi_writeAddr,
			   RDY_axi_writeAddr,

			   axi_writeBurstLen,
			   RDY_axi_writeBurstLen,

			   axi_writeBurstWidth,
			   RDY_axi_writeBurstWidth,

			   axi_writeBurstType,
			   RDY_axi_writeBurstType,

			   axi_writeBurstProt,
			   RDY_axi_writeBurstProt,

			   axi_writeBurstCache,
			   RDY_axi_writeBurstCache,

			   EN_axi_writeData,
			   axi_writeData,
			   RDY_axi_writeData,

			   axi_writeDataByteEnable,
			   RDY_axi_writeDataByteEnable,

			   axi_writeLastDataBeat,
			   RDY_axi_writeLastDataBeat,

			   axi_writeResponse_responseCode,
			   EN_axi_writeResponse,
			   RDY_axi_writeResponse);
  input  CLK;
  input  RST_N;

  // action method put
  input  [11 : 0] put_addr;
  input  [31 : 0] put_v;
  input  EN_put;
  output RDY_put;

  // actionvalue method get
  input  [11 : 0] get_addr;
  input  EN_get;
  output [31 : 0] get;
  output RDY_get;

  // value method error
  output error;
  output RDY_error;

  // value method interrupt
  output interrupt;
  output RDY_interrupt;

  // actionvalue method axi_writeAddr
  input  EN_axi_writeAddr;
  output [31 : 0] axi_writeAddr;
  output RDY_axi_writeAddr;

  // value method axi_writeBurstLen
  output [7 : 0] axi_writeBurstLen;
  output RDY_axi_writeBurstLen;

  // value method axi_writeBurstWidth
  output [2 : 0] axi_writeBurstWidth;
  output RDY_axi_writeBurstWidth;

  // value method axi_writeBurstType
  output [1 : 0] axi_writeBurstType;
  output RDY_axi_writeBurstType;

  // value method axi_writeBurstProt
  output [2 : 0] axi_writeBurstProt;
  output RDY_axi_writeBurstProt;

  // value method axi_writeBurstCache
  output [3 : 0] axi_writeBurstCache;
  output RDY_axi_writeBurstCache;

  // actionvalue method axi_writeData
  input  EN_axi_writeData;
  output [31 : 0] axi_writeData;
  output RDY_axi_writeData;

  // value method axi_writeDataByteEnable
  output [3 : 0] axi_writeDataByteEnable;
  output RDY_axi_writeDataByteEnable;

  // value method axi_writeLastDataBeat
  output axi_writeLastDataBeat;
  output RDY_axi_writeLastDataBeat;

  // action method axi_writeResponse
  input  [1 : 0] axi_writeResponse_responseCode;
  input  EN_axi_writeResponse;
  output RDY_axi_writeResponse;

  // signals for module outputs
  wire [31 : 0] axi_writeAddr, axi_writeData, get;
  wire [7 : 0] axi_writeBurstLen;
  wire [3 : 0] axi_writeBurstCache, axi_writeDataByteEnable;
  wire [2 : 0] axi_writeBurstProt, axi_writeBurstWidth;
  wire [1 : 0] axi_writeBurstType;
  wire RDY_axi_writeAddr,
       RDY_axi_writeBurstCache,
       RDY_axi_writeBurstLen,
       RDY_axi_writeBurstProt,
       RDY_axi_writeBurstType,
       RDY_axi_writeBurstWidth,
       RDY_axi_writeData,
       RDY_axi_writeDataByteEnable,
       RDY_axi_writeLastDataBeat,
       RDY_axi_writeResponse,
       RDY_error,
       RDY_get,
       RDY_interrupt,
       RDY_put,
       axi_writeLastDataBeat,
       error,
       interrupt;

  // register interrupted
  reg interrupted;
  wire interrupted$D_IN, interrupted$EN;

  // register thresholdEdgeDetected
  reg thresholdEdgeDetected;
  wire thresholdEdgeDetected$D_IN, thresholdEdgeDetected$EN;

  // ports of submodule fifoToAxi
  wire [31 : 0] fifoToAxi$axi_writeAddr,
		fifoToAxi$axi_writeData,
		fifoToAxi$base__read,
		fifoToAxi$base__write_1,
		fifoToAxi$bounds__read,
		fifoToAxi$bounds__write_1,
		fifoToAxi$enq_value,
		fifoToAxi$threshold__read,
		fifoToAxi$threshold__write_1;
  wire [7 : 0] fifoToAxi$axi_writeBurstLen;
  wire [3 : 0] fifoToAxi$axi_writeBurstCache,
	       fifoToAxi$axi_writeDataByteEnable;
  wire [2 : 0] fifoToAxi$axi_writeBurstProt, fifoToAxi$axi_writeBurstWidth;
  wire [1 : 0] fifoToAxi$axi_writeBurstType,
	       fifoToAxi$axi_writeResponse_responseCode;
  wire fifoToAxi$EN_axi_writeAddr,
       fifoToAxi$EN_axi_writeData,
       fifoToAxi$EN_axi_writeResponse,
       fifoToAxi$EN_base__write,
       fifoToAxi$EN_bounds__write,
       fifoToAxi$EN_enq,
       fifoToAxi$EN_threshold__write,
       fifoToAxi$RDY_axi_writeAddr,
       fifoToAxi$RDY_axi_writeData,
       fifoToAxi$RDY_enq,
       fifoToAxi$aboveThreshold,
       fifoToAxi$axi_writeLastDataBeat;

  // ports of submodule rf
  wire [31 : 0] rf$D_IN, rf$D_OUT_1, rf$D_OUT_2;
  wire [11 : 0] rf$ADDR_1,
		rf$ADDR_2,
		rf$ADDR_3,
		rf$ADDR_4,
		rf$ADDR_5,
		rf$ADDR_IN;
  wire rf$WE;

  // rule scheduling signals
  wire WILL_FIRE_RL_fifoAboveThreshold, WILL_FIRE_RL_fifoBelowThreshold;

  // inputs to muxes for submodule ports
  wire MUX_interrupted$write_1__SEL_1;

  // remaining internal signals
  reg [31 : 0] CASE_get_addr_0x5A5ABEEF_0x10_fifoToAxibase___ETC__q1;
  wire put_addr_ULT_0x10___d10;

  // action method put
  assign RDY_put = fifoToAxi$RDY_enq ;

  // actionvalue method get
  assign get =
	     (get_addr < 12'h010) ?
	       rf$D_OUT_2 :
	       CASE_get_addr_0x5A5ABEEF_0x10_fifoToAxibase___ETC__q1 ;
  assign RDY_get = 1'd1 ;

  // value method error
  assign error = 1'd0 ;
  assign RDY_error = 1'd1 ;

  // value method interrupt
  assign interrupt = rf$D_OUT_1[0] && interrupted ;
  assign RDY_interrupt = 1'd1 ;

  // actionvalue method axi_writeAddr
  assign axi_writeAddr = fifoToAxi$axi_writeAddr ;
  assign RDY_axi_writeAddr = fifoToAxi$RDY_axi_writeAddr ;

  // value method axi_writeBurstLen
  assign axi_writeBurstLen = fifoToAxi$axi_writeBurstLen ;
  assign RDY_axi_writeBurstLen = 1'd1 ;

  // value method axi_writeBurstWidth
  assign axi_writeBurstWidth = fifoToAxi$axi_writeBurstWidth ;
  assign RDY_axi_writeBurstWidth = 1'd1 ;

  // value method axi_writeBurstType
  assign axi_writeBurstType = fifoToAxi$axi_writeBurstType ;
  assign RDY_axi_writeBurstType = 1'd1 ;

  // value method axi_writeBurstProt
  assign axi_writeBurstProt = fifoToAxi$axi_writeBurstProt ;
  assign RDY_axi_writeBurstProt = 1'd1 ;

  // value method axi_writeBurstCache
  assign axi_writeBurstCache = fifoToAxi$axi_writeBurstCache ;
  assign RDY_axi_writeBurstCache = 1'd1 ;

  // actionvalue method axi_writeData
  assign axi_writeData = fifoToAxi$axi_writeData ;
  assign RDY_axi_writeData = fifoToAxi$RDY_axi_writeData ;

  // value method axi_writeDataByteEnable
  assign axi_writeDataByteEnable = fifoToAxi$axi_writeDataByteEnable ;
  assign RDY_axi_writeDataByteEnable = 1'd1 ;

  // value method axi_writeLastDataBeat
  assign axi_writeLastDataBeat = fifoToAxi$axi_writeLastDataBeat ;
  assign RDY_axi_writeLastDataBeat = 1'd1 ;

  // action method axi_writeResponse
  assign RDY_axi_writeResponse = 1'd1 ;

  // submodule fifoToAxi
  mkFifoToAxi fifoToAxi(.CLK(CLK),
			.RST_N(RST_N),
			.axi_writeResponse_responseCode(fifoToAxi$axi_writeResponse_responseCode),
			.base__write_1(fifoToAxi$base__write_1),
			.bounds__write_1(fifoToAxi$bounds__write_1),
			.enq_value(fifoToAxi$enq_value),
			.threshold__write_1(fifoToAxi$threshold__write_1),
			.EN_base__write(fifoToAxi$EN_base__write),
			.EN_bounds__write(fifoToAxi$EN_bounds__write),
			.EN_threshold__write(fifoToAxi$EN_threshold__write),
			.EN_axi_writeAddr(fifoToAxi$EN_axi_writeAddr),
			.EN_axi_writeData(fifoToAxi$EN_axi_writeData),
			.EN_axi_writeResponse(fifoToAxi$EN_axi_writeResponse),
			.EN_enq(fifoToAxi$EN_enq),
			.RDY_base__write(),
			.base__read(fifoToAxi$base__read),
			.RDY_base__read(),
			.RDY_bounds__write(),
			.bounds__read(fifoToAxi$bounds__read),
			.RDY_bounds__read(),
			.RDY_threshold__write(),
			.threshold__read(fifoToAxi$threshold__read),
			.RDY_threshold__read(),
			.aboveThreshold(fifoToAxi$aboveThreshold),
			.RDY_aboveThreshold(),
			.notEmpty(),
			.RDY_notEmpty(),
			.notFull(),
			.RDY_notFull(),
			.axi_writeAddr(fifoToAxi$axi_writeAddr),
			.RDY_axi_writeAddr(fifoToAxi$RDY_axi_writeAddr),
			.axi_writeBurstLen(fifoToAxi$axi_writeBurstLen),
			.RDY_axi_writeBurstLen(),
			.axi_writeBurstWidth(fifoToAxi$axi_writeBurstWidth),
			.RDY_axi_writeBurstWidth(),
			.axi_writeBurstType(fifoToAxi$axi_writeBurstType),
			.RDY_axi_writeBurstType(),
			.axi_writeBurstProt(fifoToAxi$axi_writeBurstProt),
			.RDY_axi_writeBurstProt(),
			.axi_writeBurstCache(fifoToAxi$axi_writeBurstCache),
			.RDY_axi_writeBurstCache(),
			.axi_writeData(fifoToAxi$axi_writeData),
			.RDY_axi_writeData(fifoToAxi$RDY_axi_writeData),
			.axi_writeDataByteEnable(fifoToAxi$axi_writeDataByteEnable),
			.RDY_axi_writeDataByteEnable(),
			.axi_writeLastDataBeat(fifoToAxi$axi_writeLastDataBeat),
			.RDY_axi_writeLastDataBeat(),
			.RDY_axi_writeResponse(),
			.RDY_enq(fifoToAxi$RDY_enq));

  // submodule rf
  RegFile #(.addr_width(32'd12),
	    .data_width(32'd32),
	    .lo(12'd0),
	    .hi(12'hFFF)) rf(.CLK(CLK),
			     .ADDR_1(rf$ADDR_1),
			     .ADDR_2(rf$ADDR_2),
			     .ADDR_3(rf$ADDR_3),
			     .ADDR_4(rf$ADDR_4),
			     .ADDR_5(rf$ADDR_5),
			     .ADDR_IN(rf$ADDR_IN),
			     .D_IN(rf$D_IN),
			     .WE(rf$WE),
			     .D_OUT_1(rf$D_OUT_1),
			     .D_OUT_2(rf$D_OUT_2),
			     .D_OUT_3(),
			     .D_OUT_4(),
			     .D_OUT_5());

  // rule RL_fifoAboveThreshold
  assign WILL_FIRE_RL_fifoAboveThreshold =
	     !thresholdEdgeDetected && fifoToAxi$aboveThreshold ;

  // rule RL_fifoBelowThreshold
  assign WILL_FIRE_RL_fifoBelowThreshold =
	     thresholdEdgeDetected && !fifoToAxi$aboveThreshold ;

  // inputs to muxes for submodule ports
  assign MUX_interrupted$write_1__SEL_1 =
	     EN_put && put_addr == 12'h0 && put_v[0] ;

  // register interrupted
  assign interrupted$D_IN = !MUX_interrupted$write_1__SEL_1 ;
  assign interrupted$EN =
	     EN_put && put_addr == 12'h0 && put_v[0] ||
	     WILL_FIRE_RL_fifoAboveThreshold ;

  // register thresholdEdgeDetected
  assign thresholdEdgeDetected$D_IN = !WILL_FIRE_RL_fifoBelowThreshold ;
  assign thresholdEdgeDetected$EN =
	     WILL_FIRE_RL_fifoBelowThreshold ||
	     WILL_FIRE_RL_fifoAboveThreshold ;

  // submodule fifoToAxi
  assign fifoToAxi$axi_writeResponse_responseCode =
	     axi_writeResponse_responseCode ;
  assign fifoToAxi$base__write_1 = put_v ;
  assign fifoToAxi$bounds__write_1 = put_v ;
  assign fifoToAxi$enq_value = put_v ;
  assign fifoToAxi$threshold__write_1 = put_v ;
  assign fifoToAxi$EN_base__write =
	     EN_put && !put_addr_ULT_0x10___d10 && put_addr == 12'h010 ;
  assign fifoToAxi$EN_bounds__write =
	     EN_put && !put_addr_ULT_0x10___d10 && put_addr == 12'h014 ;
  assign fifoToAxi$EN_threshold__write =
	     EN_put && !put_addr_ULT_0x10___d10 && put_addr == 12'h018 ;
  assign fifoToAxi$EN_axi_writeAddr = EN_axi_writeAddr ;
  assign fifoToAxi$EN_axi_writeData = EN_axi_writeData ;
  assign fifoToAxi$EN_axi_writeResponse = EN_axi_writeResponse ;
  assign fifoToAxi$EN_enq =
	     EN_put && !put_addr_ULT_0x10___d10 && put_addr != 12'h010 &&
	     put_addr != 12'h014 &&
	     put_addr != 12'h018 ;

  // submodule rf
  assign rf$ADDR_1 = 12'h004 ;
  assign rf$ADDR_2 = get_addr ;
  assign rf$ADDR_3 = 12'h0 ;
  assign rf$ADDR_4 = 12'h0 ;
  assign rf$ADDR_5 = 12'h0 ;
  assign rf$ADDR_IN = put_addr ;
  assign rf$D_IN = put_v ;
  assign rf$WE = EN_put && put_addr_ULT_0x10___d10 ;

  // remaining internal signals
  assign put_addr_ULT_0x10___d10 = put_addr < 12'h010 ;
  always@(get_addr or
	  fifoToAxi$base__read or
	  fifoToAxi$bounds__read or fifoToAxi$threshold__read)
  begin
    case (get_addr)
      12'h010:
	  CASE_get_addr_0x5A5ABEEF_0x10_fifoToAxibase___ETC__q1 =
	      fifoToAxi$base__read;
      12'h014:
	  CASE_get_addr_0x5A5ABEEF_0x10_fifoToAxibase___ETC__q1 =
	      fifoToAxi$bounds__read;
      12'h018:
	  CASE_get_addr_0x5A5ABEEF_0x10_fifoToAxibase___ETC__q1 =
	      fifoToAxi$threshold__read;
      default: CASE_get_addr_0x5A5ABEEF_0x10_fifoToAxibase___ETC__q1 =
		   32'h5A5ABEEF;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        interrupted <= `BSV_ASSIGNMENT_DELAY 1'd0;
	thresholdEdgeDetected <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (interrupted$EN)
	  interrupted <= `BSV_ASSIGNMENT_DELAY interrupted$D_IN;
	if (thresholdEdgeDetected$EN)
	  thresholdEdgeDetected <= `BSV_ASSIGNMENT_DELAY
	      thresholdEdgeDetected$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    interrupted = 1'h0;
    thresholdEdgeDetected = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkIpSlaveWithMaster
