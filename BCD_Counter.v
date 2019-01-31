module BCD_Counter(
  input clock,
  input clear,
  input enable_Count,
  output reg carry_Over = 1'b0,
  output reg [3:0] counter = 4'd0
);

always @ (posedge clock) begin
  // Check for clear
  if(clear) begin
    // Clear the counter register
    counter = 4'd0;
    carry_Over = 1'b0;
  end
  
  //Check for count enable signal
  if(enable_Count) begin
    // Check for the counter register to be in range
    if(counter == 4'd9) begin
      // Increase the counter
      carry_Over = 1'b1;
      counter = 4'b0000;
    end
    
    // Check the register value
    else if(counter == 4'd0) begin
      // Roll the register value
      counter = counter + 1;
      carry_Over = 1'b0;
    end
    
    else begin
      // Increment the counter
      counter = counter + 1'b1;
      carry_Over = 1'b0;
    end
  end
endmodule
