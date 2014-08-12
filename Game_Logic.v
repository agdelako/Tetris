`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Delakoura Aggeliki
// 
// Module Name:    Game_logic 
// Project Name:  
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//  ===================================================================================
module Game_Logic (
				rst,
				vclk,
				frame,
				LEFT,
				RIGHT,
				DOWN,
				hcount,
				vcount,
				vsync,
				pixel
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================		
	input		 		 			rst;
	input							vclk;
	input 			 			frame;
	input							LEFT;
	input							RIGHT;
	input							DOWN;
	input							vsync;
	input		[10:0]		hcount;
  input 	[9:0]	 		vcount;
	output	[7:0] 	  pixel;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================	
	/* State encoding */
	parameter			Start = 2'b00,
								Play = 2'b01,
								DisplayChanges = 2'b10,
								GameOver = 2'b11;
							
	parameter			X = 259,  // default X & Y
								Y = 17;
								
	integer				i;
	integer				j;
	integer				k;
	
	reg 	[10:0]  x_in;
	reg 	[9:0]		y_in;
	reg		[7:0]		pixel;
	reg		[1:0]		NextState;
	reg		[1:0]		State;
	reg						move;
	reg						new_block;
	
	
	//wire 	[10:0]  block_x;
	//wire 	[9:0]		block_y;
	wire	[10:0]	hcount;
	wire	[9:0]		vcount;
	wire 	[7:0]		pixel11;
	wire 	[7:0]		pixel21;
	wire 	[7:0]		pixel31;
	wire 	[7:0]		pixel41;
	wire 	[7:0]		pixel51;
	wire 	[7:0]		pixel61;
	wire 	[7:0]		pixel71;
	wire	[7:0]		pixel_board;
	wire	[7:0]		frame_pixel;
	wire					done;
	wire					check;
	wire					game_over;
	wire					vsync;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	

	/* State registers */
	always @(posedge vclk or posedge rst)
	begin
		if (rst)
		begin
			State = Start;
		end
		else
		begin
			State = NextState;	
		end
	end

	/* The FSM that controls the main logic of the game */
	always @( * )
	begin
		pixel = pixel_board;
		NextState = State;
		move = 1'b0;	
		new_block = 1'b0;
		x_in = X;
		y_in = Y;
		
		case (State)
			/* First the block to be shown is found pseudorandomly, *
			 * we initialize the Collision Buffer correctly and move*
			 * to the next state.																		*/
			Start :
				begin
						/*first = 8;
						sec = 9;
						third = 23;
						fourth = 24;*/		
					new_block = 1'b1;
					pixel = pixel_board | frame_pixel ;//| pixel11;
					if (frame)
					begin
						NextState = Play;
					end
				end
			Play :
				begin
					move = 1'b1;
					pixel =  pixel | pixel_board | frame_pixel ;//| pixel11;
					if (done)
						NextState = DisplayChanges;
				end
			DisplayChanges :
				begin
					pixel = pixel_board | frame_pixel ;//| pixel11 | pixel21 | pixel31 | pixel41| pixel51 | pixel61 | pixel71;
					if (frame)// && !game_over)
					begin
						NextState = Start;
					end
					//else
					//begin
						//NextState = GameOver;
					//end
				end
			GameOver:
				begin
					pixel = 8'h00;
				end
			default:;
		endcase
	end

	//-------------------------------------------------------------------------
	//		 							Draw the board
	//------------------------------------------------------------------------- 
	DrawBoard board(
				.vclk(vclk),
				.rst(rst),
				.hcount(hcount),
				.vcount(vcount),
				.pixel_board(pixel_board)
	);
	
	//-------------------------------------------------------------------------
	//		 							Calculate movement
	//-------------------------------------------------------------------------
	
	BlockMovement moveInst(
			.vclk(vclk),
			.rst(rst),
			.frame(frame),
			.LEFT(LEFT),
			.RIGHT(RIGHT),
			.DOWN(DOWN),
			.move(move),
			.vsync(vsync),
			.new_block(new_block),
			.hcount(hcount),
			.vcount(vcount),
			.x_in(x_in),
			.y_in(y_in),
			.done(done),
			.check(check),
			.game_over(game_over),
			//.block_x(block_x),
			//.block_y(block_y),
			.frame_pixel(frame_pixel)			
	);
	
	//-------------------------------------------------------------------------
	//		 							Calculate next tetromino
	//-------------------------------------------------------------------------
	
	LFSR LFSRInst(
			.vclk(vclk),
			.rst(rst),
			.LEFT(LEFT),
			.RIGHT(RIGHT),
			.DOWN(DOWN),
			.new_block(new_block)
	);
	
	//-------------------------------------------------------------------------
	//		 							Draw the blocks
	//------------------------------------------------------------------------- 
	/*DrawBlock11 green(
			.vclk(vclk),
			.rst(rst),
			.block_x(block_x),
			.block_y(block_y),
			.hcount(hcount),
			.vcount(vcount),
			.pixel11(pixel11)
	);
	
	DrawBlock21 blue(
			.vclk(vclk),
			.rst(rst),
			.hcount(hcount),
			.vcount(vcount),
			.pixel21(pixel21)
	); 
	
	DrawBlock31 purple(
			.vclk(vclk),
			.rst(rst),
			.hcount(hcount),
			.vcount(vcount),
			.pixel31(pixel31)
	);  
	
	DrawBlock41 cyan(
			.vclk(vclk),
			.rst(rst),
			.hcount(hcount),
			.vcount(vcount),
			.pixel41(pixel41)
	); 
	
	DrawBlock51 yellow(
			.vclk(vclk),
			.rst(rst),
			.hcount(hcount),
			.vcount(vcount),
			.pixel51(pixel51)
	);
	
	DrawBlock61 orange(
			.vclk(vclk),
			.rst(rst),
			.hcount(hcount),
			.vcount(vcount),
			.pixel61(pixel61)
	);
	
	DrawBlock71 red(
			.vclk(vclk),
			.rst(rst),
			.hcount(hcount),
			.vcount(vcount),
			.pixel71(pixel71)
	);*/

endmodule
