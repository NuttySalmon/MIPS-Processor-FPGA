module factorial_cu(
    input clk, Go, GT, error, 
    output sel, Load_Cnt, En, Load_Reg, OE, done, Error,
    output [2:0] CS_view
    );
    
    parameter 
        s0 = 3'b000,
        s1 = 3'b001,
        s2 = 3'b010,
        s3 = 3'b011,
        s4 = 3'b100;
        //s5 = 3'b101; 
    
    reg [2:0] CS, NS;
    reg [6:0] control_sig; 
    //NS Logic 
    always@(CS,Go,GT,error) begin 
        casex(CS) 
            s0: NS <= (Go) ? s1 : s0;
            s1: NS <= s2; 
            s2: NS <= (error || ~GT) ? s4 : s3;
            s3: NS <= s2;
            s4: NS <= s0;
            default: NS <= s0;
        endcase 
    end 
    
    //State Register 
    always@(posedge clk) begin 
        CS <= NS;
    end 
    
    //Output Logic 
    always@(CS, error) begin
     case(CS) 
        s0: control_sig <= 7'b0000000; 
        s1: control_sig <= 7'b1111000;
        s2: control_sig <= 7'b0000000;
        s3: control_sig <= 7'b0011000;
        s4:  if(error) control_sig <= 7'b0000001;
            else control_sig <= 7'b1000110;
        
        endcase    
    end
    
    assign {sel, Load_Cnt,En, Load_Reg, OE, done, Error} = control_sig; 
    assign CS_view = CS;

endmodule
