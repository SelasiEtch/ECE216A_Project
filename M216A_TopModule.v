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
reg clk_div_4 = 1'b0;
reg clk_div_2 = 1'b0;
reg [3:0] strike;
reg [7:0] index_x, index_y;
reg [7:0] Occupied_Width_values [12:0];


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

wire [4:0] height_int = 4'b0000;
reg [4:0] height_int2 = 4'b0000;
wire [4:0] width_int = 4'b0000;
reg [4:0] width_int2 = 4'b0000;


integer i;

reg [4:0] Strip_index;


// Dividing Input Clock by 4 (operations for placement happen every 4 cycles of the input clock)
/*
always @ (posedge clk_i) begin
    height_int <= height_i;
    width_int <= width_i;
    clk_counter <= clk_counter + 1;
    if (clk_counter == 2'b11) begin
        clk_div_4 <= ~ clk_div_4;
        clk_counter <= 2'b00;
    end
end
*/

always @(posedge clk_i) begin
	clk_div_2 = ~clk_div_2;
end

always @(posedge clk_div_2) begin
	clk_div_4 = ~clk_div_4;
end

always@(posedge clk_div_4) begin
	height_int2 <=  height_i;
	width_int2 <= width_i;
end


initial begin
    strike = 4'b0000;
end


    P1_Reg_5_bit Height_Reg(.DataIn(height_i), .DataOut(height_int), .rst(rst_i), .clk(clk_i));				
    P1_Reg_5_bit Width_Reg(.DataIn(width_i), .DataOut(width_int), .rst(rst_i), .clk(clk_i));				
    P1_Reg_4_bit Strike_Reg(.DataIn(strike), .DataOut(strike_o), .rst(rst_i), .clk(clk_i));			
    P1_Reg_8_bit Index_X_Reg(.DataIn(index_x), .DataOut(index_x_o), .rst(rst_i), .clk(clk_i));			
    P1_Reg_8_bit Index_Y_Reg(.DataIn(index_y), .DataOut(index_y_o), .rst(rst_i), .clk(clk_i));			
    P1_Reg_8_bit Strip1_Reg(.DataIn(Occupied_Width_values[0]), .DataOut(Occupied_Width[0]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip2_Reg(.DataIn(Occupied_Width_values[1]), .DataOut(Occupied_Width[1]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip3_Reg(.DataIn(Occupied_Width_values[2]), .DataOut(Occupied_Width[2]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip4_Reg(.DataIn(Occupied_Width_values[3]), .DataOut(Occupied_Width[3]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip5_Reg(.DataIn(Occupied_Width_values[4]), .DataOut(Occupied_Width[4]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip6_Reg(.DataIn(Occupied_Width_values[5]), .DataOut(Occupied_Width[5]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip7_Reg(.DataIn(Occupied_Width_values[6]), .DataOut(Occupied_Width[6]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip8_Reg(.DataIn(Occupied_Width_values[7]), .DataOut(Occupied_Width[7]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip9_Reg(.DataIn(Occupied_Width_values[8]), .DataOut(Occupied_Width[8]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip10_Reg(.DataIn(Occupied_Width_values[9]), .DataOut(Occupied_Width[9]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip11_Reg(.DataIn(Occupied_Width_values[10]), .DataOut(Occupied_Width[10]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip12_Reg(.DataIn(Occupied_Width_values[11]), .DataOut(Occupied_Width[11]), .rst(rst_i), .clk(clk_i));	
    P1_Reg_8_bit Strip13_Reg(.DataIn(Occupied_Width_values[12]), .DataOut(Occupied_Width[12]), .rst(rst_i), .clk(clk_i));	


always @ (posedge clk_div_4) begin
	    // Updating Strip Occupancy and determining placements
	if(rst_i) begin
  	    for (i = 0; i < 13; i = i+1) begin
                Occupied_Width_values[i] <= 0;
            end
        end
	else begin
	    case (height_int2)
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
	height_int2 = height_int;
	width_int2 = width_int;

    end

endmodule
