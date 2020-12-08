
module ECE_178_Full_System (
		clk_clk,
		hex0_3_export,
		hex4_7_export,
		LEDR,
		LEDG,
		reset_reset,
		SW,
		KEY,
		DRAM_ADDR, 
		DRAM_BA,   
		DRAM_CAS_N,
		DRAM_CKE,  
		DRAM_CS_N, 
		DRAM_DQ,   
		DRAM_DQM,  
		DRAM_RAS_N,
		DRAM_WE_N,
		DRAM_CLK,
		GPIO,
		i_GPIO
	);	

		input              clk_clk;
		output      [31:0] hex0_3_export;
		output      [31:0] hex4_7_export;
		output      [17:0] LEDR;
		input              reset_reset;
		output wire [12:0] DRAM_ADDR;          //        sdram.addr
		output wire [1:0]  DRAM_BA;            //             .ba
		output wire        DRAM_CAS_N;         //             .cas_n
		output wire        DRAM_CKE;           //             .cke
		output wire        DRAM_CS_N;          //             .cs_n
		inout  wire [31:0] DRAM_DQ;            //             .dq
		output wire [3:0]  DRAM_DQM;           //             .dqm
		output wire        DRAM_RAS_N;         //             .ras_n
		output wire        DRAM_WE_N;          //             .we_n
		input  wire [17:0] SW;
		input  wire [3:0]  KEY;                //          key.export
		output wire        DRAM_CLK;           //    sdram_clk.clk
		output wire [8:0]  LEDG;               //         ledg.export	
		output wire [35:0] GPIO;
		input  wire [1:0]  i_GPIO;             //input gpio
		
		wire        [31:0] hexSet1;
		wire        [31:0] hexSet2;
		wire        [3:0]  KEYwire;
		wire               i_gpioWire;
		
		assign             hex0_3_export = ~hexSet1;
		assign             hex4_7_export = ~hexSet2;
		assign             KEYwire = ~KEY;
		assign             i_gpioWire = ~i_GPIO[0]; //invert 
		
		wire [15:0] to_decoder0,to_decoder1,to_decoder2,to_decoder3,to_decoder4,to_decoder5,to_decoder6,to_decoder7,to_decoder8;
		wire [15:0] to_decoder9,to_decoder10,to_decoder11,to_decoder12,to_decoder13,to_decoder14,to_decoder15;
		wire [10:0] from_decoder0,from_decoder1,from_decoder2,from_decoder3,from_decoder4,from_decoder5,from_decoder6,from_decoder7,from_decoder8;
		wire [10:0] from_decoder9,from_decoder10,from_decoder11,from_decoder12,from_decoder13,from_decoder14,from_decoder15;
		
		//custom modules
		
		UART_RX u1 (
		.i_Clock     (clk_clk),
		.i_RX_Serial (i_gpioWire),
		.o_RX_DV     (),
		.o_RX_Byte   (GPIO[17:10]),
		.o_SM_Main   (GPIO[35:33])
		);
		
		decode u2(
		.clk(clk_clk),
		
		.in0 (to_decoder0), 
		.in1 (to_decoder1), 
		.in2 (to_decoder2), 
		.in3 (to_decoder3), 
		.in4 (to_decoder4), 
		.in5 (to_decoder5), 
		.in6 (to_decoder6), 
		.in7 (to_decoder7), 
		.in8 (to_decoder8), 
		.in9 (to_decoder9), 
		.in10(to_decoder10),
		
		.out0 (from_decoder0), 
		.out1 (from_decoder1), 
		.out2 (from_decoder2), 
		.out3 (from_decoder3), 
		.out4 (from_decoder4),  
		.out5 (from_decoder5),  
		.out6 (from_decoder6),  
		.out7 (from_decoder7),  
		.out8 (from_decoder8),  
		.out9 (from_decoder9),  
		.out10(from_decoder10),
		.out11(from_decoder11),
		.out12(from_decoder12),
		.out13(from_decoder13),
		.out14(from_decoder14),
		.out15(from_decoder15),
		);
		
		ECE178_nios_20_1 u0 (
		.clk_clk             (clk_clk),       // clk.clk
		.hex0_3_export       (hexSet1),       // hex0_3.export
		.hex4_7_export       (hexSet2),       // hex4_7.export
		.ledr_export         (LEDR),          // ledr.export
		.reset_reset         (reset_reset),   // reset.reset_n
		.switches0_17_export (SW),            // switches0_17.export
		.key_export          (KEYwire),       // key.export
		.ledg_export         (LEDG),          // ledg.export
		.sdram_addr          (DRAM_ADDR ),    // sdram.addr
		.sdram_ba            (DRAM_BA   ),    //      .ba
		.sdram_cas_n         (DRAM_CAS_N),    //      .cas_n
		.sdram_cke           (DRAM_CKE  ),    //      .cke
		.sdram_cs_n          (DRAM_CS_N ),    //      .cs_n
		.sdram_dq            (DRAM_DQ   ),    //      .dq
		.sdram_dqm           (DRAM_DQM  ),    //      .dqm
		.sdram_ras_n         (DRAM_RAS_N),    //      .ras_n
		.sdram_we_n          (DRAM_WE_N ),    //      .we_n
		.sdram_clk_clk       (DRAM_CLK),      // sdram_clk.clk
		
		
		.sbus_decoder_channel_0_external_connection_export  (from_decoder0),  //  sbus_decoder_channel_0_external_connection.export
		.sbus_decoder_channel_1_external_connection_export  (from_decoder1),  //  sbus_decoder_channel_1_external_connection.export
		.sbus_decoder_channel_2_external_connection_export  (from_decoder2),  //  sbus_decoder_channel_2_external_connection.export
		.sbus_decoder_channel_3_external_connection_export  (from_decoder3),  //  sbus_decoder_channel_3_external_connection.export
		.sbus_decoder_channel_4_external_connection_export  (from_decoder4),  //  sbus_decoder_channel_4_external_connection.export
		.sbus_decoder_channel_5_external_connection_export  (from_decoder5),  //  sbus_decoder_channel_5_external_connection.export
		.sbus_decoder_channel_6_external_connection_export  (from_decoder6),  //  sbus_decoder_channel_6_external_connection.export
		.sbus_decoder_channel_7_external_connection_export  (from_decoder7),  //  sbus_decoder_channel_7_external_connection.export
		.sbus_decoder_channel_8_external_connection_export  (from_decoder8),  //  sbus_decoder_channel_8_external_connection.export
		.sbus_decoder_channel_9_external_connection_export  (from_decoder9),  //  sbus_decoder_channel_9_external_connection.export
		.sbus_decoder_channel_10_external_connection_export (from_decoder10), // sbus_decoder_channel_10_external_connection.export
		.sbus_decoder_channel_11_external_connection_export (from_decoder11), // sbus_decoder_channel_11_external_connection.export
		.sbus_decoder_channel_12_external_connection_export (from_decoder12), // sbus_decoder_channel_12_external_connection.export
		.sbus_decoder_channel_13_external_connection_export (from_decoder13), // sbus_decoder_channel_13_external_connection.export
		.sbus_decoder_channel_14_external_connection_export (from_decoder14), // sbus_decoder_channel_14_external_connection.export
		.sbus_decoder_channel_15_external_connection_export (from_decoder15), // sbus_decoder_channel_15_external_connection.export
				
		.sbus_decoder_reg_0_external_connection_export      (to_decoder0),      //      sbus_decoder_reg_0_external_connection.export
		.sbus_decoder_reg_1_external_connection_export      (to_decoder1),      //      sbus_decoder_reg_1_external_connection.export
		.sbus_decoder_reg_2_external_connection_export      (to_decoder2),      //      sbus_decoder_reg_2_external_connection.export
		.sbus_decoder_reg_3_external_connection_export      (to_decoder3),      //      sbus_decoder_reg_3_external_connection.export
		.sbus_decoder_reg_4_external_connection_export      (to_decoder4),      //      sbus_decoder_reg_4_external_connection.export
		.sbus_decoder_reg_5_external_connection_export      (to_decoder5),      //      sbus_decoder_reg_5_external_connection.export
		.sbus_decoder_reg_6_external_connection_export      (to_decoder6),      //      sbus_decoder_reg_6_external_connection.export
		.sbus_decoder_reg_7_external_connection_export      (to_decoder7),      //      sbus_decoder_reg_7_external_connection.export
		.sbus_decoder_reg_8_external_connection_export      (to_decoder8),      //      sbus_decoder_reg_8_external_connection.export
		.sbus_decoder_reg_9_external_connection_export      (to_decoder9),      //      sbus_decoder_reg_9_external_connection.export
		.sbus_decoder_reg_10_external_connection_export     (to_decoder10),     //     sbus_decoder_reg_10_external_connection.export
		
		.uart_0_external_connection_rxd              (i_gpioWire),              // uart_0_external_connection.rxd
		.uart_0_external_connection_txd              (GPIO[1])               //                           .txd
		
		);	
endmodule
