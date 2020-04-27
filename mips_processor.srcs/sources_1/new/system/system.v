module System (
        input          clk,
        input          rst,
        output         we_dm,
        input  [4:0]   ra3,
        output [31:0]  pc_current,
        output [31:0]  instr,
        output [31:0]  rw_addr,
        output [31:0]  w_data,
        output [31:0]  rd_dm,
        output [31:0]  rd3,
    
        input  wire [31:0] gpI1, gpI2,
        output wire [31:0] gpO1, gpO2
    );

    wire [31:0] DMemData, FactData, GPIO;
    wire we1, we2, wem;
    wire [1:0] rd_sel;
 
    mips mips (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .we_dm          (we_dm),
            .pc_current     (pc_current),
            .alu_out        (rw_addr),
            .wd_dm          (w_data),
            .rd3            (rd3)
        );
    
    AddressDecoder ad_dec(
            .a(rw_addr[11:2]),
            .we(we_dm),
            .we1(we1),
            .we2(we2),
            .wem(wem),
            .rd_sel(rd_sel)
        );

    imem imem (
            .a              (pc_current[7:2]),
            .y              (instr)
        );

    dmem dmem (
            .clk            (clk),
            .we             (wem),
            .a              (rw_addr[7:2]),
            .d              (w_data),
            .q              (DMemData)
        );
  
    fact_top fact (
            .rst            (rst),
            .clk            (clk),
            .WE             (we1),
            .A              (rw_addr[3:2]),
            .WD             (w_data[3:0]),
            .RD             (FactData)
        );
 
    GPIO gpio (
            .rst            (rst),
            .clk            (clk),
            .we             (we2),
            .A              (rw_addr[3:2]),
            .wd             (w_data),
            .rd             (GPIO),
            .gpI1           (gpI1),
            .gpI2           (gpI2),
            .gpO1           (gpO1),
            .gpO2           (gpO2)
        );
    
    mux4 #(32) mem_mux(
            .a              (DMemData),
            .b              (DMemData),
            .c              (FactData),
            .d              (GPIO),
            .y              (rd_dm),
            .sel            (rd_sel)
        );

endmodule