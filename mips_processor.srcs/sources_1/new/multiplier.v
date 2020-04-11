module multiplier (
        input  wire             clk,
        input  wire             en,
        input  wire [31:0] a,
        input  wire [31:0] b,
        output reg  [31:0] lo,
        output reg [31:0] hi
    );
    
   
    always @ (posedge clk) begin
        if (en) {hi, lo} = a * b; 
        
    end
endmodule