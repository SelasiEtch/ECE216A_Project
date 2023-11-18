`timescale 1ns / 100ps

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

reg [7:0] Occupied_Width_values [0:12];
reg [7:0] Strip_y_occupancy = 0;
reg [7:0] Strip_y_plus_1_occupancy = 0;
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
                // Both strips are not filled
                if (Strip_y_occupancy > 0 && Strip_y_plus_1_occupancy > 0) begin
                    if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
                        Occupied_Width_values[1] = Strip_y_occupancy;
			x_4 = x_4 + width_i;
			index_x_o <= x_4;
			index_y_o <= y_4;
                    end
                    else begin
                        Occupied_Width_values[3] = Strip_y_plus_1_occupancy;
			x_5 = x_5 + width_i;
			index_x_o = x_5;
			index_x_o = y_5;
                    end
                end
                // Strip y i not filled
                else if (Strip_y_occupancy > 0) begin
                    Occupied_Width_values[1] = Strip_y_occupancy;
		    //x_4 = x_4 + Width_In;
		    //Output_x_Out = x_4;
		    //Output_y_Out = y_4;
                end
                // Strip y+1 is not filled
                else if (Strip_y_plus_1_occupancy > 0) begin
                    Occupied_Width_values[3] = Strip_y_plus_1_occupancy;
		    //x_5 = x_5 + Width_In;
		    //Output_x_Out = x_5;
		    //Output_y_Out = y_5;
                end
		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[1] = Strip_y_occupancy;
		    //x_4 = x_4 + Width_In;
		    //Output_x_Out = x_4;
		    //Output_y_Out = y_4;
		end
                // Both Strips are filled
                else begin
                    //Strike = Strike + 1;
                    //Output_x_Out = 128;
                    //utput_y_Out = 128;
                end
            end
/*
        4'd5:
            begin
                Strip_y_occupancy = Occupied_Width_values[3] - Width_In;
                Strip_y_plus_1_occupancy = Occupied_Width_values[5] - Width_In;
                // Both strips are not filled
                if (Strip_y_occupancy > 0 && Strip_y_plus_1_occupancy > 0) begin
                    if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
                        Occupied_Width_values[3] = Strip_y_occupancy;
			x_5 = x_5 + Width_In;
			Output_x_Out = x_5;
			Output_y_Out = y_5;
                    end
                    else begin
                        Occupied_Width_values[5] = Strip_y_plus_1_occupancy;
			x_6 = x_6 + Width_In;
			Output_x_Out = x_6;
			Output_y_Out = y_6;
                    end
                end
                // Strip y i not filled
                else if (Strip_y_occupancy > 0) begin
                    Occupied_Width_values[3] = Strip_y_occupancy;
		    x_5 = x_5 + Width_In;
		    Output_x_Out = x_5;
		    Output_y_Out = y_5;
                end
                // Strip y+1 is not filled
                else if (Strip_y_plus_1_occupancy > 0) begin
                    Occupied_Width_values[5] = Strip_y_plus_1_occupancy;
		    x_6 = x_6 + Width_In;
		    Output_x_Out = x_6;
		    Output_y_Out = y_6;
                end
		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[3] = Strip_y_occupancy;
		    x_5 = x_5 + Width_In;
		    Output_x_Out = x_5;
		    Output_y_Out = y_5;
		end
                // Both Strips are filled
                else begin
                    Strike = Strike + 1;
                    Output_x_Out = 128;
                    Output_y_Out = 128;
                end
            end
        4'd6:
            begin
                Strip_y_occupancy = Occupied_Width_values[5] - Width_In;
                Strip_y_plus_1_occupancy = Occupied_Width_values[7] - Width_In;
                // Both strips are not filled
                if (Strip_y_occupancy > 0 && Strip_y_plus_1_occupancy > 0) begin
                    if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
                        Occupied_Width_values[5] = Strip_y_occupancy;
			x_6 = x_6 + Width_In;
			Output_x_Out = x_6;
			Output_y_Out = y_6;
                    end
                    else begin
                        Occupied_Width_values[7] = Strip_y_plus_1_occupancy;
			x_7 = x_7 + Width_In;
			Output_x_Out = x_7;
			Output_y_Out = y_7;
                    end
                end
                // Strip y i not filled
                else if (Strip_y_occupancy > 0) begin
                    Occupied_Width_values[5] = Strip_y_occupancy;
		    x_6 = x_6 + Width_In;
		    Output_x_Out = x_6;
		    Output_y_Out = y_6;
                end
                // Strip y+1 is not filled
                else if (Strip_y_plus_1_occupancy > 0) begin
                    Occupied_Width_values[7] = Strip_y_plus_1_occupancy;
		    x_7 = x_7 + Width_In;
		    Output_x_Out = x_7;
		    Output_y_Out = y_7;
                end
		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width_values[5] = Strip_y_occupancy;
		    x_6 = x_6 + Width_In;
		    Output_x_Out = x_6;
		    Output_y_Out = y_6;
		end
                // Both Strips are filled
                else begin
                    Strike = Strike + 1;
                    Output_x_Out = 128;
                    Output_y_Out = 128;
                end
            end
        4'd7:
		Output_y_Out = 128;
        4'd8:
		Output_y_Out = 128;
        4'd9:
		Output_y_Out = 128;
        4'd10:
		Output_y_Out = 128;
        4'd11:
		Output_y_Out = 128;
        4'd12:
		Output_y_Out = 128;
        4'd13:
		Output_y_Out = 128;
        4'd14:
		Output_y_Out = 128;
        4'd15:
		Output_y_Out = 128;
        4'd16:
		Output_y_Out = 128;
*/
    endcase
end


  
endmodule
