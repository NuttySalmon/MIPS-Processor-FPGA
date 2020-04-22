module maindec (
        input  wire [5:0] opcode,
        output wire       branch,
        output wire       jump,
        output wire [1:0] reg_dst,
        output wire       we_reg,
        output wire       alu_src,
        output wire       we_dm,
        output wire [1:0] rf_wd,
        output wire [1:0] alu_op
    );

    reg [10:0] ctrl;

    assign {branch, jump, reg_dst, we_reg, alu_src, we_dm, rf_wd, alu_op} = ctrl;

    always @ (opcode) begin
        case (opcode)
            6'b00_0000: ctrl = 11'b0_0_01_1_0_0_11_10; // R-type
            6'b00_1000: ctrl = 11'b0_0_00_1_1_0_00_00; // ADDI
            6'b00_0100: ctrl = 11'b1_0_00_0_0_0_00_01; // BEQ
            6'b00_0010: ctrl = 11'b0_1_00_0_0_0_00_00; // J
            6'b10_1011: ctrl = 11'b0_0_00_0_1_1_00_00; // SW
            6'b10_0011: ctrl = 11'b0_0_00_1_1_0_01_00; // LW
            
            6'b00_0011: ctrl = 11'b0_1_10_1_0_0_10_00; // JAL 
            default:    ctrl = 11'bx_x_xx_x_x_x_xx_xx;
        endcase
    end

endmodule