module serdes_top#(
    parameter WIDTH = 32,
    parameter arch  = 16,
    parameter BL    = WIDTH/arch
)(
    input [WIDTH-1:0] wdata,
    input SerDes_en,
          SerDes_Sel,
          rst_n,
          mem_clk,
    inout wire  [arch-1:0]  DQ,
    output wire [WIDTH-1:0] rdata,
    output wire status
);

wire [arch/2-1:0] pos_ser;
wire [arch/2-1:0] neg_ser;
wire [arch/2-1:0] pos_des;
wire [arch/2-1:0] neg_des;

wire  [arch-1:0]  DQ_n;
wire  [arch-1:0]  DQ_p;
wire  [arch-1:0]  DQ_r;


genvar i;
generate
/*
    for(i=0;i<arch/2;i=i+1)begin : make_serdes_in_conns
      assign pos_ser[i]=wdata[2*i];
      assign neg_ser[i]=wdata[2*i+1];
    end
    for(i=0;i<arch/2;i=i+1)begin : generate_serdes_p
        serdes#(BL/2) serdes_inst(
            .wdata       (pos_ser[i+BL/2-1:i]),
            .SerDes_en   (SerDes_en),
            .SerDes_Sel  (SerDes_Sel),
            .rst_n       (rst_n),
            .mem_clk     (mem_clk),
            .rdata       (pos_des[i+BL/2-1:i]),
            .data_serdes (DQ[i]),
            .status      ()
        );
      end
      for(i=1;i<arch/2;i=i+1)begin : generate_serdes_n
          serdes_n#(BL/2) serdes_inst_n(
              .wdata       (neg_ser[i+BL/2-1:i]),
              .SerDes_en   (SerDes_en),
              .SerDes_Sel  (SerDes_Sel),
              .rst_n       (rst_n),
              .mem_clk     (mem_clk),
              .rdata       (neg_des[i+BL/2-1:i]),
              .data_serdes (DQ[i]),
              .status      ()
          );
      end
      for(i=0;i<arch/2;i=i+1)begin : make_des_in_conns
        assign rdata[2*i]  =pos_des[i];
        assign rdata[2*i+1]=neg_des[i];
      end
endgenerate
*/

    for(i=0;i<arch;i=i+1)begin : generate_serdes
        serdes#(BL) serdes_inst(
            //.wdata       (wdata[BL*i+BL-1:BL*i]),
            .wdata       (wdata[2*i+1:2*i]),
            .SerDes_en   (SerDes_en),
            .SerDes_Sel  (SerDes_Sel),
            .rst_n       (rst_n),
            .mem_clk     (mem_clk),
            .rdata       (rdata[BL*i+BL-1:BL*i]),
            .data_serdes (DQ[i]),
            .status      ()
        );
		  end
      /*
      for(i=1;i<2*arch;i=i+2)begin : generate_serdes_n
          serdes_n#(BL/2) serdes_inst_n(
              .wdata       (wdata[BL*i+BL-1:BL*i]),
              .SerDes_en   (SerDes_en),
              .SerDes_Sel  (SerDes_Sel),
              .rst_n       (rst_n),
              .mem_clk     (mem_clk),
              .rdata       (rdata[BL*i+BL-1:BL*i]),
              .data_serdes (DQ[i]),
              .status      ()
          );
        end
        */
endgenerate

endmodule

/*
serdes#(WIDTH/8)serdes1(wdata[3:0],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[3:0],
                      status);

serdes#(WIDTH/8)serdes2(wdata[7:4],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[7:4],
                      status);

serdes#(WIDTH/8)serdes3(wdata[11:8],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[11:8],
                      status);

serdes#(WIDTH/8)serdes4(wdata[15:12],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[15:12],
                      status);

serdes#(WIDTH/8)serdes5(wdata[19:16],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[19:16],
                      status);

serdes#(WIDTH/8)serdes6(wdata[23:20],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[23:20],
                      status);

serdes#(WIDTH/8)serdes7(wdata[27:24],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[27:24],
                      status);

serdes#(WIDTH/8)serdes8(wdata[31:28],
                      SerDes_en,
                      SerDes_Sel,
                      rst_n,
                      mem_clk,
                      rdata[31:28],
                      status);
*/
