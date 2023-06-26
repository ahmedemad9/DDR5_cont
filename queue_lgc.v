module queue_lgc #(parameter BL=2)(
    input wire valid,
    input wire clk,
    input wire rst,
    output wire sh_en
    //output wire SerDes_sel,
    //output wire SerDes_en
);
wire cntr_en;
reg c_state, n_state;
wire cntr_status;
localparam idle=1'b0, strb=1'b1;

always @(posedge clk)
begin
  if(!rst)    c_state<=idle;
  else        c_state<=n_state;      
end

assign sh_en=!c_state;
//assign SerDes_en=c_state;
assign cntr_en=c_state;

always@(*)
begin
    case(c_state)
    idle:
      if(valid)       n_state<=strb;
      else            n_state<=idle;
    
    strb:
      if(cntr_status) n_state<=idle;
      else            n_state<=strb;
    
    default:          n_state<=idle;
    endcase    

end

cntr #(.BL(BL/2)) blcntr (
    .clk(clk),
    .en(cntr_en),
    .cntr_status(cntr_status)
);
endmodule
