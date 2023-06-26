module cntr_4 #(parameter BL = 4'b0010)(
    input wire clk,
    input wire en,
    output wire cntr_status
);
reg [3:0] cntr=4'b000;
assign cntr_status = (cntr==BL);

always @(posedge clk)
begin
    if(!en || cntr== BL)  cntr<=4'b0000;
    else   cntr<=cntr+4'b0001;
end

endmodule
