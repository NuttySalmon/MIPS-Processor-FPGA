module CNT(
    input Load_cnt,
    input EN,
    input CLK,
    input [3:0] D,
    output reg [3:0] Q
    );
    
    always @ (posedge CLK) begin
        if (EN) begin
            if (Load_cnt) Q <= D;
            else  Q <= Q-1;
        end
        else Q <= Q;
    end
endmodule
