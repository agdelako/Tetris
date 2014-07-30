`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Delakoura Aggeliki
// 
// Module Name:    Top_Logic 
// Project Name: 	 Tetris_Game
//
//////////////////////////////////////////////////////////////////////////////////
module Top_Logic(  
		clk,
		reset,
		FRZ,
		sw_grid,
		LEFT,
		RIGHT,
		DOWN,
		vsync,
		hsync,
		VGA_R,
		VGA_G,
		VGA_B
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================	
	input					clk;
  input					reset;
	input					FRZ;
	input					sw_grid;
	input					LEFT;
	input					RIGHT;
	input					DOWN;
	output				vsync;
	output				hsync;
	output [2:0]	VGA_R;
	output [2:0]	VGA_G;
	output [1:0] 	VGA_B;


// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	
	reg						rst;
	reg						resetprime;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
	/* Synchronize the reset signal */
	always @(posedge clk)
	begin
		resetprime = reset;
	end
	
	always @(posedge clk)
	begin
		rst = resetprime;
	end

		//-------------------------------------------------------------------------
		//	 								Generate the vga output
		//-------------------------------------------------------------------------
		xvga VGA( 
			 .clk(clk),
			 .rst(rst),
			 .frz(FRZ),
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

endmodule
