module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    wire       branch;
    wire [1:0] jump_src; //changed
    wire [1:0] reg_dst; //changed
    wire       we_reg;
    wire       alu_src;
    wire [2:0] rf_wd_src;
    wire [2:0] alu_ctrl;
    wire       shift_lr; //changed
    wire       mul_en; //changed
    wire [2:0] rf_wd_src; //changed

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .jump_src       (jump_src),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .rf_wd_src      (rf_wd_src), //changed
            .alu_ctrl       (alu_ctrl),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3),
            .mul_en         (mul_en), // changed
            .shift_lr       (shift_lr) //changed
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .branch         (branch),
            .jump_src       (jump_src),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .rf_wd_src      (rf_wd_src),
            .alu_ctrl       (alu_ctrl),
            .shift_lr       (shift_lr),
            .mul_en         (mul_en)
        );

endmodule