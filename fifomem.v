module fifomem #(parameter DATASIZE = 8, // Memory data word width
                 parameter ADDRSIZE = 4) // Number of mem address bits
 (output [DATASIZE-1:0]   rdata,
  input  [DATASIZE-1:0]   wdata,
  input  [ADDRSIZE-1:0]   waddr, raddr,
  input                   winc, wfull, wclk);
  
// memory model
localparam DEPTH = 1<<ADDRSIZE;         // depth = 2^ADDRSIZE
reg [DATASIZE-1:0] mem [0:DEPTH-1];

  assign rdata = mem[raddr];
  
always @(posedge wclk)
 if (winc && !wfull) mem[waddr] <= wdata;
 
endmodule
  
  
