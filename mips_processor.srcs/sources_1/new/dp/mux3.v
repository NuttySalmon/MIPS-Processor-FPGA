module mux3 #(parameter WIDTH = 8) (
        input  wire       [1:0]  sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        input  wire [WIDTH-1:0] c,
        output reg [WIDTH-1:0] y
    );
    
    always@(*) begin
        case(sel)
            'b00: y = a;
            'b01: y = b;
            'b10: y = c;
            default: y = a;
        endcase
    end
    


endmodule