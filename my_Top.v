module my_Top(
  // Setup the inputs and outpus form the FPGA constrant file
  input clk,
  input btnU,
  input btnD,
  input btnL,
  input btnR,
  input btnC,
  output dp,
  output [3:0] an,
  output [6:0] seg
);

// Declare wires for the circuit
wire clock1000MHz;
wire up_Button;
wire down_Button;
wire right_Button;
wire left_Button;
wire center_Button;
wire decimal;
wire [3:0] display;
wire [6:0] segment;
wire [1:0] state;
wire [3:0] sec_Tens;
wire [3:0] sec_Ones;
wire [3:0] sec_Tenths;
wire [3:0] sec_Hundredths;
wire [3:0] seconds;
wire ten_Nano_Clock;
wire count_Enable;
wire tenths_Enable;
wire ones_Enable;
wire tens_Enable;
wire n_Enable;

//Connect inputs/outputs to wires
assign clock100MHz = clk;
assign up_Button = btnU;
assign down_Button = btnD;
assign right_Button = btnR;
assign left_Button = btnL;
assign center_Button = btnC;
assign display = an;
assign segememt = seg;
assign dp = !(4'b0010 & (1<<state));

/*---------------------------------------------------------------
module DeMux2to4L(
  input [1:0] select_State,
  output [3:0] display_Drive
);
---------------------------------------------------------------*/
DeMux2to4L demultiplexer(
  .select_State(state),
  .display_Drive(display)
);

/*---------------------------------------------------------------
module Display_Driver(
  input clock,
  output reg [1:0] select_State
);
---------------------------------------------------------------*/
Display_Driver d_Driver(
  .clock(clock100MHz),
  .select_State(state)
);

/*---------------------------------------------------------------
module Mux4to1x5(
  input [1:0] select_State,
  input [3:0] tens_Place,
  input [3:0] ones_Place,
  input [3:0] tenths_Place,
  input [3:0] hundredths_Place,
  output reg [3:0] current_Select
);
---------------------------------------------------------------*/
Mux4to1x5 multiplexer(
  .select_State(state),
  .tens_Place(sec_Tens),
  .ones_Place(sec_Ones),
  .tenths_Place(sec_Tenths),
  .hundredths_Place(sec_Hundredths),
  .current_Select(seconds)
);

/*---------------------------------------------------------------
module Control(
  input clock100MHz,
  input clock_Divided,
  input start,
  input down_Button,
  input right_Pause,
  input left_Pause,
  input clear,
  output count_Enable
);
---------------------------------------------------------------*/
Control state_Machine(
  .clock100MHz(clock100MHz),
  .clock_Divided(ten_Nano_Clock),
  .start(up_Button),
  .down_Button(down_Button),
  .right_Pause(right_Button),
  .left_Pause(left_Button),
  .clear(center_Button),
  .count_Enable(count_Enable)
);

/*---------------------------------------------------------------
module Xlate_hx(
  input [3:0] hex_Encoding,
  output reg [6:0] segments,
  output reg decimal
);
---------------------------------------------------------------*/
Xlate_hx hex_Coder(
  .hex_Encoding(seconds),
  .segments(segment),
  .decimal(decimal)
);


/*---------------------------------------------------------------
module Divider(
  input clock
  output reg divided_Clock
---------------------------------------------------------------*/
Divider divide_Clock(
  .clock(clock100MHz),
  .divided_Clock(ten_Nano_Clock)
);

/*---------------------------------------------------------------
module BCD_Counter(
  input clock,
  input clear,
  input enable_Count,
  output reg carry_Over,
  output reg [3:0] counter
);
---------------------------------------------------------------*/
BCD_Counter hundredths(
  .clock(ten_Nano_Clock),
  .clear(center_Button),
  .enable_Count(count_Enable),
  .carry_Over(tenths_Enable),
  .counter(sec_Hundredths)
);

BCD_Counter tenths(
  .clock(ten_Nano_Clock),
  .clear(center_Button),
  .enable_Count(tenths_Enable),
  .carry_Over(ones_Enable),
  .counter(sec_Tenths)
);

BCD_Counter ones(
  .clock(ten_Nano_Clock),
  .clear(center_Button),
  .enable_Count(ones_Enable),
  .carry_Over(tens_Enable),
  .counter(sec_Ones)
);

BCD_Counter tens(
  .clock(ten_Nano_Clock),
  .clear(center_Button),
  .enable_Count(tens_Enable),
  .carry_Over(n_Enable),
  .counter(sec_Tens)
);

endmodule
