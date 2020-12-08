module decode (
		clk,
		
		in0,
		in1,
		in2,
		in3,
		in4,
		in5,
		in6,
		in7,
		in8,
		in9,
		in10,
		in11,
		in12,
		in13,
		in14,
		in15,
		
		out0,
		out1,
		out2,
		out3,
		out4,
		out5,
		out6,
		out7,
		out8,
		out9,
		out10,
		out11,
		out12,
		out13,
		out14,
		out15
		);

		input clk;
		input [15:0]in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15;
		
		output [10:0]out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15;
		
		reg [7:0]payload0; 
		reg [7:0]payload1; 
		reg [7:0]payload2; 
		reg [7:0]payload3; 
		reg [7:0]payload4; 
		reg [7:0]payload5; 
		reg [7:0]payload6; 
		reg [7:0]payload7; 
		reg [7:0]payload8; 
		reg [7:0]payload9; 
		reg [7:0]payload10;
		reg [7:0]payload11;
		reg [7:0]payload12;
		reg [7:0]payload13;
		reg [7:0]payload14;
		reg [7:0]payload15;
		reg [7:0]payload16;
		reg [7:0]payload17;
		reg [7:0]payload18;
		reg [7:0]payload19;
		reg [7:0]payload20;
		reg [7:0]payload21;
		
			
		always @(posedge clk) begin
		
			payload0  <= in0 [7:0] ;
			payload1  <= in0 [15:8];
			payload2  <= in1 [7:0] ;
			payload3  <= in1 [15:8];
			payload4  <= in2 [7:0] ;
			payload5  <= in2 [15:8];
			payload6  <= in3 [7:0] ;
			payload7  <= in3 [15:8];
			payload8  <= in4 [7:0] ;
			payload9  <= in4 [15:8];
			payload10 <= in5 [7:0] ;
			payload11 <= in5 [15:8];
			payload12 <= in6 [7:0] ;
			payload13 <= in6 [15:8];
			payload14 <= in7 [7:0] ;
			payload15 <= in7 [15:8];
			payload16 <= in8 [7:0] ;
			payload17 <= in8 [15:8];
			payload18 <= in9 [7:0] ;
			payload19 <= in9 [15:8];
			payload20 <= in10[7:0] ;
			payload21 <= in10[15:8];
			//only uses 11 registers if we have 2 bytes in each register
			
		end
		
		assign out0 =   payload0        | (payload1  << 8);
		assign out1 =  (payload1 >> 3)  | (payload2  << 5);
		assign out2 =  (payload2 >> 6)  | (payload3  << 2) | (payload4 << 10);
		assign out3 =  (payload4 >> 1)  | (payload5  << 7);
		assign out4 =  (payload5 >> 4)  | (payload6  << 4);
		assign out5 =  (payload6 >> 7)  | (payload7  << 1) | (payload8 << 9);
		assign out6 =  (payload8 >> 2)  | (payload9  << 6);
		assign out7 =  (payload9 >> 5)  | (payload10 << 3);
		assign out8 =   payload11       | (payload12 << 8);
		assign out9 =  (payload12 >> 3) | (payload13 << 5);
		assign out10 = (payload13 >> 6) | (payload14 << 2) | (payload15 << 10);
		assign out11 = (payload15 >> 1) | (payload16 << 7);
		assign out12 = (payload16 >> 4) | (payload17 << 4);
		assign out13 = (payload17 >> 7) | (payload18 << 1) | (payload19 << 9);
		assign out14 = (payload19 >> 2) | (payload20 << 6);
		assign out15 = (payload20 >> 5) | (payload21 << 3);
		
endmodule
