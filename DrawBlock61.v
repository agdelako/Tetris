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
module DrawBlock61(
				vclk,
				rst,
				hcount,
				vcount,
				pixel61
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================		
	input						vclk; 
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel61;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================

	reg		[12:0]		vis;
	reg		[12:0]		addr;
	reg		[7:0]			pixel61;
	
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
			if ((hcount >= 286 && hcount < 364) && (vcount >= 407 && vcount < 460))
			begin
				addr = vis;
				vis = vis + 1;
			end
			else if ((hcount < 286) || (hcount >= 364))
			begin
				addr = 0;
			end
			else if (vcount >= 460)
			begin
				vis = 0;
				addr = 0;
			end
			
			if (pixel == 2'b00)
				pixel61 = 8'h00;
			else if (pixel == 2'b11)
				pixel61 = 8'hFF;
			else 
				pixel61 = 8'hF0;
		end
	end

	/* Memory for purple block */
	block61_mem mem61(vclk,addr,pixel);

endmodule
