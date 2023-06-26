module deser#(
    parameter WIDTH = 8
)(
    input data_i,
    input deser_en,
          rst_n,
          clk_i,
    output wire [WIDTH-1:0] data_o,
    output wire rdy
);

reg [WIDTH-1:0] data_o_n;
reg [WIDTH-1:0] data_o_p;
reg rdy_n, rdy_p;

assign data_o=clk_i?data_o_p:data_o_n;
assign rdy=clk_i?rdy_p:rdy_n;

reg [2:0] i;
always @(posedge clk_i) begin
    if(!rst_n)begin
        i <= WIDTH-2;
        data_o_p <= {WIDTH{1'bz}};
    end
    else begin
        if(deser_en|| i!= WIDTH-1)begin
            data_o_p [i] <= data_i;
            i <= i-2'd2;
            if(i <= 3'd0)begin
                i<=WIDTH-1;                rdy_p <= 1'b1;
            end
        end
        else begin
            data_o_p <= {WIDTH{1'b0}};
            i<=WIDTH-1;
        end
    end
end

reg [2:0] j;
always @(negedge clk_i) begin
    if(!rst_n)begin
        j <= WIDTH-1;
        data_o_n <= {WIDTH{1'b0}};
    end
    else begin
        if(deser_en|| j!= WIDTH-1)begin
            data_o_n [j] <= data_i;
            j <= j-2'd2;
            if(j <= 3'd0)begin
                j<=WIDTH-1;                rdy_n <= 1'b1;
            end
        end
        else begin
            data_o_n <= {WIDTH{1'bz}};
            j<=WIDTH-1;
        end
    end
end
endmodule
