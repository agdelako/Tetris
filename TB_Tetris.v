`timescale 1ns / 1ps
`define cycle 10
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:57:27 03/18/2014
// Design Name:   Top_Logic
// Module Name:   D:/Angelina/Dropbox/University/Ptyxiakh/Tetris_Game/TB_Tetris.v
// Project Name:  Tetris_Game
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_Tetris;

	// Inputs
	reg clk;
	reg reset;
	reg FRZ;
	reg sw_grid;
	reg LEFT;
	reg RIGHT;
	reg DOWN;

	// Outputs
	wire vsync;
	wire hsync;
	wire [2:0] VGA_R;
	wire [2:0] VGA_G;
	wire [1:0] VGA_B;

	// Instantiate the Unit Under Test (UUT)
	Top_Logic uut (
		.clk(clk), 
		.reset(reset), 
		.FRZ(FRZ), 
		.sw_grid(sw_grid), 
		.LEFT(LEFT), 
		.RIGHT(RIGHT), 
		.DOWN(DOWN), 
		.vsync(vsync), 
		.hsync(hsync), 
		.VGA_R(VGA_R), 
		.VGA_G(VGA_G), 
		.VGA_B(VGA_B)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		FRZ = 0;
		sw_grid = 0;
		LEFT = 0;
		RIGHT = 0;
		DOWN = 0;

		#500 reset = 1'b1;
		#500 reset = 1'b0;

	end
	
	// Drive the clock 
	always 
	begin
		#(`cycle/2) clk = ~clk;
	end
      
endmodule

