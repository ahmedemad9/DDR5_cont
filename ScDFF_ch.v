module ScDFF_ch #(parameter q_max=3)(
    input wire [q_max-1:0] mux,
    input wire             clk,
    input wire             rw,
    input wire             sh_en,
    input wire             rst,
    output wire [q_max:0]  valid,
    output wire            valid_in_q,
    output wire [q_max:0]  cong,
    output wire            rw_in_q
);

wire one=1'b1;
//wire [q_max:0] cong;
wire [q_max:0] aa_rw;
reg sh_en_n;

always @(negedge clk) sh_en_n<=sh_en;

assign cong[q_max]=!sh_en_n&valid[8];

genvar i;
generate
    for(i=0;i<q_max;i=i+1) begin : generate_schdlr
        ScDFF ScDFF_valid_inst(
            .sel(mux[i]),
            .a1(valid[i]),
            .b1(one),
            .a2(aa_rw[i]),
            .b2(rw),
            .clk(clk),
            .en(cong[i+1]),
            .rst(rst),
            .cong(cong[i]),
            .Q1(valid[i+1]),
            .Q2(aa_rw[i+1])
        );
		  end
endgenerate

assign aa_rw[0]=1'b0;
assign valid_in_q=valid[q_max];
assign rw_in_q=aa_rw[q_max];
assign valid[0]=1'b0;

endmodule
