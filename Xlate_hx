module Xlate_hx(
  // Setup the inputs & outputs for the module
  input [3:0] hex_Encoding,
  output reg [6:0] segments,
  output decimal
);

// Decode the 4-bit encoding to hex
always @ (*) begin
  case(hex_Encoding)
    4'b0000: segments[6:0] = 7'b1000000; //0
    4'b0001: segments[6:0] = 7'b1111001; //1
    4'b0010: segments[6:0] = 7'b0100100; //2
    4'b0011: segments[6:0] = 7'b0110000; //3
    4'b0100: segments[6:0] = 7'b0011001; //4
    4'b0101: segments[6:0] = 7'b0010010; //5
    4'b0110: segments[6:0] = 7'b0000010; //6
    4'b0111: segments[6:0] = 7'b1111000; //7
    4'b1000: segments[6:0] = 7'b0000000; //8
    default: segments[6:0] = 7'b0010000; //9
  endcase
end
endmodule
