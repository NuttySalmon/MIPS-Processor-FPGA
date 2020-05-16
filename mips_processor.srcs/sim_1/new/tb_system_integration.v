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
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b1; tick;
        rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
        gpI1 = 'h5;  //factorial n=5
        for (i=1; i<36; i=i+1) begin
            tick;
        end
        
        gpI1 = 'h19;  //upper bit of factorial n=9
        for (i=1; i<43; i=i+1) begin 
            tick;
        end
        gpI1 = 'hD;  // n=13
        for (i=1; i<27; i=i+1) begin 
            tick;
        end
        $finish;
    end

endmodule