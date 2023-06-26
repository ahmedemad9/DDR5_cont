module pkt_gen_ctrl(
    input   clk,
            rst_n,
    input [3:0] current_state,
    output  reg  CS_o
);
localparam [3:0]    IDLE = 4'd0,
                    ACT     =   4'd8,
                    WRP     =   4'd1,
                    WRPA    =   4'd3,
                    MRW     =   4'd2,
                    MRR     =   4'd6,
                    WR      =   4'd7,
                    WRA     =   4'd5,
                    RD      =   4'd4,
                    RDA     =   4'd12,
                    PRE     =   4'd13;

wire D_in;
wire CS_in;

assign D_in = (current_state == IDLE) ? 1'b1:CS_in;
assign CS_in = !(CS_o^1'b0);


always @(negedge clk or negedge rst_n)begin
    if(!rst_n)begin
        CS_o <= 1'b0;
    end
    else
        CS_o <= D_in;
end

endmodule