module factorial_dp(
    input [3:0] in,
    input CLK,
    input Load_reg, Load_cnt, En_cnt, OE, Sel,
    output n_GT_1, n_GT_12,
    output [31:0] out
    );
    
    wire [3:0] n;
    wire [31:0] product;
    wire [31:0] reg_in;
    wire [31:0] Y;

    CNT n_count(
        .Load_cnt(Load_cnt),
        .EN(En_cnt),
        .D(in),
        .Q(n),
        .CLK(CLK)
    );
    
    MUX reg_mux(
        .Sel(Sel),
        .s0(product),
        .s1('b1),
        .Out(reg_in)
    );
    
    MUX out_mux(
        .Sel(OE),
        .s0('b0),
        .s1(Y),
        .Out(out)
    );
    
    CMP loop_comp(
        .A(n),
        .B('b1),
        .GT(n_GT_1)
    );
    
    CMP error_comp(
        .A(n),
        .B('d12),
        .GT(n_GT_12)
    );

    MUL multi(
        .X({28'b0, n}),
        .Y(Y),
        .Z(product)
    );
    
    REG Y_reg(
        .D(reg_in),
        .Q(Y),
        .Load_reg(Load_reg),
        .CLK(CLK)
    );
    
endmodule
