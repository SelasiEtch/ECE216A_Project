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
reg [7:0] Strip_y_occupancy
reg [7:0] Strip_y_plus_1_occupancy

always @ (posedge Clk_In or posedge Rst_In) begin
    // Reset Occupied Width Array
    if (Rst_In) begin
        for (int i = 0; i < 13; i = i+1) begin
            Occupied_Width_values[i] <= 8'b00000000
        end
    end
    // On positive edge of Clock, Occupied width array is updated
    else begin
        for (int i = 0; i < 13; i = i+1) begin
            Occupied_Width_values[i] <= Occupied_Width[i]
        end   
    end
end

always @* begin   
    // Updating Strip Occupancy and determining placements
    case (Height_In)
        4'd4:
            begin
                Strip_y_occupancy = Occupied_Width_values[3] - Width_In;
                Strip_y_plus_1_occupancy = Occupied_Width_values[4] - Width_In;
                // Both strips are not filled
                if (Strip_y_occupancy > 0 and Strip_y_plus_1_occupancy > 0) begin
                    if (Strip_y_occupancy > Strip_y_plus_1_occupancy) begin
                        Occupied_Width[1] = Strip_y_occupancy;
                    end
                    else begin
                        Occupied_Width[1] = Strip_y_plus_1_occupancy;
                    end
                end
                // Strip y i not filled
                else if (Strip_y_occupancy > 0) begin
                    Occupied_Width[1] = Strip_y_occupancy;
                end
                // Strip y+1 is not filled
                else if (Strip_y_plus_1_occupancy > 0) begin
                    Occupied_Width[1] = Strip_y_plus_1_occupancy;
                end
                // Both Strips are filled
                else begin
                    Strike = Strike + 1;
                    Output_x_Out = 128;
                    Output_y_Out = 128;
                end
            end
        4'd5:
        4'd6:
        4'd7:
        4'd8:
        4'd9:
        4'd10:
        4'd11:
        4'd12:
        4'd13:
        4'd14:
        4'd15:
        4'd16:

    endcase
end


  
endmodule