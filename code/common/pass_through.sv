`timescale 1ns / 1ps
module pass_through(
	input logic [15:0] SW,
	input logic CLK100MHZ,
	input logic BTNC,
    output logic [15:0] LED,
    output logic CA, CB, CC, CD, CE, CF, CG,
    output logic DP,
    output logic [7:0] AN
    );
	parameter SPD=26;
	parameter DISPLAY=19;

	logic [3:0] count2;
	logic [6:0] sseg;
	logic [15:0] count1;
	logic [SPD-1:0] count0;


	assign LED=SW;
	assign {CA, CB, CC, CD, CE, CF, CG} = sseg;

	sseg_driver my_sseg_conv(
    		.num(count2),
    		.sseg(sseg),
    		.dp(DP)
    	);

	counter #(SPD) countspeed(
		.clk(CLK100MHZ),
		.reset(0),
		.enable(1),
		.count(count0)
	);

	counter #(16) countshown(
		.clk(CLK100MHZ),
		.reset(BTNC),
		.enable(count0[SPD-1]),
		.count(count1)
	);
	
	
	assign count2= count0[DISPLAY]?
                  count0[DISPLAY-1]?count1[15:12]:count1[11:8] :
                  count0[DISPLAY-1]?count1[7:4]:count1[3:0];

	assign an = count0[DISPLAY]?
                  count0[DISPLAY-1]?8'b11110111:8'b11111011 :
                  count0[DISPLAY-1]?8'b11111101:8'b11111110;



endmodule
