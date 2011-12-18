module Shift_Right(clk, res, shift, mux, outp);
  input clk,res;
  input [31:0] mux;
  input [7:0] shift;
  reg [7:0] tmp;
  integer n=0;
  reg [26:0] fra = 0;
  output reg [26:0] outp; //26 for signal, 25:0 for num "1" before dot and two reserved at the end.
  always @(posedge clk) begin
    fra[24:2] = mux[22:0]; //reserve two places at the end.
    if(shift)
      begin
        tmp = shift - 128;
        outp[24:0] = fra>>tmp;
        n = 25-tmp;
        outp[n] = 1; //number "1" before dot
        outp[26] = mux[31]; //signal
        outp[n] = 0;
      end
    if(!res)
      outp = 0;
    end
endmodule