module disp_hex_mux(
        input clk, rst,
        input [3:0] hex0, hex1, hex2, hex3,
        input [3:0] an,
        input [7:0] sseg
    );
    
    wire [7:0] digit3, digit2, digit1, digit0;
    
    hex_to_7seg hex_7_3 (
            .HEX                (hex0),
            .s                  (digit3)
        );

    hex_to_7seg hex_7_2 (
            .HEX                (hex1),
            .s                  (digit2)
        );

    hex_to_7seg hex_7_1 (
            .HEX                (hex2),
            .s                  (digit1)
        );

    hex_to_7seg hex_7_0 (
            .HEX                (hex3),
            .s                  (digit0)
        );
    
    led_mux led_mux (
            .clk                (clk),
            .rst                (rst),
            .LED3               (digit3),
            .LED2               (digit2),
            .LED1               (digit1),
            .LED0               (digit0),
            .LEDSEL             (an),
            .LEDOUT             (sseg)
        );
endmodule
