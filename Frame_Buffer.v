`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Module Name:    Frame_frameBuff 
// Project Name: 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module Frame_Buffer(
				vclk,
				rst,
				done,
				show,
				pixel,
				hcount,
				vcount,
				vsync,
				next,
				frame_pixel
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================			
	input 			 			vclk; 
	input		 		 			rst;
	input							done;
	input							show;
	input							vsync;
	input		[7:0]			pixel;
	input		[10:0]		hcount;
  input 	[9:0]	 		vcount;
	output						next;
	output	[7:0] 	  frame_pixel;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================		
	reg		[8:0]		addr;	
	reg		[8:0]		saddr;	
	reg		[7:0]		frame_pixel;
	reg						next;
	reg		[3:0]		frameBuff[307:0];
	
	wire					done;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	
always @(posedge vclk or posedge rst)
	begin
		if (rst)
		begin
			frameBuff[0] = 4'b0;
			frameBuff[1] = 4'b0;
					frameBuff[2] = 4'b0;
					frameBuff[3] = 4'b0;
					frameBuff[4] = 4'b0;
					frameBuff[5] = 4'b0;
					frameBuff[6] = 4'b0;
					frameBuff[7] = 4'b0;
					frameBuff[8] = 4'b0;
					frameBuff[9] = 4'b0;
					frameBuff[10] = 4'b0;
					frameBuff[11] = 4'b0;
					frameBuff[12] = 4'b0;
					frameBuff[13] = 4'b0;
					frameBuff[14] = 4'b0;
					frameBuff[15] = 4'b0;
					frameBuff[16] = 4'b0;
					frameBuff[17] = 4'b0;
					frameBuff[18] = 4'b0;
					frameBuff[19] = 4'b0;
					frameBuff[20] = 4'b0;
					frameBuff[21] = 4'b0;
					frameBuff[22] = 4'b0;
					frameBuff[23] = 4'b0;
					frameBuff[24] = 4'b0;
					frameBuff[25] = 4'b0;
					frameBuff[26] = 4'b0;
					frameBuff[27] = 4'b0;
					frameBuff[28] = 4'b0;
					frameBuff[29] = 4'b0;
					frameBuff[30] = 4'b0;
					frameBuff[31] = 4'b0;
					frameBuff[32] = 4'b0;
					frameBuff[33] = 4'b0;
					frameBuff[34] = 4'b0;
					frameBuff[35] = 4'b0;
					frameBuff[36] = 4'b0;
					frameBuff[37] = 4'b0;
					frameBuff[38] = 4'b0;
					frameBuff[39] = 4'b0;
					frameBuff[40] = 4'b0;
					frameBuff[41] = 4'b0;
					frameBuff[42] = 4'b0;
					frameBuff[43] = 4'b0;
					frameBuff[44] = 4'b0;
					frameBuff[45] = 4'b0;
					frameBuff[46] = 4'b0;
					frameBuff[47] = 4'b0;
					frameBuff[48] = 4'b0;
					frameBuff[49] = 4'b0;
					frameBuff[50] = 4'b0;
					frameBuff[51] = 4'b0;
					frameBuff[52] = 4'b0;
					frameBuff[53] = 4'b0;
					frameBuff[54] = 4'b0;
					frameBuff[55] = 4'b0;
					frameBuff[56] = 4'b0;
					frameBuff[57] = 4'b0;
					frameBuff[58] = 4'b0;
					frameBuff[59] = 4'b0;
					frameBuff[60] = 4'b0;
					frameBuff[61] = 4'b0;
					frameBuff[62] = 4'b0;
					frameBuff[63] = 4'b0;
					frameBuff[64] = 4'b0;
					frameBuff[65] = 4'b0;
					frameBuff[66] = 4'b0;
					frameBuff[67] = 4'b0;
					frameBuff[68] = 4'b0;
					frameBuff[69] = 4'b0;
					frameBuff[70] = 4'b0;
					frameBuff[71] = 4'b0;
					frameBuff[72] = 4'b0;
					frameBuff[73] = 4'b0;
					frameBuff[74] = 4'b0;
					frameBuff[75] = 4'b0;
					frameBuff[76] = 4'b0;
					frameBuff[77] = 4'b0;
					frameBuff[78] = 4'b0;
					frameBuff[79] = 4'b0;
					frameBuff[80] = 4'b0;
					frameBuff[81] = 4'b0;
					frameBuff[82] = 4'b0;
					frameBuff[83] = 4'b0;
					frameBuff[84] = 4'b0;
					frameBuff[85] = 4'b0;
					frameBuff[86] = 4'b0;
					frameBuff[87] = 4'b0;
					frameBuff[88] = 4'b0;
					frameBuff[89] = 4'b0;
					frameBuff[90] = 4'b0;
					frameBuff[91] = 4'b0;
					frameBuff[92] = 4'b0;
					frameBuff[93] = 4'b0;
					frameBuff[94] = 4'b0;
					frameBuff[95] = 4'b0;
					frameBuff[96] = 4'b0;
					frameBuff[97] = 4'b0;
					frameBuff[98] = 4'b0;
					frameBuff[99] = 4'b0;
					frameBuff[100] = 4'b0;
					frameBuff[101] = 4'b0;
					frameBuff[102] = 4'b0;
					frameBuff[103] = 4'b0;
					frameBuff[104] = 4'b0;
					frameBuff[105] = 4'b0;
					frameBuff[106] = 4'b0;
					frameBuff[107] = 4'b0;
					frameBuff[108] = 4'b0;
					frameBuff[109] = 4'b0;
					frameBuff[110] = 4'b0;
					frameBuff[111] = 4'b0;
					frameBuff[112] = 4'b0;
					frameBuff[113] = 4'b0;
					frameBuff[114] = 4'b0;
					frameBuff[115] = 4'b0;
					frameBuff[116] = 4'b0;
					frameBuff[117] = 4'b0;
					frameBuff[118] = 4'b0;
					frameBuff[119] = 4'b0;
					frameBuff[120] = 4'b0;
					frameBuff[121] = 4'b0;
					frameBuff[122] = 4'b0;
					frameBuff[123] = 4'b0;
					frameBuff[124] = 4'b0;
					frameBuff[125] = 4'b0;
					frameBuff[126] = 4'b0;
					frameBuff[127] = 4'b0;
					frameBuff[128] = 4'b0;
					frameBuff[129] = 4'b0;
					frameBuff[130] = 4'b0;
					frameBuff[131] = 4'b0;
					frameBuff[132] = 4'b0;
					frameBuff[133] = 4'b0;
					frameBuff[134] = 4'b0;
					frameBuff[135] = 4'b0;
					frameBuff[136] = 4'b0;
					frameBuff[137] = 4'b0;
					frameBuff[138] = 4'b0;
					frameBuff[139] = 4'b0;
					frameBuff[140] = 4'b0;
					frameBuff[141] = 4'b0;
					frameBuff[142] = 4'b0;
					frameBuff[143] = 4'b0;
					frameBuff[144] = 4'b0;
					frameBuff[145] = 4'b0;
					frameBuff[146] = 4'b0;
					frameBuff[147] = 4'b0;
					frameBuff[148] = 4'b0;
					frameBuff[149] = 4'b0;
					frameBuff[150] = 4'b0;
					frameBuff[151] = 4'b0;
					frameBuff[152] = 4'b0;
					frameBuff[153] = 4'b0;
					frameBuff[154] = 4'b0;
					frameBuff[155] = 4'b0;
					frameBuff[156] = 4'b0;
					frameBuff[157] = 4'b0;
					frameBuff[158] = 4'b0;
					frameBuff[159] = 4'b0;
					frameBuff[160] = 4'b0;
					frameBuff[161] = 4'b0;
					frameBuff[162] = 4'b0;
					frameBuff[163] = 4'b0;
					frameBuff[164] = 4'b0;
					frameBuff[165] = 4'b0;
					frameBuff[166] = 4'b0;
					frameBuff[167] = 4'b0;
					frameBuff[168] = 4'b0;
					frameBuff[169] = 4'b0;
					frameBuff[170] = 4'b0;
					frameBuff[171] = 4'b0;
					frameBuff[172] = 4'b0;
					frameBuff[173] = 4'b0;
					frameBuff[174] = 4'b0;
					frameBuff[175] = 4'b0;
					frameBuff[176] = 4'b0;
					frameBuff[177] = 4'b0;
					frameBuff[178] = 4'b0;
					frameBuff[179] = 4'b0;
					frameBuff[180] = 4'b0;
					frameBuff[181] = 4'b0;
					frameBuff[182] = 4'b0;
					frameBuff[183] = 4'b0;
					frameBuff[184] = 4'b0;
					frameBuff[185] = 4'b0;
					frameBuff[186] = 4'b0;
					frameBuff[187] = 4'b0;
					frameBuff[188] = 4'b0;
					frameBuff[189] = 4'b0;
					frameBuff[190] = 4'b0;
					frameBuff[191] = 4'b0;
					frameBuff[192] = 4'b0;
					frameBuff[193] = 4'b0;
					frameBuff[194] = 4'b0;
					frameBuff[195] = 4'b0;
					frameBuff[196] = 4'b0;
					frameBuff[197] = 4'b0;
					frameBuff[198] = 4'b0;
					frameBuff[199] = 4'b0;
					frameBuff[200] = 4'b0;
					frameBuff[201] = 4'b0;
					frameBuff[202] = 4'b0;
					frameBuff[203] = 4'b0;
					frameBuff[204] = 4'b0;
					frameBuff[205] = 4'b0;
					frameBuff[206] = 4'b0;
					frameBuff[207] = 4'b0;
					frameBuff[208] = 4'b0;
					frameBuff[209] = 4'b0;
					frameBuff[210] = 4'b0;
					frameBuff[211] = 4'b0;
					frameBuff[212] = 4'b0;
					frameBuff[213] = 4'b0;
					frameBuff[214] = 4'b0;
					frameBuff[215] = 4'b0;
					frameBuff[216] = 4'b0;
					frameBuff[217] = 4'b0;
					frameBuff[218] = 4'b0;
					frameBuff[219] = 4'b0;
					frameBuff[220] = 4'b0;
					frameBuff[221] = 4'b0;
					frameBuff[222] = 4'b0;
					frameBuff[223] = 4'b0;
					frameBuff[224] = 4'b0;
					frameBuff[225] = 4'b0;
					frameBuff[226] = 4'b0;
					frameBuff[227] = 4'b0;
					frameBuff[228] = 4'b0;
					frameBuff[229] = 4'b0;
					frameBuff[230] = 4'b0;
					frameBuff[231] = 4'b0;
					frameBuff[232] = 4'b0;
					frameBuff[233] = 4'b0;
					frameBuff[234] = 4'b0;
					frameBuff[235] = 4'b0;
					frameBuff[236] = 4'b0;
					frameBuff[237] = 4'b0;
					frameBuff[238] = 4'b0;
					frameBuff[239] = 4'b0;
					frameBuff[240] = 4'b0;
					frameBuff[241] = 4'b0;
					frameBuff[242] = 4'b0;
					frameBuff[243] = 4'b0;
					frameBuff[244] = 4'b0;
					frameBuff[245] = 4'b0;
					frameBuff[246] = 4'b0;
					frameBuff[247] = 4'b0;
					frameBuff[248] = 4'b0;
					frameBuff[249] = 4'b0;
					frameBuff[250] = 4'b0;
					frameBuff[251] = 4'b0;
					frameBuff[252] = 4'b0;
					frameBuff[253] = 4'b0;
					frameBuff[254] = 4'b0;
					frameBuff[255] = 4'b0;
					frameBuff[256] = 4'b0;
					frameBuff[257] = 4'b0;
					frameBuff[258] = 4'b0;
					frameBuff[259] = 4'b0;
					frameBuff[260] = 4'b0;
					frameBuff[261] = 4'b0;
					frameBuff[262] = 4'b0;
					frameBuff[263] = 4'b0;
					frameBuff[264] = 4'b0;
					frameBuff[265] = 4'b0;
					frameBuff[266] = 4'b0;
					frameBuff[267] = 4'b0;
					frameBuff[268] = 4'b0;
					frameBuff[269] = 4'b0;
					frameBuff[270] = 4'b0;
					frameBuff[271] = 4'b0;
					frameBuff[272] = 4'b0;
					frameBuff[273] = 4'b0;
					frameBuff[274] = 4'b0;
					frameBuff[275] = 4'b0;
					frameBuff[276] = 4'b0;
					frameBuff[277] = 4'b0;
					frameBuff[278] = 4'b0;
					frameBuff[279] = 4'b0;
					frameBuff[280] = 4'b0;
					frameBuff[281] = 4'b0;
					frameBuff[282] = 4'b0;
					frameBuff[283] = 4'b0;
					frameBuff[284] = 4'b0;
					frameBuff[285] = 4'b0;
					frameBuff[286] = 4'b0;
					frameBuff[287] = 4'b0;
					frameBuff[288] = 4'b0;
					frameBuff[289] = 4'b0;
					frameBuff[290] = 4'b0;
					frameBuff[291] = 4'b0;
					frameBuff[292] = 4'b0;
					frameBuff[293] = 4'b0;
					frameBuff[294] = 4'b0;
					frameBuff[295] = 4'b0;
					frameBuff[296] = 4'b0;
					frameBuff[297] = 4'b0;
					frameBuff[298] = 4'b0;
					frameBuff[299] = 4'b0;
					frameBuff[300] = 4'b0;
					frameBuff[301] = 4'b0;
					frameBuff[302] = 4'b0;
					frameBuff[303] = 4'b0;
					frameBuff[304] = 4'b0;
					frameBuff[305] = 4'b0;
					frameBuff[306] = 4'b0;
					frameBuff[307] = 4'b0;
			addr = 9'b0;
			next = 1'b0;
		end
		else
		begin
			if (done)// && !show)
			begin
				/* Calculate the centers of each tile of the grid in order to find the color of *
				 * each tile and save it on memory.																							*/
				if (((hcount == 117) || (hcount == 143) || (hcount == 169) || (hcount == 195) ||
						 (hcount == 221) || (hcount == 247) || (hcount == 273) || (hcount == 299) ||
						 (hcount == 325) || (hcount == 351) || (hcount == 377) || (hcount == 403) || 
						 (hcount == 429) || (hcount == 455)) && 
						 ((vcount == 30) || (vcount == 56) || (vcount == 82) || (vcount == 108) ||
						 (vcount == 134) || (vcount == 160) || (vcount == 186) || (vcount == 212) ||
						 (vcount == 238) || (vcount == 264) || (vcount == 290) || (vcount == 316) ||
						 (vcount == 342) || (vcount == 368) || (vcount == 394) || (vcount == 420) ||
						 (vcount == 446) || (vcount == 472) || (vcount == 498) || (vcount == 524) || 
						 (vcount == 550) || (vcount == 576)))
				begin
					next = 1'b0;
					
					if (pixel == 8'h35)
						frameBuff[addr] = 4'b0001;
					else if (pixel == 8'h2B)
						frameBuff[addr] = 4'b0010;
					else if (pixel == 8'hCF)
						frameBuff[addr] = 4'b0011;
					else if (pixel == 8'h1F)
						frameBuff[addr] = 4'b0100;
					else if (pixel == 8'hF8)
						frameBuff[addr] = 4'b0101;
					else if (pixel == 8'hF0)
						frameBuff[addr] = 4'b0110;
					else if (pixel == 8'hE0)
						frameBuff[addr] = 4'b0111;
					else 
						frameBuff[addr] = 4'b0000;
					addr = addr + 9'b0000_00001;
				end
				else if ((hcount > 798) && (hcount < 855) && (vcount > 589) && (vcount < 636))
				begin
					addr = 9'b0;
					next = 1'b1;
				end
				else
				begin
					next = 1'b0;
				end
			end
			else if (vsync)
			begin
				next = 1'b0;
			end
		end
	end
	
	always @(posedge vclk or posedge rst)
	begin
		if (rst)
		begin
			frame_pixel = 8'h00;
			saddr = 9'd0;
		end
		else
		begin
			if ((hcount >= 104) && (hcount < 468) && (vcount >= 17) && (vcount < 589))
			begin
				if (tile001) saddr = 9'd0;
				if (tile002) saddr = 9'd1;
				if (tile003) saddr = 9'd2;
				if (tile004) saddr = 9'd3;
				if (tile005) saddr = 9'd4;
				if (tile006) saddr = 9'd5;
				if (tile007) saddr = 9'd6;
				if (tile008) saddr = 9'd7;
				if (tile009) saddr = 9'd8;
				if (tile010) saddr = 9'd9;
				if (tile011) saddr = 9'd10;
				if (tile012) saddr = 9'd11;
				if (tile013) saddr = 9'd12;
				if (tile014) saddr = 9'd13;
				if (tile015) saddr = 9'd14;
				if (tile016) saddr = 9'd15;
				if (tile017) saddr = 9'd16;
				if (tile018) saddr = 9'd17;
				if (tile019) saddr = 9'd18;
				if (tile020) saddr = 9'd19;
				if (tile021) saddr = 9'd20;
				if (tile022) saddr = 9'd21;
				if (tile023) saddr = 9'd22;
				if (tile024) saddr = 9'd23;
				if (tile025) saddr = 9'd24;
				if (tile026) saddr = 9'd25;
				if (tile027) saddr = 9'd26;
				if (tile028) saddr = 9'd27;
				if (tile029) saddr = 9'd28;
				if (tile030) saddr = 9'd29;
				if (tile031) saddr = 9'd30;
				if (tile032) saddr = 9'd31;
				if (tile033) saddr = 9'd32;
				if (tile034) saddr = 9'd33;
				if (tile035) saddr = 9'd34;
				if (tile036) saddr = 9'd35;
				if (tile037) saddr = 9'd36;
				if (tile038) saddr = 9'd37;
				if (tile039) saddr = 9'd38;
				if (tile040) saddr = 9'd39;
				if (tile041) saddr = 9'd40;
				if (tile042) saddr = 9'd41;
				if (tile043) saddr = 9'd42;
				if (tile044) saddr = 9'd43;
				if (tile045) saddr = 9'd44;
				if (tile046) saddr = 9'd45;
				if (tile047) saddr = 9'd46;
				if (tile048) saddr = 9'd47;
				if (tile049) saddr = 9'd48;
				if (tile050) saddr = 9'd49;
				if (tile051) saddr = 9'd50;
				if (tile052) saddr = 9'd51;
				if (tile053) saddr = 9'd52;
				if (tile054) saddr = 9'd53;
				if (tile055) saddr = 9'd54;
				if (tile056) saddr = 9'd55;
				if (tile057) saddr = 9'd56;
				if (tile058) saddr = 9'd57;
				if (tile059) saddr = 9'd58;
				if (tile060) saddr = 9'd59;
				if (tile061) saddr = 9'd60;
				if (tile062) saddr = 9'd61;
				if (tile063) saddr = 9'd62;
				if (tile064) saddr = 9'd63;
				if (tile065) saddr = 9'd64;
				if (tile066) saddr = 9'd65;
				if (tile067) saddr = 9'd66;
				if (tile068) saddr = 9'd67;
				if (tile069) saddr = 9'd68;
				if (tile070) saddr = 9'd69;
				if (tile071) saddr = 9'd70;
				if (tile072) saddr = 9'd71;
				if (tile073) saddr = 9'd72;
				if (tile074) saddr = 9'd73;
				if (tile075) saddr = 9'd74;
				if (tile076) saddr = 9'd75;
				if (tile077) saddr = 9'd76;
				if (tile078) saddr = 9'd77;
				if (tile079) saddr = 9'd78;
				if (tile080) saddr = 9'd79;
				if (tile081) saddr = 9'd80;
				if (tile082) saddr = 9'd81;
				if (tile083) saddr = 9'd82;
				if (tile084) saddr = 9'd83;
				if (tile085) saddr = 9'd84;
				if (tile086) saddr = 9'd85;
				if (tile087) saddr = 9'd86;
				if (tile088) saddr = 9'd87;
				if (tile089) saddr = 9'd88;
				if (tile090) saddr = 9'd89;
				if (tile091) saddr = 9'd90;
				if (tile092) saddr = 9'd91;
				if (tile093) saddr = 9'd92;
				if (tile094) saddr = 9'd93;
				if (tile095) saddr = 9'd94;
				if (tile096) saddr = 9'd95;
				if (tile097) saddr = 9'd96;
				if (tile098) saddr = 9'd97;
				if (tile099) saddr = 9'd98;
				if (tile100) saddr = 9'd99;
				if (tile101) saddr = 9'd100;
				if (tile102) saddr = 9'd101;
				if (tile103) saddr = 9'd102;
				if (tile104) saddr = 9'd103;
				if (tile105) saddr = 9'd104;
				if (tile106) saddr = 9'd105;
				if (tile107) saddr = 9'd106;
				if (tile108) saddr = 9'd107;
				if (tile109) saddr = 9'd108;
				if (tile110) saddr = 9'd109;
				if (tile111) saddr = 9'd110;
				if (tile112) saddr = 9'd111;
				if (tile113) saddr = 9'd112;
				if (tile114) saddr = 9'd113;
				if (tile115) saddr = 9'd114;
				if (tile116) saddr = 9'd115;
				if (tile117) saddr = 9'd116;
				if (tile118) saddr = 9'd117;
				if (tile119) saddr = 9'd118;
				if (tile120) saddr = 9'd119;
				if (tile121) saddr = 9'd120;
				if (tile122) saddr = 9'd121;
				if (tile123) saddr = 9'd122;
				if (tile124) saddr = 9'd123;
				if (tile125) saddr = 9'd124;
				if (tile126) saddr = 9'd125;
				if (tile127) saddr = 9'd126;
				if (tile128) saddr = 9'd127;
				if (tile129) saddr = 9'd128;
				if (tile130) saddr = 9'd129;
				if (tile131) saddr = 9'd130;
				if (tile132) saddr = 9'd131;
				if (tile133) saddr = 9'd132;
				if (tile134) saddr = 9'd133;
				if (tile135) saddr = 9'd134;
				if (tile136) saddr = 9'd135;
				if (tile137) saddr = 9'd136;
				if (tile138) saddr = 9'd137;
				if (tile139) saddr = 9'd138;
				if (tile140) saddr = 9'd139;
				if (tile141) saddr = 9'd140;
				if (tile142) saddr = 9'd141;
				if (tile143) saddr = 9'd142;
				if (tile144) saddr = 9'd143;
				if (tile145) saddr = 9'd144;
				if (tile146) saddr = 9'd145;
				if (tile147) saddr = 9'd146;
				if (tile148) saddr = 9'd147;
				if (tile149) saddr = 9'd148;
				if (tile150) saddr = 9'd149;
				if (tile151) saddr = 9'd150;
				if (tile152) saddr = 9'd151;
				if (tile153) saddr = 9'd152;
				if (tile154) saddr = 9'd153;
				if (tile155) saddr = 9'd154;
				if (tile156) saddr = 9'd155;
				if (tile157) saddr = 9'd156;
				if (tile158) saddr = 9'd157;
				if (tile159) saddr = 9'd158;
				if (tile160) saddr = 9'd159;
				if (tile161) saddr = 9'd160;
				if (tile162) saddr = 9'd161;
				if (tile163) saddr = 9'd162;
				if (tile164) saddr = 9'd163;
				if (tile165) saddr = 9'd164;
				if (tile166) saddr = 9'd165;
				if (tile167) saddr = 9'd166;
				if (tile168) saddr = 9'd167;
				if (tile169) saddr = 9'd168;
				if (tile170) saddr = 9'd169;
				if (tile171) saddr = 9'd170;
				if (tile172) saddr = 9'd171;
				if (tile173) saddr = 9'd172;
				if (tile174) saddr = 9'd173;
				if (tile175) saddr = 9'd174;
				if (tile176) saddr = 9'd175;
				if (tile177) saddr = 9'd176;
				if (tile178) saddr = 9'd177;
				if (tile179) saddr = 9'd178;
				if (tile180) saddr = 9'd179;
				if (tile181) saddr = 9'd180;
				if (tile182) saddr = 9'd181;
				if (tile183) saddr = 9'd182;
				if (tile184) saddr = 9'd183;
				if (tile185) saddr = 9'd184;
				if (tile186) saddr = 9'd185;
				if (tile187) saddr = 9'd186;
				if (tile188) saddr = 9'd187;
				if (tile189) saddr = 9'd188;
				if (tile190) saddr = 9'd189;
				if (tile191) saddr = 9'd190;
				if (tile192) saddr = 9'd191;
				if (tile193) saddr = 9'd192;
				if (tile194) saddr = 9'd193;
				if (tile195) saddr = 9'd194;
				if (tile196) saddr = 9'd195;
				if (tile197) saddr = 9'd196;
				if (tile198) saddr = 9'd197;
				if (tile199) saddr = 9'd198;
				if (tile200) saddr = 9'd199;
				if (tile201) saddr = 9'd200;
				if (tile202) saddr = 9'd201;
				if (tile203) saddr = 9'd202;
				if (tile204) saddr = 9'd203;
				if (tile205) saddr = 9'd204;
				if (tile206) saddr = 9'd205;
				if (tile207) saddr = 9'd206;
				if (tile208) saddr = 9'd207;
				if (tile209) saddr = 9'd208;
				if (tile210) saddr = 9'd209;
				if (tile211) saddr = 9'd210;
				if (tile212) saddr = 9'd211;
				if (tile213) saddr = 9'd212;
				if (tile214) saddr = 9'd213;
				if (tile215) saddr = 9'd214;
				if (tile216) saddr = 9'd215;
				if (tile217) saddr = 9'd216;
				if (tile218) saddr = 9'd217;
				if (tile219) saddr = 9'd218;
				if (tile220) saddr = 9'd219;
				if (tile221) saddr = 9'd220;
				if (tile222) saddr = 9'd221;
				if (tile223) saddr = 9'd222;
				if (tile224) saddr = 9'd223;
				if (tile225) saddr = 9'd224;
				if (tile226) saddr = 9'd225;
				if (tile227) saddr = 9'd226;
				if (tile228) saddr = 9'd227;
				if (tile229) saddr = 9'd228;
				if (tile230) saddr = 9'd229;
				if (tile231) saddr = 9'd230;
				if (tile232) saddr = 9'd231;
				if (tile233) saddr = 9'd232;
				if (tile234) saddr = 9'd233;
				if (tile235) saddr = 9'd234;
				if (tile236) saddr = 9'd235;
				if (tile237) saddr = 9'd236;
				if (tile238) saddr = 9'd237;
				if (tile239) saddr = 9'd238;
				if (tile240) saddr = 9'd239;
				if (tile241) saddr = 9'd240;
				if (tile242) saddr = 9'd241;
				if (tile243) saddr = 9'd242;
				if (tile244) saddr = 9'd243;
				if (tile245) saddr = 9'd244;
				if (tile246) saddr = 9'd245;
				if (tile247) saddr = 9'd246;
				if (tile248) saddr = 9'd247;
				if (tile249) saddr = 9'd248;
				if (tile250) saddr = 9'd249;
				if (tile251) saddr = 9'd250;
				if (tile252) saddr = 9'd251;
				if (tile253) saddr = 9'd252;
				if (tile254) saddr = 9'd253;
				if (tile255) saddr = 9'd254;
				if (tile256) saddr = 9'd255;
				if (tile257) saddr = 9'd256;
				if (tile258) saddr = 9'd257;
				if (tile259) saddr = 9'd258;
				if (tile260) saddr = 9'd259;
				if (tile261) saddr = 9'd260;
				if (tile262) saddr = 9'd261;
				if (tile263) saddr = 9'd262;
				if (tile264) saddr = 9'd263;
				if (tile265) saddr = 9'd264;
				if (tile266) saddr = 9'd265;
				if (tile267) saddr = 9'd266;
				if (tile268) saddr = 9'd267;
				if (tile269) saddr = 9'd268;
				if (tile270) saddr = 9'd269;
				if (tile271) saddr = 9'd270;
				if (tile272) saddr = 9'd271;
				if (tile273) saddr = 9'd272;
				if (tile274) saddr = 9'd273;
				if (tile275) saddr = 9'd274;
				if (tile276) saddr = 9'd275;
				if (tile277) saddr = 9'd276;
				if (tile278) saddr = 9'd277;
				if (tile279) saddr = 9'd278;
				if (tile280) saddr = 9'd279;
				if (tile281) saddr = 9'd280;
				if (tile282) saddr = 9'd281;
				if (tile283) saddr = 9'd282;
				if (tile284) saddr = 9'd283;
				if (tile285) saddr = 9'd284;
				if (tile286) saddr = 9'd285;
				if (tile287) saddr = 9'd286;
				if (tile288) saddr = 9'd287;
				if (tile289) saddr = 9'd288;
				if (tile290) saddr = 9'd289;
				if (tile291) saddr = 9'd290;
				if (tile292) saddr = 9'd291;
				if (tile293) saddr = 9'd292;
				if (tile294) saddr = 9'd293;
				if (tile295) saddr = 9'd294;
				if (tile296) saddr = 9'd295;
				if (tile297) saddr = 9'd296;
				if (tile298) saddr = 9'd297;
				if (tile299) saddr = 9'd298;
				if (tile300) saddr = 9'd299;
				if (tile301) saddr = 9'd300;
				if (tile302) saddr = 9'd301;
				if (tile303) saddr = 9'd302;
				if (tile304) saddr = 9'd303;
				if (tile305) saddr = 9'd304;
				if (tile306) saddr = 9'd305;
				if (tile307) saddr = 9'd306;
				if (tile308) saddr = 9'd307;
					
				if (frameBuff[saddr] == 4'b0001)
					frame_pixel = 8'h35;
				else if (frameBuff[saddr] == 4'b0010)
					frame_pixel = 8'h2B;
				else if (frameBuff[saddr] == 4'b0011)
					frame_pixel = 8'hCF;
				else if (frameBuff[saddr] == 4'b0100)
					frame_pixel = 8'h1F;
				else if (frameBuff[saddr] == 4'b0101)
					frame_pixel = 8'hF8;
				else if (frameBuff[saddr] == 4'b0110)
					frame_pixel = 8'hF0;
				else if (frameBuff[saddr] == 4'b0111)
					frame_pixel = 8'hE0;
				else if (frameBuff[saddr] == 4'b0000)
					frame_pixel = 8'h00;
			end
			else
			begin
				frame_pixel = 8'h00;
			end
		end
	end
	
/*	always @(*)
	begin
		//if (show)
		//begin
				
			if ((hcount >= 103) && (hcount <= 467) && (vcount >= 17) && (vcount <= 589))
			begin
				if(k < 22)//for (k = 0; k < 22; k = k + 1)
				begin
					if (l < 26)//for (l = 0; l < 26; l = l + 1)
					begin
						if (i < 14)//for (i = 0; i < 14; i = i + 1)
						begin
							saddr = row_addr + i;
							if (j < 25)//for (j = 0; j < 26; j = j + 1)
							begin
								//saddr = row_addr + i;
								if (frameBuff[saddr] =<= 4'b0001)
									frame_pixel = 8'h35;
								else if (frameBuff[saddr] =<= 4'b0000)
									frame_pixel = 8'h00;
								nextj = j + 5'b00001;
							end
							else//j
							begin
								nextj = 5'b0;
								nexti = i + 4'b00001;
							end
						end
						else//i
						begin
							nexti = 4'b0;
							nextl = l + 5'b00001;
						end
					end
					else//l
					begin
						row_addr = row_addr + 14;
						saddr = row_addr;
						nextl = 5'b0;
						nextk = k + 5'b00001;
					end
				end
				else//k
				begin
					nextk = 5'b0;
				end
			end
			else if ((hcount > 467) && (vcount > 589))
			begin
				saddr = 9'b0;
				row_addr = 9'b0;
				frame_pixel = 8'h00;
				nextk = 5'b0;
				nextl = 5'b0;
				nextj = 5'b0;
				nexti = 5'b0;
			end
			else if (((hcount < 103) || (hcount > 467)) && ((vcount < 17) || (vcount > 589)))
			begin
				frame_pixel = 8'h00;
				saddr = saddr;
				nextk = nextk;
				nextl = nextl;
				nextj = nextj;
				nexti = nexti;				
			end
			//end
	end*/
	
	/* First line of the active grid */
	wire tile001 = ((hcount >= 104) && (hcount < 130) && (vcount >= 17) && (vcount < 43));
	wire tile002 = ((hcount >= 130) && (hcount < 156) && (vcount >= 17) && (vcount < 43));
	wire tile003 = ((hcount >= 156) && (hcount < 182) && (vcount >= 17) && (vcount < 43));
	wire tile004 = ((hcount >= 182) && (hcount < 208) && (vcount >= 17) && (vcount < 43));
	wire tile005 = ((hcount >= 208) && (hcount < 234) && (vcount >= 17) && (vcount < 43));
	wire tile006 = ((hcount >= 234) && (hcount < 260) && (vcount >= 17) && (vcount < 43));
	wire tile007 = ((hcount >= 260) && (hcount < 286) && (vcount >= 17) && (vcount < 43));
	wire tile008 = ((hcount >= 286) && (hcount < 312) && (vcount >= 17) && (vcount < 43));
	wire tile009 = ((hcount >= 312) && (hcount < 338) && (vcount >= 17) && (vcount < 43));
	wire tile010 = ((hcount >= 338) && (hcount < 364) && (vcount >= 17) && (vcount < 43));
	wire tile011 = ((hcount >= 364) && (hcount < 390) && (vcount >= 17) && (vcount < 43));
	wire tile012 = ((hcount >= 390) && (hcount < 416) && (vcount >= 17) && (vcount < 43));
	wire tile013 = ((hcount >= 416) && (hcount < 442) && (vcount >= 17) && (vcount < 43));
	wire tile014 = ((hcount >= 442) && (hcount < 468) && (vcount >= 17) && (vcount < 43));
	/* Second line of the active grid */
	wire tile015 = ((hcount >= 104) && (hcount < 130) && (vcount >= 43) && (vcount < 69));
	wire tile016 = ((hcount >= 130) && (hcount < 156) && (vcount >= 43) && (vcount < 69));
	wire tile017 = ((hcount >= 156) && (hcount < 182) && (vcount >= 43) && (vcount < 69));
	wire tile018 = ((hcount >= 182) && (hcount < 208) && (vcount >= 43) && (vcount < 69));
	wire tile019 = ((hcount >= 208) && (hcount < 234) && (vcount >= 43) && (vcount < 69));
	wire tile020 = ((hcount >= 234) && (hcount < 260) && (vcount >= 43) && (vcount < 69));
	wire tile021 = ((hcount >= 260) && (hcount < 286) && (vcount >= 43) && (vcount < 69));
	wire tile022 = ((hcount >= 286) && (hcount < 312) && (vcount >= 43) && (vcount < 69));
	wire tile023 = ((hcount >= 312) && (hcount < 338) && (vcount >= 43) && (vcount < 69));
	wire tile024 = ((hcount >= 338) && (hcount < 364) && (vcount >= 43) && (vcount < 69));
	wire tile025 = ((hcount >= 364) && (hcount < 390) && (vcount >= 43) && (vcount < 69));
	wire tile026 = ((hcount >= 390) && (hcount < 416) && (vcount >= 43) && (vcount < 69));
	wire tile027 = ((hcount >= 416) && (hcount < 442) && (vcount >= 43) && (vcount < 69));
	wire tile028 = ((hcount >= 442) && (hcount < 468) && (vcount >= 43) && (vcount < 69));
	/* Third line of the active grid */
	wire tile029 = ((hcount >= 104) && (hcount < 130) && (vcount >= 69) && (vcount < 95));
	wire tile030 = ((hcount >= 130) && (hcount < 156) && (vcount >= 69) && (vcount < 95));
	wire tile031 = ((hcount >= 156) && (hcount < 182) && (vcount >= 69) && (vcount < 95));
	wire tile032 = ((hcount >= 182) && (hcount < 208) && (vcount >= 69) && (vcount < 95));
	wire tile033 = ((hcount >= 208) && (hcount < 234) && (vcount >= 69) && (vcount < 95));
	wire tile034 = ((hcount >= 234) && (hcount < 260) && (vcount >= 69) && (vcount < 95));
	wire tile035 = ((hcount >= 260) && (hcount < 286) && (vcount >= 69) && (vcount < 95));
	wire tile036 = ((hcount >= 286) && (hcount < 312) && (vcount >= 69) && (vcount < 95));
	wire tile037 = ((hcount >= 312) && (hcount < 338) && (vcount >= 69) && (vcount < 95));
	wire tile038 = ((hcount >= 338) && (hcount < 364) && (vcount >= 69) && (vcount < 95));
	wire tile039 = ((hcount >= 364) && (hcount < 390) && (vcount >= 69) && (vcount < 95));
	wire tile040 = ((hcount >= 390) && (hcount < 416) && (vcount >= 69) && (vcount < 95));
	wire tile041 = ((hcount >= 416) && (hcount < 442) && (vcount >= 69) && (vcount < 95));
	wire tile042 = ((hcount >= 442) && (hcount < 468) && (vcount >= 69) && (vcount < 95));
	/* Fourth line of the active grid */
	wire tile043 = ((hcount >= 104) && (hcount < 130) && (vcount >= 95) && (vcount < 121));
	wire tile044 = ((hcount >= 130) && (hcount < 156) && (vcount >= 95) && (vcount < 121));
	wire tile045 = ((hcount >= 156) && (hcount < 182) && (vcount >= 95) && (vcount < 121));
	wire tile046 = ((hcount >= 182) && (hcount < 208) && (vcount >= 95) && (vcount < 121));
	wire tile047 = ((hcount >= 208) && (hcount < 234) && (vcount >= 95) && (vcount < 121));
	wire tile048 = ((hcount >= 234) && (hcount < 260) && (vcount >= 95) && (vcount < 121));
	wire tile049 = ((hcount >= 260) && (hcount < 286) && (vcount >= 95) && (vcount < 121));
	wire tile050 = ((hcount >= 286) && (hcount < 312) && (vcount >= 95) && (vcount < 121));
	wire tile051 = ((hcount >= 312) && (hcount < 338) && (vcount >= 95) && (vcount < 121));
	wire tile052 = ((hcount >= 338) && (hcount < 364) && (vcount >= 95) && (vcount < 121));
	wire tile053 = ((hcount >= 364) && (hcount < 390) && (vcount >= 95) && (vcount < 121));
	wire tile054 = ((hcount >= 390) && (hcount < 416) && (vcount >= 95) && (vcount < 121));
	wire tile055 = ((hcount >= 416) && (hcount < 442) && (vcount >= 95) && (vcount < 121));
	wire tile056 = ((hcount >= 442) && (hcount < 468) && (vcount >= 95) && (vcount < 121));
	/* Fifth line of the active grid */
	wire tile057 = ((hcount >= 104) && (hcount < 130) && (vcount >= 121) && (vcount < 147));
	wire tile058 = ((hcount >= 130) && (hcount < 156) && (vcount >= 121) && (vcount < 147));
	wire tile059 = ((hcount >= 156) && (hcount < 182) && (vcount >= 121) && (vcount < 147));
	wire tile060 = ((hcount >= 182) && (hcount < 208) && (vcount >= 121) && (vcount < 147));
	wire tile061 = ((hcount >= 208) && (hcount < 234) && (vcount >= 121) && (vcount < 147));
	wire tile062 = ((hcount >= 234) && (hcount < 260) && (vcount >= 121) && (vcount < 147));
	wire tile063 = ((hcount >= 260) && (hcount < 286) && (vcount >= 121) && (vcount < 147));
	wire tile064 = ((hcount >= 286) && (hcount < 312) && (vcount >= 121) && (vcount < 147));
	wire tile065 = ((hcount >= 312) && (hcount < 338) && (vcount >= 121) && (vcount < 147));
	wire tile066 = ((hcount >= 338) && (hcount < 364) && (vcount >= 121) && (vcount < 147));
	wire tile067 = ((hcount >= 364) && (hcount < 390) && (vcount >= 121) && (vcount < 147));
	wire tile068 = ((hcount >= 390) && (hcount < 416) && (vcount >= 121) && (vcount < 147));
	wire tile069 = ((hcount >= 416) && (hcount < 442) && (vcount >= 121) && (vcount < 147));
	wire tile070 = ((hcount >= 442) && (hcount < 468) && (vcount >= 121) && (vcount < 147));
	/* Sixth line of the active grid */
	wire tile071 = ((hcount >= 104) && (hcount < 130) && (vcount >= 147) && (vcount < 173));
	wire tile072 = ((hcount >= 130) && (hcount < 156) && (vcount >= 147) && (vcount < 173));
	wire tile073 = ((hcount >= 156) && (hcount < 182) && (vcount >= 147) && (vcount < 173));
	wire tile074 = ((hcount >= 182) && (hcount < 208) && (vcount >= 147) && (vcount < 173));
	wire tile075 = ((hcount >= 208) && (hcount < 234) && (vcount >= 147) && (vcount < 173));
	wire tile076 = ((hcount >= 234) && (hcount < 260) && (vcount >= 147) && (vcount < 173));
	wire tile077 = ((hcount >= 260) && (hcount < 286) && (vcount >= 147) && (vcount < 173));
	wire tile078 = ((hcount >= 286) && (hcount < 312) && (vcount >= 147) && (vcount < 173));
	wire tile079 = ((hcount >= 312) && (hcount < 338) && (vcount >= 147) && (vcount < 173));
	wire tile080 = ((hcount >= 338) && (hcount < 364) && (vcount >= 147) && (vcount < 173));
	wire tile081 = ((hcount >= 364) && (hcount < 390) && (vcount >= 147) && (vcount < 173));
	wire tile082 = ((hcount >= 390) && (hcount < 416) && (vcount >= 147) && (vcount < 173));
	wire tile083 = ((hcount >= 416) && (hcount < 442) && (vcount >= 147) && (vcount < 173));
	wire tile084 = ((hcount >= 442) && (hcount < 468) && (vcount >= 147) && (vcount < 173));
	/* Seventh line of the active grid */
	wire tile085 = ((hcount >= 104) && (hcount < 130) && (vcount >= 173) && (vcount < 199));
	wire tile086 = ((hcount >= 130) && (hcount < 156) && (vcount >= 173) && (vcount < 199));
	wire tile087 = ((hcount >= 156) && (hcount < 182) && (vcount >= 173) && (vcount < 199));
	wire tile088 = ((hcount >= 182) && (hcount < 208) && (vcount >= 173) && (vcount < 199));
	wire tile089 = ((hcount >= 208) && (hcount < 234) && (vcount >= 173) && (vcount < 199));
	wire tile090 = ((hcount >= 234) && (hcount < 260) && (vcount >= 173) && (vcount < 199));
	wire tile091 = ((hcount >= 260) && (hcount < 286) && (vcount >= 173) && (vcount < 199));
	wire tile092 = ((hcount >= 286) && (hcount < 312) && (vcount >= 173) && (vcount < 199));
	wire tile093 = ((hcount >= 312) && (hcount < 338) && (vcount >= 173) && (vcount < 199));
	wire tile094 = ((hcount >= 338) && (hcount < 364) && (vcount >= 173) && (vcount < 199));
	wire tile095 = ((hcount >= 364) && (hcount < 390) && (vcount >= 173) && (vcount < 199));
	wire tile096 = ((hcount >= 390) && (hcount < 416) && (vcount >= 173) && (vcount < 199));
	wire tile097 = ((hcount >= 416) && (hcount < 442) && (vcount >= 173) && (vcount < 199));
	wire tile098 = ((hcount >= 442) && (hcount < 468) && (vcount >= 173) && (vcount < 199));
	/* Eighth line of the active grid */
	wire tile099 = ((hcount >= 104) && (hcount < 130) && (vcount >= 199) && (vcount < 225));
	wire tile100 = ((hcount >= 130) && (hcount < 156) && (vcount >= 199) && (vcount < 225));
	wire tile101 = ((hcount >= 156) && (hcount < 182) && (vcount >= 199) && (vcount < 225));
	wire tile102 = ((hcount >= 182) && (hcount < 208) && (vcount >= 199) && (vcount < 225));
	wire tile103 = ((hcount >= 208) && (hcount < 234) && (vcount >= 199) && (vcount < 225));
	wire tile104 = ((hcount >= 234) && (hcount < 260) && (vcount >= 199) && (vcount < 225));
	wire tile105 = ((hcount >= 260) && (hcount < 286) && (vcount >= 199) && (vcount < 225));
	wire tile106 = ((hcount >= 286) && (hcount < 312) && (vcount >= 199) && (vcount < 225));
	wire tile107 = ((hcount >= 312) && (hcount < 338) && (vcount >= 199) && (vcount < 225));
	wire tile108 = ((hcount >= 338) && (hcount < 364) && (vcount >= 199) && (vcount < 225));
	wire tile109 = ((hcount >= 364) && (hcount < 390) && (vcount >= 199) && (vcount < 225));
	wire tile110 = ((hcount >= 390) && (hcount < 416) && (vcount >= 199) && (vcount < 225));
	wire tile111 = ((hcount >= 416) && (hcount < 442) && (vcount >= 199) && (vcount < 225));
	wire tile112 = ((hcount >= 442) && (hcount < 468) && (vcount >= 199) && (vcount < 225));
	/* Ninth line of the active grid */
	wire tile113 = ((hcount >= 104) && (hcount < 130) && (vcount >= 225) && (vcount < 251));
	wire tile114 = ((hcount >= 130) && (hcount < 156) && (vcount >= 225) && (vcount < 251));
	wire tile115 = ((hcount >= 156) && (hcount < 182) && (vcount >= 225) && (vcount < 251));
	wire tile116 = ((hcount >= 182) && (hcount < 208) && (vcount >= 225) && (vcount < 251));
	wire tile117 = ((hcount >= 208) && (hcount < 234) && (vcount >= 225) && (vcount < 251));
	wire tile118 = ((hcount >= 234) && (hcount < 260) && (vcount >= 225) && (vcount < 251));
	wire tile119 = ((hcount >= 260) && (hcount < 286) && (vcount >= 225) && (vcount < 251));
	wire tile120 = ((hcount >= 286) && (hcount < 312) && (vcount >= 225) && (vcount < 251));
	wire tile121 = ((hcount >= 312) && (hcount < 338) && (vcount >= 225) && (vcount < 251));
	wire tile122 = ((hcount >= 338) && (hcount < 364) && (vcount >= 225) && (vcount < 251));
	wire tile123 = ((hcount >= 364) && (hcount < 390) && (vcount >= 225) && (vcount < 251));
	wire tile124 = ((hcount >= 390) && (hcount < 416) && (vcount >= 225) && (vcount < 251));
	wire tile125 = ((hcount >= 416) && (hcount < 442) && (vcount >= 225) && (vcount < 251));
	wire tile126 = ((hcount >= 442) && (hcount < 468) && (vcount >= 225) && (vcount < 251));
	/* Tenth line of the active grid */
	wire tile127 = ((hcount >= 104) && (hcount < 130) && (vcount >= 251) && (vcount < 277));
	wire tile128 = ((hcount >= 130) && (hcount < 156) && (vcount >= 251) && (vcount < 277));
	wire tile129 = ((hcount >= 156) && (hcount < 182) && (vcount >= 251) && (vcount < 277));
	wire tile130 = ((hcount >= 182) && (hcount < 208) && (vcount >= 251) && (vcount < 277));
	wire tile131 = ((hcount >= 208) && (hcount < 234) && (vcount >= 251) && (vcount < 277));
	wire tile132 = ((hcount >= 234) && (hcount < 260) && (vcount >= 251) && (vcount < 277));
	wire tile133 = ((hcount >= 260) && (hcount < 286) && (vcount >= 251) && (vcount < 277));
	wire tile134 = ((hcount >= 286) && (hcount < 312) && (vcount >= 251) && (vcount < 277));
	wire tile135 = ((hcount >= 312) && (hcount < 338) && (vcount >= 251) && (vcount < 277));
	wire tile136 = ((hcount >= 338) && (hcount < 364) && (vcount >= 251) && (vcount < 277));
	wire tile137 = ((hcount >= 364) && (hcount < 390) && (vcount >= 251) && (vcount < 277));
	wire tile138 = ((hcount >= 390) && (hcount < 416) && (vcount >= 251) && (vcount < 277));
	wire tile139 = ((hcount >= 416) && (hcount < 442) && (vcount >= 251) && (vcount < 277));
	wire tile140 = ((hcount >= 442) && (hcount < 468) && (vcount >= 251) && (vcount < 277));
	/* Eleventh line of the active grid */
	wire tile141 = ((hcount >= 104) && (hcount < 130) && (vcount >= 277) && (vcount < 303));
	wire tile142 = ((hcount >= 130) && (hcount < 156) && (vcount >= 277) && (vcount < 303));
	wire tile143 = ((hcount >= 156) && (hcount < 182) && (vcount >= 277) && (vcount < 303));
	wire tile144 = ((hcount >= 182) && (hcount < 208) && (vcount >= 277) && (vcount < 303));
	wire tile145 = ((hcount >= 208) && (hcount < 234) && (vcount >= 277) && (vcount < 303));
	wire tile146 = ((hcount >= 234) && (hcount < 260) && (vcount >= 277) && (vcount < 303));
	wire tile147 = ((hcount >= 260) && (hcount < 286) && (vcount >= 277) && (vcount < 303));
	wire tile148 = ((hcount >= 286) && (hcount < 312) && (vcount >= 277) && (vcount < 303));
	wire tile149 = ((hcount >= 312) && (hcount < 338) && (vcount >= 277) && (vcount < 303));
	wire tile150 = ((hcount >= 338) && (hcount < 364) && (vcount >= 277) && (vcount < 303));
	wire tile151 = ((hcount >= 364) && (hcount < 390) && (vcount >= 277) && (vcount < 303));
	wire tile152 = ((hcount >= 390) && (hcount < 416) && (vcount >= 277) && (vcount < 303));
	wire tile153 = ((hcount >= 416) && (hcount < 442) && (vcount >= 277) && (vcount < 303));
	wire tile154 = ((hcount >= 442) && (hcount < 468) && (vcount >= 277) && (vcount < 303));
	/* Twelfth line of the active grid */
	wire tile155 = ((hcount >= 104) && (hcount < 130) && (vcount >= 303) && (vcount < 329));
	wire tile156 = ((hcount >= 130) && (hcount < 156) && (vcount >= 303) && (vcount < 329));
	wire tile157 = ((hcount >= 156) && (hcount < 182) && (vcount >= 303) && (vcount < 329));
	wire tile158 = ((hcount >= 182) && (hcount < 208) && (vcount >= 303) && (vcount < 329));
	wire tile159 = ((hcount >= 208) && (hcount < 234) && (vcount >= 303) && (vcount < 329));
	wire tile160 = ((hcount >= 234) && (hcount < 260) && (vcount >= 303) && (vcount < 329));
	wire tile161 = ((hcount >= 260) && (hcount < 286) && (vcount >= 303) && (vcount < 329));
	wire tile162 = ((hcount >= 286) && (hcount < 312) && (vcount >= 303) && (vcount < 329));
	wire tile163 = ((hcount >= 312) && (hcount < 338) && (vcount >= 303) && (vcount < 329));
	wire tile164 = ((hcount >= 338) && (hcount < 364) && (vcount >= 303) && (vcount < 329));
	wire tile165 = ((hcount >= 364) && (hcount < 390) && (vcount >= 303) && (vcount < 329));
	wire tile166 = ((hcount >= 390) && (hcount < 416) && (vcount >= 303) && (vcount < 329));
	wire tile167 = ((hcount >= 416) && (hcount < 442) && (vcount >= 303) && (vcount < 329));
	wire tile168 = ((hcount >= 442) && (hcount < 468) && (vcount >= 303) && (vcount < 329));
	/* Thirteenth line of the active grid */
	wire tile169 = ((hcount >= 104) && (hcount < 130) && (vcount >= 329) && (vcount < 355));
	wire tile170 = ((hcount >= 130) && (hcount < 156) && (vcount >= 329) && (vcount < 355));
	wire tile171 = ((hcount >= 156) && (hcount < 182) && (vcount >= 329) && (vcount < 355));
	wire tile172 = ((hcount >= 182) && (hcount < 208) && (vcount >= 329) && (vcount < 355));
	wire tile173 = ((hcount >= 208) && (hcount < 234) && (vcount >= 329) && (vcount < 355));
	wire tile174 = ((hcount >= 234) && (hcount < 260) && (vcount >= 329) && (vcount < 355));
	wire tile175 = ((hcount >= 260) && (hcount < 286) && (vcount >= 329) && (vcount < 355));
	wire tile176 = ((hcount >= 286) && (hcount < 312) && (vcount >= 329) && (vcount < 355));
	wire tile177 = ((hcount >= 312) && (hcount < 338) && (vcount >= 329) && (vcount < 355));
	wire tile178 = ((hcount >= 338) && (hcount < 364) && (vcount >= 329) && (vcount < 355));
	wire tile179 = ((hcount >= 364) && (hcount < 390) && (vcount >= 329) && (vcount < 355));
	wire tile180 = ((hcount >= 390) && (hcount < 416) && (vcount >= 329) && (vcount < 355));
	wire tile181 = ((hcount >= 416) && (hcount < 442) && (vcount >= 329) && (vcount < 355));
	wire tile182 = ((hcount >= 442) && (hcount < 468) && (vcount >= 329) && (vcount < 355));
	/* Fourteenth line of the active grid */
	wire tile183 = ((hcount >= 104) && (hcount < 130) && (vcount >= 355) && (vcount < 381));
	wire tile184 = ((hcount >= 130) && (hcount < 156) && (vcount >= 355) && (vcount < 381));
	wire tile185 = ((hcount >= 156) && (hcount < 182) && (vcount >= 355) && (vcount < 381));
	wire tile186 = ((hcount >= 182) && (hcount < 208) && (vcount >= 355) && (vcount < 381));
	wire tile187 = ((hcount >= 208) && (hcount < 234) && (vcount >= 355) && (vcount < 381));
	wire tile188 = ((hcount >= 234) && (hcount < 260) && (vcount >= 355) && (vcount < 381));
	wire tile189 = ((hcount >= 260) && (hcount < 286) && (vcount >= 355) && (vcount < 381));
	wire tile190 = ((hcount >= 286) && (hcount < 312) && (vcount >= 355) && (vcount < 381));
	wire tile191 = ((hcount >= 312) && (hcount < 338) && (vcount >= 355) && (vcount < 381));
	wire tile192 = ((hcount >= 338) && (hcount < 364) && (vcount >= 355) && (vcount < 381));
	wire tile193 = ((hcount >= 364) && (hcount < 390) && (vcount >= 355) && (vcount < 381));
	wire tile194 = ((hcount >= 390) && (hcount < 416) && (vcount >= 355) && (vcount < 381));
	wire tile195 = ((hcount >= 416) && (hcount < 442) && (vcount >= 355) && (vcount < 381));
	wire tile196 = ((hcount >= 442) && (hcount < 468) && (vcount >= 355) && (vcount < 381));
	/* Fifteenth line of the active grid */
	wire tile197 = ((hcount >= 104) && (hcount < 130) && (vcount >= 381) && (vcount < 407));
	wire tile198 = ((hcount >= 130) && (hcount < 156) && (vcount >= 381) && (vcount < 407));
	wire tile199 = ((hcount >= 156) && (hcount < 182) && (vcount >= 381) && (vcount < 407));
	wire tile200 = ((hcount >= 182) && (hcount < 208) && (vcount >= 381) && (vcount < 407));
	wire tile201 = ((hcount >= 208) && (hcount < 234) && (vcount >= 381) && (vcount < 407));
	wire tile202 = ((hcount >= 234) && (hcount < 260) && (vcount >= 381) && (vcount < 407));
	wire tile203 = ((hcount >= 260) && (hcount < 286) && (vcount >= 381) && (vcount < 407));
	wire tile204 = ((hcount >= 286) && (hcount < 312) && (vcount >= 381) && (vcount < 407));
	wire tile205 = ((hcount >= 312) && (hcount < 338) && (vcount >= 381) && (vcount < 407));
	wire tile206 = ((hcount >= 338) && (hcount < 364) && (vcount >= 381) && (vcount < 407));
	wire tile207 = ((hcount >= 364) && (hcount < 390) && (vcount >= 381) && (vcount < 407));
	wire tile208 = ((hcount >= 390) && (hcount < 416) && (vcount >= 381) && (vcount < 407));
	wire tile209 = ((hcount >= 416) && (hcount < 442) && (vcount >= 381) && (vcount < 407));
	wire tile210 = ((hcount >= 442) && (hcount < 468) && (vcount >= 381) && (vcount < 407));
	/* Sixteenth line of the active grid */
	wire tile211 = ((hcount >= 104) && (hcount < 130) && (vcount >= 407) && (vcount < 433));
	wire tile212 = ((hcount >= 130) && (hcount < 156) && (vcount >= 407) && (vcount < 433));
	wire tile213 = ((hcount >= 156) && (hcount < 182) && (vcount >= 407) && (vcount < 433));
	wire tile214 = ((hcount >= 182) && (hcount < 208) && (vcount >= 407) && (vcount < 433));
	wire tile215 = ((hcount >= 208) && (hcount < 234) && (vcount >= 407) && (vcount < 433));
	wire tile216 = ((hcount >= 234) && (hcount < 260) && (vcount >= 407) && (vcount < 433));
	wire tile217 = ((hcount >= 260) && (hcount < 286) && (vcount >= 407) && (vcount < 433));
	wire tile218 = ((hcount >= 286) && (hcount < 312) && (vcount >= 407) && (vcount < 433));
	wire tile219 = ((hcount >= 312) && (hcount < 338) && (vcount >= 407) && (vcount < 433));
	wire tile220 = ((hcount >= 338) && (hcount < 364) && (vcount >= 407) && (vcount < 433));
	wire tile221 = ((hcount >= 364) && (hcount < 390) && (vcount >= 407) && (vcount < 433));
	wire tile222 = ((hcount >= 390) && (hcount < 416) && (vcount >= 407) && (vcount < 433));
	wire tile223 = ((hcount >= 416) && (hcount < 442) && (vcount >= 407) && (vcount < 433));
	wire tile224 = ((hcount >= 442) && (hcount < 468) && (vcount >= 407) && (vcount < 433));
	/* Seventeenth line of the active grid */
	wire tile225 = ((hcount >= 104) && (hcount < 130) && (vcount >= 433) && (vcount < 459));
	wire tile226 = ((hcount >= 130) && (hcount < 156) && (vcount >= 433) && (vcount < 459));
	wire tile227 = ((hcount >= 156) && (hcount < 182) && (vcount >= 433) && (vcount < 459));
	wire tile228 = ((hcount >= 182) && (hcount < 208) && (vcount >= 433) && (vcount < 459));
	wire tile229 = ((hcount >= 208) && (hcount < 234) && (vcount >= 433) && (vcount < 459));
	wire tile230 = ((hcount >= 234) && (hcount < 260) && (vcount >= 433) && (vcount < 459));
	wire tile231 = ((hcount >= 260) && (hcount < 286) && (vcount >= 433) && (vcount < 459));
	wire tile232 = ((hcount >= 286) && (hcount < 312) && (vcount >= 433) && (vcount < 459));
	wire tile233 = ((hcount >= 312) && (hcount < 338) && (vcount >= 433) && (vcount < 459));
	wire tile234 = ((hcount >= 338) && (hcount < 364) && (vcount >= 433) && (vcount < 459));
	wire tile235 = ((hcount >= 364) && (hcount < 390) && (vcount >= 433) && (vcount < 459));
	wire tile236 = ((hcount >= 390) && (hcount < 416) && (vcount >= 433) && (vcount < 459));
	wire tile237 = ((hcount >= 416) && (hcount < 442) && (vcount >= 433) && (vcount < 459));
	wire tile238 = ((hcount >= 442) && (hcount < 468) && (vcount >= 433) && (vcount < 459));
	/* Eighteenth line of the active grid */
	wire tile239 = ((hcount >= 104) && (hcount < 130) && (vcount >= 459) && (vcount < 485));
	wire tile240 = ((hcount >= 130) && (hcount < 156) && (vcount >= 459) && (vcount < 485));
	wire tile241 = ((hcount >= 156) && (hcount < 182) && (vcount >= 459) && (vcount < 485));
	wire tile242 = ((hcount >= 182) && (hcount < 208) && (vcount >= 459) && (vcount < 485));
	wire tile243 = ((hcount >= 208) && (hcount < 234) && (vcount >= 459) && (vcount < 485));
	wire tile244 = ((hcount >= 234) && (hcount < 260) && (vcount >= 459) && (vcount < 485));
	wire tile245 = ((hcount >= 260) && (hcount < 286) && (vcount >= 459) && (vcount < 485));
	wire tile246 = ((hcount >= 286) && (hcount < 312) && (vcount >= 459) && (vcount < 485));
	wire tile247 = ((hcount >= 312) && (hcount < 338) && (vcount >= 459) && (vcount < 485));
	wire tile248 = ((hcount >= 338) && (hcount < 364) && (vcount >= 459) && (vcount < 485));
	wire tile249 = ((hcount >= 364) && (hcount < 390) && (vcount >= 459) && (vcount < 485));
	wire tile250 = ((hcount >= 390) && (hcount < 416) && (vcount >= 459) && (vcount < 485));
	wire tile251 = ((hcount >= 416) && (hcount < 442) && (vcount >= 459) && (vcount < 485));
	wire tile252 = ((hcount >= 442) && (hcount < 468) && (vcount >= 459) && (vcount < 485));
	/* Ninteenth line of the active grid */
	wire tile253 = ((hcount >= 104) && (hcount < 130) && (vcount >= 485) && (vcount < 511));
	wire tile254 = ((hcount >= 130) && (hcount < 156) && (vcount >= 485) && (vcount < 511));
	wire tile255 = ((hcount >= 156) && (hcount < 182) && (vcount >= 485) && (vcount < 511));
	wire tile256 = ((hcount >= 182) && (hcount < 208) && (vcount >= 485) && (vcount < 511));
	wire tile257 = ((hcount >= 208) && (hcount < 234) && (vcount >= 485) && (vcount < 511));
	wire tile258 = ((hcount >= 234) && (hcount < 260) && (vcount >= 485) && (vcount < 511));
	wire tile259 = ((hcount >= 260) && (hcount < 286) && (vcount >= 485) && (vcount < 511));
	wire tile260 = ((hcount >= 286) && (hcount < 312) && (vcount >= 485) && (vcount < 511));
	wire tile261 = ((hcount >= 312) && (hcount < 338) && (vcount >= 485) && (vcount < 511));
	wire tile262 = ((hcount >= 338) && (hcount < 364) && (vcount >= 485) && (vcount < 511));
	wire tile263 = ((hcount >= 364) && (hcount < 390) && (vcount >= 485) && (vcount < 511));
	wire tile264 = ((hcount >= 390) && (hcount < 416) && (vcount >= 485) && (vcount < 511));
	wire tile265 = ((hcount >= 416) && (hcount < 442) && (vcount >= 485) && (vcount < 511));
	wire tile266 = ((hcount >= 442) && (hcount < 468) && (vcount >= 485) && (vcount < 511));
	/* Twentieth line of the active grid */
	wire tile267 = ((hcount >= 104) && (hcount < 130) && (vcount >= 511) && (vcount < 537));
	wire tile268 = ((hcount >= 130) && (hcount < 156) && (vcount >= 511) && (vcount < 537));
	wire tile269 = ((hcount >= 156) && (hcount < 182) && (vcount >= 511) && (vcount < 537));
	wire tile270 = ((hcount >= 182) && (hcount < 208) && (vcount >= 511) && (vcount < 537));
	wire tile271 = ((hcount >= 208) && (hcount < 234) && (vcount >= 511) && (vcount < 537));
	wire tile272 = ((hcount >= 234) && (hcount < 260) && (vcount >= 511) && (vcount < 537));
	wire tile273 = ((hcount >= 260) && (hcount < 286) && (vcount >= 511) && (vcount < 537));
	wire tile274 = ((hcount >= 286) && (hcount < 312) && (vcount >= 511) && (vcount < 537));
	wire tile275 = ((hcount >= 312) && (hcount < 338) && (vcount >= 511) && (vcount < 537));
	wire tile276 = ((hcount >= 338) && (hcount < 364) && (vcount >= 511) && (vcount < 537));
	wire tile277 = ((hcount >= 364) && (hcount < 390) && (vcount >= 511) && (vcount < 537));
	wire tile278 = ((hcount >= 390) && (hcount < 416) && (vcount >= 511) && (vcount < 537));
	wire tile279 = ((hcount >= 416) && (hcount < 442) && (vcount >= 511) && (vcount < 537));
	wire tile280 = ((hcount >= 442) && (hcount < 468) && (vcount >= 511) && (vcount < 537));
	/* Twenty-first line of the active grid */
	wire tile281 = ((hcount >= 104) && (hcount < 130) && (vcount >= 537) && (vcount < 563));
	wire tile282 = ((hcount >= 130) && (hcount < 156) && (vcount >= 537) && (vcount < 563));
	wire tile283 = ((hcount >= 156) && (hcount < 182) && (vcount >= 537) && (vcount < 563));
	wire tile284 = ((hcount >= 182) && (hcount < 208) && (vcount >= 537) && (vcount < 563));
	wire tile285 = ((hcount >= 208) && (hcount < 234) && (vcount >= 537) && (vcount < 563));
	wire tile286 = ((hcount >= 234) && (hcount < 260) && (vcount >= 537) && (vcount < 563));
	wire tile287 = ((hcount >= 260) && (hcount < 286) && (vcount >= 537) && (vcount < 563));
	wire tile288 = ((hcount >= 286) && (hcount < 312) && (vcount >= 537) && (vcount < 563));
	wire tile289 = ((hcount >= 312) && (hcount < 338) && (vcount >= 537) && (vcount < 563));
	wire tile290 = ((hcount >= 338) && (hcount < 364) && (vcount >= 537) && (vcount < 563));
	wire tile291 = ((hcount >= 364) && (hcount < 390) && (vcount >= 537) && (vcount < 563));
	wire tile292 = ((hcount >= 390) && (hcount < 416) && (vcount >= 537) && (vcount < 563));
	wire tile293 = ((hcount >= 416) && (hcount < 442) && (vcount >= 537) && (vcount < 563));
	wire tile294 = ((hcount >= 442) && (hcount < 468) && (vcount >= 537) && (vcount < 563));
	/* Twenty-second line of the active grid */
	wire tile295 = ((hcount >= 104) && (hcount < 130) && (vcount >= 563) && (vcount < 589));
	wire tile296 = ((hcount >= 130) && (hcount < 156) && (vcount >= 563) && (vcount < 589));
	wire tile297 = ((hcount >= 156) && (hcount < 182) && (vcount >= 563) && (vcount < 589));
	wire tile298 = ((hcount >= 182) && (hcount < 208) && (vcount >= 563) && (vcount < 589));
	wire tile299 = ((hcount >= 208) && (hcount < 234) && (vcount >= 563) && (vcount < 589));
	wire tile300 = ((hcount >= 234) && (hcount < 260) && (vcount >= 563) && (vcount < 589));
	wire tile301 = ((hcount >= 260) && (hcount < 286) && (vcount >= 563) && (vcount < 589));
	wire tile302 = ((hcount >= 286) && (hcount < 312) && (vcount >= 563) && (vcount < 589));
	wire tile303 = ((hcount >= 312) && (hcount < 338) && (vcount >= 563) && (vcount < 589));
	wire tile304 = ((hcount >= 338) && (hcount < 364) && (vcount >= 563) && (vcount < 589));
	wire tile305 = ((hcount >= 364) && (hcount < 390) && (vcount >= 563) && (vcount < 589));
	wire tile306 = ((hcount >= 390) && (hcount < 416) && (vcount >= 563) && (vcount < 589));
	wire tile307 = ((hcount >= 416) && (hcount < 442) && (vcount >= 563) && (vcount < 589));
	wire tile308 = ((hcount >= 442) && (hcount < 468) && (vcount >= 563) && (vcount < 589));
	
	
	/* Memory for frame frameBuff */
	//FrameframeBuff frameInst(vclk,WEA,addr,frame_in,frameBuff);
//	assign frameBuff = 1'b1;

endmodule
