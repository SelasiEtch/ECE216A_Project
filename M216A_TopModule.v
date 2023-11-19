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

reg [3:0] strike;
assign strike_o = strike;
reg [7:0] index_x, index_y;
assign index_x_o = index_x;
assign index_y_o = index_y;
reg [7:0] Occupied_Width_values [0:12];
reg [7:0] Strip_y_occupancy = 0;
reg [7:0] Strip_y_plus_1_occupancy = 0;
reg [7:0] Strip_y_plus_2_occupancy = 0;

reg [7:0] x_4=0;
reg [7:0] y_4=12;
reg [7:0] x_5=0;
reg [7:0] y_5=27;
reg [7:0] x_6=0;
reg [7:0] y_6=42;
reg [7:0] x_7=0;
reg [7:0] y_7=57;
reg [7:0] x_8=0;
reg [7:0] y_8=72;
reg [7:0] x_9=0;
reg [7:0] y_9=87;
reg [7:0] x_10=0;
reg [7:0] y_10=32;
reg [7:0] x_11=0;
reg [7:0] y_11=16;
reg [7:0] x_12=0;
reg [7:0] y_12=0;
reg [7:0] x_13=0;
reg [7:0] y_13=0; //
reg [7:0] x_14=0;
reg [7:0] y_14=0; //
reg [7:0] x_15=0;
reg [7:0] y_15=0; //
reg [7:0] x_16=0;
reg [7:0] y_16=0; //

integer i;
always @ (posedge clk_i or posedge rst_i) begin
    // Reset Occupied Width Array
    if (rst_i) begin
        for (i = 0; i < 13; i = i+1) begin
            Occupied_Width_values[i] <= 8'b00000000;
        end
    end
    // On positive edge of Clock, Occupied width array is updated
    else begin
        for (i = 0; i < 13; i = i+1) begin
            Occupied_Width_values[i] <= Occupied_Width[i];
        end   
    end
end

