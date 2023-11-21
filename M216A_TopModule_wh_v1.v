`timescale 1ns / 100ps

// START BOILERPLATE - DO NOT MODIFY
module P1_Reg_8_bit (DataIn, DataOut, rst, clk);	// 8 bit register.

    input [7: 0] DataIn;
    output [7: 0] DataOut;
    input rst;
    input clk;
    reg [7:0] DataReg;
    
    always @(posedge clk)
        if(rst)
            DataReg  <= 8'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg ;          
endmodule

module P1_Reg_5_bit (DataIn, DataOut, rst, clk);	// 5 bit register.

    input [4: 0] DataIn;
    output [4: 0] DataOut;
    input rst;
    input clk;
    reg [4:0] DataReg;
    
    always @(posedge clk)
        if(rst)
            DataReg  <= 5'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg ;          
endmodule

module P1_Reg_4_bit (DataIn, DataOut, rst, clk);	// 4 bit register.

    input [3: 0] DataIn;
    output [3: 0] DataOut;
    input rst;
    input clk;
    reg [3:0] DataReg;
    
    always @(posedge clk)
        if(rst)
            DataReg  <= 4'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg ;          
endmodule

//Do NOT Modify This
module M216A_TopModule_wh_v1(
    clk_i,
    width_i,
    height_i,
    index_x_o,
    index_y_o,
    strike_o,
    Occupied_Width,
    rst_i);

  input rst_i;
  input clk_i;
  input [4:0] width_i;
  input [4:0] height_i;
  output [7:0] index_x_o, index_y_o;
  output [7:0] Occupied_Width [12:0];  // Connect it to a 13 element Register array
  output [3:0] strike_o;


wire [4:0] width_i, height_i;
wire clk_i, rst_i;

// Add your code below. 
// Make sure to Register the outputs using the Register modules given above.
// END BOILERPLATE - DO MODIFY


// PARAMETERS
parameter strip0_yCoor = 8'd0;	// Y-coordinate for 'floor' of all 13 strips.
parameter strip1_yCoor = 8'd12;
parameter strip2_yCoor = 8'd16;
parameter strip3_yCoor = 8'd27;
parameter strip4_yCoor = 8'd32;
parameter strip5_yCoor = 8'd42;
parameter strip6_yCoor = 8'd48;
parameter strip7_yCoor = 8'd57;
parameter strip8_yCoor = 8'd64;
parameter strip9_yCoor = 8'd72;
parameter strip10_yCoor = 8'd80;
parameter strip11_yCoor = 8'd96;
parameter strip12_yCoor = 8'd112;

parameter minHeight = 5'd4, maxHeight = 5'd16, minWidth = 5'd4, maxWidth = 5'd16;	// Input program size limits.
parameter arryDim = 8'd128;	// Compute array X and Y dimension.

parameter S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3;	// "FSM" states.
parameter PH4 = 8'd4, PH5 = 8'd5, PH6 = 8'd6, PH7 = 8'd7, PH8 = 8'd8, PH9 = 8'd9, PH10 = 8'd10, PH11 = 8'd11, PH12 = 8'd12;	// Program heights for case statements. Heights 13, 14, 15 and 16 use default case statement.


// VARIABLE DECLARATIONS
reg tempPlace1_EN, tempPlace2_EN, tempPlace3_EN;			// When enabled, this is a viable placement option for the first incoming program.
reg [7:0] tempPlace_x, tempPlace_y;					// Locations of temporary placement options for first incoming program.
wire [4:0] progHeight, progWidth;					// Internal program width and height.
reg [4:0] progHeightold, progWidthold;
reg [3:0] currStrike, currStrike_up;					// Internal strike counter, update to output reg.
reg [7:0] currIndX, currIndY, currIndX_up, currIndY_up;			// Internal current program index, update to output reg.
reg [7:0] currOccW [12:0], currOccW_up [12:0];				// Internal current occupied width of a strip, update to output reg.
reg [1:0] state, next_state;
reg firstFlag, strikeFlag;
integer i;

// SUB-MODULE INSTANTIATION
P1_Reg_5_bit I_h_r(.DataIn(height_i), .DataOut(progHeight), .rst(rst_i), .clk(clk_i));				// Input reg. for height_i.
P1_Reg_5_bit I_w_r(.DataIn(width_i), .DataOut(progWidth), .rst(rst_i), .clk(clk_i));				// Input reg. for width_i.
P1_Reg_4_bit I_s_r(.DataIn(currStrike_up), .DataOut(strike_o), .rst(rst_i), .clk(clk_i));			// Output reg. for strike_o.
P1_Reg_8_bit I_x_r(.DataIn(currIndX_up), .DataOut(index_x_o), .rst(rst_i), .clk(clk_i));			// Output reg. for index_x_o.
P1_Reg_8_bit I_y_r(.DataIn(currIndY_up), .DataOut(index_y_o), .rst(rst_i), .clk(clk_i));			// Output reg. for index_y_o.
P1_Reg_8_bit I_occWstr0_r(.DataIn(currOccW_up[0]), .DataOut(Occupied_Width[0]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 0.
P1_Reg_8_bit I_occWstr1_r(.DataIn(currOccW_up[1]), .DataOut(Occupied_Width[1]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 1.
P1_Reg_8_bit I_occWstr2_r(.DataIn(currOccW_up[2]), .DataOut(Occupied_Width[2]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 2.
P1_Reg_8_bit I_occWstr3_r(.DataIn(currOccW_up[3]), .DataOut(Occupied_Width[3]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 3.
P1_Reg_8_bit I_occWstr4_r(.DataIn(currOccW_up[4]), .DataOut(Occupied_Width[4]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 4.
P1_Reg_8_bit I_occWstr5_r(.DataIn(currOccW_up[5]), .DataOut(Occupied_Width[5]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 5.
P1_Reg_8_bit I_occWstr6_r(.DataIn(currOccW_up[6]), .DataOut(Occupied_Width[6]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 6.
P1_Reg_8_bit I_occWstr7_r(.DataIn(currOccW_up[7]), .DataOut(Occupied_Width[7]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 7.
P1_Reg_8_bit I_occWstr8_r(.DataIn(currOccW_up[8]), .DataOut(Occupied_Width[8]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 8.
P1_Reg_8_bit I_occWstr9_r(.DataIn(currOccW_up[9]), .DataOut(Occupied_Width[9]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 9.
P1_Reg_8_bit I_occWstr10_r(.DataIn(currOccW_up[10]), .DataOut(Occupied_Width[10]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 10.
P1_Reg_8_bit I_occWstr11_r(.DataIn(currOccW_up[11]), .DataOut(Occupied_Width[11]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 11.
P1_Reg_8_bit I_occWstr12_r(.DataIn(currOccW_up[12]), .DataOut(Occupied_Width[12]), .rst(rst_i), .clk(clk_i));	// Output reg. for occupied width of strip 12.



// IF RESET IS HIGH, SET ALL VALUES TO ZERO. MEMORY STATE ELEMENTS.
always@(posedge clk_i)
	begin
	if(rst_i)
		begin
		for(i = 0; i <= 12; i = i+1)
			begin
			currOccW[i] <= 8'b0;
			end
			currStrike <= 4'b0;
			currIndX <= 8'b0;
			currIndY <= 8'b0;
			state <= S1;
			firstFlag <= 1'd1;
			strikeFlag <= 1'd0;
			tempPlace1_EN <= 1'd0;
			tempPlace2_EN <= 1'd0;
			tempPlace3_EN <= 1'd0;
			tempPlace_x <= 1'd0;
			tempPlace_y <= 1'd0;
			progHeightold <= 1'd0;
			progWidthold <= 1'd0;
		end
	else
		state <= next_state;
	end


// NEXT STATE LOGIC.
// S0: Get temporary placement location for last incoming program.
// S1: Check if current input is valid. Start here after reset 1->0.
// S2: Update internal variables for strike, index_x, etc.
// S3: Update output register inputs. Unless reset has just been lifted (need to wait 8 clk cyles).
always@(*)
	begin
	case(state)
		S0:	begin	// Get temporary placement location for current program before dealing with next incoming program.
			if(firstFlag) firstFlag <= 1'd0;
			case(progHeight)

				PH4:	begin
			 		if((currOccW[1] <= currOccW[3]) & ((currOccW[1] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[1];
						tempPlace_y = strip1_yCoor;
						end
					else if((currOccW[3] + progWidth) <= arryDim)					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[3];
						tempPlace_y = strip3_yCoor;
						end
					else if(((currOccW[1] + progWidth) > arryDim) & ((currOccW[3] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.	TRYING TO AVOID ELSE STATEMENT TO GATE CLOCK IN SYNTHESIS. USE A 'badFitFlag' INSTEAD OF DOING ALL THESE EXTRA COMPARISIONS?
						begin
						strikeFlag = 4'd1;
						end
					end

				PH5:	begin
			 		if((currOccW[3] <= currOccW[5]) & ((currOccW[3] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[3];
						tempPlace_y = strip3_yCoor;
						end
					else if((currOccW[5] + progWidth) <= arryDim)					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[5];
						tempPlace_y = strip5_yCoor;
						end
					else if(((currOccW[3] + progWidth) > arryDim) & ((currOccW[5] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.
						begin
						strikeFlag = 4'd1;
						end
					end

				PH6:	begin
			 		if((currOccW[5] <= currOccW[7]) & ((currOccW[5] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[5];
						tempPlace_y = strip5_yCoor;
						end
					else if((currOccW[7] + progWidth) <= arryDim)					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[7];
						tempPlace_y = strip7_yCoor;
						end
					else if(((currOccW[5] + progWidth) > arryDim) & ((currOccW[7] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.
						begin
						strikeFlag = 4'd1;
						end
					end

				PH7:	begin
			 		if((currOccW[7] <= currOccW[8]) & (currOccW[7] <= currOccW[9]) & ((currOccW[7] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[7];
						tempPlace_y = strip7_yCoor;
						end
					else if((currOccW[8] <= currOccW[9]) & ((currOccW[8] + progWidth) <= arryDim))					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[8];
						tempPlace_y = strip8_yCoor;
						end
					else if((currOccW[9] + progWidth) <= arryDim)					// ELSE IF fits in other strip height y+1, put there.
						begin
						tempPlace3_EN = 1'd1;
						tempPlace_x = currOccW[9];
						tempPlace_y = strip9_yCoor;
						end
					else if(((currOccW[7] + progWidth) > arryDim) & ((currOccW[8] + progWidth) > arryDim) & ((currOccW[9] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.
						begin
						strikeFlag = 4'd1;
						end
					end

				PH8:	begin
			 		if((currOccW[8] <= currOccW[9]) & (currOccW[8] <= currOccW[6]) & ((currOccW[8] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[8];
						tempPlace_y = strip8_yCoor;
						end
					else if((currOccW[9] <= currOccW[6]) & ((currOccW[9] + progWidth) <= arryDim))					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[9];
						tempPlace_y = strip9_yCoor;
						end
					else if((currOccW[6] + progWidth) <= arryDim)					// ELSE IF fits in other strip height y+1, put there.
						begin
						tempPlace3_EN = 1'd1;
						tempPlace_x = currOccW[6];
						tempPlace_y = strip6_yCoor;
						end
					else if(((currOccW[8] + progWidth) > arryDim) & ((currOccW[9] + progWidth) > arryDim) & ((currOccW[6] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.
						begin
						strikeFlag = 4'd1;
						end
					end

				PH9:	begin
			 		if((currOccW[6] <= currOccW[4]) & ((currOccW[6] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[6];
						tempPlace_y = strip6_yCoor;
						end
					else if((currOccW[4] + progWidth) <= arryDim)					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[4];
						tempPlace_y = strip4_yCoor;
						end
					else if(((currOccW[6] + progWidth) > arryDim) & ((currOccW[4] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.	
						begin
						strikeFlag = 4'd1;
						end
					end

				PH10:	begin
			 		if((currOccW[4] <= currOccW[2]) & ((currOccW[4] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[4];
						tempPlace_y = strip4_yCoor;
						end
					else if((currOccW[2] + progWidth) <= arryDim)					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[2];
						tempPlace_y = strip2_yCoor;
						end
					else if(((currOccW[4] + progWidth) > arryDim) & ((currOccW[2] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.	
						begin
						strikeFlag = 4'd1;
						end
					end

				PH11:	begin
			 		if((currOccW[2] <= currOccW[0]) & ((currOccW[2] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[2];
						tempPlace_y = strip2_yCoor;
						end
					else if((currOccW[0] + progWidth) <= arryDim)					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[0];
						tempPlace_y = strip0_yCoor;
						end
					else if(((currOccW[2] + progWidth) > arryDim) & ((currOccW[0] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.	
						begin
						strikeFlag = 4'd1;
						end
					end

				PH12:	begin
					if((currOccW[0] + progWidth) <= arryDim)					// Only one spot to check for program height of 12.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[0];
						tempPlace_y = strip0_yCoor;
						end
					else if((currOccW[0] + progWidth) > arryDim)	// If current program doesn't fit in strip, strike out.	
						begin
						strikeFlag = 4'd1;
						end
					end

			default:	begin
			 		if((currOccW[10] <= currOccW[11]) & (currOccW[10] <= currOccW[12]) & ((currOccW[10] + progWidth) <= arryDim))	// IF strip with height y and strip with height y+1 have same occupied width, use strip with exact height for better utilization as preferred placement location.
						begin
						tempPlace1_EN = 1'd1;
						tempPlace_x = currOccW[10];
						tempPlace_y = strip10_yCoor;
						end
					else if((currOccW[11] <= currOccW[12]) & ((currOccW[11] + progWidth) <= arryDim))					// ELSE IF fits in strip height y+1, put here.
						begin
						tempPlace2_EN = 1'd1;
						tempPlace_x = currOccW[11];
						tempPlace_y = strip11_yCoor;
						end
					else if((currOccW[12] + progWidth) <= arryDim)					// ELSE IF fits in other strip height y+1, put there.
						begin
						tempPlace3_EN = 1'd1;
						tempPlace_x = currOccW[12];
						tempPlace_y = strip12_yCoor;
						end
					else if(((currOccW[10] + progWidth) > arryDim) & ((currOccW[11] + progWidth) > arryDim) & ((currOccW[12] + progWidth) > arryDim))	// If current program doesn't fit in either strip, strike out.
						begin
						strikeFlag = 4'd1;
						end
					end

			endcase
			next_state = S1;
			end
	


		S1:	begin	// Check that current program input is valid.
			if((progHeight >= minHeight) & (progHeight <= maxHeight) & (progWidth >= minWidth) & (progWidth <= maxWidth))
				next_state = S2;
			else
				next_state = S1;
			end


		S2:	begin
			if(!firstFlag & !strikeFlag)	// Place the program internally.
				begin
				case(progHeightold)
					PH4:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[1] = currOccW[1] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[3] = currOccW[3] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						end

					PH5:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[3] = currOccW[3] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[5] = currOccW[5] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						end

					PH6:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[5] = currOccW[5] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[7] = currOccW[7] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						end

					PH7:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[7] = currOccW[7] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[8] = currOccW[8] + progWidthold;
							end
						else if(tempPlace3_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[9] = currOccW[9] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						tempPlace3_EN = 1'd0;
						end

					PH8:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[8] = currOccW[8] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[9] = currOccW[9] + progWidthold;
							end
						else if(tempPlace3_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[6] = currOccW[6] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						tempPlace3_EN = 1'd0;
						end

					PH9:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[6] = currOccW[6] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[4] = currOccW[4] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						end

					PH10:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[4] = currOccW[4] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[2] = currOccW[2] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						end

					PH11:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[2] = currOccW[2] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[0] = currOccW[0] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						end

					PH12:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[0] = currOccW[0] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						end

				default:	begin
						if(tempPlace1_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[10] = currOccW[10] + progWidthold;
							end
						else if(tempPlace2_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[11] = currOccW[11] + progWidthold;
							end
						else if(tempPlace3_EN)
							begin
							currIndX = tempPlace_x;
							currIndY = tempPlace_y;
							currOccW[12] = currOccW[12] + progWidthold;
							end
						tempPlace1_EN = 1'd0;
						tempPlace2_EN = 1'd0;
						tempPlace3_EN = 1'd0;
						end

				endcase				
				end

			else if(strikeFlag)
				begin
				currStrike <= currStrike + 1'd1;
				strikeFlag <= 1'd0;
				currIndX <= arryDim;
				currIndY <= arryDim;
				end

			next_state = S3;
			end


		S3:	begin
			progWidthold <= progWidth;
			progHeightold <= progHeight;
			if(!firstFlag)	// Skip updating output registers if first time to S3.
				begin
				currStrike_up <= currStrike;
				currIndX_up <= currIndX;
				currIndY_up <= currIndY;
				for(i = 0; i <= 12; i = i+1)
					begin
					currOccW_up[i] <= currOccW[i];
					end
				end
			next_state = S0;
			end
	endcase
	end
endmodule
