module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] imem_instr,
        input  wire [31:0] dmem_rd,
        output wire [31:0] pc_current,
        output wire [31:0] rd3,
        output wire [31:0] dmem_addr
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
    wire [2:0] rf_wd_src, rf_wd_src_1, rf_wd_src_2;
    wire dm2regE, dm2regM;
    wire [31:0] instrD, instrE;
    
    
    assign dm2regE = rf_wd_src_1 == 'b001 ? 1 : 0;
    assign dm2regM = rf_wd_src_2 == 'b001 ? 1 : 0;
    wire [4:0] rf_waE, rf_waM, rf_waW;
    wire we_regE;
    wire fwd_ad, fwd_bd; 
    wire [1:0] fwd_ae, fwd_be;

    datapath dp (
            .clk           (clk       ),  
            .rst           (rst       ),  
            .branch        (branch    ),  
            .jump_src      (jump_src  ),  
            .reg_dst       (reg_dst   ),  
            .we_reg(we_reg), .we_reg_1(we_regE), .we_reg_2(we_regM), .we_reg_3(we_regW),
            .alu_src       (alu_src   ),  
            .we_dm         (we_dm     ),  
            .rf_wd_src     (rf_wd_src ),
            .rf_wd_src_1    (rf_wd_src_1),  
            .rf_wd_src_2    (rf_wd_src_2),
            .alu_ctrl      (alu_ctrl  ),  
            .ra3           (ra3       ),  
            .imem_instr    (imem_instr), 
            .instrD        (instrD), 
            .instrE        (instrE),
            .mul_en        (mul_en    ),  
            .shift_lr      (shift_lr  ),  
            .dmem_rd       (dmem_rd   ),   
            .StallF(StallF),.StallD(StallD), .FlushE(FlushE),  
            .fwd_ad(fwd_ad), .fwd_bd(fwd_bd),          
            .fwd_ae(fwd_ae), .fwd_be(fwd_be),   
            .pc_current  (pc_current),     
            .alu_out     (alu_out ),     
            .wd_dm       (wd_dm   ),    
            .rd3         (rd3     ),     
            .dem_we      (dem_we  ),                 
            .dmem_wd     (dmem_wd ),
            .dmem_addr   (dmem_addr),
            .rf_wa(rf_waE), .rf_wa_1(rf_waM), .rf_wa_2(rf_waW)           
    );

    controlunit cu (
            .opcode         (instrD[31:26]),
            .funct          (instrD[5:0]),
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
    
    // --- Hazard Unit --- //
    hazard_unit HU(
        .we_regE(we_regE), .we_regM(we_regM), .we_regW(we_regW),
        .dm2regE(dm2regE), .dm2regM(dm2regM),
        .branchD(branch),
        .rsD(instrD[25:21]), .rtD(instrD[20:16]),
        .rsE(instrE[25:21]), .rtE(instrE[20:16]),
        .rf_waE(rf_waE), .rf_waM(rf_waM), .rf_waW(rf_waW), 
        .StallF   (StallF),
        .StallD   (StallD),        
        .FlushE   (FlushE),         
        .ForwardAD (fwd_ad),      
        .ForwardBD (fwd_bd),      
        .ForwardAE (fwd_ae), 
        .ForwardBE (fwd_be) 
    ); 
    
endmodule