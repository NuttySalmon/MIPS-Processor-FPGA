`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2020 12:45:50 PM
// Design Name: 
// Module Name: tb_fact_top
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


module tb_fact_top;

    reg tb_clk, tb_rst;
    reg [1:0] tb_A;
    reg tb_WE;
    reg [3:0] tb_WD;
    wire [31:0] tb_RD; 
    
    fact_top DUT(
        .clk        (tb_clk),
        .rst        (tb_rst),
        .A          (tb_A),
        .WE         (tb_WE),
        .WD         (tb_WD),
        .RD         (tb_RD)  
    
        );
    task tick; 
    begin 
        tb_clk = 1'b0; #5;
        tb_clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        tb_rst = 1'b0; #5;
        tb_rst = 1'b1; #5;
        tb_rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
        tb_WE = 1'b1;
        tb_WD = 4'b0011;
        
        tb_A = 2'b00;
        tick;
        
        tb_A = 2'b01;
        tick;
        
        tb_A = 2'b10;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        
        tb_A = 2'b11;
        tick;

        
        
        $finish;
    end

endmodule
