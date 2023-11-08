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



  
endmodule