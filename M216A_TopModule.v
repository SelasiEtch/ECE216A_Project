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
    Clk_In,
    Width_In,
    Height_In,
    Output_x_Out,
    Output_y_Out,
    Strike,
    Occupied_Width,
    Rst_In);
  input Clk_In;
  input [4:0]Width_In;
  input [4:0]Height_In;
  output [7:0]Output_x_Out, Output_y_Out;
  output [7:0]Occupied_Width[12:0];  // Connect it to a 13 element Register array
  output [3:0]Strike;
  input Rst_In;

wire [4:0] Width_In, Height_In;
wire Clk_In, Rst_In;


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
always @ (posedge Clk_In or posedge Rst_In) begin
    // Reset Occupied Width Array
    if (Rst_In) begin
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
    case (Height_In)
        4'd4:
            begin
                Strip_y_occupancy = Occupied_Width_values[1] - Width_In;
                Strip_y_plus_1_occupancy = Occupied_Width_values[3] - Width_In;
                // Both strips are not filled
                if (Strip_y_occupancy > 0 && Strip_y_plus_1_occupancy > 0) begin
                    if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
                        Occupied_Width[1] = Strip_y_occupancy;
			x_4 = x_4 + Width_In;
			Output_x_Out = x_4;
			Output_y_Out = y_4;
                    end
                    else begin
                        Occupied_Width[3] = Strip_y_plus_1_occupancy;
			x_5 = x_5 + Width_In;
			Output_x_Out = x_5;
			Output_y_Out = y_5;
                    end
                end
                // Strip y i not filled
                else if (Strip_y_occupancy > 0) begin
                    Occupied_Width[1] = Strip_y_occupancy;
		    x_4 = x_4 + Width_In;
		    Output_x_Out = x_4;
		    Output_y_Out = y_4;
                end
                // Strip y+1 is not filled
                else if (Strip_y_plus_1_occupancy > 0) begin
                    Occupied_Width[3] = Strip_y_plus_1_occupancy;
		    x_5 = x_5 + Width_In;
		    Output_x_Out = x_5;
		    Output_y_Out = y_5;
                end
		// Strip y+1 and Strip y have equal occupancies. Strip y has priority
		else if (Strip_y_occupancy == Strip_y_plus_1_occupancy) begin
		    Occupied_Width[1] = Strip_y_occupancy;
		    x_4 = x_4 + Width_In;
		    Output_x_Out = x_4;
		    Output_y_Out = y_4;
		end
                // Both Strips are filled
                else begin
                    Strike = Strike + 1;
                    Output_x_Out = 128;
                    Output_y_Out = 128;
                end
            end
        4'd5:
		Output_y_Out = 128;
        4'd6:
		Output_y_Out = 128;
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

    endcase
end


  
endmodule
