`timescale 1ns / 1ps
module counter#(parameter BITS=20)(
    	input logic clk,
	input logic reset,
	input logic enable,
	output logic [BITS-1:0] count
    );
	logic [BITS-1:0] cnt, ncnt;

	assign count=cnt;
	
	always_ff @(posedge(clk), posedge(reset))
		if(reset)
			cnt <= 0;
		else
			cnt <= ncnt;
	
	always_comb begin
		ncnt=cnt;
		if(enable)
			ncnt=cnt+1;
	end
endmodule
