module tb_system_integration;

    reg         clk;
    reg         rst;
    wire        we_dm;
    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] rw_addr;
    wire [31:0] w_data;
    wire [31:0] rd_dm;
    reg [31:0] gpI1, gpI2;
    wire [31:0] gpO1, gpO2;
    wire [31:0] DONT_USE;
    System DUT (
            .clk            (clk),
            .rst            (rst),
            .we_dm          (we_dm),
            .ra3            ('b0),
            .pc_current     (pc_current),
            .instr          (instr),
            .rw_addr        (rw_addr),
            .w_data         (w_data),
            .rd_dm          (rd_dm),
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
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
        gpI1 = 'h2;
        gpI2 = 'h3;
        while(pc_current <= 32'h3c) tick;
         
        $finish;
    end

endmodule