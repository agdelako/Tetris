`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Module Name:    DrawBlock11 
// Project Name: 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module DrawBlock11(
				vclk,
				rst,
				hcount,
				vcount,
				block_x,
				block_y,
				pixel11
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================	
	input						vclk;	
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	input		[10:0] 	block_x;
	input		[9:0] 	block_y;
	output	[7:0]		pixel11;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	parameter 			WIDTH = 78,  
                  HEIGHT = 53;
									
	reg		[12:0]		vis;
	reg		[12:0]		addr;
	reg		[7:0]			pixel11;
	
	wire	[1:0]			pixel;

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
			if ((hcount >= block_x && hcount < (block_x + WIDTH)) && (vcount >= block_y && vcount < (block_y + HEIGHT)))
			begin
				addr = vis;
				vis = vis + 1;
			end
			else if ((hcount < block_x) || (hcount >= (block_x + WIDTH)))
			begin
				addr = 0;
			end
			else if (vcount >= (block_y + HEIGHT))
			begin
				vis = 0;
				addr = 0;
			end
			
			/* Check the color value */
			if (pixel == 2'b00)
				pixel11 = 8'h00;
			else if (pixel == 2'b11)
				pixel11 = 8'hFF;
			else
				pixel11 = 8'h35;
		end
	end
	
	/* Memory for green block */
	block11_mem mem11(vclk,addr,pixel);

endmodule
