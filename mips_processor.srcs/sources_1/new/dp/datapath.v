module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire [1:0]  jump_src, 
        input  wire [1:0]  reg_dst, 
        input  wire        we_reg,
        output wire we_reg_1, we_reg_2, we_reg_3,
        input  wire        alu_src,
        input  wire        we_dm,
        input  wire [2:0]  rf_wd_src,
        output wire [2:0]  rf_wd_src_1, rf_wd_src_2, rf_wd_src_3, 
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] imem_instr,
        input  wire [31:0] instrD, instrE,
        input  wire        mul_en, 
        input  wire        shift_lr, 
        input  wire [31:0] dmem_rd,
        input  wire StallF, StallD, FlushE,
        input  wire fwd_ad, fwd_bd,
        input   wire [1:0] fwd_ae, fwd_be,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] rd3,
        output wire [31:0] dmem_addr,
        output dmem_we,
        output [31:0] dmem_wd,
        output [4:0]  rf_wa, rf_wa_1, rf_wa_2
        //output [31:0] pc_plus4_1, instr, 
    );

    wire        pc_src;
    wire [31:0] pc_pre;

    wire [31:0] pc_plus4, pc_plus4_1, pc_plus4_2, pc_plus4_3, pc_plus4_4;
    wire [31:0] pc_next;
    wire [31:0] sext_imm, sext_imm_2;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] wd_rf;
    wire [31:0] mul_lo, mul_lo_1; 
    wire [31:0] mul_hi, mul_hi_1; 
    wire [31:0] shift_out, shift_out_1;
    wire        beq;
    wire [31:0] rd1, rd1_1;
    wire [31:0] rd2, rd2_1;
    wire [31:0] instr, instr_2;
    wire [31:0] ad, bd, ae, be;
    wire        we_dm_1;
    wire        mul_en_1;
    wire        alu_src_1;
    wire [2:0]  alu_ctrl_1;
    wire        shift_lr_1;
    wire [1:0]  reg_dst_1;
    wire [31:0] alu_out_1;
    wire [31:0] alu_pb;
    wire [31:0]  mul_lo_wb;
    wire [31:0]  mul_hi_wb;
    wire [31:0]  dmem_wb  ;
    wire [31:0]  alu_wb   ;
    wire [31:0]  sl_wb    ;
    wire [31:0]  ba;
    
    assign        dmem_addr = alu_out_1;
    assign        instrD = instr;
    assign        instrE = instr_2;
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
        .rd1_1       (rd1_1      ),
        .mul_en_1    (mul_en_1   ),
        .rd2_1       (rd2_1      ),
        .alu_src_1   (alu_src_1  ),
        .alu_ctrl_1  (alu_ctrl_1 ),
        .shift_lr_1  (shift_lr_1 ),
        .instr_2     (instr_2    ),
        .reg_dst_1   (reg_dst_1  ),
        .we_reg_1    (we_reg_1   )
    );         
    
    // --- EXE --- //
    
    mux3 #(5) rf_wa_mux (
        .sel            (reg_dst_1), 
        .a              (instr_2[20:16]),
        .b              (instr_2[15:11]),
        .c              ('d31),
        .y              (rf_wa)
    );                   
    mux2 #(32) alu_pb_mux (
        .sel            (alu_src_1),
        .a              (be),
        .b              (sext_imm_2),
        .y              (alu_pb)
    );
    
    alu alu (
        .op             (alu_ctrl_1),
        .a              (ae),
        .b              (alu_pb),
        .y              (alu_out)
    );
    
    multiplier mul(
        .a              (ae),
        .b              (be),
        .lo             (mul_lo),
        .hi             (mul_hi)   

    );
    
    shifter sl( 
            .s              (be),
            .shamt          (instr_2[10:6]),
            .lr             (shift_lr_1),
            .y              (shift_out)
    
        );
        
    mux3 #(32) fwd_ae_mux ( 
            .sel            (fwd_ae),
            .a              (rd1_1),
            .b              (wd_rf),
            .c              (alu_out_1),
            .y              (ae)
        );
                
    mux3 #(32) fwd_be_mux ( 
           .sel            (fwd_be),
           .a              (rd2_1),
           .b              (wd_rf),
           .c              (alu_out_1),
           .y              (be)
       );

    exe_mem_reg exe_mem(
      .dmem_we      (dmem_we),
      .mul_en       (mul_en     ),
      .clk          (clk        ),
      .rst          (rst        ),
      .we_reg_1     (we_reg_1   ),   
      .we_dm_1      (we_dm_1    ),
      .rf_wd_src_1  (rf_wd_src_1),   
      .pc_plus4_2   (pc_plus4_2 ),   
      .wd_dm        (be),
      .mul_lo       (mul_lo     ),   
      .mul_hi       (mul_hi     ), 
      .alu_out      (alu_out    ), 
      .shift_out    (shift_out  ),
      .rf_wa        (rf_wa      ),
      .rf_wd_src_2  (rf_wd_src_2),   
      .pc_plus4_3   (pc_plus4_3 ),
      .dmem_wd      (dmem_wd    ),   
      .mul_lo_1     (mul_lo_1   ),   
      .mul_hi_1     (mul_hi_1   ),   
      .alu_out_1    (alu_out_1  ),   
      .shift_out_1  (shift_out_1),   
      .rf_wa_1      (rf_wa_1    ),   
      .we_reg_2     (we_reg_2   )
    );

    // --- MEM --- //
    mem_wb_reg mem_wb(
        .clk         ( clk        ),
        .rst         ( rst        ),
        .rf_wd_src_2 ( rf_wd_src_2),
        .pc_plus4_3  ( pc_plus4_3 ),
        .mul_lo_1    ( mul_lo_1   ),
        .mul_hi_1    ( mul_hi_1   ),
        .dmem_rd     ( dmem_rd    ),
        .alu_out_1   ( alu_out_1  ),
        .shift_out_1 ( shift_out_1),
        .rf_wa_1     ( rf_wa_1    ),
        .we_reg_2    ( we_reg_2   ),
        .rf_wd_src_3 ( rf_wd_src_3),
        .pc_plus4_4  ( pc_plus4_4 ),
        .mul_lo_wb   ( mul_lo_wb  ),
        .mul_hi_wb   ( mul_hi_wb  ),
        .dmem_wb     ( dmem_wb    ),
        .alu_wb      ( alu_wb     ),
        .sl_wb       ( sl_wb      ),
        .rf_wa_2     ( rf_wa_2    ),
        .we_reg_3    ( we_reg_3   ) 
    );
    
       
     // --- wb --- // 
    mux6 #(32) rf_wd_mux (
            .sel            (rf_wd_src_3),
            .a              (alu_wb),
            .b              (dmem_wb),
            .c              (pc_plus4_wb),
            .d              (sl_wb),
            .e              (mul_lo_wb),
            .f              (mul_hi_wb),
            .y              (wd_rf)
    );
        


   endmodule 