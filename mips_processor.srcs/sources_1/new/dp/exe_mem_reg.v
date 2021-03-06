`timescale 1ns / 1ps

module exe_mem_reg(
        input wire             mul_en,
        input  wire             clk,
        input  wire             rst,
        input  wire        we_reg_1,
        input  wire             we_dm_1, 
        input  wire [2:0]  rf_wd_src_1,
        input  wire [31:0] pc_plus4_2,
        input  wire [31:0]     wd_dm,
        input  wire [31:0] mul_lo,
        input  wire [31:0] mul_hi,
        input wire  [31:0] instr_2,
        input  wire [31:0] alu_out,
        input  wire [31:0] shift_out,
        input  wire [4:0] rf_wa,  
        output reg  [2:0]  rf_wd_src_2,
        output reg  [31:0] pc_plus4_3,
        output reg  [31:0] dmem_wd,
        output reg  [31:0] mul_lo_1,
        output reg  [31:0] mul_hi_1,
        output reg  [31:0] alu_out_1,
        output reg  [31:0] shift_out_1,
        output reg  [4:0] rf_wa_1,
        output reg  dmem_we,
        output reg we_reg_2
);
    wire [5:0] op, func;
    assign op = instr_2[31:26];
    assign func = instr_2[5:0];
 
    always @ (posedge clk) begin
        if (rst) begin
            rf_wd_src_2 <= 0;
            pc_plus4_3 <= 0;
            dmem_we <= 0;
            dmem_wd <= 0;
            mul_lo_1 <= 0;
            mul_hi_1 <= 0;
            alu_out_1 <= 0;
            shift_out_1 <= 0;
            rf_wa_1 <= 0;
            we_reg_2 <= 0;
        end
        else begin
            rf_wd_src_2 <= rf_wd_src_1;
            pc_plus4_3 <= pc_plus4_2;
            dmem_we <= we_dm_1;
            dmem_wd <= wd_dm;
            alu_out_1 <= op == 0 && (func == 0 || func == 2) ? shift_out : alu_out ;
            shift_out_1 <= shift_out;
            rf_wa_1 <= rf_wa;
            we_reg_2 <= we_reg_1;
            if(mul_en) begin
                mul_lo_1 <= mul_lo;
                mul_hi_1 <= mul_hi;
            end
            else begin
                mul_hi_1 <= mul_hi_1;
                mul_lo_1 <= mul_lo_1;
            end
        end
    end
endmodule