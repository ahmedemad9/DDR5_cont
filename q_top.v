module q_top #(
    parameter CLA   = 6,
    parameter CL    = 4,
    parameter q_max =8, 
    parameter BL    =2
) 
(
    input wire [3:0] C_S,
    input wire       rst,
    input wire       clk,
    output wire      SerDes_en,
    output wire      SerDes_sel,
    output wire      busy
    //output wire      rw
);

wire rw;
wire sh_en,valid_in_q,rw_in_q;
wire [q_max-1:0]    mux;
wire [q_max:0]      valid;
wire [q_max:0]      cong;
assign busy= |valid;

assign SerDes_en = valid_in_q;
assign SerDes_sel= rw_in_q;

queue_lgc #(.BL(BL)) q_lgc_inst(
    .valid(valid_in_q),
    .clk(clk),
    .rst(rst),
    .sh_en(sh_en)
    //.SerDes_en(SerDes_en)
);

VacSel #(
    .CLA(CLA),
    .CL(CL),
    .CL_max(q_max)) 
VacSelInst(
    .clk(clk),
    .C_S(C_S),
    .valid(valid[q_max:1]),
    .cong(cong[q_max:1]),
    .rst(rst),
    .rw(rw),
    .mux_sel(mux)
);

ScDFF_ch #(.q_max(q_max)) ScDFF_ch_inst(
    .mux(mux),
    .clk(clk),
    .rw(rw),
    .cong(cong),
    .sh_en(sh_en),
    .rst(rst),
    .valid(valid),
    .valid_in_q(valid_in_q),
    .rw_in_q(rw_in_q)
);

endmodule
