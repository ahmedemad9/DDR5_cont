module PU#(
    parameter CLA=6,
    parameter CL=4,

    parameter q_max=8,
    parameter BL=4,

    parameter t_act=8,
    parameter t_pre=8
)
(
    input wire clk,
    input wire rst,

    //input wire [31:0] in_adrs,
    input wire [31:0] rd_adrs,
    input wire [31:0] wr_adrs,
    
    input wire rd_mt,
    input wire wr_mt,

    output wire [3:0] C_S,

    output wire rw_mux_sel,

    output wire SerDes_en,
    output wire SerDes_sel,
    output wire rd_en,
    output wire wr_en,

    output wire valid,
    output wire [31:0] adrs_out
);
wire q_busy, rw;
cont_top #(
    .t_act(t_act),
    .t_pre(t_pre)
)cont_top_pu(
    .clk(clk),
    .rst(rst),
    
    //.adrs_in(in_adrs),
    .rd_adrs(rd_adrs),
    .wr_adrs(wr_adrs),
    
    .C_S(C_S),
    
    .rd_mt(rd_mt),
    .wr_mt(wr_mt),
    
    .q_busy(q_busy),

    .rw(rw_mux_sel),
    .valid(valid),
    .rd_en(rd_en),
    .wr_en(wr_en),

    .adrs_out(adrs_out)
);

q_top#(
    .CLA(CLA),
    .CL(CL),
    .q_max(q_max),
    .BL(BL)
)q_top_pu(
    .C_S(C_S),
    .clk(clk),
    .rst(rst),
    .SerDes_en(SerDes_en),
    .SerDes_sel(SerDes_sel),
    .busy(q_busy)
    //.rw(rw)
);

endmodule

/*
PU#(
    .CLA(6),
    .CL(4),

    .q_max(8),
    .BL(4),

    .t_act(8),
    .t_pre(8)
)
PU_inst
(
    .clk(),
    .rst(),

    .in_ards(),
    
    .rd_mt(),
    .wr_mt(),

    .C_S(),

    .rw_mux_sel(),

    .SerDes_en(),
    .SerDes_sel(),

    .valid(),
    .adrs_out()
);
    
*/
