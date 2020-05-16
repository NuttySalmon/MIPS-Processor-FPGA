`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2020 12:45:50 PM
// Design Name: 
// Module Name: tb_fact_top
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


module tb_fact_top;
    
    integer n, i=1, error=0;
    reg tb_clk, tb_rst;
    reg [1:0] tb_A;
    reg tb_WE;
    reg [3:0] tb_WD;
    wire [31:0] tb_RD; 
    reg [31:0] expected, factorial_result;
    
    
    fact_top DUT(
        .clk        (tb_clk),
        .rst        (tb_rst),
        .A          (tb_A),
        .WE         (tb_WE),
        .WD         (tb_WD),
        .RD         (tb_RD)  
    
        );
    task tick; 
    begin 
        #5; tb_clk = 1'b1; 
        #5; tb_clk = 1'b0;
    end
    endtask

    task reset;
    begin 
        tb_rst = 1'b0; #5;
        tb_rst = 1'b1; #5;
        tb_rst = 1'b0; #5;
    end
    endtask
    
    task check;
        if (expected != tb_RD) begin
            $display("ERROR");
            error = error +1;
        end
    endtask
    
    task cal_fact; begin
        factorial_result = 1;
        for(i = 1; i <=n; i=i+1)
            factorial_result =  factorial_result  * i;
    end
    endtask

    initial begin 
        for (n=0; n <= 13; n=n+1) begin
            reset; // reset
            
            // read go
            expected = 'b0; 
            tb_WE = 1'b0;
            tb_A = 2'b01;
            tb_WD = 1'b1;
            tick;
            
            // check go
            check;
            
            //set n
            tb_WE = 1'b1; 
            tb_A = 2'b00;
            tb_WD = n;
            tick;
            
            // read n
            expected = n;
            tb_WE = 1'b1;
            tick;
            
            //check n
            check;
            
            //assert go
            tb_WD = 1'b1;
            tb_A = 2'b01;
            tick;
            
            // read go
            
            tb_WE = 1'b0;
            tick;
            
            //check go
            expected = 'b1; 
            check;
            
            //tick while not done or error
            tb_A = 2'b10; #5
            while (tb_RD == 'b0)
                tick;
 
            if (tb_RD == 01) begin
                cal_fact;
                expected = factorial_result; 
                //read result
                tb_A = 2'b11;
                tick;
                
                
                check;
            end
            else if (n < 13) begin
                $display("ERROR");
                error = error +1;
            end
        end

        $finish;
    end

endmodule
