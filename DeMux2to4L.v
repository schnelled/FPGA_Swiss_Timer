module DeMux2to4L(
  //Setup the inputs & outputs for the module
  input [1:0] select_State,
  output reg [3:0] display_Drive
);

always @ (*) begin
  case(select_State)
    //Change the state of the display
    2'b00:    display_Drive = 4'b0111;
    2'b01:    display_Drive = 4'b1011;
    2'b10:    display_Drive = 4'b1101;
    default:  display_Drive = 4'b1110;
  endcase
end
endmodule
