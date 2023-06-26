module top_fifos#(
  parameter DSIZE = 8,
  parameter ASIZE = 4
 )
 (
input 					mem_clk,axi_clk,rst_n,
						w_en1,r_en1,
						w_en2,r_en2,
						w_en3,r_en3,
						w_en4,r_en4,
	  
input [DSIZE-1:0]		rdata1,
input [DSIZE-1:0]		W_data2,
input [DSIZE-1:0]		Data_in3,
input [DSIZE-1:0]		Data_in4,  
		  
		  		  
output 					full1,empty1,
						full2,empty2,
						full3,empty3,
						full4,empty4,
	   
output [DSIZE-1:0]		R_Data1,
output [DSIZE-1:0]		Data_in2,
output [DSIZE-1:0]		Data_out3,
output [DSIZE-1:0]		Data_out4
	   
	   
);


fifo_top #(DSIZE,ASIZE)  Rd_Data_F (	.winc(w_en1),
								.wclk(mem_clk),
								.wrst_n(rst_n),
								.rinc(r_en1),
								.rclk(axi_clk),
								.rrst_n(rst_n),
								.wdata(rdata1),
								.rdata(R_Data1),
								.wfull(full1),
								.rempty(empty1));
								//R_Valid (not empty1)?



fifo_top #(DSIZE,ASIZE)  Wr_Data_F (	.winc(w_en2),
								.wclk(axi_clk),
								.wrst_n(rst_n),
								.rinc(r_en2),
								.rclk(mem_clk),
								.rrst_n(rst_n),
								.wdata(W_data2),
								.rdata(Data_in2),
								.wfull(full2),
								.rempty(empty2));




fifo_top #(DSIZE,ASIZE)  Wr_Adress_F (.winc(w_en3),
								.wclk(axi_clk),
								.wrst_n(rst_n),
								.rinc(r_en3),
								.rclk(mem_clk),
								.rrst_n(rst_n),
								.wdata(Data_in3),
								.rdata(Data_out3),
								.wfull(full3),
								.rempty(empty3));



fifo_top #(DSIZE,ASIZE)  Rd_Adress_F (.winc(w_en4),
								.wclk(axi_clk),
								.wrst_n(rst_n),
								.rinc(r_en4),
								.rclk(mem_clk),
								.rrst_n(rst_n),
								.wdata(Data_in4),
								.rdata(Data_out4),
								.wfull(full4),
								.rempty(empty4));

endmodule 
