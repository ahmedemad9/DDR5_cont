module ppl(
    input wire clk,
    input wire rst,

    //input wire [31:0] in_adrs,
    input wire [31:0] rd_adrs,
    input wire [31:0] wr_adrs,

    input wire rd_mt,
    input wire wr_mt,

    input wire ready,

    output reg rd_ld,
    output reg wr_ld,

    output reg op,
    output wire ppl,

    output reg wr_valid,
    output reg rd_valid,
    //output reg n_op,

    output reg rd_en,
    output reg wr_en,
    output wire [31:0] adrs_out
);

wire [31:0] rd_out_adrs, wr_out_adrs;
reg  [31:0] rd_out_adrs_r, wr_out_adrs_r;
reg  [31:0] rd_adrs_r, wr_adrs_r;

localparam [1:0] idle          = 2'b00,
                 a1_p1         = 2'b01,
                 a1_p2_a2_p1   = 2'b11;

reg [2:0] c_state,n_state;

wire wr_ppl, rd_ppl;

//reg op;
reg wr_a1_valid, rd_a1_valid;
reg rd_prev, wr_prev;
reg prev_op;

always @(posedge clk)
begin
    if(!rst)   begin
        c_state<=idle;
        //prev_op<=1'b0;
    end else       c_state<=n_state;
end


assign wr_out_adrs=wr_valid?wr_out_adrs_r:32'hzzzz_zzzz;
assign rd_out_adrs=rd_valid?rd_out_adrs_r:32'hzzzz_zzzz;
assign adrs_out=op?wr_out_adrs:rd_out_adrs;

assign wr_ppl=(wr_out_adrs==wr_adrs)&wr_a1_valid;
assign rd_ppl=(rd_out_adrs==rd_adrs)&rd_a1_valid;
assign ppl=op?wr_ppl:rd_ppl;

always @(*)
begin
   case(c_state)

    idle:
    begin
        wr_a1_valid<=1'b0;  rd_a1_valid<=1'b0;
        rd_en<=1'b0;        wr_en<=1'b0;
        prev_op<=prev_op;

        rd_valid<=1'b0;     wr_valid<=1'b0;
        wr_prev<=wr_prev; rd_prev<=rd_prev;

        if((rd_mt && wr_mt) || !ready)begin
            op<=op;
            wr_ld<=1'b0;    rd_ld<=1'b0;
            n_state<=idle;
        end else begin
            //n_state<=a1_p1;
            if(prev_op)begin
                if(!rd_mt) begin
                    op<=1'b0;
                    rd_ld<=1'b1;   wr_ld<=1'b0;
                    if(rd_prev)    n_state<=a1_p2_a2_p1;
                    else           n_state<=a1_p1;
                end else begin
                    op<=1'b1;
                    wr_ld<=1'b1;   rd_ld<=1'b0;
                    if(wr_prev)    n_state<=a1_p2_a2_p1;
                    else           n_state<=a1_p1;
                end
            end else begin
                if(!wr_mt) begin
                    op<=1'b1;
                    rd_ld<=1'b0;   wr_ld<=1'b1;
                    if(wr_prev)    n_state<=a1_p2_a2_p1;
                    else           n_state<=a1_p1;
                end else begin
                    op<=1'b0;
                    wr_ld<=1'b0;   rd_ld<=1'b1;
                    if(wr_prev)    n_state<=a1_p2_a2_p1;
                    else           n_state<=a1_p1;
                end
            end
        end
    end

    a1_p1:
    begin
      prev_op=op;
        op<=op;
        rd_en<=1'b0;      wr_en<=1'b0;
        prev_op<=op;

        rd_valid<=1'b0;   wr_valid<=1'b0;
        rd_prev<=rd_prev; wr_prev<=wr_prev;
        n_state<=a1_p2_a2_p1;
        rd_en<=!op;       wr_en<=op;

        if(op && !wr_mt) begin
             wr_ld<=1'b1;        rd_ld<=1'b0;
             wr_a1_valid<=1'b1;  rd_a1_valid<=1'b0;
        end else if(!op && !rd_mt) begin
             rd_ld<=1'b1;        wr_ld<=1'b0;
             rd_a1_valid<=1'b1;  wr_a1_valid<=1'b0;
        end else begin
             wr_ld<=1'b0;        rd_ld<=1'b0;
             rd_a1_valid<=1'b0;  wr_a1_valid<=1'b0;
        end
    end


    a1_p2_a2_p1:
    begin
//        prev_op<=op;
//        op<=1'b0;
        rd_ld<=1'b0;  wr_ld<=1'b0;
        rd_valid<=!op;  wr_valid<=op;

        if(!ready) begin
            if(op) begin
                wr_a1_valid<=!wr_mt;
                rd_a1_valid<=1'b0;
            end else begin
                rd_a1_valid<=!rd_mt;
                wr_a1_valid<=1'b0;
            end
            n_state<=a1_p2_a2_p1;
            rd_valid<=1'b0; wr_valid<=1'b0;
            rd_en<=1'b0;    wr_en<=1'b0;
            wr_prev<=1'b0;  rd_prev<=1'b0;              //rd_prev & wr_prev
            //rd_valid<=!op;  wr_valid<=op;
        end else if((wr_a1_valid&&op)||(rd_a1_valid&&!op)) begin
            //rd_valid<=!op;     wr_valid<=op;
            wr_a1_valid<=1'b0; rd_a1_valid<=1'b0;
            if((wr_ppl&&op)||(rd_ppl&&!op))begin
                wr_en<=1'b0;          rd_en<=1'b0;
                rd_prev<=1'b0;        wr_prev<=1'b0;    //rd_prev & wr_prev
                n_state<=a1_p1;
            end else begin
                n_state<=idle;
                wr_en<=op;            rd_en<=!op;
                rd_prev<=!op;         wr_prev<=op;          //rd_prev & wr_prev
            end
        end else begin
                n_state<=idle;
                rd_en<=1'b0;	      wr_en<=1'b0;
                wr_a1_valid<=1'b0;    rd_a1_valid<=1'b0;
            //    rd_valid<=1'b0;       wr_valid<=1'b0;
                rd_prev<=1'b0;        wr_prev<=1'b0;        //rd_prev & wr_prev
        end
    end

default:
begin
            rd_valid<=1'b0;     wr_valid<=1'b0;
            rd_en<=1'b0;        wr_en<=1'b0;
            wr_prev<=1'b0;      rd_prev<=1'b0;              //rd_prev & wr_prev
            wr_a1_valid<=1'b0;  rd_a1_valid<=1'b0;
            op<=1'b0;	          prev_op<=1'b0;
            wr_ld<=1'b0;        rd_ld<=1'b0;
            wr_en<=1'b0;        rd_en<=1'b0;
            n_state<=idle;
end

   endcase
end

always @(posedge clk) begin
    if(rd_ld) rd_adrs_r<=rd_adrs;
    else      rd_adrs_r<=rd_adrs_r;
    if(wr_ld) wr_adrs_r<=wr_adrs;
    else      wr_adrs_r<=wr_adrs_r;

    if(rd_en) rd_out_adrs_r<=rd_adrs_r;
    else      rd_out_adrs_r<=32'h0000_0000;
    if(wr_en) wr_out_adrs_r<=wr_adrs_r;
    else      wr_out_adrs_r<=32'h0000_0000;
end

endmodule
