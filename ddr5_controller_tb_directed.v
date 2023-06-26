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
W_STRB_tb          =4'hE;
W_Address_tb       =32'h0000_4568;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 3 : single_write_3 */
$display("test 3 @ %0t : single_write_3",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5186;
W_STRB_tb          =4'h3;
W_Address_tb       =32'h0000_4569;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 4 : single_write_4 */
$display("test 4 @ %0t : single_write_4",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5187;
W_STRB_tb          =4'h6;
W_Address_tb       =32'h0000_4570;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 5 : single_write_5 */
$display("test 5 @ %0t : single_write_5",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5188;
W_STRB_tb          =4'h7;
W_Address_tb       =32'h0000_4571;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 6 : single_write_6 */
$display("test 6 @ %0t : single_write_6",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5189;
W_STRB_tb          =4'hC;
W_Address_tb       =32'h0000_4572;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 7 : single_write_7 */
$display("test 7 @ %0t : single_write_7",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5190;
W_STRB_tb          =4'hA;
W_Address_tb       =32'h0000_4573;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 8 : single_write_8 */
$display("test 8 @ %0t : single_write_8",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5191;
W_STRB_tb          =4'h7;
W_Address_tb       =32'h0000_4574;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 9 : single_write_9 */
$display("test 9 @ %0t : single_write_9",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5192;
W_STRB_tb          =4'h4;
W_Address_tb       =32'h0000_4575;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 10 : single_write_10 */
$display("test 10 @ %0t : single_write_10",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h3172_5193;
W_STRB_tb          =4'h0;
W_Address_tb       =32'h0000_4576;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 11 : single_read_1 */
$display("test 11 @ %0t : single_read_1",$realtime);
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

/* test case 12 : single_read_2 */
$display("test 12 @ %0t : single_read_2",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4568;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 13 : single_read_3 */
$display("test 13 @ %0t : single_read_3",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4569;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 14 : single_read_4 */
$display("test 14 @ %0t : single_read_4",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4570;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 15 : single_read_5 */
$display("test 15 @ %0t : single_read_5",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4571;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 16 : single_read_6 */
$display("test 16 @ %0t : single_read_6",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4572;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 17 : single_read_7 */
$display("test 17 @ %0t : single_read_7",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4573;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 18 : single_read_8 */
$display("test 18 @ %0t : single_read_8",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4574;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 19 : single_read_9 */
$display("test 19 @ %0t : single_read_9",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4575;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 20 : single_read_10 */
$display("test 20 @ %0t : single_read_10",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h0000_4576;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=5;i=i+1) #xclk;

/* test case 21 : input_w_rush_10 */
$display("test 21 @ %0t : input_w_rush_10",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5187;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4567;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 22 : input_w_rush_11 */
$display("test 22 @ %0t : input_w_rush_11",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5188;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4568;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 23 : input_w_rush_12 */
$display("test 23 @ %0t : input_w_rush_12",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5189;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4569;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 24 : input_w_rush_13 */
$display("test 24 @ %0t : input_w_rush_13",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5190;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4570;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 25 : input_w_rush_14 */
$display("test 25 @ %0t : input_w_rush_14",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5191;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4571;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 26 : input_w_rush_15 */
$display("test 26 @ %0t : input_w_rush_15",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5192;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4572;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 27 : input_w_rush_16 */
$display("test 27 @ %0t : input_w_rush_16",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5193;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4573;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 28 : input_w_rush_17 */
$display("test 28 @ %0t : input_w_rush_17",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5194;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4574;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 29 : input_w_rush_18 */
$display("test 29 @ %0t : input_w_rush_18",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5195;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4575;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 30 : input_w_rush_19 */
$display("test 30 @ %0t : input_w_rush_19",$realtime);
R_Ready_tb         =1'bx;
W_Valid_tb        =1'b1;
W_Data_tb          =32'h8493_5196;
W_STRB_tb          =4'hF;
W_Address_tb       =32'h1000_4576;
R_Valid_Address_tb =1'b0;
R_Address_tb       =32'hxxxx_xxxx;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 31 : input_r_rush_10 */
$display("test 31 @ %0t : input_r_rush_10",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4567;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 32 : input_r_rush_11 */
$display("test 32 @ %0t : input_r_rush_11",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4568;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 33 : input_r_rush_12 */
$display("test 33 @ %0t : input_r_rush_12",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4569;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 34 : input_r_rush_13 */
$display("test 34 @ %0t : input_r_rush_13",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4570;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 35 : input_r_rush_14 */
$display("test 35 @ %0t : input_r_rush_14",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4571;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 36 : input_r_rush_15 */
$display("test 36 @ %0t : input_r_rush_15",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4572;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 37 : input_r_rush_16 */
$display("test 37 @ %0t : input_r_rush_16",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4573;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 38 : input_r_rush_17 */
$display("test 38 @ %0t : input_r_rush_17",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4574;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 39 : input_r_rush_18 */
$display("test 39 @ %0t : input_r_rush_18",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4575;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

/* test case 40 : input_r_rush_19 */
$display("test 40 @ %0t : input_r_rush_19",$realtime);
R_Ready_tb         =1'b0;
W_Valid_tb        =1'b0;
W_Data_tb          =32'hxxxx_xxxx;
W_STRB_tb          =4'hx;
W_Address_tb       =32'hxxxx_xxxx;
R_Valid_Address_tb =1'b1;
R_Address_tb       =32'h1000_4576;
#xclk;              
W_Valid_tb         =1'b0;
R_Valid_Address_tb =1'b0;
for(i=0;i<=0;i=i+1) #xclk;

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
