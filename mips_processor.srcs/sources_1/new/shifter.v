`timescale 1ns / 1ps
module shifter(
        input wire [31:0] s,
        input wire [4:0]shamt,
        input wire lr,
        output reg [31:0] y
    );
    
    always @(s, shamt, lr) begin
        if (lr) y = s >> shamt; 
        else y = s << shamt;
    end
endmodule
