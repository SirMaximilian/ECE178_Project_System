/////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
// Modified by Gilbert Barr
/////////////////////////////////////////////////////////////////////
// This file contains the UART Receiver.  This receiver is able to
// receive 8 bits of serial data, one start bit, one stop bit,
// and no parity bit.  When receive is complete o_rx_dv will be
// driven high for one clock cycle.
// 
// Set Parameter CLKS_PER_BIT as follows:
// CLKS_PER_BIT = (Frequency of i_Clock)/(Frequency of UART)
// Example: 25 MHz Clock, 115200 baud UART
// (25000000)/(115200) = 217
// (50000000)/(100000) = 500
 
module UART_RX
  #(parameter CLKS_PER_BIT = 500,
	parameter DATA_BITS    = 9)
  (
   input        i_Clock,
   input        i_RX_Serial,
   output       o_RX_DV,
   output [7:0] o_RX_Byte,
   output [2:0] o_SM_Main,
	output [3:0] o_Bit_Index
   );
   
  parameter IDLE          = 3'b010;
  parameter RX_START_BIT  = 3'b001;
  parameter RX_DATA_BITS  = 3'b111;
  parameter RX_PARITY_BIT = 3'b011;
  parameter RX_STOP_BIT_1 = 3'b100;
  parameter RX_STOP_BIT_2 = 3'b101;
  parameter CLEANUP       = 3'b110;
  
  reg [7:0]     r_Clock_Count = 0;
  reg [3:0]     r_Bit_Index   = 0; //8 bits total + parity
  reg [DATA_BITS-1:0]     r_RX_Byte     = 0;
  reg           r_RX_DV       = 0;
  reg [2:0]     r_SM_Main     = 0;
  
  
  // Purpose: Control RX state machine
  always @(posedge i_Clock)
  begin
      
    case (r_SM_Main)
      IDLE :
        begin
          r_RX_DV       <= 1'b0;
          r_Clock_Count <= 0;
          r_Bit_Index   <= 0;
          
          if (i_RX_Serial == 1'b0)          // Start bit detected
            r_SM_Main <= RX_START_BIT;
          else
            r_SM_Main <= IDLE;
        end
      
      // Check middle of start bit to make sure it's still low
      RX_START_BIT :
        begin
          if (r_Clock_Count == (CLKS_PER_BIT-1)/2)
          begin
            if (i_RX_Serial == 1'b0)
            begin
              r_Clock_Count <= 0;  // reset counter, found the middle
              r_SM_Main     <= RX_DATA_BITS;
            end
            else
              r_SM_Main <= IDLE;
          end
          else
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= RX_START_BIT;
          end
        end // case: RX_START_BIT
      
      
      // Wait CLKS_PER_BIT-1 clock cycles to sample serial data
      RX_DATA_BITS :
        begin
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= RX_DATA_BITS;
          end
          else
          begin
            r_Clock_Count          <= 0;
            r_RX_Byte[r_Bit_Index] <= i_RX_Serial;
            
            // Check if we have received all bits
            if (r_Bit_Index < DATA_BITS-1)
            begin
              r_Bit_Index <= r_Bit_Index + 1;
              r_SM_Main   <= RX_DATA_BITS;
            end
            else
            begin
              r_Bit_Index <= 0;
              r_SM_Main   <= RX_STOP_BIT_1;
            end
          end
        end // case: RX_DATA_BITS
      
      
      // Receive Stop bit 1.  Stop bit = 1
      RX_STOP_BIT_1 :
        begin
          // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
     	    r_SM_Main     <= RX_STOP_BIT_1;
          end
          else
          begin
       	    r_RX_DV       <= 1'b0;
            r_Clock_Count <= 0;
            r_SM_Main     <= RX_STOP_BIT_2;
          end
        end // case: RX_STOP_BIT_1
      
	  // Receive Stop bit 2.  Stop bit = 1
      RX_STOP_BIT_2 :
        begin
          // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
     	    r_SM_Main     <= RX_STOP_BIT_2;
          end
          else
          begin
       	    r_RX_DV       <= 1'b1;
            r_Clock_Count <= 0;
            r_SM_Main     <= CLEANUP;
          end
        end // case: RX_STOP_BIT_2
      
      // Stay here 1 clock
      CLEANUP :
        begin
          r_SM_Main <= IDLE;
          r_RX_DV   <= 1'b0;
        end
      
      
      default :
        r_SM_Main <= IDLE;
      
    endcase
  end    
  
  assign o_RX_DV   = r_RX_DV;
  assign o_RX_Byte = r_RX_Byte;
  assign o_SM_Main = r_SM_Main;
  assign o_Bit_Index = r_Bit_Index;
  
endmodule // UART_RX
