`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Delakoura Aggeliki
// 
// Module Name:    xvga 
// Project Name: 	 Tetris_Game 
// Description: The xvga module creates the signals for the refresh rate of the
//							display, the horizontal interval and the signal for the three 
//							colors red, green, blue. The signals of the three colors are 
//							consisted of a three bit vector for red and green and a two bit 
//							vector for blue.
//
//  Inputs:
//		clk				100MHz onboard system clock
//		rst				Main Reset Controller
//		frz				Signal to freeze the displaying frame
//
//  Outputs:
//		vsync			Signal for the reafresh rate of the display
//		hsync			Signal for the horizontal interval
//		VGA_R			Signal for color red
//		VGA_G			Signal for color green
//		VGA_B			Signal for color blue
//
////////////////////////////////////////////////////////////////////////////////////
//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//  ===================================================================================
module xvga( 
		clk, 
		rst,
		frz,
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
	input 			 		clk; 
	input		 		 		rst;
	input 			 		frz;
	input						sw_grid;
	input						LEFT;
	input						RIGHT;
	input						DOWN;
	output			 		vsync;
	output					hsync;
	output [2:0] 		VGA_R;
	output [2:0] 		VGA_G;
	output [1:0] 		VGA_B;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================	
	parameter				halfSec = 25000000,
									oneSec = 50000000;
								
	reg							vs;
	reg			 				hs;
  reg			 				frame;
	reg		[25:0]		Counter;
  reg 	[10:0]		hcount;
  reg 	[9:0]	 		vcount;

	wire						vclk;
	wire 					 	hfrntporch;
	wire					 	hsyncpulse;
	wire				 		hbackporch;
	wire 					 	vfrntporch;
	wire					 	vsyncpulse;
	wire				 		vbackporch;
	wire						debouncedLeft;
	wire						debouncedRight;
	wire						debouncedDown;
	wire	[7:0]			pixel;
	wire	[7:0]			pixel_grid;
	wire	[7:0]			final;
  wire				 win_rst1;
	wire 				 win_rst2;
	wire				 over1;
	wire				 over2;
	
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
	// horizontal: 1039 pixels total
	// display 800 pixels per line
	//assign hvarea = (hcount == 799);    
	assign hfrntporch = (hcount == 855);
	assign hsyncpulse = (hcount == 975);
	assign hbackporch = (hcount == 1039);

	// vertical: 665 lines total
	// display 600 lines
	//assign vvarea = hbackporch & (vcount == 599);    
	assign vfrntporch = hbackporch & (vcount == 636);
	assign vsyncpulse = hbackporch & (vcount == 642);
	assign vbackporch = hbackporch & (vcount == 665);
  

	/* Calculate the hcount, vcount, hsync, vsync */
	always @(posedge vclk or posedge rst) 
	begin
		if (rst)  
		begin
			hcount = 11'b0;
			vcount = 10'b0;
			vs = 1'b1;
			hs = 1'b1;
			Counter = 26'b0;
			frame = 1'b0;
		end
		else 
		begin
			hcount = hbackporch ? 11'b0 : hcount + 11'b1;       //At the end of each line hcount = 0 
			hs = hfrntporch ? 1'b0 : (hsyncpulse ? 1'b1 : hs);  // active low
			vcount = hbackporch ? (vbackporch ? 10'b0 : vcount + 10'b1) : vcount;  //At the end of each frame vcount = 0 
			vs = vfrntporch ? 1'b0 : vsyncpulse ? 1'b1 : vs;  // active low
			
			Counter = Counter + 26'b1;
			
			/* Calculate the line 
			if (!vs)
				counter = counter + 1;*/
			
			/* Check if a frame is completed */
			if (Counter == halfSec && !frz) 
			begin
				Counter = 26'b0;
				frame = 1'b1;
			end
			else
				frame = 1'b0;
		end
	end
	

	//-------------------------------------------------------------------------
	//		 							Generate final output
	//-------------------------------------------------------------------------


	//assign pixel = 8'hBB;//final_pixels;
	assign final = pixel | pixel_grid;
	assign VGA_R = final[7:5];
	assign VGA_G = final[4:2];
	assign VGA_B = final[1:0];
	assign vsync = ~vs;
	assign hsync = ~hs;				

	//-------------------------------------------------------------------------
	//		 							Draw the score
	//-------------------------------------------------------------------------
	
	
	//-------------------------------------------------------------------------
	//		 							Draw the grid
	//-------------------------------------------------------------------------
	Grid gridInst(
			.vclk(vclk),
			.sw_grid(sw_grid),
			.hcount(hcount),
			.vcount(vcount),
			.pixel_grid(pixel_grid)
);
	
	//-------------------------------------------------------------------------
	//		 							Debounce the buttons
	//-------------------------------------------------------------------------
	ButtonModule LEFTinst (
						 .vclk(vclk),
						 .button(LEFT),
						 .rst(rst),
						 .debounced_button(debouncedLeft)/*,
						 .btn1(btn1),
						 .btn2(btn2)*/
	);
	
	ButtonModule RIGHTinst (
						 .vclk(vclk),
						 .button(RIGHT),
						 .rst(rst),
						 .debounced_button(debouncedRight)/*,
						 .btn1(btnRight1),
						 .btn2(btnRight2)*/
	);
	
	ButtonModule DOWNinst (
						 .vclk(vclk),
						 .button(DOWN),
						 .rst(rst),
						 .debounced_button(debouncedDown)/*,
						 .btn1(btnDown1),
						 .btn2(btnDown2)*/
	); 

	//-------------------------------------------------------------------------
	//		 											Game Logic
	//-------------------------------------------------------------------------
	Game_Logic game (
			.frame(frame),
			.vclk(vclk),
			.rst(rst),
			.LEFT(debouncedLeft),
			.RIGHT(debouncedRight),
			.DOWN(debouncedDown),
			.hcount(hcount),
			.vcount(vcount),
			.vsync(vsync),
			.pixel(pixel)
	);


	//-------------------------------------------------------------------------
	// 							Get 50Mhz clock for the vga calculations
	//-------------------------------------------------------------------------
	DCM_SP #(
		.CLKDV_DIVIDE(2.0),                   // CLKDV divide value
																					// (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
    .CLKFX_DIVIDE(1),                     // Divide value on CLKFX outputs - D - (1-32)
    .CLKFX_MULTIPLY(4),                   // Multiply value on CLKFX outputs - M - (2-32)
    .CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
    .CLKIN_PERIOD(10.0),                  // Input clock period specified in nS
    .CLKOUT_PHASE_SHIFT("NONE"),          // Output phase shift (NONE, FIXED, VARIABLE)
    .CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
    .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
    .DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
    .DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
    .DSS_MODE("NONE"),                    // Unsupported - Do not change value
    .DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
    .FACTORY_JF(16'hc080),                // Unsupported - Do not change value
    .PHASE_SHIFT(0),                      // Amount of fixed phase shift (-255 to 255)
    .STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
 )
 DCM_SP_inst (
    .CLK0(CLK0),         // 1-bit output: 0 degree clock output
    .CLKDV(vclk),       // 1-bit output: Divided clock output
    .CLKFB(CLK0),       // 1-bit input: Clock feedback input
    .CLKIN(clk),       // 1-bit input: Clock input
    .RST(rst)            // 1-bit input: Active high reset input
 );
	
endmodule

