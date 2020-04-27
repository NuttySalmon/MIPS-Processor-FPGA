`timescale 1ns / 1ps

module SR_reg(
    input wire rst,
    input wire clk,
    input wire s,
    input wire r,
    output reg q
    
    );
    
    always @(posedge clk, posedge rst) begin
        if (rst) q <= 1'b0;
        else q <= (~r) & (s|q); //added ~
    end
endmodule
