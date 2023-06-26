module MemCont #(
    parameter t_act=8,
    parameter t_pre=8
)
(
    input wire clk,
    input wire rst,

    input wire ppl,

    input wire rd_valid,
    input wire wr_valid,

    input wire busy,

    //input wire rw,
    output reg [3:0] c_state,
    output reg ready
);

localparam [3:0] Idle = 4'b0000,
                 WRP  = 4'b0001,
                 WRPA = 4'b0011,
                 MRW  = 4'b0010,
                 MRR  = 4'b0110,
                 WR   = 4'b0111,
                 WRA  = 4'b0101,
                 RD   = 4'b0100,
                 RDA  = 4'b1100,
                 PRE  = 4'b1101,
                 PREH = 4'b1110,
                 ACT  = 4'b1000,
                 ACTC = 4'b1001,
                 PREC = 4'b1011;

reg [3:0] n_state;
reg [3:0] op;

reg act_cntr_en;
wire act_cntr_status;

reg pre_cntr_en;
wire pre_cntr_status;

wire [3:0] op_delay;
///////////*     Switch to Next State    *///////////
always @(posedge clk)
begin
    if(!rst)
    begin
        c_state<=Idle;
        //act_cntr_en<=1'b0;
        ////pre_cntr_en<=1'b0;
    end
    else       c_state<=n_state;
end
///////////*     Next State Logic    *///////////
always @(*)
begin
    /*
    n_state=Idle;
    act_cntr_en=1'b0;
    pre_cntr_en=1'b0;
    ready = 1'b0;
*/
    case(c_state)

        Idle:
        begin
            act_cntr_en=1'b0;
            pre_cntr_en=1'b0;
            //ready = 1'b1;
            ready = !busy;
            n_state=((rd_valid||wr_valid)&&!busy)?ACT:Idle;

            if(wr_valid)      op=WRA;
            else if(rd_valid) op=RDA;
            else              op=4'h0;
        end

        ACT:
        begin
		  /*
          if      (op==WRA &&  ppl)  op=WR;
          //else if (wr_valid && !ppl)  op=WRA;
          else if (op==RDA &&  ppl)  op=RD;
          //else if (rd_valid && !ppl)  op=RDA;
          else                       op=op;
      */
      op=4'h0;
			 n_state=ACTC;
          act_cntr_en=1'b0;
          pre_cntr_en=1'b0;
          ready = 1'b0;
        end

        ACTC:
        begin
           pre_cntr_en=1'b0;
           ready = 1'b0;
           op=4'h0; //op=op;
           if(act_cntr_status)
           begin
               if(ppl && op_delay==WRA)      n_state=WR;
               else if(ppl && op_delay==RDA) n_state=RD;
               else                          n_state=op_delay;
               act_cntr_en=1'b0;
           end else begin
                n_state=ACTC;
                act_cntr_en=1'b1;
           end
        end

        RDA:
        begin
           op=4'h0;
           act_cntr_en=1'b0;
           pre_cntr_en=1'b0;
           ready = 1'b0;
           n_state=Idle;
        end

        WRA:
        begin
           op=4'h0;
           act_cntr_en=1'b0;
           pre_cntr_en=1'b0;
           ready = 1'b0;
           n_state=Idle;
        end

        RD :
        begin
            if(rd_valid && !ppl)     n_state=RDA;
            else if(rd_valid && ppl) n_state=RD;
            else                     n_state=PREH;
            op=4'h0;
            act_cntr_en=1'b0;
            pre_cntr_en=1'b0;
            ready = 1'b1;
        end

        WR :
        begin
            if(wr_valid && !ppl)     n_state=WRA;
            else if(wr_valid && ppl) n_state=WR;
            else                     n_state=PREH;
            op=4'h0;
            act_cntr_en=1'b0;
            pre_cntr_en=1'b0;
            ready = 1'b1;
        end

        PREH :
        begin
            op=4'h0;
            if(!busy) n_state=PRE;
            else       n_state=PREH;
            act_cntr_en=1'b0;
            pre_cntr_en=1'b0;
            ready = 1'b0;
        end

        PRE :
        begin
            op=4'h0;
            n_state=PREC;
            act_cntr_en=1'b0;
            pre_cntr_en=1'b0;
            ready = 1'b0;
        end

        PREC:
        begin
           op=4'h0;
           act_cntr_en=1'b0;
           pre_cntr_en=1'b1;
           ready = 1'b0;
           if(pre_cntr_status)
           begin
               pre_cntr_en=1'b0;
               n_state=Idle;
           end else begin
              pre_cntr_en=1'b1;
              n_state=PREC;
           end
        end

        default:
        begin
           op=4'h0;
           act_cntr_en=1'b0;
           pre_cntr_en=1'b0;
           ready = 1'b0;
           n_state=Idle;
        end
    endcase
end
    cntr_4 #(.BL(t_act)) act_cntr (
    .clk(clk),
    .en(act_cntr_en),
    .cntr_status(act_cntr_status)
    );

    cntr_4 #(.BL(t_pre)) pre_cntr (
    .clk(clk),
    .en(pre_cntr_en),
    .cntr_status(pre_cntr_status)
    );

    sh_reg #(.length(t_act+3), .width(4)) op_t_act(
      .D(op),
      .clk(clk),
      .rst(rst),
      .Q(op_delay)
      );
endmodule
