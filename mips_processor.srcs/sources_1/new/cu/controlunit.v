module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire [1:0]  jump_src,
        output wire [1:0]  reg_dst,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire [2:0]  rf_wd_src,
        output wire [2:0]  alu_ctrl,
        output wire        mul_en,
        output wire        shift_lr
    );
    
    wire [1:0] alu_op;
    wire [1:0] rf_wd;
    wire jump, jr;
    wire we_reg_md;
    
    assign we_reg = we_reg_md & ~jr;
    assign jump_src = {jr, jump};
    
    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .reg_dst        (reg_dst),
        .we_reg         (we_reg_md),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .rf_wd          (rf_wd),
        .alu_op         (alu_op)
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl),
        .rf_wd          (rf_wd),
        .rf_wd_src      (rf_wd_src),
        .shift_lr       (shift_lr),  
        .mul_en         (mul_en),
        .jr             (jr)
    );

endmodule