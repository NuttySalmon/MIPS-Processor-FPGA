`timescale 1ns / 1ps

module GPIO(
    input wire clk,
    input wire rst,
    input wire we,
    input wire [1:0] A,
    input wire [31:0]gpI1,
    input wire [31:0]gpI2,
    input wire [31:0] wd,
    output wire [31:0] rd,
    output wire [31:0] gpO1,
    output wire [31:0] gpO2
    );
    
    wire we1, we2;
    wire [1:0] rd_sel;
    
    AddressDecoderGpio gpio_ad (
        .a          (A),
        .we         (we),
        .we1        (we1),
        .we2        (we2),
        .rd_sel      (rd_sel)
    );       
            
    dreg_en #(32) dreg_gpio (
        .clk        (clk),
        .rst        (rst),
        .en         (we1),
        .d          (wd),
        .q          (gpO1)
    );
       
    dreg_en #(32) dreg_gpio2 (
        .clk        (clk),
        .rst        (rst),
        .en         (we2),
        .d          (wd),
        .q          (gpO2)
    );
        
    mux4 #(32) gpio_mux(
        .a          (gpI1),
        .b          (gpI2),
        .c          (gpO1),
        .d          (gpO2),
        .y          (rd),
        .sel        (rd_sel)                 
    );         
    
endmodule
