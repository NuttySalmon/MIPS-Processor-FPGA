`timescale 1ns/1ns
module tb_mips_extended;
    reg         clk;
    reg         rst;
    reg  [4:0]  ra3;
    wire [31:0] pc_current;
    reg [31:0] instr;
    wire [31:0] rd3;
    reg [15:0] var1, var2;
    reg [63:0] mult_expect;
    reg [31:0] value;
    reg [31:0] expected;

    integer error_count = 0;

    mips DUT (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .pc_current     (pc_current),
            .imem_instr     (instr),
            .rd3            (rd3)
        );

    task tick; 
    begin 
        clk = 1'b0; #10;
        clk = 1'b1; #10;
    end
    endtask
    
    task extra_ticks; begin
        instr = 0;
        tick; tick; tick; tick;
    end
    endtask
  
    task reset;
    begin  
        rst = 1'b1; tick;
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
        var1 = 16'h5000;
        var2 = 16'h10;
        instr = {16'h2008, var1}; tick; // addi $t0, $zero, 0x5000
        instr = {16'h2009, var2}; tick; //addi $t1, $zero, 0x10
        instr = 32'h01090019; tick; //multu $t0, $t1
        instr = 32'h00004012; tick;//mflo $t0
        instr = 32'h00004810; tick;//mfhi $t1
        extra_ticks;
        
        //MFLO test
        ra3 = 'b01000;  //t0 
        mult_expect = var1 * var2; 
        #5; value = rd3;
        expected = mult_expect[31:0];
        test;

        //MFHI test
        ra3 = 'b01001; //t1
        #5; value = rd3;
        expected = mult_expect[63:32];
         test;

        //JAL
        reset;
        instr = 0; 
        tick; tick; tick; 
        var1 = 16'h0100; // dest address/4
        instr = {16'h0C00, var1}; tick; //jal 0x0100
        // $ra expected 0x10
        instr = 0; tick;
        //test new pc
        value = pc_current;
        expected = var1 << 2;
        #5; test;
        
        extra_ticks;
        
        //test ra value
        ra3 = 'd31; // $ra
        #5; value = rd3;
        expected = 'h10;
        test;

        //JR
        instr = 32'h03E00008; tick; //jr $ra
        instr = 0; tick;
        value = pc_current;
        expected = 'h10;
        #5; test;

        //SLL
        reset;
        var1 = 16'b1110000;
        instr = {16'h2008, var1}; tick; //addi $t0, $0, 0x70
        instr = {32'h00084080}; tick; //sll $t0 t0 0x2
        extra_ticks;
        ra3 = 'b01000;  //t0 
        expected = var1 << 2;
        #50;
        value = rd3;
        test;    

        //SRL
        reset;
        var1 = 16'b1110000;
        instr = {16'h2008, var1}; tick; //addi $t0, $0, 0x70
        instr = {32'h00084082}; tick; //srl $t0 t0 0x2
        extra_ticks;
        ra3 = 'b01000;  //t0 
        expected = var1 >> 2;
        #50;
        value = rd3;
        test;
        $finish;
    end
endmodule