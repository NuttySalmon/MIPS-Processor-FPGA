`timescale 1ns / 1ps

module id_exe_reg(

        input  wire             clk,
        input  wire             rst,
        input  wire             we_dm,
        input  wire [2:0]  rf_wd_src,
        input  wire [31:0] sext_imm,
        input  wire [31:0] pc_plus4_1,
        input  wire [31:0] rd1, rd2,
        input  wire             mul_en,
        input  wire             alu_src,
        input  wire             we_reg,
        input  wire [2:0]       alu_ctrl,
        input  wire             shift_lr,
        input  wire [31:0]      instr,
        input  wire [1:0]       reg_dst,
        output  reg             we_dm_1,
        output  reg [2:0]  rf_wd_src_1,
        output  reg [31:0] sext_imm_2,
        output  reg [31:0] pc_plus4_2,
        output  reg [31:0] rd1_1,
        output  reg             mul_en_1,
        output  reg [31:0] rd2_1,
        output  reg             alu_src_1,
        output  reg [2:0]       alu_ctrl_1,
        output  reg             shift_lr_1,
        output  reg [31:0] instr_2,
        output  reg [1:0]       reg_dst_1,
        output  reg             we_reg_1
    );
    
    always @ (posedge clk) begin
        if (rst) begin
            we_dm_1 <= 0; 
            rf_wd_src_1 <= 0;
            sext_imm_2 <= 0;
            pc_plus4_2 <= 0;
            rd1_1 <= 0;
            mul_en_1 <= 0;
            rd2_1 <= 0;
            alu_src_1 <= 0;
            alu_ctrl_1 <= 0;
            shift_lr_1 <= 0;
            instr_2 <= 0;
            reg_dst_1 <= 0;
            we_reg_1 <=0;
        end
        else begin 
            we_dm_1 <= we_dm; 
            rf_wd_src_1 <= rf_wd_src;
            sext_imm_2 <= sext_imm;
            pc_plus4_2 <= pc_plus4_1;
            rd1_1 <= rd1;
            mul_en_1 <= mul_en;
            rd2_1 <= rd2;
            alu_src_1 <= alu_src;
            alu_ctrl_1 <= alu_ctrl;
            shift_lr_1 <= shift_lr;
            instr_2 <= instr;
            reg_dst_1 <= reg_dst;  
            we_reg_1 <= we_reg;         
        end
    end    
endmodule