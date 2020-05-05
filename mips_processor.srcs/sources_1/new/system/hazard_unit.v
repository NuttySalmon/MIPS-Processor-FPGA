module hazard_unit(
    input wire we_regE,
    input wire we_regM,
    input wire we_regW,
    input wire dm2regE,
    input wire dm2regM,
    input wire branchD,
    input wire [4:0] rsD,
    input wire [4:0] rtD,
    input wire [4:0] rsE,
    input wire [4:0] rtE,
    input wire [4:0] rf_waE,    
    input wire [4:0] rf_waM,
    output wire StallF,
    output wire StallD,
    output wire FlushE,
    output wire ForwardAD,
    output wire ForwardBD,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE
    );
    //a little bit confused if branchD && is already implemented in the dp or not?
    assign ForwardAD = branchD && we_regM && (rsD != 0) && (rf_waM == rsD);
    assign ForwardBD = branchD && we_regM && (rtD != 0) && (rf_waM == rtD);
    assign branchstall = (branchD && we_regE && ((rf_waE == rsD) || (rf_waE == rtD))) ||
                         (branchD && dm2regM && ((rf_waM == rsD) || (rf_waM == rtD)));
    assign lwstall = ((rsD == rtE) || (rtD == rtE)) && dm2regE;
    assign StallF = lwstall || branchstall;
    assign StallD = lwstall || branchstall;
    assign FlushE = lwstall || branchstall;

    
    
    always @(*) begin
        if (we_regM && (rsE != 0) && (rf_waM == rsE))
            ForwardAE = 2'b10;
        if (we_regM && (rtE != 0) && (rf_waM == rtE))        
            ForwardBE = 2'b10;
        if (we_regW && (rsE != 0) && (rf_waW == rsE)) 
            ForwardAE = 2'b01;
        if (we_regW && (rtE != 0) && (rf_waW == rtE))         
            ForwardBE = 2'b01;   
        else begin
            ForwardAE = 2'b00;
            ForwardBE = 2'b00;
        end
    end
    
endmodule
