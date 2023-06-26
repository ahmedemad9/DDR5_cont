//this module generates an n-bit pointer rptr (the read pointer is a dual n-bit Gray code counter)
//this module generates (raddr) which is used to address the FIFO buffer
//this module generates an empty flag (rempty)

module rptr_empty #(parameter ADDRSIZE = 4)
(output reg                  rempty,
 output       [ADDRSIZE-1:0] raddr,
 output reg   [ADDRSIZE :0]  rptr,
 input        [ADDRSIZE :0]  rq2_wptr,
 input                       rinc, rclk, rrst_n);
 
reg   [ADDRSIZE:0] rbin;
wire  [ADDRSIZE:0] rgraynext, rbinnext;

//generating rptr (in GRAYSTYLE2) and raddr (in binary) 
always @(posedge rclk or negedge rrst_n)
  begin
    if (!rrst_n)
      begin
        rptr <= 0;
        rbin <= 0;
      end
    else 
      begin
        rptr <= rgraynext;
        rbin <= rbinnext;
      end
  end
 
assign rbinnext = rbin + (rinc & ~rempty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;

//memory read address 
assign raddr = rbin[ADDRSIZE-1:0];
  
//empty flag generation 
// FIFO is empty when rptr == synchronized wptr or on reset
assign rempty_val = (rgraynext == rq2_wptr);

always @(posedge rclk or negedge rrst_n)
  begin
    if (!rrst_n)  
      rempty <= 1'b1;
    else 
      rempty <= rempty_val;
  end
  
endmodule
