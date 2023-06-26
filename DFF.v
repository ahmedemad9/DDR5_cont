module DFF #(parameter width = 1)(
    input wire [width-1:0] D,
    output reg [width-1:0] Q,
    input wire clk,
    input wire rst
);

always @(posedge clk)begin
    if(!rst)    Q<=1'b0;
    else        Q<=D;
end

endmodule
