`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Delakoura Aggeliki
// 
// Module Name:    DrawBlock31 
// Project Name: Tetris-Game
// Description:  
//
//////////////////////////////////////////////////////////////////////////////////
module DrawBlock71(
				vclk,
				rst,
				hcount,
				vcount,
				pixel71
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================		
	input						vclk; 
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel71;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================

	reg		[12:0]		vis;
	reg		[12:0]		addr;
	reg		[7:0]			pixel71;
	
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
			if ((hcount >= 338 && hcount < 416) && (vcount >= 485 && vcount < 538))
			begin
				addr = vis;
				vis = vis + 1;
			end
			else if ((hcount < 338) || (hcount >= 416))
			begin
				addr = 77;
			end
			else if (vcount >= 538)
			begin
				vis = 0;
				addr = 77;
			end
			
			if (pixel == 2'b00)
				pixel71 = 8'h00;
			else if (pixel == 2'b11)
				pixel71 = 8'hFF;
			else 
				pixel71 = 8'hE0;
		end
	end

	/* Memory for purple block */
	block71_mem mem71(vclk,addr,pixel);

endmodule
