`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: university of Thessaly
// Engineer: Delakoura Aggeliki
// 
// Create Date:    00:58:14 11/02/2013 
// Module Name:    ButtonModule 
// Project Name: 	 Seven_Seg_c
// Description: In this module we remove the noise from the button's signal in order
//							to push the button once and have the result we want. For our 320ns
//							period clock with 3.125MHz we need to have the button pushed for 
//							0.01sec in order to be able to debounce the signal. So we will have 
//							to wait for 31250 clock cycles
//
//
//////////////////////////////////////////////////////////////////////////////////
module ButtonModule(
			 vclk,
			 rst,
			 button,
			 debounced_button/*,
			 btn1,
			 btn2*/
);
	
	input					vclk;
	input					rst;
	input					button;
  output				debounced_button;
	//output				btn1;
	//output				btn2;

	reg [18:0]			count;
	reg 					new;
	reg						debounced_button;
	//reg						btn1;
	//reg						btn2;

	//Debounce the button signal
	always @(posedge vclk)
	begin
		if (rst)
		begin
			count = 19'b0;
			new = button;
			debounced_button = button;
		end
		else 
		begin
			if (button != new)
			begin
				new = button;
				count = 19'b0;
			end
			else if (count == 19'd500000)//Sta ergasthria etre3e me to 70. 31250)			// 0.01 sec with a 3.125Mhz clock
			begin
				debounced_button = new;
			end
			else
			begin
				count = count + 19'b1;
			end
		end
	end	
	
	//Keep the previous state of the button (pushed or not)
	/*always @(posedge CLKDV or posedge rst)
	begin
		if (rst)
		begin			
			btn1 <= 0;
			btn2 <= 0;
		end
		else
		begin
			btn1 <= debounced_button;
			btn2 <= btn1;
		end
	end*/


endmodule
