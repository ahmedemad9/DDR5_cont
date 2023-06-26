module sh_reg #(parameter length =3, parameter width =5)(
    input wire [width-1:0] D,
    input wire clk,
    input wire rst,

    output wire [width-1:0] Q
);


wire [width-1:0] intrnl [0:length];
assign intrnl[0]=D;
assign Q=intrnl[length-1];

genvar i;
generate
    for(i=0;i<length;i=i+1) begin : generate_chain
        DFF #(.width(width)) dff(
            .D(intrnl[i]),
            .clk(clk),
            .rst(rst),
            .Q(intrnl[i+1])
        );
    end
endgenerate

endmodule
