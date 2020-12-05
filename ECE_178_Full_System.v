
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
	DRAM_CLK);	

	input		       clk_clk;
	output	[31:0]	   hex0_3_export;
	output	[31:0]	   hex4_7_export;
	output	[17:0]	   LEDR;
	input			   reset_reset;
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
	input  wire [3:0]  KEY;          //          key.export
    output wire        DRAM_CLK;       //    to --> sdram_clk.clk
    output wire [8:0]  LEDG;         //         ledg.export	
	
	wire [31:0]hexSet1;
	wire [31:0]hexSet2;
	wire [3:0] KEYwire;
	assign hex0_3_export = ~hexSet1;
	assign hex4_7_export = ~hexSet2;
	assign KEYwire = ~KEY;

		ECE178_nios_20_1 u0 (
		.clk_clk             (clk_clk),       // clk.clk
		.hex0_3_export       (hexSet1),       // hex0_3.export
		.hex4_7_export       (hexSet2),       // hex4_7.export
		.ledr_export         (LEDR),          // ledr.export
		.reset_reset       (reset_reset),     // reset.reset_n
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
		.sdram_clk_clk       (DRAM_CLK)       // sdram_clk.clk
		
		.slave_user_interface_user_dataout_0_export  (<connected-to-slave_user_interface_user_dataout_0_export>),  // slave_user_interface.user_dataout_0_export
        .slave_user_interface_user_dataout_1_export  (<connected-to-slave_user_interface_user_dataout_1_export>),  //                     .user_dataout_1_export
        .slave_user_interface_user_dataout_2_export  (<connected-to-slave_user_interface_user_dataout_2_export>),  //                     .user_dataout_2_export
        .slave_user_interface_user_dataout_3_export  (<connected-to-slave_user_interface_user_dataout_3_export>),  //                     .user_dataout_3_export
        .slave_user_interface_user_dataout_4_export  (<connected-to-slave_user_interface_user_dataout_4_export>),  //                     .user_dataout_4_export
        .slave_user_interface_user_dataout_5_export  (<connected-to-slave_user_interface_user_dataout_5_export>),  //                     .user_dataout_5_export
        .slave_user_interface_user_dataout_6_export  (<connected-to-slave_user_interface_user_dataout_6_export>),  //                     .user_dataout_6_export
        .slave_user_interface_user_dataout_7_export  (<connected-to-slave_user_interface_user_dataout_7_export>),  //                     .user_dataout_7_export
        .slave_user_interface_user_dataout_8_export  (<connected-to-slave_user_interface_user_dataout_8_export>),  //                     .user_dataout_8_export
        .slave_user_interface_user_dataout_9_export  (<connected-to-slave_user_interface_user_dataout_9_export>),  //                     .user_dataout_9_export
        .slave_user_interface_user_dataout_10_export (<connected-to-slave_user_interface_user_dataout_10_export>), //                     .user_dataout_10_export
        .slave_user_interface_user_dataout_11_export (<connected-to-slave_user_interface_user_dataout_11_export>), //                     .user_dataout_11_export
        .slave_user_interface_user_dataout_12_export (<connected-to-slave_user_interface_user_dataout_12_export>), //                     .user_dataout_12_export
        .slave_user_interface_user_dataout_13_export (<connected-to-slave_user_interface_user_dataout_13_export>), //                     .user_dataout_13_export
        .slave_user_interface_user_dataout_14_export (<connected-to-slave_user_interface_user_dataout_14_export>), //                     .user_dataout_14_export
        .slave_user_interface_user_dataout_15_export (<connected-to-slave_user_interface_user_dataout_15_export>), //                     .user_dataout_15_export
        .slave_user_interface_user_datain_0_export   (<connected-to-slave_user_interface_user_datain_0_export>),   //                     .user_datain_0_export
        .slave_user_interface_user_datain_1_export   (<connected-to-slave_user_interface_user_datain_1_export>),   //                     .user_datain_1_export
        .slave_user_interface_user_datain_2_export   (<connected-to-slave_user_interface_user_datain_2_export>),   //                     .user_datain_2_export
        .slave_user_interface_user_datain_3_export   (<connected-to-slave_user_interface_user_datain_3_export>),   //                     .user_datain_3_export
        .slave_user_interface_user_datain_4_export   (<connected-to-slave_user_interface_user_datain_4_export>),   //                     .user_datain_4_export
        .slave_user_interface_user_datain_5_export   (<connected-to-slave_user_interface_user_datain_5_export>),   //                     .user_datain_5_export
        .slave_user_interface_user_datain_6_export   (<connected-to-slave_user_interface_user_datain_6_export>),   //                     .user_datain_6_export
        .slave_user_interface_user_datain_7_export   (<connected-to-slave_user_interface_user_datain_7_export>),   //                     .user_datain_7_export
        .slave_user_interface_user_datain_8_export   (<connected-to-slave_user_interface_user_datain_8_export>),   //                     .user_datain_8_export
        .slave_user_interface_user_datain_9_export   (<connected-to-slave_user_interface_user_datain_9_export>),   //                     .user_datain_9_export
        .slave_user_interface_user_datain_10_export  (<connected-to-slave_user_interface_user_datain_10_export>),  //                     .user_datain_10_export
        .slave_user_interface_user_datain_11_export  (<connected-to-slave_user_interface_user_datain_11_export>),  //                     .user_datain_11_export
        .slave_user_interface_user_datain_12_export  (<connected-to-slave_user_interface_user_datain_12_export>),  //                     .user_datain_12_export
        .slave_user_interface_user_datain_13_export  (<connected-to-slave_user_interface_user_datain_13_export>),  //                     .user_datain_13_export
        .slave_user_interface_user_datain_14_export  (<connected-to-slave_user_interface_user_datain_14_export>),  //                     .user_datain_14_export
        .slave_user_interface_user_datain_15_export  (<connected-to-slave_user_interface_user_datain_15_export>),  //                     .user_datain_15_export
        .slave_user_interface_user_write_export      (<connected-to-slave_user_interface_user_write_export>),      //                     .user_write_export
        .slave_user_interface_user_read_export       (<connected-to-slave_user_interface_user_read_export>),       //                     .user_read_export
        .slave_user_interface_user_chipselect_export (<connected-to-slave_user_interface_user_chipselect_export>), //                     .user_chipselect_export
		
	);	
endmodule
