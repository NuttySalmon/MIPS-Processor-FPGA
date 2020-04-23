module REG(
    input [31:0] D,
    input CLK, Load_reg,
    output reg [31:0] Q
    );
    always @ (posedge CLK) begin
        if (Load_reg) Q <= D;
        else Q <= Q;
    end
endmodule
