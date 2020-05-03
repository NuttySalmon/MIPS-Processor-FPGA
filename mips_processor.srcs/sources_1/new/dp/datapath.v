module datapath (
//        input  wire        clk,
//        input  wire        rst,
        input  wire        branch,
        input  wire [1:0]  jump_src, 
        input  wire [1:0]  reg_dst, 
        input  wire        we_reg,
        input  wire        alu_src,
//        input  wire [2:0]  rf_wd_src,
        input  wire [2:0]  alu_ctrl,
//        input  wire [4:0]  ra3,
        input  wire [31:0] imem_instr,
//        input  wire [31:0] rd_dm,
        input  wire        mul_en, 
        input  wire        shift_lr, 
        output wire [31:0] pc_current,
//        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
//        output wire [31:0] rd3

          wire StallF, StallD, FlushE,
          wire fwd_ad, fwd_bd,
          wire [1:0] fwd_ae, fwd_be
    );

//    wire [4:0]  rf_wa;
//    wire        pc_src;
//    wire [31:0] pc_pre;

    wire [31:0] pc_plus4, pc_plus4_1, pc_plus_4_2;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
//    wire [31:0] ba;
//    wire [31:0] bta;
//    wire [31:0] jta;
//    wire [31:0] ad;
//    wire [31:0] bd;
//    wire [31:0] wd_rf;
//    wire        zero;
//    wire [31:0] mul_lo; 
//    wire [31:0] mul_hi; 
//    wire [31:0] shift_out;
    wire [4:0] rf_wa_2;
    wire we_reg_3;
    wire        beq;
    wire [31:0] rd1, rd1_1;
    wire [31:0] rd2, rd2_1;
    wire [31:0] instr, instr_2;
    wire [31:0] alu_out_1;
    wire [31:0] ad, bd;
    wire        we_dm_1;
    wire [2:0]  rf_wd_src_1;
    wire        mul_en_1;
    wire [31:0] sext_imm_2;
    wire        alu_src_1;
    wire [2:0]  alu_ctrl_1;
    wire        we_reg_1;
    wire        shift_lr_1;
    wire [1:0]  reg_dst_1;

    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- IF Logic --- //
    dreg_en pc_reg (
            .clk            (clk),
            .rst            (rst),
            .en             (~StallF),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
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
            .c              (rd2),
            .y              (pc_next)
        );
        
    if_id_reg if_id(
        .clk                (clk),
        .rst                (rst),
        .en                 (~StallD), 
        .pc_plus4           (pc_plus4),
        .imem_instr         (imem_instr),
        .pc_plus4_1         (pc_plus4_1),
        .instr              (instr)    
    
    );
    
    // --- ID --- //
    
    assign pc_src = beq & branch;
    assign ba = {sext_imm[29:0], 2'b00};
    
    adder pc_plus_br (
        .a              (pc_plus4_1),
        .b              (ba),
        .y              (bta)
    );
    
    regfile rf (
        .clk            (clk),
        .we             (we_reg_3),
        .ra1            (instr[25:21]),
        .ra2            (instr[20:16]),
        .ra3            (ra3),
        .wa             (rf_wa_2),
        .wd             (wd_rf),
        .rd1            (rd1),
        .rd2            (rd2),
        .rd3            (rd3)
    );
    
    mux2 #(32) fwd_ad_mux(
        .a(rd1),
        .b(alu_out_1),
        .y(ad),
        .sel(fwd_ad)
    );
    
    mux2 #(32) fwd_bd_mux(
        .a(rd2),
        .b(alu_out_1),
        .y(bd),
        .sel(fwd_bd)
    );
    
    signext se (
        .a              (instr[15:0]),
        .y              (sext_imm)
    );

    cmp_eq cmp (
       .a(ad),
       .b(bd),
       .y(beq)
    ); 
    
    id_exe_reg id_exe(
        .clk (clk),
        .rst         (rst || FlushE),
        .we_dm       (we_dm),
        .rf_wd_src   (rf_wd_src),
        .sext_imm    (sext_imm),
        .pc_plus4_1  (pc_plus4_1),
        .rd1(rd1), .rd2(rd2),
        .mul_en      (mul_en     ),
        .alu_src     (alu_src    ),
        .we_reg      (we_reg     ),
        .alu_ctrl    (alu_ctrl   ),
        .shift_lr    (shift_lr   ),
        .instr       (instr      ),
        .reg_dst     (reg_dst    ),
        .we_dm_1     (we_dm_1    ),
        .rf_wd_src_1 (rf_wd_src_1),
        .sext_imm_2  (sext_imm_2 ),
        .pc_plus4_2  (pc_plus4_2 ),
        .rd1_2       (rd1_2      ),
        .mul_en_1    (mul_en_1   ),
        .rd2_2       (rd2_2      ),
        .alu_src_1   (alu_src_1  ),
        .alu_ctrl_1  (alu_ctrl_1 ),
        .shift_lr_1  (shift_lr_1 ),
        .instr_2     (instr_2    ),
        .reg_dst_1   (reg_dst_1  ),
        .we_reg_1    (we_reg_1   )
    );         
    /*
    // --- EXE --- //
    
    mux3 #(5) rf_wa_mux (
        .sel            (reg_dst_1), 
        .a              (instr[20:16]),
        .b              (instr[15:11]),
        .c              ('d31),
        .y              (rf_wa)
    );                   
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
    
    multiplier mul( //changed add clock to picture?
        .clk            (clk),
        .en             (mul_en),
        .a              (alu_pa),
        .b              (wd_dm),
        .lo             (mul_lo),
        .hi             (mul_hi)   

    );
    
    shifter sl( 
            .s              (alu_pb),
            .shamt          (instr[10:6]),
            .lr             (shift_lr),
            .y              (shift_out)
    
        );
        
    mux3 #(32) fwd_ae_mux ( //added
            .sel            (fwd_ae_sel),
            .a              (alu_pa),//rd1
            .b              (rf_wa),//wa
            .c              (alu_out), //
            .y              (alu_pa)
        );
                
    mux3 #(32) fwd_be_mux ( //added
           .sel            (fwd_be_sel),
           .a              (wd_dm),//rd2
           .b              (rf_wa),//wa
           .c              (alu_out), //idk if right
           .y              (wd_dm)
       );
    /*
    
    
    
    
    // --- ALU Logic --- //


// --- MEM Logic --- // im here
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
        

                
 
   */
   endmodule 