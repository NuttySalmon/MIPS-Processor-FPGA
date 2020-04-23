`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 01:05:45 PM
// Design Name: 
// Module Name: ad_dec
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ad_dec(
        input [0:9] a,
        input we,
        output we1,
        output we2,
        output wem,
        output reg [1:0] rd_sel
    );
    
    reg [2:0] we_ctrl ;
    assign {we1, we2, wem} = we_ctrl;
 
    always@(a, we) begin
        case (a[9:6])
            'h0: begin //dmem
                    rd_sel = 'b00; 
                    we_ctrl = we ? 'b1_0_0 : 'b0_0_0;
                 end
            'h8: begin //factorial acc
                    rd_sel = 'b10; 
                    we_ctrl = we ? 'b0_1_0 : 'b0_0_0;
                 end
            'h9: begin  //gpio
                    rd_sel = 'b11;
                    we_ctrl = we ? 'b0_0_1 : 'b0_0_0;
                 end
            default: begin 
                    rd_sel = 'b00; 
                    we_ctrl = 'b0_0_0; 
                end 
        endcase
    end
endmodule
