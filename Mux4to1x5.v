module Mux4to1x5(
  // Setup the inputs & outputs for the module
  input [1:0] select_State,
  input [4:0] tens_Place,
  input [4:0] ones_Place,
  input [4:0] tenths_Place,
  input [4:0] hundredths_Place,
  output reg [4:0] current_Select
);

always @ (*) begin
  case(select_State)
    2'b00:    current_Select = tens_Place [4:0];
    2'b01:    current_Select = ones_Place [4:0];
    2'b10:    current_Select = tenths_Place [4:0];
    default:  current_Select = hundredths_Place [4:0];
  endcase
end
endmodule
