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
reg [3:0] strike;
assign strike_o = strike;
reg [7:0] index_x, index_y;
assign index_x_o = index_x;
assign index_y_o = index_y;
reg [7:0] Occupied_Width_values [0:12];
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


integer i;

// Dividing Input Clock by 4 (operations for placement happen every 4 cycles of the input clock)
always @ (posedge clk_i) begin
    clk_counter <= clk_counter + 1;
    if (clk_counter == 2'b11) begin
        clk_div_4 <= ~ clk_div_4;
        clk_counter <= 2'b00;
    end
end

/*
always @ (posedge clk_div_4 or posedge rst_i) begin
    // Reset Occupied Width Array
    if (rst_i) begin
        for (i = 0; i < 13; i = i+1) begin
		Occupied_Width_values[i] <= 8'd128;
        end
    end
    // On positive edge of Clock, Occupied width array is updated
    else begin
        for (i = 0; i < 13; i = i+1) begin
            Occupied_Width_values[i] <= Occupied_Width[i];
        end   
    end
end
*/

always @ (posedge clk_div_4 or posedge rst_i) begin
    // Reset Occupied Width Array
    if (rst_i) begin
        for (i = 0; i < 13; i = i+1) begin
		Occupied_Width_values[i] <= 8'd128;
        end
    end

    else begin
	    // Updating Strip Occupancy and determining placements
	    case (height_i)
	        4'd4:
	            begin
	                Strip_y_occupancy = Occupied_Width_values[1] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[3] - width_i;
	
	                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[1] = Strip_y_occupancy;
	                    Strip1_X = Strip1_X + width_i;
	                    index_x = Strip1_X;
	                    index_y = Strip1_Y;
	                end
	                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
	                    Occupied_Width_values[3] = Strip_y_plus_1_occupancy;
	                    Strip3_X = Strip3_X + width_i;
	                    index_x = Strip3_X;
	                    index_y = Strip3_Y;
	                end
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[1] = Strip_y_occupancy;
	                    Strip1_X = Strip1_X + width_i;
	                    index_x = Strip1_X;
	                    index_y = Strip1_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	
	        4'd5:
	            begin
	                Strip_y_occupancy = Occupied_Width_values[3] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[5] - width_i;
	                // Both strips are not filled
	                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[3] = Strip_y_occupancy;
	                    Strip3_X = Strip3_X + width_i;
	                    index_x = Strip3_X;
	                    index_y = Strip3_Y;
	                end
	                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
	                    Occupied_Width_values[5] = Strip_y_plus_1_occupancy;
	                    Strip5_X = Strip5_X + width_i;
	                    index_x = Strip5_X;
	                    index_y = Strip5_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[3] = Strip_y_occupancy;
	                    Strip3_X = Strip3_X + width_i;
	                    index_x = Strip3_X;
	                    index_y = Strip3_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd6:
	            begin
	                Strip_y_occupancy = Occupied_Width_values[5] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[7] - width_i;
	                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[5] = Strip_y_occupancy;
	                    Strip5_X = Strip5_X + width_i;
	                    index_x = Strip5_X;
	                    index_y = Strip5_Y;
	                end
	
	                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
	                    Occupied_Width_values[7] = Strip_y_plus_1_occupancy;
	                    Strip7_X = Strip7_X + width_i;
	                    index_x = Strip7_X;
	                    index_y = Strip7_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[5] = Strip_y_occupancy;
	                    Strip5_X = Strip5_X + width_i;
	                    index_x = Strip5_X;
	                    index_y = Strip5_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd7:
	            begin
	                Strip_y_occupancy = Occupied_Width_values[7] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[8] - width_i;
			Strip_y_plus_2_occupancy = Occupied_Width_values[9] - width_i;
	                // Both strips are not filled
	                if ((Strip_y_occupancy > Strip_y_plus_1_occupancy) && (Strip_y_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[7] = Strip_y_occupancy;
	                    Strip7_X = Strip7_X + width_i;
	                    index_x = Strip7_X;
	                    index_y = Strip7_Y;
	                end
			        else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[8] = Strip_y_plus_1_occupancy;
	                    Strip8_X = Strip8_X + width_i;
	                    index_x = Strip8_X;
	                    index_y = Strip8_Y;
			        end
			        else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
	                    Occupied_Width_values[9] = Strip_y_plus_2_occupancy;
	                    Strip9_X = Strip9_X + width_i;
	                    index_x = Strip9_X;
	                    index_y = Strip9_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[7] = Strip_y_occupancy;
	                    Strip7_X = Strip7_X + width_i;
	                    index_x = Strip7_X;
	                    index_y = Strip7_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd8:
	            begin
	                Strip_y_occupancy = Occupied_Width_values[6] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[8] - width_i;
			Strip_y_plus_2_occupancy = Occupied_Width_values[9] - width_i;
	                // Both strips are not filled
	                if ((Strip_y_occupancy > Strip_y_plus_1_occupancy) && (Strip_y_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[6] = Strip_y_occupancy;
	                    Strip6_X = Strip6_X + width_i;
	                    index_x = Strip6_X;
	                    index_y = Strip6_Y;
	                end
	                else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[8] = Strip_y_plus_1_occupancy;
	                    Strip8_X = Strip8_X + width_i;
	                    index_x = Strip8_X;
	                    index_y = Strip8_Y;
	                end
	                else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
	                    Occupied_Width_values[9] = Strip_y_plus_2_occupancy;
	                    Strip9_X = Strip9_X + width_i;
	                    index_x = Strip9_X;
	                    index_y = Strip9_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[6] = Strip_y_occupancy;
	                    Strip6_X = Strip6_X + width_i;
	                    index_x = Strip6_X;
	                    index_y = Strip6_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd9:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[4] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[6] - width_i;
	                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[4] = Strip_y_occupancy;
	                    Strip4_X = Strip4_X + width_i;
	                    index_x = Strip4_X;
	                    index_y = Strip4_Y;
	                end
	
	                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
	                    Occupied_Width_values[6] = Strip_y_plus_1_occupancy;
	                    Strip6_X = Strip6_X + width_i;
	                    index_x = Strip6_X;
	                    index_y = Strip6_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[4] = Strip_y_occupancy;
	                    Strip4_X = Strip4_X + width_i;
	                    index_x = Strip4_X;
	                    index_y = Strip4_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd10:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[2] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[4] - width_i;
	                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[2] = Strip_y_occupancy;
	                    Strip2_X = Strip2_X + width_i;
	                    index_x = Strip2_X;
	                    index_y = Strip2_Y;
	                end
	
	                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
	                    Occupied_Width_values[4] = Strip_y_plus_1_occupancy;
	                    Strip4_X = Strip4_X + width_i;
	                    index_x = Strip4_X;
	                    index_y = Strip4_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[2] = Strip_y_occupancy;
	                    Strip2_X = Strip2_X + width_i;
	                    index_x = Strip2_X;
	                    index_y = Strip2_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd11:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[0] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[2] - width_i;
	                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[0] = Strip_y_occupancy;
	                    Strip0_X = Strip0_X + width_i;
	                    index_x = Strip0_X;
	                    index_y = Strip0_Y;
	                end
	
	                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
	                    Occupied_Width_values[2] = Strip_y_plus_1_occupancy;
	                    Strip2_X = Strip2_X + width_i;
	                    index_x = Strip2_X;
	                    index_y = Strip2_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[0] = Strip_y_occupancy;
	                    Strip0_X = Strip0_X + width_i;
	                    index_x = Strip0_X;
	                    index_y = Strip0_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd12:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[0] - width_i;
			        if (Strip_y_occupancy > 0) begin
	                    Occupied_Width_values[0] = Strip_y_occupancy;
	                    Strip0_X = Strip0_X + width_i;
	                    index_x = Strip0_X;
	                    index_y = Strip0_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd13:
	            begin
	                Strip_y_occupancy = Occupied_Width_values[10] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[11] - width_i;
			        Strip_y_plus_2_occupancy = Occupied_Width_values[12] - width_i;
	                // Both strips are not filled
	                if ((Strip_y_occupancy > Strip_y_plus_1_occupancy) && (Strip_y_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
	                    Strip11_X = Strip11_X + width_i;
	                    index_x = Strip11_X;
	                    index_y = Strip11_Y;
	                end
	                else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
	                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
	                    Strip12_X = Strip12_X + width_i;
	                    index_x = Strip12_X;
	                    index_y = Strip12_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd14:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[10] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[11] - width_i;
			        Strip_y_plus_2_occupancy = Occupied_Width_values[12] - width_i;
	                // Both strips are not filled
	                if ((Strip_y_occupancy > Strip_y_plus_1_occupancy) && (Strip_y_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
	                     Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
	                    Strip11_X = Strip11_X + width_i;
	                    index_x = Strip11_X;
	                    index_y = Strip11_Y;
	                end
	                else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
	                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
	                    Strip12_X = Strip12_X + width_i;
	                    index_x = Strip12_X;
	                    index_y = Strip12_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd15:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[10] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[11] - width_i;
			        Strip_y_plus_2_occupancy = Occupied_Width_values[12] - width_i;
	                // Both strips are not filled
	                if ((Strip_y_occupancy > Strip_y_plus_1_occupancy) && (Strip_y_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = x_13;
	                    index_y = Strip10_Y;
	                end
	                else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
	                    Strip11_X = Strip11_X + width_i;
	                    index_x = Strip11_X;
	                    index_y = Strip11_Y;
	                end
	                else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
	                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
	                    Strip12_X = Strip12_X + width_i;
	                    index_x = Strip12_X;
	                    index_y = Strip12_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	        4'd16:
		        begin
	                Strip_y_occupancy = Occupied_Width_values[10] - width_i;
	                Strip_y_plus_1_occupancy = Occupied_Width_values[11] - width_i;
			        Strip_y_plus_2_occupancy = Occupied_Width_values[12] - width_i;
	                // Both strips are not filled
	                if ((Strip_y_occupancy > Strip_y_plus_1_occupancy) && (Strip_y_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
	                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
	                    Strip11_X = Strip11_X + width_i;
	                    index_x = Strip11_X;
	                    index_y = Strip11_Y;
	                end
	                else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
	                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
	                    Strip12_X = Strip12_X + width_i;
	                    index_x = Strip12_X;
	                    index_y = Strip12_Y;
	                end
	
	                // Strip y+1 and Strip y have equal occupancies. Strip y has priority
	                else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
	                    Occupied_Width_values[10] = Strip_y_occupancy;
	                    Strip10_X = Strip10_X + width_i;
	                    index_x = Strip10_X;
	                    index_y = Strip10_Y;
	                end
	                // Both Strips are filled
	                else begin
	                    strike = strike + 1;
	                    index_x = 128;
	                    index_y = 128;
	                end
	            end
	
	    endcase
    	end
    end
endmodule
