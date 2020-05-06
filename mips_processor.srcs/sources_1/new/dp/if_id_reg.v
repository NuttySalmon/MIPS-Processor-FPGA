`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2020 01:46:29 PM
// Design Name: 
// Module Name: if_id_reg
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


module if_id_reg(

        input  wire             clk,
        input  wire             rst,
        input  wire             en,
        input  wire [31:0] pc_plus4,
        input  wire [31:0] imem_instr,
        output reg  [31:0] pc_plus4_1,
        output reg  [31:0] instr
    );
    
    always @ (posedge clk) begin
        if (rst) begin
            pc_plus4_1 <= 0; instr <= 0;
        end
        else if (en) begin
            pc_plus4_1 <= pc_plus4; instr <= imem_instr;
        end
        else begin 
            pc_plus4_1 <= pc_plus4_1; instr <= instr;
        end
    end    
endmodule
