`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 01:06:22 PM
// Design Name: 
// Module Name: fact_top
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


module fact_top(
    input wire clk,
    input wire rst,
    input wire [1:0] A,
    input wire WE,
    input wire [3:0] WD,
    output wire [31:0] RD
    );
    
    wire WE1, WE2;
    wire [1:0] Rdsel;
    wire [3:0] n;
    wire go, gopulse_cmb, gopulse;
    wire [31:0] nf, result;
    wire [2:0] CS;
    wire done, error;
    wire ResDone, ResError;
    wire [3:0] go_pad;
    
    assign gopulse_cmb = WD[0] & WE2;
    //assign go_pad = {3'b0, go};
    
    fact_ad fact_add_dec (
        .A          (A),
        .WE         (WE),
        .WE1        (WE1),
        .WE2        (WE2),
        .Rdsel      (Rdsel)
    
    );
    
    dreg_en #(4) n_reg (
        .clk        (clk),
        .rst        (rst),
        .en         (WE1),
        .d          (WD),
        .q          (n)
    );
    
    dreg_en #(1) go_reg (
        .clk        (clk),
        .rst        (rst),
        .en         (WE2),
        .d          (WD[0]),
        .q          (go)
    );
    
    dreg_en #(1) gopulse_reg (
        .clk        (clk),
        .rst        (rst),
        .en         (1'b1),
        .d          (gopulse_cmb),
        .q          (gopulse)
    );    
    
    factorial fact(
        .CLK        (clk),
        .Go         (gopulse), //gopulse
        .in         (n),
        .out        (nf),
        .CS         (CS),
        .Done       (done),
        .Error      (error)
    );
    
    SR_reg done_reg(
        .rst        (rst),
        .clk        (clk),
        .s          (done),
        .r          (gopulse_cmb),
        .q          (ResDone)
    
    );
    
    SR_reg error_reg(
        .rst        (rst),
        .clk        (clk),
        .s          (error),
        .r          (gopulse_cmb),
        .q          (ResError)
    
    ); 

    dreg_en #(32) result_reg (
        .clk        (clk),
        .rst        (rst),
        .en         (done),
        .d          (nf),
        .q          (result)
    );
    
    mux4 #(32) mux(
        .sel        (Rdsel),
        .a          ({28'b0,n}),
        .b          ({31'b0,go}),
        .c          ({30'b0,ResError, ResDone}),
        .d          (result),
        .y          (RD)
    );         
endmodule
