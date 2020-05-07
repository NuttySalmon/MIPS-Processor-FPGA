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
        .dmem_addr      (dmem_addr),
        //.pc_plus4_1   (pc_plus4_1), 
        .instr  (instr) 
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
    
    task add_four;
        begin
            expected = 4 * n; n = n + 1;
        end
    endtask
     
 initial begin
    imem_instr = 32'h20040002; tick; expected = 32'h20040002; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h20050001; tick; expected = 32'h20050001; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h200b0003; tick; expected = 32'h200b0003; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h200e0008; tick; expected = 32'h200e0008; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h10850004; tick; expected = 32'h10850004; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h012a8820; tick; expected = 32'h012a8820; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h01105822; tick; expected = 32'h01105822; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h01cf8025; tick; expected = 32'h01cf8025; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h1491fffc; tick; expected = 32'h1491fffc; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h01cf5824; tick; expected = 32'h01cf5824; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'hae2d0000; tick; expected = 32'hae2d0000; value = imem_instr; test; add_four;//value = pc_plus4_1; test;
    imem_instr = 32'h8eb20000; tick; expected = 32'h8eb20000; value = imem_instr; test; add_four;//value = pc_plus4_1; test;

end


endmodule
