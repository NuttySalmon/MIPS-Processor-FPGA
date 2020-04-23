module MUX(
    input Sel,
    input [31:0] s0, s1,
    output [31:0] Out
    );
    assign Out = Sel ? s1 : s0;
endmodule
