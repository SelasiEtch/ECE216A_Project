
`timescale 1ns / 100ps
//Updated

//Do NOT Modify This
module P1_Reg_8_bit (DataIn, DataOut, rst, clk);

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

module P1_Reg_5_bit (DataIn, DataOut, rst, clk);

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

module P1_Reg_4_bit (DataIn, DataOut, rst, clk);

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
module M216A_TopModule(
    clk_i,
    width_i,
    height_i,
    index_x_o,
    index_y_o,
    strike_o,
    Occupied_Width,
    rst_i);
  input clk_i;
  input [4:0]width_i;
  input [4:0]height_i;
  output [7:0]index_x_o, index_y_o;
  output [7:0]Occupied_Width[12:0];  // Connect it to a 13 element Register array
  output [3:0]strike_o;
  input rst_i;

wire [4:0] width_i, height_i;
wire clk_i, rst_i;

//Add your code below 
//Make sure to Register the outputs using the Register modules given above
reg [1:0] clk_counter;
reg clk_div_4;
reg [3:0] strike = 4'b0;
//assign strike_o = strike;
reg [7:0] index_x, index_y;
//assign index_x_o = index_x;
//assign index_y_o = index_y;
reg [7:0] Occupied_Width_values [12:0];
reg [7:0] Strip_y_occupancy = 0;
reg [7:0] Strip_y_plus_1_occupancy = 0;
reg [7:0] Strip_y_plus_2_occupancy = 0;


reg [7:0] Strip0_Y = 0;
reg [7:0] Strip1_Y = 12;
reg [7:0] Strip2_Y = 16;
reg [7:0] Strip3_Y = 27;
reg [7:0] Strip4_Y = 32;
reg [7:0] Strip5_Y = 42;
reg [7:0] Strip6_Y = 48;
reg [7:0] Strip7_Y = 57;
reg [7:0] Strip8_Y = 64;
reg [7:0] Strip9_Y = 72;
reg [7:0] Strip10_Y = 80;
reg [7:0] Strip11_Y = 96;
reg [7:0] Strip12_Y = 112;

reg [7:0] Strip0_X = 0;
reg [7:0] Strip1_X = 0;
reg [7:0] Strip2_X = 0;
reg [7:0] Strip3_X = 0;
reg [7:0] Strip4_X = 0;
reg [7:0] Strip5_X = 0;
reg [7:0] Strip6_X = 0;
reg [7:0] Strip7_X = 0;
reg [7:0] Strip8_X = 0;
reg [7:0] Strip9_X = 0;
reg [7:0] Strip10_X = 0;
reg [7:0] Strip11_X = 0;
reg [7:0] Strip12_X = 0;

reg [4:0] height_int, height_int2, width_int, width_int2;


integer i;

reg [4:0] Strip_index;


// Dividing Input Clock by 4 (operations for placement happen every 4 cycles of the input clock)
always @ (posedge clk_i) begin
    clk_counter <= clk_counter + 1;
    if (clk_counter == 2'b11) begin
        clk_div_4 <= ~ clk_div_4;
        clk_counter <= 2'b00;
    end
end

    P1_Reg_5_bit I_h_r(.DataIn(height_int), .DataOut(height_i), .rst(rst_i), .clk(clk_div_4));				// Input reg. for height_i.
    P1_Reg_5_bit I_w_r(.DataIn(width_int), .DataOut(width_i), .rst(rst_i), .clk(clk_div_4));				// Input reg. for width_i.
    P1_Reg_4_bit I_s_r(.DataIn(strike), .DataOut(strike_o), .rst(rst_i), .clk(clk_div_4));			// Output reg. for strike_o.
    P1_Reg_8_bit I_x_r(.DataIn(index_x), .DataOut(index_x_o), .rst(rst_i), .clk(clk_div_4));			// Output reg. for index_x_o.
    P1_Reg_8_bit I_y_r(.DataIn(index_y), .DataOut(index_y_o), .rst(rst_i), .clk(clk_div_4));			// Output reg. for index_y_o.
    P1_Reg_8_bit I_occWstr0_r(.DataIn(Occupied_Width_values[0]), .DataOut(Occupied_Width[0]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 0.
    P1_Reg_8_bit I_occWstr1_r(.DataIn(Occupied_Width_values[1]), .DataOut(Occupied_Width[1]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 1.
    P1_Reg_8_bit I_occWstr2_r(.DataIn(Occupied_Width_values[2]), .DataOut(Occupied_Width[2]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 2.
    P1_Reg_8_bit I_occWstr3_r(.DataIn(Occupied_Width_values[3]), .DataOut(Occupied_Width[3]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 3.
    P1_Reg_8_bit I_occWstr4_r(.DataIn(Occupied_Width_values[4]), .DataOut(Occupied_Width[4]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 4.
    P1_Reg_8_bit I_occWstr5_r(.DataIn(Occupied_Width_values[5]), .DataOut(Occupied_Width[5]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 5.
    P1_Reg_8_bit I_occWstr6_r(.DataIn(Occupied_Width_values[6]), .DataOut(Occupied_Width[6]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 6.
    P1_Reg_8_bit I_occWstr7_r(.DataIn(Occupied_Width_values[7]), .DataOut(Occupied_Width[7]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 7.
    P1_Reg_8_bit I_occWstr8_r(.DataIn(Occupied_Width_values[8]), .DataOut(Occupied_Width[8]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 8.
    P1_Reg_8_bit I_occWstr9_r(.DataIn(Occupied_Width_values[9]), .DataOut(Occupied_Width[9]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 9.
    P1_Reg_8_bit I_occWstr10_r(.DataIn(Occupied_Width_values[10]), .DataOut(Occupied_Width[10]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 10.
    P1_Reg_8_bit I_occWstr11_r(.DataIn(Occupied_Width_values[11]), .DataOut(Occupied_Width[11]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 11.
    P1_Reg_8_bit I_occWstr12_r(.DataIn(Occupied_Width_values[12]), .DataOut(Occupied_Width[12]), .rst(rst_i), .clk(clk_div_4));	// Output reg. for occupied width of strip 12.

initial begin
strike = 4'b0;
end

always @ (posedge clk_div_4) begin
	    // Updating Strip Occupancy and determining placements
	    case (height_int)
	        4'd4:
            	    begin
			if(Occupied_Width_values[1] <= Occupied_Width_values[3]) begin
			Strip_index = 1;
			index_y = Strip1_Y;
			end

			else begin
			Strip_index = 3;
			index_y = Strip3_Y;
	            	end
		    end
	        4'd5:
            	    begin
			if(Occupied_Width_values[3] <= Occupied_Width_values[5]) begin
			Strip_index = 3;
			index_y = Strip3_Y;
			end

			else begin
			Strip_index = 5;
			index_y = Strip5_Y;
	            	end
		    end
	        4'd6:
            	    begin
			if(Occupied_Width_values[5] <= Occupied_Width_values[7]) begin
			Strip_index = 5;
			index_y = Strip5_Y;
			end

			else begin
			Strip_index = 7;
			index_y = Strip7_Y;
	            	end
		    end
	        4'd7:
	            begin
			if(Occupied_Width_values[7] <= Occupied_Width_values[8] && Occupied_Width_values[7] <= Occupied_Width_values[9]) begin
			Strip_index = 7;
			index_y = Strip7_Y;
			end

			else if(Occupied_Width_values[8] <= Occupied_Width_values[9]) begin
			Strip_index = 8;
			index_y = Strip8_Y;
			end
			
			else begin
			Strip_index = 9;
			index_y = Strip9_Y;
	            	end
		    end
	        4'd8:
	            begin
			if(Occupied_Width_values[8] <= Occupied_Width_values[9] && Occupied_Width_values[8] <= Occupied_Width_values[6]) begin
			Strip_index = 8;
			index_y = Strip8_Y;
			end

			else if(Occupied_Width_values[9] <= Occupied_Width_values[6]) begin
			Strip_index = 9;
			index_y = Strip9_Y;
			end
			
			else begin
			Strip_index = 6;
			index_y = Strip6_Y;
	            	end
		    end
	        4'd9:
            	    begin
			if(Occupied_Width_values[6] <= Occupied_Width_values[4]) begin
			Strip_index = 6;
			index_y = Strip6_Y;
			end

			else begin
			Strip_index = 4;
			index_y = Strip4_Y;
	            	end
		    end
	        4'd10:
            	    begin
			if(Occupied_Width_values[4] <= Occupied_Width_values[2]) begin
			Strip_index = 4;
			index_y = Strip4_Y;
			end

			else begin
			Strip_index = 2;
			index_y = Strip2_Y;
	            	end
		    end
	        4'd11:
            	    begin
			if(Occupied_Width_values[2] <= Occupied_Width_values[0]) begin
			Strip_index = 2;
			index_y = Strip2_Y;
			end

			else begin
			Strip_index = 0;
			index_y = Strip0_Y;
	            	end
		    end
	        4'd12:
            	    begin
			Strip_index = 0;
			index_y = Strip0_Y;
		    end
	        4'd13:
		    begin
                	if (Occupied_Width_values[10] <= Occupied_Width_values[11] && Occupied_Width_values[10] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 10;
                    	    index_y = Strip10_Y;
                	end
                	else if (Occupied_Width_values[11] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 11;
                    	    index_y = Strip11_Y;
                	end
                	else begin
                    	    Strip_index = 12;
                    	    index_y = Strip12_Y;
                	end
        	    end
	        4'd14:
		    begin
                	if (Occupied_Width_values[10] <= Occupied_Width_values[11] && Occupied_Width_values[10] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 10;
                    	    index_y = Strip10_Y;
                	end
                	else if (Occupied_Width_values[11] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 11;
                    	    index_y = Strip11_Y;
                	end
                	else begin
                    	    Strip_index = 12;
                    	    index_y = Strip12_Y;
                	end
        	    end
	        4'd15:
		    begin
                	if (Occupied_Width_values[10] <= Occupied_Width_values[11] && Occupied_Width_values[10] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 10;
                    	    index_y = Strip10_Y;
                	end
                	else if (Occupied_Width_values[11] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 11;
                    	    index_y = Strip11_Y;
                	end
                	else begin
                    	    Strip_index = 12;
                    	    index_y = Strip12_Y;
                	end
        	    end
	        4'd16:
		    begin
                	if (Occupied_Width_values[10] <= Occupied_Width_values[11] && Occupied_Width_values[10] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 10;
                    	    index_y = Strip10_Y;
                	end
                	else if (Occupied_Width_values[11] <= Occupied_Width_values[12]) begin
                    	    Strip_index = 11;
                    	    index_y = Strip11_Y;
                	end
                	else begin
                    	    Strip_index = 12;
                    	    index_y = Strip12_Y;
                	end
        	    end
	    endcase

      	    if(Occupied_Width_values[Strip_index] + width_i > 128) begin
            	strike = strike +1;
            	index_x = 128;
            	index_y = 128;
            end
      	    else begin
                index_x = Occupied_Width_values[Strip_index]; 
                Occupied_Width_values[Strip_index] = Occupied_Width_values[Strip_index]+width_i;
            end
    end

endmodule
