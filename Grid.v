`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:53 02/21/2014 
// Design Name: 
// Module Name:    Grid 
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
module Grid(
			vclk,
			sw_grid,
			hcount,
			vcount,
			pixel_grid
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================			
	input						vclk; 
	input						sw_grid;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel_grid;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg		[2:0]			temp_pixel_grid;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	

	always @(posedge vclk)
	begin
			if (sw_grid)
			begin
				if (hcount == 26 || hcount == 52 || hcount == 78 || hcount == 104 ||
					hcount == 130 || hcount == 156 || hcount == 182 || hcount == 208 ||
					hcount == 234 || hcount == 260 || hcount == 286 || hcount == 312 ||
					hcount == 338 || hcount == 364 || hcount == 390 || hcount == 416 ||
					hcount == 442 || hcount == 468 || hcount == 494 || hcount == 520 ||
					hcount == 546 || hcount == 572 || hcount == 598 || hcount == 624 ||
					hcount == 650 || hcount == 676 || hcount == 702 || hcount == 728 ||
					hcount == 754 || hcount == 780 || 
					vcount == 17 || vcount == 43 || vcount == 69 || vcount == 95 ||
					vcount == 121 || vcount == 147 || vcount == 173 || vcount == 199 ||
					vcount == 225 || vcount == 251 || vcount == 277 || vcount == 303 ||
					vcount == 329 || vcount == 355 || vcount == 381 || vcount == 407 ||
					vcount == 433 || vcount == 459 || vcount == 485 || vcount == 511 ||
					vcount == 537 || vcount == 563 || vcount == 589)
						temp_pixel_grid = 3'b111;
				else
						temp_pixel_grid = 3'b000;
			end
	end
	
	assign pixel_grid = {temp_pixel_grid,5'b0};


endmodule
