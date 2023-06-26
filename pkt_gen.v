module pkt_gen(
    input [2:0]     BG,
    input           BA,
    input [15:0]    row,
    input [9:0]     col,
    input           CS_i,   //coming from pkt_gen_ctrl
                    clk,
    input [3:0]     current_state,

    output reg [13:0]   CA,
    //output              en,
    output reg          CS_o
);
//concatenate inputs in a certain way with CS at the begining 

reg [13:0] out1;
reg [13:0] out2;
reg [13:0] out3;
wire en;
assign en = (out1>0 || out2>0) ? 1'b1:1'b0;
wire VALID = 1'b1;

localparam [3:0]    IDLE = 4'd0,
                    ACT     =   4'd8,
                    WRP     =   4'd1,
                    WRPA    =   4'd3,
                    MRW     =   4'd2,
                    MRR     =   4'd6,
                    WR      =   4'd7,
                    WRA     =   4'd5,
                    RD      =   4'd4,
                    RDA     =   4'd12,
                    PRE     =   4'd13;

always @* begin
    case (current_state) 
        IDLE:begin
            out1[13:0] = 14'd0;
            out2[13:0] = 14'd0;
        end
        ACT:begin
                out1[1:0]    =   2'd0;
                out1[5:2]    =   row[3:0];
                out1[7:6]    =   {1'b0,BA}; //concatenation between BA and 0 on the MSB
                out1[10:8]   =   BG[2:0];
                out1[13:11]  =   3'd0;
                out2[11:0]   =   row[15:4];
                out2[13:12]  =   2'd0;
        end
        WRA:begin
                out1[0]      =   1'b1;
                out1[1]      =   1'b0;
                out1[3:2]    =   2'b11;
                out1[5:4]    =   2'd0;
                out1[7:6]    =   {1'b0,BA};
                out1[10:8]   =   BG[2:0];
                out1[13:11]  =   3'd0;
                out2[0]      =   VALID;   //VALID=HIGH
                out2[7:1]    =   col[9:3];
                out2[8]      =   1'b0;
                out2[9]      =   VALID;
                out2[11:10]  =   2'd0;
                out2[12]     =   VALID;
                out2[13]     =   1'b0;
        end
        RDA:begin
                out1[0]      =   1'b1;
                out1[1]      =   1'b0;
                out1[4:2]    =   3'd1;
                out1[5]      =   1'd0;
                out1[7:6]    =   {1'b0,BA};
                out1[10:8]   =   BG[2:0];
                out1[13:11]  =   3'd0;
                out2[7:0]    =   col[9:2];
                out2[8]      =   1'b0;
                out2[9]      =   VALID;
                out2[10]     =   1'd0;
                out2[11]     =   VALID;
                out2[12]     =   VALID;
                out2[13]     =   1'b0;
        end
         default:begin
            out1[13:0] = 14'd0;
            out2[13:0] = 14'd0;
        end
    endcase
end

always@(negedge clk)begin
    out3 <= out2;
end

always@(negedge clk)begin
    if(en)begin
        CS_o    =  1'b0;
    end
    else
        CS_o    =  1'b1;
end

always@(negedge clk or negedge CS_o)begin
    if(!CS_o)
        CA  <= out1;    
    else
        CA <= out3;
end

/*
always@(negedge clk)begin
    if(en)begin
        CA  <= CA_r;
    end
    else
        CA  <= 14'd0; //or CA remains unchanged?
end
*/


endmodule
