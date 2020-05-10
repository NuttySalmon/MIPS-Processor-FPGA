module fpga_top (
        input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire       sel,
        input  wire [3:0] n,
        output wire       dispSe,
        output wire       factErr,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );
    
    wire [31:0] gpO1, gpO2;    
    assign dispSe = gpO1[4];
    assign factErr = gpO1[0];
    
    wire  [15:0] hex;
    wire        clk_sec;
    wire        clk_5KHz;

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
            .gpI1               ({27'b0, {sel, n[3:0]}}),
            .gpI2               (gpO1),
            .gpO1               (gpO1),
            .gpO2               (gpO2)
        );

    mux2 #(16) disp_mux(
        .a(gpO2[15:0]),
        .b(gpO2[31:16]),
        .y(hex),
        .sel(dispSe)
    );
   
    
    disp_hex_mux disp_unit(
        .hex0(hex[15:12]),
        .hex1(hex[11:8]),
        .hex2(hex[7:4]),
        .hex3(hex[3:0]),
        .clk(clk_5KHz),
        .rst(rst),
        .an(LEDSEL),
        .sseg(LEDOUT)
    );
    

endmodule
