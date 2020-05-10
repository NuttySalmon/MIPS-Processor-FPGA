`timescale 1ns / 1ps

module tb_if_id;
    reg         clk;
    reg         rst;
    reg  [4:0]  ra3;
    reg [31:0]  imem_instr;
    wire [31:0] pc_current;
    reg [31:0] dmem_rd;
    wire [31:0] dmem_addr;
    wire [31:0] instr;
    wire [31:0] rd3;
    wire [31:0] pc_plus_4_1;
    reg [31:0] value;
    reg [31:0] expected;
    
    integer error_count = 0;
    integer n = 1;

mips DUT(
        .clk            (clk),
        .rst            (rst),
        .ra3            (ra3),
        .imem_instr     (imem_instr),
        .dmem_rd        (dmem_rd),
        .pc_current     (pc_current),
        .rd3            (rd3),
        .dmem_addr      (dmem_addr)
    );
    task tick; 
    begin 
        clk = 1'b0; #100;
        clk = 1'b1; #100;
    end
    endtask

    task reset;
    begin 
        rst = 1'b1; tick;
        rst = 1'b0; #5; 
    end
    endtask
    
    task test;
        if (expected != value) begin
            $display("ERROR");
            error_count = error_count + 1;
        end
    endtask
    
    task add_four;
        begin
            expected = 4 * n; n = n + 1;
        end
    endtask
     
 initial begin
 
    //--early branch & branch stall--//
    reset;
    imem_instr = 'h20090123; tick; //addi t1 zero 0x123
    imem_instr = 'h200A0456; tick; //addi t2, zero, 0x456
    imem_instr = 'h0149402A; tick; // slt t0, t2, t1
    imem_instr = 'h11000555; tick; //beq t0 $zero 0x555
    tick;
    tick; 
    
    //--fwd bd ad--//
    reset;
    imem_instr = 'h0149402A; tick; // slt t0, t2, t1
    imem_instr = 'h10080555; tick; //beq $zero, t0  0x555
    tick;
    tick;
    
    //--branch not taken--//
    reset;
    imem_instr = 'h012A402A; tick; //slt t0, t1, t2
    imem_instr = 'h11000555; tick; //beq t0 $zero 0x555
    tick;
    tick;
    
    //--fwd ae be--//
    reset;
    imem_instr = 'h012A4020; tick; //add t0 t1 t2
    imem_instr = 'h010A5820; tick; //add t3 t0 t2
    imem_instr = 'h012A4020; tick; //add t0 t1 t2
    tick;
    tick;
    tick;
    
        
    //--fwd ae be--//
    reset;
    dmem_rd = 'h123;
    imem_instr = 'h8C080040; tick; //LW $t0, 0x40(zero)
    imem_instr = 'h010A5820; tick; //add t3, t0, t2 
    tick; //add t0 t1 t2
    tick;
    tick;
    tick;
            
    //--fwd ae be--//
    reset;
    imem_instr = 'h10000555; tick; //beq zero, zero, 0x555
    //imem_instr = 'h08000555; tick; 
    imem_instr = 'h014A5822; tick; //sub t3, t2, t2 
    imem_instr = 'h014A0019; tick; //multu t2, t2
    imem_instr = 'h00005812; tick; //mflo t3
    tick;
    tick;
    tick;
    $finish; 
end


endmodule
