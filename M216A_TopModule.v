
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
reg [7:0] index_x = 7'b0000000;
reg [7:0] index_y = 7'b0000000;
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

reg [4:0] height_in = 4'b0000;
reg [4:0] width_in = 4'b0000;
reg [4:0] height_in_0 = 4'b0000;
reg [4:0] width_in_0 = 4'b0000;


integer i;

reg [4:0] Strip_index;
reg [7:0] Strip_y_temp; 

always @(posedge clk_i) begin
	height_in_0 <=  height_i;
	width_in_0 <= width_i;
	clk_div_2 = ~clk_div_2;
end

always @(posedge clk_div_2) begin
	clk_div_4 = ~clk_div_4;
end



initial begin
    strike = 4'b0000;
    clk_div_2 = 1'b0;
    clk_div_4 = 1'b0;
end


    P1_Reg_5_bit Height_Reg(.DataIn(height_i), .DataOut(height_int2), .rst(rst_i), .clk(clk_i));				
    P1_Reg_5_bit Width_Reg(.DataIn(width_i), .DataOut(width_int2), .rst(rst_i), .clk(clk_i));				
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
	if(rst_i)begin
	    for (i = 0; i < 13; i = i+1) begin
                Occupied_Width_values[i] <= 8'b00000000;
        end
	end

	else begin

case (height_in)
    8: begin
        if (Occupied_Width_values[8] <= Occupied_Width_values[9] && Occupied_Width_values[8] <= Occupied_Width_values[6]) begin
            Strip_index = 8;
            Strip_y_temp = Strip8_Y;
        end else if (Occupied_Width_values[9] <= Occupied_Width_values[6]) begin
            Strip_index = 9;
            Strip_y_temp = Strip9_Y;
        end else begin
            Strip_index = 6;
            Strip_y_temp = Strip6_Y;
        end
    end

    7: begin
        if (Occupied_Width_values[7] <= Occupied_Width_values[8] && Occupied_Width_values[7] <= Occupied_Width_values[9]) begin
            Strip_index = 7;
            Strip_y_temp = Strip7_Y;
        end else if (Occupied_Width_values[8] <= Occupied_Width_values[9]) begin
            Strip_index = 8;
            Strip_y_temp = Strip8_Y;
        end else begin
            Strip_index = 9;
            Strip_y_temp = Strip9_Y;
        end
    end

    6: begin
        if (Occupied_Width_values[5] <= Occupied_Width_values[7]) begin
            Strip_index = 5;
            Strip_y_temp = Strip5_Y;
        end else begin
            Strip_index = 7;
            Strip_y_temp = Strip7_Y;
        end
    end

    5: begin
        if (Occupied_Width_values[3] <= Occupied_Width_values[5]) begin
            Strip_index = 3;
            Strip_y_temp = Strip3_Y;
        end else begin
            Strip_index = 5;
            Strip_y_temp = Strip5_Y;
        end
    end

    4: begin
        if (Occupied_Width_values[1] <= Occupied_Width_values[3]) begin
            Strip_index = 1;
            Strip_y_temp = Strip1_Y;
        end else begin
            Strip_index = 3;
            Strip_y_temp = Strip3_Y;
        end
    end

    12: begin
        Strip_index = 0;
        Strip_y_temp = Strip12_Y;
    end

    11: begin
        if (Occupied_Width_values[2] <= Occupied_Width_values[0]) begin
            Strip_index = 2;
            Strip_y_temp = Strip2_Y;
        end else begin
            Strip_index = 0;
            Strip_y_temp = Strip0_Y;
        end
    end

    10: begin
        if (Occupied_Width_values[4] <= Occupied_Width_values[2]) begin
            Strip_index = 4;
            Strip_y_temp = Strip4_Y;
        end else begin
            Strip_index = 2;
            Strip_y_temp = Strip2_Y;
        end
    end

    9: begin
        if (Occupied_Width_values[6] <= Occupied_Width_values[4]) begin
            Strip_index = 6;
            Strip_y_temp = Strip6_Y;
        end else begin
            Strip_index = 4;
            Strip_y_temp = Strip4_Y;
        end
    end

    default: begin
                if (Occupied_Width_values[10] <= Occupied_Width_values[11] && Occupied_Width_values[10] <= Occupied_Width_values[12]) begin
                    Strip_index = 10;
                    Strip_y_temp = Strip10_Y;
                    //We now know that ID 10 is the emptiest one
                end
                else if (Occupied_Width_values[11] <= Occupied_Width_values[12]) begin
                    Strip_index = 11;
                    Strip_y_temp = Strip11_Y;
                    //We now know that ID 11 is the emptiest one
                end
                else begin
                    Strip_index = 12;
                    Strip_y_temp = Strip12_Y;
                    //We now know that ID 12 is the emptiest one
                end
    end
endcase
      	    if(Occupied_Width_values[Strip_index] + width_in > 128) begin
            	strike = strike +1;
            	index_x = 128;
            	index_y = 128;
            end
      	    else begin
                index_x = Occupied_Width_values[Strip_index]; 
		index_y = Strip_y_temp;
                Occupied_Width_values[Strip_index] = Occupied_Width_values[Strip_index]+width_in;
            end
	end
	height_in = height_in_0;
	width_in = width_in_0;

    end
endmodule
