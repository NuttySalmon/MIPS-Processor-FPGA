`timescale 1ns/1ns
module tb_mips_extended;
    reg         clk;
    reg         rst;
    reg  [4:0]  ra3;
    wire        we_dm;
    
    wire [31:0] pc_current;
    reg [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] rd3;
    reg [15:0] var1, var2;
    reg [63:0] mult_expect;
    reg [31:0] value;
    reg [31:0] expected;

    integer error_count = 0;

    mips DUT (
            .clk            (clk),
            .rst            (rst),
            .we_dm          (we_dm),
            .ra3            (ra3),
            .pc_current     (pc_current),
            .instr          (instr),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd_dm          (rd_dm),
            .rd3            (rd3)
        );

    task tick; 
    begin 
        clk = 1'b0; #100;
        clk = 1'b1; #100;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    
    task test;
        if (expected != value) begin
            $display("ERROR");
            error_count = error_count + 1;
        end
    endtask

    initial begin
        reset;
        
        //rd_dm = 'b0;
        //ra3 = 'b00000;
        //MULTU
        var1 = 16'hFFFF;
        var2 = 16'h0010;
        instr = {16'h2008, var1}; tick; // addi $t0, $zero, 0xFFFF
        instr = {16'h2009, var2}; tick; //addi $t1, $zero, 0x10
        instr = 32'h01090019; tick; //multu $t0, $t1
        instr = 32'h00004012; tick;//mflo $t0
        instr = 32'h00004810; tick;//mfhi $t1
        
        //MFLO test
        ra3 = 'b01000;  //t0 
        mult_expect = var1 * var2;
        value = rd3;
        expected = mult_expect[31:0];
        #5; test;

        //MFHI test
        ra3 = 'b01001; //t1
        value = rd3;
        expected = mult_expect[63:32];
        #5; test;

        //JAL
        reset;
        tick; tick; tick; 
        var1 = 16'h0100; // dest address/4
        instr = {16'h0C00, var1}; tick; //jal 0x0100
        // $ra expected 0x10

        //test new pc
        value = pc_current;
        expected = {var1, 2'b00};
        #5; test;

        //test ra value
        ra3 = 'd31; // $ra
        value = rd3;
        expected = 'h10;
        #5; test;

        //JR
        instr = 32'h03E00008; tick; //jr $ra
        value = pc_current;
        expected = 'h10;
        #5; test;

        //SLL
        var1 = 16'b1110000;
        instr = {16'h2008, var1}; tick; //addi $t0, $0, 0x70
        instr = {32'h00084080}; tick; //sll $t0 t0 0x2
        ra3 = 'b01000;  //t0 
        expected = var1 << 2;
        #50;
        value = rd3;
        test;    

        //SRL
        var1 = 16'b1110000;
        instr = {16'h2008, var1}; tick; //addi $t0, $0, 0x70
        instr = {32'h00084082}; tick; //srl $t0 t0 0x2
        ra3 = 'b01000;  //t0 
        expected = var1 >> 2;
        #50;
        value = rd3;
        test;
        $finish;
    end
endmodule