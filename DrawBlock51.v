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
module DrawBlock51(
				vclk,
				rst,
				hcount,
				vcount,
				pixel51
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================	
	input						vclk; 
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel51;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================

	reg		[11:0]		vis;
	reg		[11:0]		addr;
	reg		[7:0]			pixel51;
	
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
			if ((hcount >= 208 && hcount < 261) && (vcount >= 407 && vcount < 461))
			begin
				addr = vis;
				vis = vis + 1;
			end
			else if ((hcount < 208) || (hcount >= 261))
			begin
				addr = 0;
			end
			else if (vcount >= 461)
			begin
				vis = 0;
				addr = 0;
			end
			
			if (pixel == 2'b00)
				pixel51 = 8'h00;
			else if (pixel == 2'b11)
				pixel51 = 8'hFF;
			else 
				pixel51 = 8'hF8;
		end
	end

	/* Memory for purple block */
	block51_mem mem51(vclk,addr,pixel);

endmodule
