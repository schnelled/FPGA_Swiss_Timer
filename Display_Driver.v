module Display_Driver(
  // Setup the inputs & outputs for the module
  input clock,
  output reg [1:0] select_State
);

// Declare a counter register
reg [15:0] counter;

// Initialize the counter
initial counter = 16'h0000;

always @ (posedge clock) begin
  // Check the value of the counter
  if(counter >= 16'hFFFF) begin
    // Reset the counter
    counter = 16'h0000;
  end
  
  //Increament the counter
  counter = counter + 1;
  
  //Set the current state
  select_State[0] = counter[14];
  select_State[1] = counter[15];
end
endmodule
