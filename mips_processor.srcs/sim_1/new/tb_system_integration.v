`timescale 1ns/1ns
module tb_system_integration;
    integer     i;
    reg         clk;
    reg         rst;
    wire        we_dm;
    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] rw_addr;
    reg [31:0] gpI1, gpI2;
    wire [31:0] gpO1, gpO2;
    wire [31:0] DONT_USE;
    System DUT (
            .clk            (clk),
            .rst            (rst),
            .ra3            ('b0),
            .pc_current     (pc_current),
            .instr          (instr),
            .rw_addr        (rw_addr),
            .rd3            (DONT_USE),
            .gpI1           (gpI1), 
            .gpI2           (gpI2),
            .gpO1           (gpO1),
            .gpO2           (gpO2)
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
        tick;
        rst = 1'b1; #5;
        tick;
        rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
        gpI1 = 'h15;
        for (i=1; i<35; i=i+1) begin
            #5; 
            tick;
        end
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick; tick; tick; tick;
        $finish;
    end

endmodule