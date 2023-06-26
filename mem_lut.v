module mem_lut#(
    parameter t_act=3
)(
    input [31:0] addr_i,
    input           en,
    input   clk,
    input [3:0] current_state,
    output [2:0]    BG, //one BG??
    output          BA,
    output [15:0]   row,
    output [9:0]    col

);

wire [31:0] addr_i_delayed1;
wire [31:0] addr_i_delayed2;
wire en_delayed;
wire en_delayed5;
// wire en_delayed3;
assign BG   =   3'b000;
assign BA = (en_delayed|en_delayed5)? ((current_state==4'd8)?(addr_i_delayed1[20]):(addr_i_delayed2[20])): 1'b0;
// assign BA   = (en_delayed|en_delayed5)  ?   (addr_i_delayed1? (addr_i_delayed1[20]):(addr_i_delayed2[20])   )          : 1'b0;
assign row  = (en_delayed|en_delayed5)  ?  ((current_state==4'd8)?({8'd0 , addr_i_delayed1[15:8]}):({8'd0 , addr_i_delayed2[15:8]}))  : 16'd0;
assign col  = (en_delayed|en_delayed5)  ?   ((current_state==4'd8)?({2'd0, addr_i_delayed1[7:0]}):({2'd0, addr_i_delayed2[7:0]}))  : 10'd0;
sh_reg #(.length(/*(t_act+4/2)*/2),.width(32)) addr_delay1(
    .D(addr_i),
    .clk(clk),
    .rst(/*rst*/),
    .Q(addr_i_delayed1)
);
sh_reg #(.length(t_act+4),.width(32)) addr_delay2(
    .D(addr_i),
    .clk(clk),
    .rst(/*rst*/),
    .Q(addr_i_delayed2)
);
sh_reg #(.length(/*(t_act+4/2)*/2),.width(1)) en_delay(
    .D(en),
    .clk(clk),
    .rst(/*rst*/),
    .Q(en_delayed)
);
sh_reg #(.length(t_act+4),.width(1)) en_delay5(
    .D(en),
    .clk(clk),
    .rst(/*rst*/),
    .Q(en_delayed5)
);
// sh_reg #(.length(t_act)) en_delay(
//     .D(en),
//     .clk(clk),
//     .rst(rst),
//     .Q(en_delayed)
// );
// sh_reg #(.length(t_act+1)) en_delay1(
//     .D(en),
//     .clk(clk),
//     .rst(rst),
//     .Q(en_delayed1)
// );
// sh_reg #(.length(t_act+2)) en_delay2(
//     .D(en),
//     .clk(clk),
//     .rst(rst),
//     .Q(en_delayed2)
// );
// sh_reg #(.length(t_act+3)) en_delay3(
//     .D(en),
//     .clk(clk),
//     .rst(rst),
//     .Q(en_delayed3)
// );
// sh_reg #(.length(t_act+4)) en_delay3(
//     .D(en),
//     .clk(clk),
//     .rst(rst),
//     .Q(en_delayed4)
// );
endmodule
