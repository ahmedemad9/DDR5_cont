/* this module generates the following signals:
 1. a write pointer 'wrptr', n-bit gray code counter
 2. 'waddr' which is used to address the FIFO buffer
 3. a full flag (wfull)                            */

module wptr_full #(parameter ADDRSIZE = 4)
 (output reg                wfull,
 output      [ADDRSIZE-1:0] waddr,
 output reg  [ADDRSIZE :0]  wptr,
 input       [ADDRSIZE :0]  wq2_rptr,
 input                      winc, wclk, wrst_n);
 
 reg  [ADDRSIZE:0]  wbin;
 wire [ADDRSIZE:0]  wgraynext, wbinnext;
 
 
// write pointer generation (in graystyle2)
always @(posedge wclk or negedge wrst_n)
  begin 
    if (!wrst_n)
      begin 
        wbin <= 0;
        wptr <= 0;
      end
    else 
      begin
        wbin <= wbinnext;
        wptr <= wgraynext;
      end
    end
    

// write address generation (in binary)
 assign waddr = wbin[ADDRSIZE-1:0];
 
 assign wbinnext = wbin + (winc & ~wfull);
 assign wgraynext = (wbinnext>>1) ^ wbinnext;
 
 
// full flag generation
 assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});


always @(posedge wclk or negedge wrst_n)
  begin
    if (!wrst_n) 
      wfull <= 1'b0;
    else 
      wfull <= wfull_val;
  end
  
  
endmodule