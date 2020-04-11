module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        input  wire [1:0] rf_wd,
        output wire [2:0] alu_ctrl,
        output wire [2:0] rf_wd_src,
        output wire       shift_lr,
        output wire       mul_en,
        output wire       jr
    );

    reg [2:0] ctrl;

    assign {alu_ctrl, rf_wd_src, shift_lr, mul_en, jr} = ctrl;

    always @ (alu_op, funct, rf_wd) begin
        case (alu_op)
            2'b00: ctrl = {3'b010, {1'b0, rf_wd}, 3'b0};          // alu add
            2'b01: ctrl = {3'b110, {1'b0, rf_wd}, 3'b0};          // alu sub 
            default: case (funct)
                6'b10_0100: ctrl = 9'b000_000_0_0_0; // AND
                6'b10_0101: ctrl = 9'b001_000_0_0_0; // OR
                6'b10_0000: ctrl = 9'b010_000_0_0_0; // ADD
                6'b10_0010: ctrl = 9'b110_000_0_0_0; // SUB
                6'b10_1010: ctrl = 9'b111_000_0_0_0; // SLT
                
                6'b01_1001: ctrl = 9'bxxx_000_1_0_0; // MULTU
                6'b01_0000: ctrl = 9'bxxx_110_0_0_0; // MFHI
                6'b01_0010: ctrl = 9'bxxx_101_1_0_0; // MFLO
                6'b00_1000: ctrl = 9'bxxx_000_0_0_1; // JR
                6'b00_0000: ctrl = 9'bxxx_100_0_0_0; // SLL
                6'b00_0010: ctrl = 9'bxxx_100_0_1_0; // SRL
                
                default:    ctrl = {3'bxxx, {1'b0, rf_wd}, 3'b0};
            endcase
        endcase
    end

endmodule