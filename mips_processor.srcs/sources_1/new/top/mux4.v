module mux4 #(parameter WIDTH = 32) (
        input  wire       [1:0]  sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        input  wire [WIDTH-1:0] c,
        input  wire [WIDTH-1:0] d,
        output reg [WIDTH-1:0] y
    );
    
    always@(*) begin
        case(sel)
            'b00: y = a;
            'b01: y = b;
            'b10: y = c;
            'b11: y = d;
            default: y = a;
        endcase
    end
    


endmodule