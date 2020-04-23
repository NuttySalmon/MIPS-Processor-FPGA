module fpga_top (
        input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire [4:0] switches,
        output wire       we_dm,
        output wire [4:0] ld,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );
    
    wire [31:0] gpO1, gpO2;
    wire dispSe, factErr;
    
    assign {dispSe, factErr} = gpO1[1:0];
    assign LD = {dispSe, {4{factErr}}} ;
    
    reg  [15:0] hex;
    wire        clk_sec;
    wire        clk_5KHz;
    wire        clk_pb;

    wire [7:0]  digit0;
    wire [7:0]  digit1;
    wire [7:0]  digit2;
    wire [7:0]  digit3;

    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] dispData;

    clk_gen clk_gen (
            .clk100MHz          (clk),
            .rst                (rst),
            .clk_4sec           (clk_sec),
            .clk_5KHz           (clk_5KHz)
        );

    button_debouncer bd (
            .clk                (clk_5KHz),
            .button             (button),
            .debounced_button   (clk_pb)
        );

    System system (
            .clk                (clk_pb),
            .rst                (rst),
            .gpI1               ({28'b0, switches[4:0]}),
            .gpI2               (gpO1),
            .gpO1               (gpO1),
            .gpO2               (gpO2)
        );

    mux2 #(16) disp_mux(
        .a(gpO1[15:0]),
        .b(gpO2[31:16]),
        .y(hex[15:0]),
        .sel(dispSe)
    );
        
    disp_hex_mux disp_unit(
        .hex0(hex[3:0]),
        .hex1(hex[7:4]),
        .hex2(hex[11:8]),
        .hex3(hex[15:12]),
        .clk(clk_5KHz),
        .rst(rst),
        .an(LEDSEL),
        .sseg(LEDOUT)
    );
    

endmodule
