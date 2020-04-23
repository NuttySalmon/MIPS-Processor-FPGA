module factorial(
    input [3:0] in,
    input CLK, Go,
    output [31:0] out,
    output [2:0] CS,
    output Done, Error
    );
    
    wire n_GT_1, n_GT_12;
    wire Sel, Load_cnt, En_cnt, Load_reg, OE;

    factorial_cu CU(
         .clk(CLK),
         .Go(Go),
         .GT(n_GT_1),
         .error(n_GT_12), 
         .sel(Sel), 
         .Load_Cnt(Load_cnt),
         .En(En_cnt), 
         .Load_Reg(Load_reg), 
         .OE(OE), 
         .done(Done),
         .Error(Error),
         .CS_view(CS)
    );
    
    factorial_dp DP(
        .CLK(CLK),
        .in(in),
        .Load_reg(Load_reg),
        .Load_cnt(Load_cnt),
        .En_cnt(En_cnt), 
        .OE(OE), 
        .Sel(Sel),
        .n_GT_1(n_GT_1), 
        .n_GT_12(n_GT_12),
        .out(out)
    );
endmodule
