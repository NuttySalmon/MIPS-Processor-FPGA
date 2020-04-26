`timescale 1ns / 1ps
module tb_system_decoder;
    integer error_count = 0;
    integer i;
    reg [31:0] a ;
    reg we;
    wire we1,we2, wem;
    wire [1:0] rd_sel;
    reg  [1:0] rd_sel_expected;
    wire [2:0] we_all;
    reg  [2:0] we_all_expected;

    AddressDecoder DUT(
        .a(a[11:2]),
        .we(we),
        .we1(we1),
        .we2(we2),
        .wem(wem),
        .rd_sel(rd_sel)
    );
    
    assign we_all = {wem, we1, we2};
    
    task check; begin
        if (we_all != we_all_expected) begin
            $display("Wrong we signals");
            error_count = error_count + 1;
        end
        if (rd_sel != rd_sel_expected) begin
            $display("Wrong rd_sel");
            error_count = error_count + 1;
        end
    end
    endtask
    
    task test;
        for (i='h0; i<='hFF; i=i+'h4) begin
            a[7:0] = i[7:0]; 
            #5; check;
        end
    endtask
    
    initial begin
        we = 'b0;
        we_all_expected = 'b0_0_0;
        
        a = 'h000;
        rd_sel_expected = 'b00;
        test;
        
        a = 'h800;
        rd_sel_expected = 'b10;
        test;
        
        a = 'h900;
        rd_sel_expected = 'b11;
        test;
        
        we = 'b1;
        a = 'h000;
        rd_sel_expected = 'b00;
        we_all_expected = 'b1_0_0;
        test;
        
        a = 'h800;
        rd_sel_expected = 'b10;
        we_all_expected = 'b0_1_0;
        test;
        
        a = 'h900;
        rd_sel_expected = 'b11;
        we_all_expected = 'b0_0_1;
        test;
        
        $finish;
    end
endmodule
