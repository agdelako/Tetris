`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:45 08/12/2014 
// Design Name: 
// Module Name:    LFSR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LFSR(
			vclk,
			rst,
			LEFT,
			RIGHT,
			DOWN,
			new_block
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================			
	input 			 			vclk;
	input							rst;
	input							LEFT;
	input							RIGHT;
	input							DOWN;
	input							new_block;
	output	[7:0]			out;
	
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================		
	
	reg			[7:0]			out;
	
	wire							linear_feedback;
	
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	
	
	always @(posedge vclk or posedge rst)
	begin
		if (rst)
			out = 8'b0;
		else if (new_block || LEFT || RIGHT || DOWN)
			out = {out[6],out[5],out[4],out[3],
						out[2],out[1],out[0],linear_feedback};
	end
	
	assign linear_feedback = !(out[7]^out[3]);

endmodule
