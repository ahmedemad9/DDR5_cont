module cntr #(parameter BL = 3'b010)(
    input wire clk,
    input wire en,
    output wire cntr_status
);
reg [2:0] cntr=3'b000;
assign cntr_status = (cntr==BL);

always @(posedge clk)
begin
    if(!en || cntr== BL)  cntr<=3'b000;
    else   cntr<=cntr+3'b001;
end

endmodule
