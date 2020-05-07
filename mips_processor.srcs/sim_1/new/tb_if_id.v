`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2020 11:17:57 AM
// Design Name: 
// Module Name: tb_if_id
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
        clk = 1'b0; #10;
        clk = 1'b1; #10;
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
    imem_instr = 'h0x11000555; tick; //beq t0 $zero 0x555
    tick;
    tick;
    
    //--fwd_bd--//
    reset;
    imem_instr = 'h0149402A; tick; // slt t0, t2, t1
    imem_instr = 'h0x10080555; tick; //beq $zero, t0  0x555
    tick;
    tick;
    
    //--branch not taken--//
    reset;
    imem_instr = 'h0012A402A; tick; //  slt t0, t1, t2
    imem_instr = 'h0x11000555; tick; //beq t0 $zero 0x555
    tick;
    tick;
    
    //----//
    reset;
    imem_instr = 'h0149402A; tick; // slt t0, t2, t1
    imem_instr = 'h0x11000555; tick; //beq t0 $zero 0x555
    tick;
    tick;
    
    $finish; 
end


endmodule
