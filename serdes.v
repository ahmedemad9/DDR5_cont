module serdes#(
    parameter WIDTH = 4
)(
    input [WIDTH-1:0]       wdata,
    input                   SerDes_en,
                            SerDes_Sel,
                            rst_n,
                            mem_clk,
    output wire [WIDTH-1:0] rdata,
    inout wire              data_serdes,
    output wire             status
);

//serdes_sel??
wire data_des;

wire ser_en, des_en;

reg SerDes_Sel_r, SerDes_en_r; 

assign data_des= des_en? data_serdes:1'bz;
// assign data_serdes= des_en? data_serdes:1'bz;
// assign data_serdes= ser_en? data_serdes:1'bz;

assign ser_en = SerDes_en & SerDes_Sel;
assign des_en = SerDes_en & !SerDes_Sel;

serialiser#(WIDTH)ser(wdata,
                      ser_en,
                      rst_n,
                      mem_clk,
                      data_serdes);

deser     #(WIDTH)des(data_des,
                      des_en,
                      rst_n,
                      mem_clk,
                      rdata,
                      status);

always @(posedge mem_clk) begin
    SerDes_Sel_r=SerDes_Sel;
    SerDes_en_r =SerDes_en;
end
endmodule
