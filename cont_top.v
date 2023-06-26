module cont_top#(
    parameter t_act=8,
    parameter t_pre=8
)(
    input wire clk,
    input wire rst,

    //input wire [31:0] in_adrs,
    input wire [31:0] rd_adrs,
    input wire [31:0] wr_adrs,
    //input wire [31:0] adrs_in,

    input wire rd_mt,
    input wire wr_mt,

    input wire q_busy,

    output wire rw,
    output wire valid,
    
    output wire [3:0] C_S,
    output wire rd_en,
    output wire wr_en,

    output wire [31:0] adrs_out
);

wire rd_valid, wr_valid;
assign valid = rd_valid | wr_valid;

wire ppl;

wire cont_ready;

MemCont #(
    .t_act(t_act),
    .t_pre(t_pre)
) memContInst(
    .clk(clk),
    .rst(rst),
    .ppl(ppl),
    .wr_valid(wr_valid),
    .rd_valid(rd_valid),
    //.rw(rw_mux),
    .busy(q_busy),
    .c_state(C_S),

    .ready(cont_ready)
);

ppl ppl_inst(
    .clk(clk),
    .rst(rst),

    //.in_adrs(adrs_in),
    .rd_adrs(rd_adrs),
    .wr_adrs(wr_adrs),

    .rd_mt(rd_mt),
    .wr_mt(wr_mt),

    .ready(cont_ready),

    .rd_ld(rd_ld),
    .wr_ld(wr_ld),

    .op(rw),
    .ppl(ppl),

    .rd_valid(rd_valid),
    .wr_valid(wr_valid),

    .rd_en(rd_en),
    .wr_en(wr_en),

    .adrs_out(adrs_out)
);

endmodule
