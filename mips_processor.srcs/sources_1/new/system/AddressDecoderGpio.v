`timescale 1ns / 1ps
module AddressDecoderGpio(
       input [1:0] a,
       input we,
       output we1,
       output we2,
       output reg [1:0] rd_sel
   );
   
   reg [1:0] we_ctrl ;
   assign {we1, we2} = we_ctrl;

   always@(a, we) begin
       case (a)
           'h0: begin //gpI1 
                   rd_sel = 'b00; 
                   we_ctrl = 'b0_0;
                end
           'h1: begin //gpI2 
                   rd_sel = 'b01; 
                   we_ctrl = 'b0_0;
                end
           'h2: begin //gpO1 
                   rd_sel = 'b10; 
                   we_ctrl = we ? 'b1_0 : 'b0_0;
                end
           'h3: begin //gp02 
                   rd_sel = 'b11; 
                   we_ctrl = we ? 'b0_1 : 'b0_0;
                end
           default: begin 
                   rd_sel = 'b00; 
                   we_ctrl = 'b0_0; 
               end 
       endcase
   end
endmodule

