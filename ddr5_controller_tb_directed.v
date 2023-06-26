`timescale 1ns/1ns
module ddr5_controller_tb_directed();

/************ TB Wires Decleration ************/
reg						mclk_tb	=1'b0		;
reg						xclk_tb	=1'b0		;
reg						rst_tb		    	;
reg						R_Ready_tb			;
wire	[31	:	0]		R_Data_tb			;
wire					R_Valid_tb			;
reg						W_Valid_tb			;
reg		[31	:	0]		W_Data_tb			;
reg		[3  :   0]		W_STRB_tb			;
wire					W_Ready_tb			;
reg						W_Valid_Address_tb			;
reg		[31	:	0]		W_Address_tb	    		;
reg						R_Valid_Address_tb			;
reg		[31	:	0]		R_Address_tb		    	;
wire					R_Error_tb			        ;
wire					R_Ready_Address_tb			;
wire	[15	:	0]		DQ_tb			;
wire	[13	:	0]		CA_tb			;
wire					CS_tb			;


/************ Setting clk ************/
integer h_m_clk=1;
integer mclk=2;
always #h_m_clk mclk_tb=!mclk_tb;

integer h_x_clk=5;
integer xclk=10;
always #h_x_clk xclk_tb=!xclk_tb;

/************ Functions ************/



/************ Variables ************/
integer i;


/************ Initial Block ************/
initial begin

/* reset all blocks  */
    rst_tb=1'b0;
    #xclk
    rst_tb=1'b1;

/* Tests  */


/* test case 1 : single_write_1 */
$display("test 1 @ %0t : single_write_1",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h1425_3679;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h0000_4567;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 2 : single_write_2 */
$display("test 2 @ %0t : single_write_2",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h5148_AECF;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h0000_4823;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 3 : single_read_1 */
$display("test 3 @ %0t : single_read_1",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4567;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 4 : single_read_2 */
$display("test 4 @ %0t : single_read_2",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4823;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

end



/************ Module Instantiation ************/
top_top DUT(
	.mem_clk(mclk_tb),
	.axi_clk(xclk_tb),
    .rst_n(rst_tb),
	.R_Ready(R_Ready_tb),
	.R_Data(R_Data_tb),
	.empty1(R_Valid_tb),
    .empty2(),
    .empty3(),
    .empty4(),
    .W_Valid(W_Valid_tb),
	.W_Data(W_Data_tb),
	.W_STRB(W_STRB_tb),
	.full2(W_Ready_tb),
    .full3(),    
	//.W_Valid_Address(W_Valid_Address_tb),   
	.W_Address(W_Address_tb),           
	.R_Valid_Address_x(R_Valid_Address_tb),   //
    //.R_Valid(R_Valid_tb),
	.R_Address(R_Address_tb),
	.R_Error(R_Error_tb),
	.R_Ready_Address(R_Ready_Address_tb),
	.DQ(DQ_tb),
	.CA(CA_tb),
	.CS(CS_tb)
);


endmodule
