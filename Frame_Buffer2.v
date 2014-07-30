`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Module Name:    Frame_Buffer 
// Project Name: 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module Frame_Buffer2(
				vclk,
				rst,
				done,
				show,
				pixel,
				hcount,
				vcount,
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
	input		[7:0]			pixel;
	input		[10:0]		hcount;
  input 	[9:0]	 		vcount;
	output						next;
	output	[7:0] 	  frame_pixel;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================		
	reg 					next;
	reg		[7:0]		frame_pixel;
	reg 	[3:0]		buffer [308:1];
	reg 	[8:0] 	i;
	reg 	[8:0] 	j;

	wire					done;
	wire					center = ((hcount == 117) || (hcount == 143) || (hcount == 169) || (hcount == 195) ||
						 (hcount == 221) || (hcount == 247) || (hcount == 273) || (hcount == 299) ||
						 (hcount == 325) || (hcount == 351) || (hcount == 377) || (hcount == 403) || 
						 (hcount == 429)) && 
						 ((vcount == 30) || (vcount == 56) || (vcount == 82) || (vcount == 108) ||
						 (vcount == 134) || (vcount == 160) || (vcount == 186) || (vcount == 212) ||
						 (vcount == 238) || (vcount == 264) || (vcount == 290) || (vcount == 316) ||
						 (vcount == 342) || (vcount == 368) || (vcount == 394) || (vcount == 420) ||
						 (vcount == 446) || (vcount == 472) || (vcount == 498) || (vcount == 524) || 
						 (vcount == 550));
						 
	wire ctrl = tile001|tile015|tile029|tile043|tile057|tile071|tile085|tile099|
				        tile002|tile016|tile030|tile044|tile058|tile072|tile086|tile100|
				        tile003|tile017|tile031|tile045|tile059|tile073|tile087|
				        tile004|tile018|tile032|tile046|tile060|tile074|tile088|
				        tile005|tile019|tile033|tile047|tile061|tile075|tile089|
				        tile006|tile020|tile034|tile048|tile062|tile076|tile090|
				        tile007|tile021|tile035|tile049|tile063|tile077|tile091|
				        tile008|tile022|tile036|tile050|tile064|tile078|tile092|
				        tile009|tile023|tile037|tile051|tile065|tile079|tile093|
				        tile010|tile024|tile038|tile052|tile066|tile080|tile094|
				        tile011|tile025|tile039|tile053|tile067|tile081|tile095|
				        tile012|tile026|tile040|tile054|tile068|tile082|tile096|
				        tile013|tile027|tile041|tile055|tile069|tile083|tile097|
				        tile014|tile028|tile042|tile056|tile070|tile084|tile098|
								
								tile101|tile115|tile129|tile143|tile157|tile171|tile185|tile199|
				        tile102|tile116|tile130|tile144|tile158|tile172|tile186|tile200|
				        tile103|tile117|tile131|tile145|tile159|tile173|tile187|
				        tile104|tile118|tile132|tile146|tile160|tile174|tile188|
				        tile105|tile119|tile133|tile147|tile161|tile175|tile189|
				        tile106|tile120|tile134|tile148|tile162|tile176|tile190|
				        tile107|tile121|tile135|tile149|tile163|tile177|tile191|
				        tile108|tile122|tile136|tile150|tile164|tile178|tile192|
				        tile109|tile123|tile137|tile151|tile165|tile179|tile193|
				        tile110|tile124|tile138|tile152|tile166|tile180|tile194|
				        tile111|tile125|tile139|tile153|tile167|tile181|tile195|
				        tile112|tile126|tile140|tile154|tile168|tile182|tile196|
				        tile113|tile127|tile141|tile155|tile169|tile183|tile197|
				        tile114|tile128|tile142|tile156|tile170|tile184|tile198|
								
								tile201|tile215|tile229|tile243|tile257|tile271|tile285|tile299|
				        tile202|tile216|tile230|tile244|tile258|tile272|tile286|tile300|
				        tile203|tile217|tile231|tile245|tile259|tile273|tile287|tile301|
				        tile204|tile218|tile232|tile246|tile260|tile274|tile288|tile302|
				        tile205|tile219|tile233|tile247|tile261|tile275|tile289|tile303|
				        tile206|tile220|tile234|tile248|tile262|tile276|tile290|tile304|
				        tile207|tile221|tile235|tile249|tile263|tile277|tile291|tile305|
				        tile208|tile222|tile236|tile250|tile264|tile278|tile292|tile306|
				        tile209|tile223|tile237|tile251|tile265|tile279|tile293|tile307|
				        tile210|tile224|tile238|tile252|tile266|tile280|tile294|tile308|
				        tile211|tile225|tile239|tile253|tile267|tile281|tile295|
				        tile212|tile226|tile240|tile254|tile268|tile282|tile296|
				        tile213|tile227|tile241|tile255|tile269|tile283|tile297|
				        tile214|tile228|tile242|tile256|tile270|tile284|tile298;
								
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	

	always @(posedge vclk or posedge rst)
	begin
		if (rst)
		begin
			j = 9'b0000_00001;
			buffer[1] = 4'b0;
			buffer[2] = 4'b0;
			buffer[3] = 4'b0;
			buffer[4] = 4'b0;
			buffer[5] = 4'b0;
			buffer[6] = 4'b0;
			buffer[7] = 4'b0;
			buffer[8] = 4'b0;
			buffer[9] = 4'b0;
			buffer[10] = 4'b0;
			buffer[11] = 4'b0;
			buffer[12] = 4'b0;
			buffer[13] = 4'b0;
			buffer[14] = 4'b0;
			buffer[15] = 4'b0;
			buffer[16] = 4'b0;
			buffer[17] = 4'b0;
			buffer[18] = 4'b0;
			buffer[19] = 4'b0;
			buffer[20] = 4'b0;
			buffer[21] = 4'b0;
			buffer[22] = 4'b0;
			buffer[23] = 4'b0;
			buffer[24] = 4'b0;
			buffer[25] = 4'b0;
			buffer[26] = 4'b0;
			buffer[27] = 4'b0;
			buffer[28] = 4'b0;
			buffer[29] = 4'b0;
			buffer[30] = 4'b0;
			buffer[31] = 4'b0;
			buffer[32] = 4'b0;
			buffer[33] = 4'b0;
			buffer[34] = 4'b0;
			buffer[35] = 4'b0;
			buffer[36] = 4'b0;
			buffer[37] = 4'b0;
			buffer[38] = 4'b0;
			buffer[39] = 4'b0;
			buffer[40] = 4'b0;
			buffer[41] = 4'b0;
			buffer[42] = 4'b0;
			buffer[43] = 4'b0;
			buffer[44] = 4'b0;
			buffer[45] = 4'b0;
			buffer[46] = 4'b0;
			buffer[47] = 4'b0;
			buffer[48] = 4'b0;
			buffer[49] = 4'b0;
			buffer[50] = 4'b0;
			buffer[51] = 4'b0;
			buffer[52] = 4'b0;
			buffer[53] = 4'b0;
			buffer[54] = 4'b0;
			buffer[55] = 4'b0;
			buffer[56] = 4'b0;
			buffer[57] = 4'b0;
			buffer[58] = 4'b0;
			buffer[59] = 4'b0;
			buffer[60] = 4'b0;
			buffer[61] = 4'b0;
			buffer[62] = 4'b0;
			buffer[63] = 4'b0;
			buffer[64] = 4'b0;
			buffer[65] = 4'b0;
			buffer[66] = 4'b0;
			buffer[67] = 4'b0;
			buffer[68] = 4'b0;
			buffer[69] = 4'b0;
			buffer[70] = 4'b0;
			buffer[71] = 4'b0;
			buffer[72] = 4'b0;
			buffer[73] = 4'b0;
			buffer[74] = 4'b0;
			buffer[75] = 4'b0;
			buffer[76] = 4'b0;
			buffer[77] = 4'b0;
			buffer[78] = 4'b0;
			buffer[79] = 4'b0;
			buffer[80] = 4'b0;
			buffer[81] = 4'b0;
			buffer[82] = 4'b0;
			buffer[83] = 4'b0;
			buffer[84] = 4'b0;
			buffer[85] = 4'b0;
			buffer[86] = 4'b0;
			buffer[87] = 4'b0;
			buffer[88] = 4'b0;
			buffer[89] = 4'b0;
			buffer[90] = 4'b0;
			buffer[91] = 4'b0;
			buffer[92] = 4'b0;
			buffer[93] = 4'b0;
			buffer[94] = 4'b0;
			buffer[95] = 4'b0;
			buffer[96] = 4'b0;
			buffer[97] = 4'b0;
			buffer[98] = 4'b0;
			buffer[99] = 4'b0;
			buffer[100] = 4'b0;
			buffer[101] = 4'b0;
			buffer[102] = 4'b0;
			buffer[103] = 4'b0;
			buffer[104] = 4'b0;
			buffer[105] = 4'b0;
			buffer[106] = 4'b0;
			buffer[107] = 4'b0;
			buffer[108] = 4'b0;
			buffer[109] = 4'b0;
			buffer[110] = 4'b0;
			buffer[111] = 4'b0;
			buffer[112] = 4'b0;
			buffer[113] = 4'b0;
			buffer[114] = 4'b0;
			buffer[115] = 4'b0;
			buffer[116] = 4'b0;
			buffer[117] = 4'b0;
			buffer[118] = 4'b0;
			buffer[119] = 4'b0;
			buffer[120] = 4'b0;
			buffer[121] = 4'b0;
			buffer[122] = 4'b0;
			buffer[123] = 4'b0;
			buffer[124] = 4'b0;
			buffer[125] = 4'b0;
			buffer[126] = 4'b0;
			buffer[127] = 4'b0;
			buffer[128] = 4'b0;
			buffer[129] = 4'b0;
			buffer[130] = 4'b0;
			buffer[131] = 4'b0;
			buffer[132] = 4'b0;
			buffer[133] = 4'b0;
			buffer[134] = 4'b0;
			buffer[135] = 4'b0;
			buffer[136] = 4'b0;
			buffer[137] = 4'b0;
			buffer[138] = 4'b0;
			buffer[139] = 4'b0;
			buffer[140] = 4'b0;
			buffer[141] = 4'b0;
			buffer[142] = 4'b0;
			buffer[143] = 4'b0;
			buffer[144] = 4'b0;
			buffer[145] = 4'b0;
			buffer[146] = 4'b0;
			buffer[147] = 4'b0;
			buffer[148] = 4'b0;
			buffer[149] = 4'b0;
			buffer[150] = 4'b0;
			buffer[151] = 4'b0;
			buffer[152] = 4'b0;
			buffer[153] = 4'b0;
			buffer[154] = 4'b0;
			buffer[155] = 4'b0;
			buffer[156] = 4'b0;
			buffer[157] = 4'b0;
			buffer[158] = 4'b0;
			buffer[159] = 4'b0;
			buffer[160] = 4'b0;
			buffer[161] = 4'b0;
			buffer[162] = 4'b0;
			buffer[163] = 4'b0;
			buffer[164] = 4'b0;
			buffer[165] = 4'b0;
			buffer[166] = 4'b0;
			buffer[167] = 4'b0;
			buffer[168] = 4'b0;
			buffer[169] = 4'b0;
			buffer[170] = 4'b0;
			buffer[171] = 4'b0;
			buffer[172] = 4'b0;
			buffer[173] = 4'b0;
			buffer[174] = 4'b0;
			buffer[175] = 4'b0;
			buffer[176] = 4'b0;
			buffer[177] = 4'b0;
			buffer[178] = 4'b0;
			buffer[179] = 4'b0;
			buffer[180] = 4'b0;
			buffer[181] = 4'b0;
			buffer[182] = 4'b0;
			buffer[183] = 4'b0;
			buffer[184] = 4'b0;
			buffer[185] = 4'b0;
			buffer[186] = 4'b0;
			buffer[187] = 4'b0;
			buffer[188] = 4'b0;
			buffer[189] = 4'b0;
			buffer[190] = 4'b0;
			buffer[191] = 4'b0;
			buffer[192] = 4'b0;
			buffer[193] = 4'b0;
			buffer[194] = 4'b0;
			buffer[195] = 4'b0;
			buffer[196] = 4'b0;
			buffer[197] = 4'b0;
			buffer[198] = 4'b0;
			buffer[199] = 4'b0;
			buffer[200] = 4'b0;
			buffer[201] = 4'b0;
			buffer[202] = 4'b0;
			buffer[203] = 4'b0;
			buffer[204] = 4'b0;
			buffer[205] = 4'b0;
			buffer[206] = 4'b0;
			buffer[207] = 4'b0;
			buffer[208] = 4'b0;
			buffer[209] = 4'b0;
			buffer[210] = 4'b0;
			buffer[211] = 4'b0;
			buffer[212] = 4'b0;
			buffer[213] = 4'b0;
			buffer[214] = 4'b0;
			buffer[215] = 4'b0;
			buffer[216] = 4'b0;
			buffer[217] = 4'b0;
			buffer[218] = 4'b0;
			buffer[219] = 4'b0;
			buffer[220] = 4'b0;
			buffer[221] = 4'b0;
			buffer[222] = 4'b0;
			buffer[223] = 4'b0;
			buffer[224] = 4'b0;
			buffer[225] = 4'b0;
			buffer[226] = 4'b0;
			buffer[227] = 4'b0;
			buffer[228] = 4'b0;
			buffer[229] = 4'b0;
			buffer[230] = 4'b0;
			buffer[231] = 4'b0;
			buffer[232] = 4'b0;
			buffer[233] = 4'b0;
			buffer[234] = 4'b0;
			buffer[235] = 4'b0;
			buffer[236] = 4'b0;
			buffer[237] = 4'b0;
			buffer[238] = 4'b0;
			buffer[239] = 4'b0;
			buffer[240] = 4'b0;
			buffer[241] = 4'b0;
			buffer[242] = 4'b0;
			buffer[243] = 4'b0;
			buffer[244] = 4'b0;
			buffer[245] = 4'b0;
			buffer[246] = 4'b0;
			buffer[247] = 4'b0;
			buffer[248] = 4'b0;
			buffer[249] = 4'b0;
			buffer[250] = 4'b0;
			buffer[251] = 4'b0;
			buffer[252] = 4'b0;
			buffer[253] = 4'b0;
			buffer[254] = 4'b0;
			buffer[255] = 4'b0;
			buffer[256] = 4'b0;
			buffer[257] = 4'b0;
			buffer[258] = 4'b0;
			buffer[259] = 4'b0;
			buffer[260] = 4'b0;
			buffer[261] = 4'b0;
			buffer[262] = 4'b0;
			buffer[263] = 4'b0;
			buffer[264] = 4'b0;
			buffer[265] = 4'b0;
			buffer[266] = 4'b0;
			buffer[267] = 4'b0;
			buffer[268] = 4'b0;
			buffer[269] = 4'b0;
			buffer[270] = 4'b0;
			buffer[271] = 4'b0;
			buffer[272] = 4'b0;
			buffer[273] = 4'b0;
			buffer[274] = 4'b0;
			buffer[275] = 4'b0;
			buffer[276] = 4'b0;
			buffer[277] = 4'b0;
			buffer[278] = 4'b0;
			buffer[279] = 4'b0;
			buffer[280] = 4'b0;
			buffer[281] = 4'b0;
			buffer[282] = 4'b0;
			buffer[283] = 4'b0;
			buffer[284] = 4'b0;
			buffer[285] = 4'b0;
			buffer[286] = 4'b0;
			buffer[287] = 4'b0;
			buffer[288] = 4'b0;
			buffer[289] = 4'b0;
			buffer[290] = 4'b0;
			buffer[291] = 4'b0;
			buffer[292] = 4'b0;
			buffer[293] = 4'b0;
			buffer[294] = 4'b0;
			buffer[295] = 4'b0;
			buffer[296] = 4'b0;
			buffer[297] = 4'b0;
			buffer[298] = 4'b0;
			buffer[299] = 4'b0;
			buffer[300] = 4'b0;
			buffer[301] = 4'b0;
			buffer[302] = 4'b0;
			buffer[303] = 4'b0;
			buffer[304] = 4'b0;
			buffer[305] = 4'b0;
			buffer[306] = 4'b0;
			buffer[307] = 4'b0;
			buffer[308] = 4'b0;
		end
		else
			begin
			if (done && !show)
			begin	
				if ((hcount == 455) && (vcount == 576))
				begin
					if (pixel == 8'h35)
						buffer[j] = 4'b0001;
					else if (pixel == 8'h00)
						buffer[j] = 4'b0000;
					next = 1'b1;
					j = 9'b0000_00001;
				end
				else if (center)
				begin
					if (pixel == 8'h35)
						buffer[j] = 4'b0001;
					else if (pixel == 8'h00)
						buffer[j] = 4'b0000;
						
					j = j + 9'b0000_00001;
					next = 1'b0;
				end
				else
					next = 1'b0;
				end
			end
	end
	
	always @( * )
	begin
		frame_pixel = 8'h0;
		if (show)
		begin
			if(ctrl)
				if (buffer[i] == 4'b0001)
					frame_pixel = 8'h35;
				else if (buffer[i] == 4'b0000)
					frame_pixel = 8'h00;
			else
				frame_pixel = 8'h0;
		end
	end
	
	always @ ( posedge vclk or posedge rst )
	begin
		if(rst)
			i = 9'b0000_00001;
		else
		begin
				if (tile308)
					i = 9'b0000_00001;
				else if(ctrl)
					i = i + 9'b0000_00001;	
		end
	end
	
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
	wire tile029 = ((hcount >= 105) && (hcount < 131) && (vcount >= 69) && (vcount < 95));
	wire tile030 = ((hcount >= 131) && (hcount < 157) && (vcount >= 69) && (vcount < 95));
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
	wire tile043 = ((hcount >= 105) && (hcount < 131) && (vcount >= 95) && (vcount < 121));
	wire tile044 = ((hcount >= 131) && (hcount < 157) && (vcount >= 95) && (vcount < 121));
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
	wire tile057 = ((hcount >= 105) && (hcount < 131) && (vcount >= 121) && (vcount < 147));
	wire tile058 = ((hcount >= 131) && (hcount < 157) && (vcount >= 121) && (vcount < 147));
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
	wire tile071 = ((hcount >= 105) && (hcount < 131) && (vcount >= 147) && (vcount < 173));
	wire tile072 = ((hcount >= 131) && (hcount < 157) && (vcount >= 147) && (vcount < 173));
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
	wire tile085 = ((hcount >= 105) && (hcount < 131) && (vcount >= 173) && (vcount < 199));
	wire tile086 = ((hcount >= 131) && (hcount < 157) && (vcount >= 173) && (vcount < 199));
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
	wire tile099 = ((hcount >= 105) && (hcount < 131) && (vcount >= 199) && (vcount < 225));
	wire tile100 = ((hcount >= 131) && (hcount < 157) && (vcount >= 199) && (vcount < 225));
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
	wire tile113 = ((hcount >= 105) && (hcount < 131) && (vcount >= 225) && (vcount < 251));
	wire tile114 = ((hcount >= 131) && (hcount < 157) && (vcount >= 225) && (vcount < 251));
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
	wire tile127 = ((hcount >= 105) && (hcount < 131) && (vcount >= 251) && (vcount < 277));
	wire tile128 = ((hcount >= 131) && (hcount < 157) && (vcount >= 251) && (vcount < 277));
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
	wire tile141 = ((hcount >= 105) && (hcount < 131) && (vcount >= 277) && (vcount < 303));
	wire tile142 = ((hcount >= 131) && (hcount < 157) && (vcount >= 277) && (vcount < 303));
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
	wire tile155 = ((hcount >= 105) && (hcount < 131) && (vcount >= 303) && (vcount < 329));
	wire tile156 = ((hcount >= 131) && (hcount < 157) && (vcount >= 303) && (vcount < 329));
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
	wire tile169 = ((hcount >= 105) && (hcount < 131) && (vcount >= 329) && (vcount < 355));
	wire tile170 = ((hcount >= 131) && (hcount < 157) && (vcount >= 329) && (vcount < 355));
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
	wire tile183 = ((hcount >= 105) && (hcount < 131) && (vcount >= 355) && (vcount < 381));
	wire tile184 = ((hcount >= 131) && (hcount < 157) && (vcount >= 355) && (vcount < 381));
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
	wire tile197 = ((hcount >= 105) && (hcount < 131) && (vcount >= 381) && (vcount < 407));
	wire tile198 = ((hcount >= 131) && (hcount < 157) && (vcount >= 381) && (vcount < 407));
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
	wire tile211 = ((hcount >= 105) && (hcount < 131) && (vcount >= 407) && (vcount < 433));
	wire tile212 = ((hcount >= 131) && (hcount < 157) && (vcount >= 407) && (vcount < 433));
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
	wire tile225 = ((hcount >= 105) && (hcount < 131) && (vcount >= 433) && (vcount < 459));
	wire tile226 = ((hcount >= 131) && (hcount < 157) && (vcount >= 433) && (vcount < 459));
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
	wire tile239 = ((hcount >= 105) && (hcount < 131) && (vcount >= 459) && (vcount < 485));
	wire tile240 = ((hcount >= 131) && (hcount < 157) && (vcount >= 459) && (vcount < 485));
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
	wire tile253 = ((hcount >= 105) && (hcount < 131) && (vcount >= 485) && (vcount < 511));
	wire tile254 = ((hcount >= 131) && (hcount < 157) && (vcount >= 485) && (vcount < 511));
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
	wire tile267 = ((hcount >= 105) && (hcount < 131) && (vcount >= 511) && (vcount < 537));
	wire tile268 = ((hcount >= 131) && (hcount < 157) && (vcount >= 511) && (vcount < 537));
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
	wire tile281 = ((hcount >= 105) && (hcount < 131) && (vcount >= 537) && (vcount < 563));
	wire tile282 = ((hcount >= 131) && (hcount < 157) && (vcount >= 537) && (vcount < 563));
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
	wire tile295 = ((hcount >= 105) && (hcount < 131) && (vcount >= 563) && (vcount < 589));
	wire tile296 = ((hcount >= 131) && (hcount < 157) && (vcount >= 563) && (vcount < 589));
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


endmodule
