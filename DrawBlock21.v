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
module DrawBlock21(
				vclk,
				rst,
				hcount,
				vcount,
				pixel21
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================	
	input						vclk; 
	input						rst;
	input		[10:0]	hcount;
  input 	[9:0]	 	vcount;
	output	[7:0]		pixel21;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================

	reg		[12:0]		vis;
	reg		[12:0]		addr;
	reg		[7:0]			pixel21;
	
	wire	[1:0]			pixel;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	
	
	always @(posedge vclk or posedge rst) 
	begin
		if (rst)
		begin
			addr = 77;
			vis = 0;
		end
		else
		begin
			if ((hcount >= 208 && hcount < 286) && (vcount >= 303 && vcount < 356))
			begin
				addr = vis;
				vis = vis + 1;
			end
			else if ((hcount < 208) || (hcount >= 286))
			begin
				addr = 77;
			end
			else if (vcount >= 356)
			begin
				vis = 0;
				addr = 77;
			end
			
			if (pixel == 2'b00)
				pixel21 = 8'h00;
			else if (pixel == 2'b11)
				pixel21 = 8'hFF;
			else
				pixel21 = 8'h2B;
		end
	end

	/* Memory for purple block */
	blocktest mem21(vclk,addr,pixel);

endmodule
