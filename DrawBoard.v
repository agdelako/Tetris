`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Module Name:    DrawBoard 
// Project Name: 
// Description:  
//
//////////////////////////////////////////////////////////////////////////////////
module DrawBoard(
				vclk,
				rst,
				hcount,
				vcount,
				pixel_board
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================	
	input						vclk; 
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel_board;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================

	reg		[18:0]		vis;
	reg		[18:0]		addr;
	reg		[7:0]			pixel_board;
	
	wire						pixel;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	
	
	always @(posedge vclk or posedge rst) 
	begin
		if (rst)
		begin
			addr = 0;
			vis = 0;
		end
		else
		begin	
			if ((hcount >= 92 && hcount < 718) && (vcount >= 0 && vcount < 600))
			begin
				addr= vis;
				vis = vis + 1;
			end
			else if (hcount >= 718)
			begin
				addr = 0;
			end
			else if (vcount >= 600)
			begin
				addr = 0;
				vis = 0;
			end
			
			if (pixel == 1)
				pixel_board = 8'h97;
			else
				pixel_board = 8'h0;
		end
	end

	/* Memory for board */
	mem_board board_mem(vclk, addr, pixel);

endmodule

