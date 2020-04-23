`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 12:57:56 PM
// Design Name: 
// Module Name: SR_reg
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


module SR_reg(
    input wire rst,
    input wire clk,
    input wire s,
    input wire r,
    output reg q
    
    );
    
    always @(posedge clk, posedge rst) begin
        if (rst) q <= 1'b0;
        else q <= (r) & (s|q);
    end
endmodule
