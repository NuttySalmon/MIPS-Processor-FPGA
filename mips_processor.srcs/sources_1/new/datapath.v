module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire [1:0]  jump_src, //changed
        input  wire [1:0]  reg_dst, //changed
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire [2:0]  rf_wd_src, //changed
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        input  wire        mul_en, //changed
        input  wire        shift_lr, //changed
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );

    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire        zero;
    wire [31:0] mul_lo; //changed
    wire [31:0] mul_hi; //changed
    wire [31:0] shift_out; //changed
    
    assign pc_src = branch & zero;
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux3 #(32) pc_jmp_mux ( //changed
            .sel            (jump_src),
            .a              (pc_pre),
            .b              (jta),
            .c              (alu_pa),
            .y              (pc_next)
        );

    // --- RF Logic --- //
    mux3 #(5) rf_wa_mux ( //changed
            .sel            (reg_dst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .c              ('d31),
            .y              (rf_wa)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (rf_wa),
            .wd             (wd_rf),
            .rd1            (alu_pa),
            .rd2            (wd_dm),
            .rd3            (rd3)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            .a              (wd_dm),
            .b              (sext_imm),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrl),
            .a              (alu_pa),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out)
        );

    // --- MEM Logic --- //
    mux6 #(32) rf_wd_mux ( //changed
            .sel            (rf_wd_src),
            .a              (alu_out),
            .b              (rd_dm),
            .c              (pc_plus4),
            .d              (shift_out),
            .e              (mul_lo),
            .f              (mul_hi),
            .y              (wd_rf)
        );
        
    multiplier mul( //changed
            .clk            (clk),
            .en             (mul_en),
            .a              (alu_pa),
            .b              (wd_dm),
            .lo             (mul_lo),
            .hi             (mul_hi)   
    
        );
    
    shifter sl( //changed
            .s              (alu_pb),
            .shamt          (instr[10:6]),
            .lr             (shift_lr),
            .y              (shift_out)
    
        );

endmodule