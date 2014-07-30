`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Module Name:    DrawBlock31 
// Project Name: 
// Description:  
//
//////////////////////////////////////////////////////////////////////////////////
module DrawBlock31(
				vclk,
				rst,
				hcount,
				vcount,
				pixel31
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================		
	input						vclk; 
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel31;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================

	reg		[12:0]		vis;
	reg		[12:0]		addr;
	reg		[7:0]			pixel31;
	
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
			if ((hcount >= 551 && hcount < 629) && (vcount >= 466 && vcount < 519))
			begin
				addr = vis;
				vis = vis + 1;
			end
			else if ((hcount < 551) || (hcount >= 629))
			begin
				addr = 0;
			end
			else if (vcount >= 519)
			begin
				vis = 0;
				addr = 0;
			end
			
			if (pixel == 2'b00)
				pixel31 = 8'h00;
			else if (pixel == 2'b11)
				pixel31 = 8'hFF;
			else
				pixel31 = 8'hCF;
		end
	end

	/* Memory for purple block */
	block31_mem mem31(vclk,addr,pixel);

endmodule
