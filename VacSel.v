module VacSel #(
    parameter CLA    = 6,
    parameter CL     = 4,
    parameter CL_max = 10)(

    input wire              clk,
    input wire [3:0]        C_S,
    input wire [CL_max-1:0] valid,
    input wire [CL_max-1:0] cong,
    input wire              rst,
    output wire              rw,
    output reg [CL_max-1:0] mux_sel
);

reg rw_r;
reg c_state, n_state;
localparam Idle = 1'b0,
           Chk  = 1'b1;

reg [4:0] CL_itr;
localparam [3:0] WR  = 4'b0111,
                 WRA = 4'b0101,
                 RD  = 4'b0100,
                 ACTC = 4'b1001,
                 RDA = 4'b1100;

wire rw_r_del;
/////////////////////////////////////////
always @(posedge clk)
begin
    if(!rst) c_state<=Idle;
    else c_state <= n_state;
end
////////////////////////////////////////
/*assign CL_itr=  (C_S==WRA?CLA-2:
                (C_S==RDA?CLA  :
                (C_S==RD?CL    :
                (C_S==WR?CL-2  :
                 0
                ))))
*/
//assign mux_sel= 1<<CL_itr-1;
always @(posedge clk)
begin

  case(c_state)
    Idle:
    begin
        rw_r <= (C_S == WR | C_S == WRA);
        //CL_itr<=3'b000;
        mux_sel<=0;
        if(C_S==WRA)        CL_itr<=CL_max-(CLA-2)+1;
        else if (C_S==RDA)  CL_itr<=CL_max-(CLA)+1;
        else if (C_S==RD)   CL_itr<=CL_max-(CL)+1;
        else if (C_S==WR)   CL_itr<=CL_max-(CL-2)+1;
        else                CL_itr<=CL_itr;

        if(C_S == WR || C_S == WRA || C_S == RDA || C_S == RDA)
           n_state <= Chk;
        else n_state <= Idle;
    end

    Chk:
    begin
        rw_r<=rw_r_del;												//this is wrong it should be rw_r<=rw_r
        if(valid[CL_max-CL_itr-1'b1]) begin
            n_state<=Chk;
            mux_sel<=0;                                   //18/6 @ CWS
            if( !cong[CL_itr]) CL_itr<=CL_itr-1'b1;
            else               CL_itr<=CL_itr;
        end else begin
            //mux_sel[CL_max-CL_itr-1:0]<=0;
            //mux_sel[CL_max-1:CL_max-CL_itr+1]<=0;
            mux_sel<= (1<<CL_itr);                               //18/6 @ CWS
            CL_itr<=CL_itr;
            n_state <= Idle;
            //mux_sel_r[CL_max-CL_itr] <= 1'b1;
        end
    end
/*
	 default:
	 begin
		rw_r<=1'b0;
		mux_sel<=0;
		CL_itr<=0;
      n_state <= Idle;
	 end
*/
  endcase

end
   assign rw= rw_r_del;
    
sh_reg #(.length(3),.width(1))rw_r_delayed(
    .D(rw_r),
    .clk(clk),
    .rst(rst),
    .Q(rw_r_del)
);
endmodule


