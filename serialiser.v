module serialiser#(
    parameter WIDTH = 2
)(
    input [WIDTH-1:0] data_i,
    input ser_en,
          rst_n,
          clk_i,
    output wire data_o_w
);

reg [WIDTH-1:0] data_o_n;
reg [WIDTH-1:0] data_o_p;


wire [2:0] data_o_n_r;

assign data_o_w=clk_i?data_o_p:data_o_n;
assign data_o=(ser_en)? data_o_w:1'bz;

//assign data_o_ww = (cntr <=(16-BL)/2)?data_o_w:{WIDTH{1'b0}};

reg [3:0]cntr;
wire cntr_en;

reg [2:0] i;

always @(posedge clk_i) begin
    if(!rst_n)begin
        data_o_p <= {WIDTH{1'b0}};
        i<=WIDTH-2;
    end
    else begin
        if(ser_en)begin //|| i!= WIDTH-1)begin
            data_o_p <= data_i[i];
            if(i>=0)
                i<=WIDTH;
            else
                i<=i-2;
        end
        else begin
            data_o_p <= (cntr !=(16-WIDTH+1)/2) ? /*{WIDTH{1'b0}}*/ data_o_p : {WIDTH{1'bz}};
            i<=WIDTH-2;
        end
    end
end

reg [2:0] j;
always @(negedge clk_i) begin
    if(!rst_n)begin
        data_o_n <= {WIDTH{1'b0}};
        j<=WIDTH-1;
    end
    else begin
        if(ser_en)begin //|| j!= WIDTH-1)begin
            data_o_n <= data_i[j];
            if(j>=2)
                j<= j-1;
            else
                j<=WIDTH-1;
            // j <= j-2'd2;
            // if(j==3'd0)begin
            //     j <= WIDTH-1;
            // end
        end
        else begin
            data_o_n <= (cntr !=(16-WIDTH+1)/2) ? /*{WIDTH{1'b0}}*/data_o_n : {WIDTH{1'bz}};
            j<=WIDTH-1;
        end
    end
end

assign data_o_n_r[0] = data_o_n;
genvar ii;
generate
    for(ii=0;ii<2;ii=ii+1) begin : generate_wen_delay
        DFF sh_reg(
            .D(data_o_n_r[ii]),
            .Q(data_o_n_r[ii+1]),
            .clk(clk_i),
            .rst(rst_n)
        );
		  end

endgenerate


always @(posedge clk_i) begin
    if(!rst_n) cntr<=0;
    else if(cntr_en || cntr <(16-WIDTH)/2)begin
        if(cntr==0) cntr<=(16-WIDTH)/2;
        else begin
          cntr<=cntr-1;      
        end
    end
end

sh_reg #(.length(1),.width(1)) cntr_en_sh(
    .D(ser_en),
    .Q(cntr_en),
    .clk(clk_i),
    .rst(rst_n)
);

endmodule
