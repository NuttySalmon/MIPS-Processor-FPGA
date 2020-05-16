module multiplier (
        input  wire [31:0] a,
        input  wire [31:0] b,
        output wire [31:0] lo,
        output wire [31:0] hi
    );
    
   
    assign {hi, lo} = a * b; 
        
endmodule