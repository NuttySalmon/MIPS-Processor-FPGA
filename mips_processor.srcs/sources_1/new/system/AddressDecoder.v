module AddressDecoder(
        input [0:9] a,
        input we,
        output we1,
        output we2,
        output wem,
        output reg [1:0] rd_sel
    );
    
    reg [2:0] we_ctrl ;
    assign {wem, we1, we2} = we_ctrl;
 
    always@(a, we) begin
        case (a[9:6])
            'h0: begin //dmem
                    rd_sel = 'b00; 
                    we_ctrl = we ? 'b1_0_0 : 'b0_0_0;
                 end
            'h8: begin //factorial acc
                    rd_sel = 'b10; 
                    we_ctrl = we ? 'b0_1_0 : 'b0_0_0;
                 end
            'h9: begin  //gpio
                    rd_sel = 'b11;
                    we_ctrl = we ? 'b0_0_1 : 'b0_0_0;
                 end
            default: begin 
                    rd_sel = 'b00; 
                    we_ctrl = 'b0_0_0; 
                end 
        endcase
    end
endmodule
