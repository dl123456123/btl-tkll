module myinterface( 
   input [17:0] SW,//[2:0] SW: mode 
	                //[3:3] SW: mode auto
	                //[17:17] SW: reset
	                //[16:14] SW: mode_hz

	input CLOCK_50,
	input [0:0] KEY,
	output [17:0] LEDR,
	output [8:0] LEDG,
	output [0:6] HEX7,
   output [0:6] HEX6,
   output [0:6] HEX5,
   output [0:6] HEX4,
   output [0:6] HEX3,
   output [0:6] HEX2,
   output [0:6] HEX1,
   output [0:6] HEX0
	);
	
	running_LED_v2 r1(
	.mode(KEY[0]), 
	.mode_hz(SW[16:14]), 
	.auto(SW[0]), 
	.clk(CLOCK_50), 
	.reset(SW[17]), 
	.out({LEDR,LEDG[7:0]}),
	.led7(HEX7), 
	.led6(HEX6), 
	.led5(HEX5), 
	.led4(HEX4),
	.led3(HEX3), 
	.led2(HEX2), 
	.led1(HEX1), 
	.led0(HEX0),
	.out_auto(LEDG[8])
	);
endmodule