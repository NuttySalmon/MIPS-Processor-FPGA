`timescale 1ns / 1ps
    
module mem_wb_reg(
        input  wire             clk,
        input  wire             rst,
        input  wire  [2:0]  rf_wd_src_2,
        input  wire  [31:0] pc_plus4_3,
        input  wire  [31:0] mul_lo_1,
        input  wire  [31:0] mul_hi_1,
        input  wire  [31:0] dmem_rd,
        input  wire  [31:0] alu_out_1,
        input  wire  [31:0] shift_out_1,
        input  wire  [4:0]  rf_wa_1,      
        input  wire         we_reg_2,
        output reg   [2:0]  rf_wd_src_3,
        output reg   [31:0] pc_plus4_wb,
        output reg   [31:0] mul_lo_wb,
        output reg   [31:0] mul_hi_wb,
        output reg   [31:0] dmem_wb,
        output reg   [31:0] alu_wb,
        output reg   [31:0] sl_wb,
        output reg   [4:0] rf_wa_2,
        output reg         we_reg_3         
);

    always @ (posedge clk) begin
        if (rst) begin
            rf_wd_src_3 <= 0;
            pc_plus4_wb <= 0;
            mul_lo_wb <= 0;
            mul_hi_wb <= 0;
            dmem_wb <= 0;
            alu_wb <= 0;
            sl_wb <= 0;
            rf_wa_2 <= 0;
        end
        else begin
            rf_wd_src_3 <= rf_wd_src_2;
            pc_plus4_wb <= pc_plus4_3;
            mul_lo_wb <= mul_lo_1;
            mul_hi_wb <= mul_hi_1;
            dmem_wb <= dmem_rd;
            alu_wb <= alu_out_1;
            sl_wb <= shift_out_1; //beware of 1 and l looking the same
            rf_wa_2 <= rf_wa_1;
            we_reg_3 <= we_reg_2;
        end
    end
endmodule