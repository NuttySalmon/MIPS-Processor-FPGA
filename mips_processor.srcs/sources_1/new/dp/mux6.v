module mux6 #(parameter WIDTH = 8) (
        input  wire       [2:0]  sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        input  wire [WIDTH-1:0] c,
        input  wire [WIDTH-1:0] d,
        input  wire [WIDTH-1:0] e,
        input  wire [WIDTH-1:0] f,
        output reg [WIDTH-1:0] y
    );
    
    always@(*) begin
        case(sel)
            'd0: y = a;
            'd1: y = b;
            'd2: y = c;
            'd4: y = d;
            'd5: y = e;
            'd6: y = f;        
            default: y = a;
        endcase
    end
endmodule