always @* begin   
    // Updating Strip Occupancy and determining placements
    case (height_i)
        4'd4:
            begin
                Strip_y_occupancy = Occupied_Width_values[1] - width_i;
                Strip_y_plus_1_occupancy = Occupied_Width_values[3] - width_i;

                if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
                    Occupied_Width_values[1] = Strip_y_occupancy;
		    x_4 = x_4 + width_i;
		    index_x = x_4;
		    index_y = y_4;
                end
                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
                    Occupied_Width_values[3] = Strip_y_plus_1_occupancy;
		    x_5 = x_5 + width_i;
		    index_x = x_5;
		    index_y = y_5;
                end
		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[1] = Strip_y_occupancy;
		    x_4 = x_4 + width_i;
		    index_x = x_4;
		    index_y = y_4;
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
		    x_5 = x_5 + width_i;
		    index_x = x_5;
		    index_y = y_5;
                end
                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
                    Occupied_Width_values[5] = Strip_y_plus_1_occupancy;
		    x_6 = x_6 + width_i;
		    index_x = x_6;
		    index_y = y_6;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[3] = Strip_y_occupancy;
		    x_5 = x_5 + width_i;
		    index_x = x_6;
		    index_y = y_6;
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
		    x_6 = x_6 + width_i;
		    index_x = x_6;
		    index_y = y_6;
                end

                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
                    Occupied_Width_values[7] = Strip_y_plus_1_occupancy;
		    x_7 = x_7 + width_i;
		    index_x = x_7;
		    index_y = y_7;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[5] = Strip_y_occupancy;
		    x_6 = x_6 + width_i;
		    index_x = x_6;
		    index_y = y_6;
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
		    x_7 = x_7 + width_i;
		    index_x = x_7;
		    index_y = y_7;
                end
		else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
                    Occupied_Width_values[8] = Strip_y_plus_1_occupancy;
		    x_8 = x_8 + width_i;
		    index_x = x_8;
		    index_y = y_8;
		end
		else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
                    Occupied_Width_values[9] = Strip_y_plus_2_occupancy;
		    x_9 = x_9 + width_i;
		    index_x = x_9;
		    index_y = y_9;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[7] = Strip_y_occupancy;
		    x_7 = x_7 + width_i;
		    index_x = x_7;
		    index_y = y_7;
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
		    x_8 = x_8 + width_i;
		    index_x = x_8;
		    index_y = y_8;
                end
		else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
                    Occupied_Width_values[8] = Strip_y_plus_1_occupancy;
		    x_9 = x_9 + width_i;
		    index_x = x_9;
		    index_y = y_9;
		end
		else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
                    Occupied_Width_values[9] = Strip_y_plus_2_occupancy;
		    x_10 = x_10 + width_i;
		    index_x = x_10;
		    index_y = y_10;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[6] = Strip_y_occupancy;
		    x_8 = x_8 + width_i;
		    index_x = x_8;
		    index_y = y_8;
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
		    x_9 = x_9 + width_i;
		    index_x = x_9;
		    index_y = y_9;
                end

                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
                    Occupied_Width_values[6] = Strip_y_plus_1_occupancy;
		    x_10 = x_10 + width_i;
		    index_x = x_10;
		    index_y = y_10;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[4] = Strip_y_occupancy;
		    x_9 = x_9 + width_i;
		    index_x = x_9;
		    index_y = y_9;
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
		    x_10 = x_10 + width_i;
		    index_x = x_10;
		    index_y = y_10;
                end

                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
                    Occupied_Width_values[4] = Strip_y_plus_1_occupancy;
		    x_11 = x_11 + width_i;
		    index_x = x_11;
		    index_y = y_11;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[2] = Strip_y_occupancy;
		    x_10 = x_10 + width_i;
		    index_x = x_10;
		    index_y = y_10;
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
		    x_11 = x_11 + width_i;
		    index_x = x_11;
		    index_y = y_11;
                end

                else if(Strip_y_plus_1_occupancy > Strip_y_occupancy) begin
                    Occupied_Width_values[2] = Strip_y_plus_1_occupancy;
		    x_12 = x_12 + width_i;
		    index_x = x_12;
		    index_y = y_12;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[0] = Strip_y_occupancy;
		    x_11 = x_11 + width_i;
		    index_x = x_11;
		    index_y = y_11;
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
		    x_12 = x_12 + width_i;
		    index_x = x_12;
		    index_y = y_12;
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
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
                end
		else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
		    x_14 = x_14 + width_i;
		    index_x = x_14;
		    index_y = y_14;
		end
		else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
		    x_15 = x_15 + width_i;
		    index_x = x_15;
		    index_y = y_15;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[10] = Strip_y_occupancy;
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
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
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
                end
		else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
		    x_14 = x_14 + width_i;
		    index_x = x_14;
		    index_y = y_14;
		end
		else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
		    x_15 = x_15 + width_i;
		    index_x = x_15;
		    index_y = y_15;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[10] = Strip_y_occupancy;
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
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
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
                end
		else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
		    x_14 = x_14 + width_i;
		    index_x = x_14;
		    index_y = y_14;
		end
		else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
		    x_15 = x_15 + width_i;
		    index_x = x_15;
		    index_y = y_15;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[10] = Strip_y_occupancy;
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
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
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
                end
		else if ((Strip_y_plus_1_occupancy > Strip_y_occupancy) && (Strip_y_plus_1_occupancy > Strip_y_plus_2_occupancy)) begin
                    Occupied_Width_values[11] = Strip_y_plus_1_occupancy;
		    x_14 = x_14 + width_i;
		    index_x = x_14;
		    index_y = y_14;
		end
		else if ((Strip_y_plus_2_occupancy > Strip_y_occupancy) && (Strip_y_plus_2_occupancy > Strip_y_plus_1_occupancy)) begin
                    Occupied_Width_values[12] = Strip_y_plus_2_occupancy;
		    x_15 = x_15 + width_i;
		    index_x = x_15;
		    index_y = y_15;
                end

		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[10] = Strip_y_occupancy;
		    x_13 = x_13 + width_i;
		    index_x = x_13;
		    index_y = y_13;
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


  
endmodule
