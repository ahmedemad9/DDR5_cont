module ScDFF(
    input wire sel,
    input wire a1,
    input wire b1,
    input wire a2,
    input wire b2,
    input wire clk,
    input wire en,
    input wire rst,
    output wire cong,
    output reg Q1,
    output reg Q2
); 

wire D1,D2;

assign D1 = sel? b1 : a1;
assign D2 = sel? b2 : a2;

assign cong = en & Q1;

always @(posedge clk)
begin
    if(!rst) begin           
        Q1<=1'b0;
        Q2<=1'b0;
    end else if(!en) begin
        Q1<=D1;
        Q2<=D2;
    end else begin
        Q1<=1'b0;
        Q2<=1'b0;
    end 
end

endmodule
