module Control(
  // Setup the inputs & outputs for the module
  input clock100MHz,
  input clock_Divided,
  input start,
  input down_Button,
  input right_Button,
  input left_Button,
  clear,
  output reg count_Enable
);

// Declare wire bus for the buttons
reg [2:0] button_Press;

// Declare register to store the different states
reg [1:0] state;

// Preform state change every positive edge of the 100MHz clock
always @ (posedge clock100MHz) begin
  // Check for the button press
  button_Press[0] = clear;
  button_Press[1] = start;
  button_Press[2] = (right_Pause | left_Pause);
end

// Preform state change every positive edge of the divided clock
always @ (posedge clock_Divided) begin
  // Set the current state
  casex(button_Press)
  3'bxx1: begin
    state = 2'b01;
    count_Enable = 1'b0; end
  3'bx10: begin
    state = 2'b11;
    count_Enable = 1'b1; end
  3'b100: begin
    state = 2'b10;
    count_Enable =  1'b0; end
  default: begin
    state = 2'b00;
    count_Enable = count_Enable; end
  endcase
end
endmodule
