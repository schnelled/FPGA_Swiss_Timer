module Divider(
  input clock,
  output reg divided_Clock
);

// Declare counter variables
reg [19:0] counter;

// Initialize the variables
initial counter = 20'b00000000000000000000;
initial divided_Clock = 1'b0;

// Modify the clock signal
always @ (posedge clock) begin
  // Check the value of the counter
  if(counter >= 20'hf423f) begin
    //Reset the counter
    counter = 20'b00000000000000000000;
    // Change the state of the divided clock
    divided_Clock = 1'b1;
  end
  else begin
    //Increase the counter
    counter = counter + 1;
    divided_Clock = 1'b0;
  end
end
endmodule
