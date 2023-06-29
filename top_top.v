module top_top(
    input               mem_clk,
                        axi_clk,
                        sm_clk,
                        rst_n,
                        R_Ready,
                        W_Valid,
    input wire          [3:0] W_STRB,
                        //W_Valid_Address,
    input wire          R_Valid_Address_x,

    input [31:0]        W_Data,
    input [31:0]        W_Address,
    input [31:0]        R_Address,

	output reg 			R_Error,

	output   			R_Ready_Address,

    output              //R_Valid,
                        CS,
                        full2,
                        full3,
                        empty1,
                        empty2,
                        empty3,
                        empty4,

    output [31:0]       R_Data,

    output [15:0]       DQ,

    output [13:0]       CA
);

parameter data_w = 32;
parameter arch   = 16;
parameter BL     = data_w/arch;
parameter CL     = 20;
parameter CLA    = 20;
parameter CL_max = 40;  //always edit width in VacSel file
parameter t_act  = 5;
parameter t_pre   = 5;

wire W_Valid_Address;
assign W_Valid_Address=W_Valid;

wire 		status;
wire			SerDes_en;
wire			SerDes_Sel;
wire			load_rd_adrs;
wire        load_wr_adrs;
wire    	BA;
wire		[3:0]   C_S;
wire		CS_wire;
wire        full1;
wire        full4;


wire [31:0] rdata;
wire [31:0]            Data_in;
wire [31:0]            Data_out1;
wire [31:0]           Data_out2;
wire [31:0]          mux_o;

wire [2:0]  BG;
wire [15:0] row;
wire [9:0] 	col;

wire 		rw; //coming from pu

wire 	    [31:0] str_o;

reg 		R_Valid_Address;

assign R_Ready_Address = !(full1|full4);


assign str_o = (W_Valid) ? ({W_Data[31:24] & {8{W_STRB[3]}} ,
                             W_Data[23:16] & {8{W_STRB[2]}} ,
                             W_Data[15:8]  & {8{W_STRB[1]}} ,
                             W_Data[7:0]   & {8{W_STRB[0]}} }) : 32'd0;

/*
assign str_o = (W_Valid) ? ({W_Data[31:24] & W_STRB[3],
                             W_Data[23:16] & W_STRB[2],
                             W_Data[15:8] & W_STRB[1] ,
                             W_Data[7:0] & W_STRB[0]    }) : 32'd0;
*/

wire [BL:0] sh_reg_conn;
wire [1:0]  sh_reg_ren;


always@(R_Address)begin
    if((R_Address >= 32'h0000_0000 && R_Address < 32'h0000_8001) || (R_Address >= 32'h0010_0000 && R_Address < 32'h0010_8001)) begin
        R_Error <= 1'b0;
        R_Valid_Address <= 1'b1;
    end else begin
        R_Error <= 1'b1;
        R_Valid_Address <= 1'b0;
    end
end


//assign mux_o = (rw) ? Data_out1 : Data_out2 ;
//ASIZE???????????

top_fifos#(.DSIZE(32),
           .ASIZE(4))
   fifos(
   .mem_clk(mem_clk),
   .axi_clk(axi_clk),
   .rst_n(rst_n),
   .w_en1(sh_reg_conn[BL]),
   .r_en1(R_Ready),
   .w_en2(W_Valid),
   .r_en2(sh_reg_ren[1]),
   .w_en3(W_Valid_Address),
   .r_en3(load_wr_adrs),
   .w_en4(R_Valid_Address_x&R_Valid_Address), //Emad Edited this
   .r_en4(load_rd_adrs),

   //input data
   .rdata1(rdata),
   .W_data2(str_o),
   .Data_in3(W_Address),
   .Data_in4(R_Address),

   .full1(full1),
   .empty1(empty1),
   .full2(full2),
   .empty2(empty2),
   .full3(full3),
   .empty3(empty3),
   .full4(full4),
   .empty4(empty4),

   //output data
   .R_Data1(R_Data),
   .Data_in2(Data_in),
   .Data_out3(Data_out1),
   .Data_out4(Data_out2)

);


pkt_gen_ctrl pktGenCtrl(.clk(mem_clk),
                        .rst_n(rst_n),
                        .current_state(C_S), //coming
                        .CS_o(CS_wire)
);


pkt_gen pktGen(.BG(BG),
               .BA(BA),
               .row(row),
               .col(col),
               .CS_i(CS_wire),
               .clk(mem_clk),
               .current_state(C_S), //coming from pu

               .CA(CA),
               .CS_o(CS)
);

serdes_top#(
    .WIDTH(data_w),
    .arch(arch)
)serdesTop(
    .wdata(Data_in),
    .SerDes_en(SerDes_en),
    .SerDes_Sel(SerDes_Sel),
    .rst_n(rst_n),
    .mem_clk(mem_clk),
    .rdata(rdata),
    .DQ(DQ),
    .status(status)
);

//wire [BL:0] sh_reg_conn;
assign sh_reg_conn[0]= SerDes_en& !SerDes_Sel;
assign sh_reg_ren[0]= SerDes_en& SerDes_Sel;

/*
sh_reg #(.length(BL), .width(1)) op_t_act(
  .D(sh_reg_conn[i]),
  .clk(clk),
  .rst(rst),
  .Q(sh_reg_conn[i+1])
  );
*/
genvar i;
generate
    for(i=0;i<BL;i=i+1) begin : generate_wen_delay
        DFF sh_reg(
            .D(sh_reg_conn[i]),
            .Q(sh_reg_conn[i+1]),
            .clk(mem_clk),
            .rst(rst_n)
        );
		  end

endgenerate
        DFF sh_reg(
            .D(sh_reg_ren[0]),
            .Q(sh_reg_ren[1]),
            .clk(mem_clk),
            .rst(rst_n)
        );


mem_lut #(.t_act(t_act))memLUT(.addr_i(mux_o),
               .en(adrs_valid), //coming from pu
               .BG(BG),
               .BA(BA),
               .current_state(C_S),
               .clk(mem_clk),
               .row(row),
               .col(col)
);

PU#(
    .CLA(CLA),
    .CL(CL),

    .q_max(CL_max),
    .BL(BL),

    .t_act(t_act),
    .t_pre(t_pre)
)
PU_inst
(
    .clk(mem_clk),
    .rst(rst_n),

    .rd_adrs(Data_out2),
    .wr_adrs(Data_out1),

    .rd_mt(empty4),
    .wr_mt(empty3),

    .C_S(C_S),

    .rw_mux_sel(),

    .SerDes_en(SerDes_en),
    .SerDes_sel(SerDes_Sel),
    .rd_en(load_rd_adrs),
    .wr_en(load_wr_adrs),

    .valid(adrs_valid),
    .adrs_out(mux_o)
);
/*
veloce_ddr5_sm mem_module (
  .RESET_N(rst_n),
  .CK_t(mem_clk),
  .CK_c(~mem_clk),
  .CS_n(CS),
  .CA(CA),
  .CAI(),
  .MIR(),
  .DM_n(),
  .DQ(DQ),
  .DQS_t(),
  .DQS_c(),
  .ALERT_n()
);
*/
endmodule
