`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:08 03/07/2014 
// Design Name: 
// Module Name:    BlockMovement 
// Project Name: 
// Description:  
//
//////////////////////////////////////////////////////////////////////////////////
module BlockMovement(
				vclk,
				rst,
				frame,
				LEFT,
				RIGHT,
				DOWN,
				move,
				vsync,
				new_block,
				hcount,
				vcount,
				x_in,
				y_in,
				done,
				game_over,
				//block_x,
				//block_y,
				frame_pixel	
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================			
	input 			 			vclk;
	input							rst;
	input 			 			frame;
	input							LEFT;
	input							RIGHT;
	input							DOWN;
	input							move;
	input							vsync;
	input							new_block;
	input		[10:0]		hcount;
  input 	[9:0]	 		vcount;
	input 	[10:0]  	x_in;
	input 	[9:0]			y_in;
	output						done;
	output						game_over;
	//output 	[10:0] 	 	block_x;
	//output 	[9:0]			block_y;
	output	[7:0] 	  frame_pixel;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================								
	//parameter			X = 260,  // default X & Y
								//Y = 17;
								
	integer				i;
	integer				j;
	integer				k;
	
	//reg 	[10:0]  block_x;
	//reg 	[9:0]		block_y;
	reg		[8:0]		first;
	reg		[8:0]		sec;
	reg		[8:0]		third;
	reg		[8:0]		fourth;	
	reg		[8:0]		diff_d;
	reg		[8:0]		diff_s;
	reg		[8:0]		saddr;
	reg		[7:0]		frame_pixel;
	//reg		[4:0]		v_x;
	//reg		[4:0]		v_y;
	reg		[2:0]		CollisionBuf[367:0];
	reg						done;
	reg						game_over;
	reg						filled;
	
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================	

	always @(posedge vclk or posedge rst)
	begin
		if (rst)
		begin
			//block_x = x_in;
			//block_y = y_in;
			filled = 1'b0;
			done = 1'b0;
			game_over = 1'b0;
			diff_d = 9'b0;
			diff_s = 9'b0;
			//v_x = 5'd26;
			//v_y = 5'd26;
			first = 9'd0;
			sec = 9'd0;
			third = 9'd0;
			fourth = 9'd0;			
			/*first1 = 9'd8;
			sec1 = 9'd9;
			third1 = 9'd23;
			fourth1 = 9'd24;*/
			
			for (i = 0; i < 23; i = i + 1)
			begin
				CollisionBuf[i*16] = 1'b1;
				CollisionBuf[i*16 + 15] = 1;
				for (j = 1; j < 15; j = j + 1)
					if (i == 22)
						CollisionBuf[i*16 + j] = 3'b111;
					else
						CollisionBuf[i*16 + j] = 3'b000;
			end
		end
		else
		begin
			if (move)
			begin
				if (frame)
				begin
					if (DOWN && ((!CollisionBuf[sec+32] && !CollisionBuf[third+32] && !CollisionBuf[fourth+32]) || //block_y >= 485 && block_y < 521
											(!CollisionBuf[third+32] && !CollisionBuf[fourth+32])))
					begin
						done = 1'b0;
						diff_d = 9'd32;
						//block_y = block_y + v_y + v_y;
						//first = first + 9'd32;
						//sec = sec + 9'd32;
						//third = third + 9'd32;
						//fourth = fourth + 9'd32;
					end
					else if ((!CollisionBuf[sec+16] && !CollisionBuf[third+16] && !CollisionBuf[fourth+16]) || // block_y < 521
									(!CollisionBuf[third+16] && !CollisionBuf[fourth+16]))
					begin	
						done = 1'b0;
						diff_d = 9'd16;
						//block_y = block_y + v_y;
						//first = first + 9'd16;
						//sec = sec + 9'd16;
						//third = third + 9'd16;
						//fourth = fourth + 9'd16;
					end
					else
					begin
						diff_d = 9'd0;
						/*block_y = block_y;
						if (block_x == x_in && block_y == y_in) //detect game over
							game_over = 1'b1;
						else
							game_over = 1'b0;*/
							
						if (vsync)//keep done up for a whole scan
							done = 1'b0;
						else
							done = 1'b1;
					end
					
					if (LEFT && !CollisionBuf[first-1] && !CollisionBuf[third-1]) // block_x >= 130
					begin
						done = 1'b0;
						diff_s = -9'd1;
						//block_x = block_x - v_x;
						//first = first - 9'd1;
						//sec = sec - 9'd1;
						//third = third - 9'd1;
						//fourth = fourth - 9'd1;
					end
					else if (RIGHT && !CollisionBuf[sec+1] && !CollisionBuf[fourth+1]) // block_x <= 364
					begin
						done = 1'b0;
						diff_s = 9'd1;
						//block_x = block_x + v_x;
						//first = first + 9'd1;
						//sec = sec + 9'd1;
						//third = third + 9'd1;
						//fourth = fourth + 9'd1;
					end
					else
					begin
						diff_s = 9'd0;
					end
					
					CollisionBuf[first] = 3'b000;
					CollisionBuf[sec] = 3'b000;
					CollisionBuf[third] = 3'b000;
					CollisionBuf[fourth] = 3'b000;
					
					first = first + diff_d + diff_s;
					sec = sec + diff_d + diff_s;
					third = third + diff_d + diff_s;
					fourth = fourth + diff_d + diff_s;
					
					CollisionBuf[first] = 3'b001;
					CollisionBuf[sec] = 3'b001;
					CollisionBuf[third] = 3'b001;
					CollisionBuf[fourth] = 3'b001;
					
					for (i = 0; i < 22; i = i + 1)			//detect filled lines
					begin
						filled = 1'b1;
						for (j = 1; j < 15; j = j + 1)
						begin
							if (!CollisionBuf[j + i*16]) 
								filled = 1'b0;
						end
						if (filled)
						begin
							for (k <= i; k = 1; k = k - 1)
							begin
								for (j = 1; j < 15; j = j + 1)
								begin
									CollisionBuf[j + k*16] = CollisionBuf[j + (k-1)*16];
								end
							end
						end
					end
				end
			end
			
			if (new_block)
			begin
				done = 1'b0;
				/*v_x = 5'd26;
				block_x = x_in;
				block_y = y_in;*/
				first = 9'd8;
				sec = 9'd9;
				third = 9'd24;
				fourth = 9'd25;
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
				if (tile001) saddr = 9'd1;
				if (tile002) saddr = 9'd2;
				if (tile003) saddr = 9'd3;
				if (tile004) saddr = 9'd4;
				if (tile005) saddr = 9'd5;
				if (tile006) saddr = 9'd6;
				if (tile007) saddr = 9'd7;
				if (tile008) saddr = 9'd8;
				if (tile009) saddr = 9'd9;
				if (tile010) saddr = 9'd10;
				if (tile011) saddr = 9'd11;
				if (tile012) saddr = 9'd12;
				if (tile013) saddr = 9'd13;
				if (tile014) saddr = 9'd14;
				if (tile015) saddr = 9'd17;
				if (tile016) saddr = 9'd18;
				if (tile017) saddr = 9'd19;
				if (tile018) saddr = 9'd20;
				if (tile019) saddr = 9'd21;
				if (tile020) saddr = 9'd22;
				if (tile021) saddr = 9'd23;
				if (tile022) saddr = 9'd24;
				if (tile023) saddr = 9'd25;
				if (tile024) saddr = 9'd26;
				if (tile025) saddr = 9'd27;
				if (tile026) saddr = 9'd28;
				if (tile027) saddr = 9'd29;
				if (tile028) saddr = 9'd30;
				if (tile029) saddr = 9'd33;
				if (tile030) saddr = 9'd34;
				if (tile031) saddr = 9'd35;
				if (tile032) saddr = 9'd36;
				if (tile033) saddr = 9'd37;
				if (tile034) saddr = 9'd38;
				if (tile035) saddr = 9'd39;
				if (tile036) saddr = 9'd40;
				if (tile037) saddr = 9'd41;
				if (tile038) saddr = 9'd42;
				if (tile039) saddr = 9'd43;
				if (tile040) saddr = 9'd44;
				if (tile041) saddr = 9'd45;
				if (tile042) saddr = 9'd46;
				if (tile043) saddr = 9'd49;
				if (tile044) saddr = 9'd50;
				if (tile045) saddr = 9'd51;
				if (tile046) saddr = 9'd52;
				if (tile047) saddr = 9'd53;
				if (tile048) saddr = 9'd54;
				if (tile049) saddr = 9'd55;
				if (tile050) saddr = 9'd56;
				if (tile051) saddr = 9'd57;
				if (tile052) saddr = 9'd58;
				if (tile053) saddr = 9'd59;
				if (tile054) saddr = 9'd60;
				if (tile055) saddr = 9'd61;
				if (tile056) saddr = 9'd62;
				if (tile057) saddr = 9'd65;
				if (tile058) saddr = 9'd66;
				if (tile059) saddr = 9'd67;
				if (tile060) saddr = 9'd68;
				if (tile061) saddr = 9'd69;
				if (tile062) saddr = 9'd70;
				if (tile063) saddr = 9'd71;
				if (tile064) saddr = 9'd72;
				if (tile065) saddr = 9'd73;
				if (tile066) saddr = 9'd74;
				if (tile067) saddr = 9'd75;
				if (tile068) saddr = 9'd76;
				if (tile069) saddr = 9'd77;
				if (tile070) saddr = 9'd78;
				if (tile071) saddr = 9'd81;
				if (tile072) saddr = 9'd82;
				if (tile073) saddr = 9'd83;
				if (tile074) saddr = 9'd84;
				if (tile075) saddr = 9'd85;
				if (tile076) saddr = 9'd86;
				if (tile077) saddr = 9'd87;
				if (tile078) saddr = 9'd88;
				if (tile079) saddr = 9'd89;
				if (tile080) saddr = 9'd90;
				if (tile081) saddr = 9'd91;
				if (tile082) saddr = 9'd92;
				if (tile083) saddr = 9'd93;
				if (tile084) saddr = 9'd94;
				if (tile085) saddr = 9'd97;
				if (tile086) saddr = 9'd98;
				if (tile087) saddr = 9'd99;
				if (tile088) saddr = 9'd100;
				if (tile089) saddr = 9'd101;
				if (tile090) saddr = 9'd102;
				if (tile091) saddr = 9'd103;
				if (tile092) saddr = 9'd104;
				if (tile093) saddr = 9'd105;
				if (tile094) saddr = 9'd106;
				if (tile095) saddr = 9'd107;
				if (tile096) saddr = 9'd108;
				if (tile097) saddr = 9'd109;
				if (tile098) saddr = 9'd110;
				if (tile099) saddr = 9'd113;
				if (tile100) saddr = 9'd114;
				if (tile101) saddr = 9'd115;
				if (tile102) saddr = 9'd116;
				if (tile103) saddr = 9'd117;
				if (tile104) saddr = 9'd118;
				if (tile105) saddr = 9'd119;
				if (tile106) saddr = 9'd120;
				if (tile107) saddr = 9'd121;
				if (tile108) saddr = 9'd122;
				if (tile109) saddr = 9'd123;
				if (tile110) saddr = 9'd124;
				if (tile111) saddr = 9'd125;
				if (tile112) saddr = 9'd126;
				if (tile113) saddr = 9'd129;
				if (tile114) saddr = 9'd130;
				if (tile115) saddr = 9'd131;
				if (tile116) saddr = 9'd132;
				if (tile117) saddr = 9'd133;
				if (tile118) saddr = 9'd134;
				if (tile119) saddr = 9'd135;
				if (tile120) saddr = 9'd136;
				if (tile121) saddr = 9'd137;
				if (tile122) saddr = 9'd138;
				if (tile123) saddr = 9'd139;
				if (tile124) saddr = 9'd140;
				if (tile125) saddr = 9'd141;
				if (tile126) saddr = 9'd142;
				if (tile127) saddr = 9'd145;
				if (tile128) saddr = 9'd146;
				if (tile129) saddr = 9'd147;
				if (tile130) saddr = 9'd148;
				if (tile131) saddr = 9'd149;
				if (tile132) saddr = 9'd150;
				if (tile133) saddr = 9'd151;
				if (tile134) saddr = 9'd152;
				if (tile135) saddr = 9'd153;
				if (tile136) saddr = 9'd154;
				if (tile137) saddr = 9'd155;
				if (tile138) saddr = 9'd156;
				if (tile139) saddr = 9'd157;
				if (tile140) saddr = 9'd158;
				if (tile141) saddr = 9'd161;
				if (tile142) saddr = 9'd162;
				if (tile143) saddr = 9'd163;
				if (tile144) saddr = 9'd164;
				if (tile145) saddr = 9'd165;
				if (tile146) saddr = 9'd166;
				if (tile147) saddr = 9'd167;
				if (tile148) saddr = 9'd168;
				if (tile149) saddr = 9'd169;
				if (tile150) saddr = 9'd170;
				if (tile151) saddr = 9'd171;
				if (tile152) saddr = 9'd172;
				if (tile153) saddr = 9'd173;
				if (tile154) saddr = 9'd174;
				if (tile155) saddr = 9'd177;
				if (tile156) saddr = 9'd178;
				if (tile157) saddr = 9'd179;
				if (tile158) saddr = 9'd180;
				if (tile159) saddr = 9'd181;
				if (tile160) saddr = 9'd182;
				if (tile161) saddr = 9'd183;
				if (tile162) saddr = 9'd184;
				if (tile163) saddr = 9'd185;
				if (tile164) saddr = 9'd186;
				if (tile165) saddr = 9'd187;
				if (tile166) saddr = 9'd188;
				if (tile167) saddr = 9'd189;
				if (tile168) saddr = 9'd190;
				if (tile169) saddr = 9'd193;
				if (tile170) saddr = 9'd194;
				if (tile171) saddr = 9'd195;
				if (tile172) saddr = 9'd196;
				if (tile173) saddr = 9'd197;
				if (tile174) saddr = 9'd198;
				if (tile175) saddr = 9'd199;
				if (tile176) saddr = 9'd200;
				if (tile177) saddr = 9'd201;
				if (tile178) saddr = 9'd202;
				if (tile179) saddr = 9'd203;
				if (tile180) saddr = 9'd204;
				if (tile181) saddr = 9'd205;
				if (tile182) saddr = 9'd206;
				if (tile183) saddr = 9'd209;
				if (tile184) saddr = 9'd210;
				if (tile185) saddr = 9'd211;
				if (tile186) saddr = 9'd212;
				if (tile187) saddr = 9'd213;
				if (tile188) saddr = 9'd214;
				if (tile189) saddr = 9'd215;
				if (tile190) saddr = 9'd216;
				if (tile191) saddr = 9'd217;
				if (tile192) saddr = 9'd218;
				if (tile193) saddr = 9'd219;
				if (tile194) saddr = 9'd220;
				if (tile195) saddr = 9'd221;
				if (tile196) saddr = 9'd222;
				if (tile197) saddr = 9'd225;
				if (tile198) saddr = 9'd226;
				if (tile199) saddr = 9'd227;
				if (tile200) saddr = 9'd228;
				if (tile201) saddr = 9'd229;
				if (tile202) saddr = 9'd230;
				if (tile203) saddr = 9'd231;
				if (tile204) saddr = 9'd232;
				if (tile205) saddr = 9'd233;
				if (tile206) saddr = 9'd234;
				if (tile207) saddr = 9'd235;
				if (tile208) saddr = 9'd236;
				if (tile209) saddr = 9'd237;
				if (tile210) saddr = 9'd238;
				if (tile211) saddr = 9'd241;
				if (tile212) saddr = 9'd242;
				if (tile213) saddr = 9'd243;
				if (tile214) saddr = 9'd244;
				if (tile215) saddr = 9'd245;
				if (tile216) saddr = 9'd246;
				if (tile217) saddr = 9'd247;
				if (tile218) saddr = 9'd248;
				if (tile219) saddr = 9'd249;
				if (tile220) saddr = 9'd250;
				if (tile221) saddr = 9'd251;
				if (tile222) saddr = 9'd252;
				if (tile223) saddr = 9'd253;
				if (tile224) saddr = 9'd254;
				if (tile225) saddr = 9'd257;
				if (tile226) saddr = 9'd258;
				if (tile227) saddr = 9'd259;
				if (tile228) saddr = 9'd260;
				if (tile229) saddr = 9'd261;
				if (tile230) saddr = 9'd262;
				if (tile231) saddr = 9'd263;
				if (tile232) saddr = 9'd264;
				if (tile233) saddr = 9'd265;
				if (tile234) saddr = 9'd266;
				if (tile235) saddr = 9'd267;
				if (tile236) saddr = 9'd268;
				if (tile237) saddr = 9'd269;
				if (tile238) saddr = 9'd270;
				if (tile239) saddr = 9'd273;
				if (tile240) saddr = 9'd274;
				if (tile241) saddr = 9'd275;
				if (tile242) saddr = 9'd276;
				if (tile243) saddr = 9'd277;
				if (tile244) saddr = 9'd278;
				if (tile245) saddr = 9'd279;
				if (tile246) saddr = 9'd280;
				if (tile247) saddr = 9'd281;
				if (tile248) saddr = 9'd282;
				if (tile249) saddr = 9'd283;
				if (tile250) saddr = 9'd284;
				if (tile251) saddr = 9'd285;
				if (tile252) saddr = 9'd286;
				if (tile253) saddr = 9'd289;
				if (tile254) saddr = 9'd290;
				if (tile255) saddr = 9'd291;
				if (tile256) saddr = 9'd292;
				if (tile257) saddr = 9'd293;
				if (tile258) saddr = 9'd294;
				if (tile259) saddr = 9'd295;
				if (tile260) saddr = 9'd296;
				if (tile261) saddr = 9'd297;
				if (tile262) saddr = 9'd298;
				if (tile263) saddr = 9'd299;
				if (tile264) saddr = 9'd300;
				if (tile265) saddr = 9'd301;
				if (tile266) saddr = 9'd302;
				if (tile267) saddr = 9'd305;
				if (tile268) saddr = 9'd306;
				if (tile269) saddr = 9'd307;
				if (tile270) saddr = 9'd308;
				if (tile271) saddr = 9'd309;
				if (tile272) saddr = 9'd310;
				if (tile273) saddr = 9'd311;
				if (tile274) saddr = 9'd312;
				if (tile275) saddr = 9'd313;
				if (tile276) saddr = 9'd314;
				if (tile277) saddr = 9'd315;
				if (tile278) saddr = 9'd316;
				if (tile279) saddr = 9'd317;
				if (tile280) saddr = 9'd318;
				if (tile281) saddr = 9'd321;
				if (tile282) saddr = 9'd322;
				if (tile283) saddr = 9'd323;
				if (tile284) saddr = 9'd324;
				if (tile285) saddr = 9'd325;
				if (tile286) saddr = 9'd326;
				if (tile287) saddr = 9'd327;
				if (tile288) saddr = 9'd328;
				if (tile289) saddr = 9'd329;
				if (tile290) saddr = 9'd330;
				if (tile291) saddr = 9'd331;
				if (tile292) saddr = 9'd332;
				if (tile293) saddr = 9'd333;
				if (tile294) saddr = 9'd334;
				if (tile295) saddr = 9'd337;
				if (tile296) saddr = 9'd338;
				if (tile297) saddr = 9'd339;
				if (tile298) saddr = 9'd340;
				if (tile299) saddr = 9'd341;
				if (tile300) saddr = 9'd342;
				if (tile301) saddr = 9'd343;
				if (tile302) saddr = 9'd344;
				if (tile303) saddr = 9'd345;
				if (tile304) saddr = 9'd346;
				if (tile305) saddr = 9'd347;
				if (tile306) saddr = 9'd348;
				if (tile307) saddr = 9'd349;
				if (tile308) saddr = 9'd350;
				
					
				if (CollisionBuf[saddr] == 3'b001)
					frame_pixel = 8'h35;
				else if (CollisionBuf[saddr] == 3'b010)
					frame_pixel = 8'h2B;
				else if (CollisionBuf[saddr] == 3'b011)
					frame_pixel = 8'hCF;
				else if (CollisionBuf[saddr] == 3'b100)
					frame_pixel = 8'h1F;
				else if (CollisionBuf[saddr] == 3'b101)
					frame_pixel = 8'hF8;
				else if (CollisionBuf[saddr] == 3'b110)
					frame_pixel = 8'hF0;
				else if (CollisionBuf[saddr] == 3'b111)
					frame_pixel = 8'hE0;
				else if (CollisionBuf[saddr] == 3'b000)
					frame_pixel = 8'h00;
			end
			else
			begin
				frame_pixel = 8'h00;
			end
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
	/*assign fisrt = first1;
	assign sec = sec1;
	assign third = third1;
	assign fourth = fourth1;*/
	
endmodule
