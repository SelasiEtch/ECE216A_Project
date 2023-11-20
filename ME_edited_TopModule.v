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
  output [7:0]Occupied_Width[12:0];  //Connect it to a 13 element Register array
  output [3:0]Strike;
  input Rst_In;

  wire [4:0] Width_In, Height_In;
  wire Clk_In, Rst_In;
  
  //Add your code below 
  //Make sure to Register the outputs using the Register modules given above

  //Set the number of STRIPS
  parameter STRIP_ID_SIZE = 13;
  parameter STRIP_WIDTH = 128;

  reg [7:0] temp_size;
  reg [7:0] temp_y_pos;
  wire [4:0] temp_strip_id;
  reg [7:0] id_width_counters [0:STRIP_ID_SIZE-1];
  
  /*
  The Strip ID is different to what the project calls so it is easier to handle here
              size 12 -> Array_ID: 0  -> y_position: 0 
              size 4  -> Array_ID: 1  -> y_position: 12 
              size 11 -> Array_ID: 2  -> y_position: 16
              size 5  -> Array_ID: 3  -> y_position: 27
              size 10 -> Array_ID: 4  -> y_position: 32
              size 6  -> Array_ID: 5  -> y_position: 42
              size 9  -> Array_ID: 6  -> y_position: 48
              size 7  -> Array_ID: 7  -> y_position: 57
              size 8  -> Array_ID: 8  -> y_position: 64
              size 8  -> Array_ID: 9  -> y_position: 72
              size 16 -> Array_ID: 10 -> y_position: 80
              size 16 -> Array_ID: 11 -> y_position: 96
              size 16 -> Array_ID: 12 -> y_position: 112
  */
  
  
  always @() begin
      //How do I make sure there is no overlapping between placement?
      //data comes every 4 clock cycles. so we have to somehow wait for that

      if(Height_In == 8)begin
            if(id_width_counters[8] <= id_width_counters[9] && id_width_counters[8] <= id_width_counters[6])begin
                temp_strip_id = 8;
                temp_y_pos = 64; 
                //We now know that the empiest ID is ID = 8
           end
            else if(id_width_counters[9] <= id_width_counters[6])begin
                temp_strip_id = 9;
                temp_y_pos = 72;
                //We now know that the empiest ID is ID 9
            end
            else begin
                temp_strip_id = 6;
                temp_y_pos = 48;
                //Now we know that the empiest ID is 6
            end
      end

      else if(Height_In < 8)begin
            //do for sizes: 4,5,6,7 index of the 13 item array: 2,4,6,8. Not worth doing a loop for. Just a few items to go thru.

            if(Height_In == 7)begin
                if(id_width_counters[7] <= id_width_counters[8] && id_width_counters[7] <= id_width_counters[9])begin
                    temp_strip_id = 7;
                    temp_y_pos = 57;
                    //We now know that the empiest ID is ID = 8
                end
                else if(id_width_counters[8] <= id_width_counters[9])begin
                    temp_strip_id = 8;
                    temp_y_pos = 64;
                    //We now know that the empiest ID is ID 9
                end
                else begin
                    temp_strip_id = 9;
                    temp_y_pos = 72;
                    //Now we know that the empiest ID is 6
                end
            end
            //If size is 6, and bucket size 6 is emptier. place it there
            if(Height_In == 6 && id_width_counters[5] <= id_width_counters[7])begin
                temp_strip_id = 5;
                temp_y_pos = 42;
            end
            else begin
                temp_strip_id = 7; 
                temp_y_pos = 57;
            end
            //if Size is 5, and bucket size 5 is emptier
            if(Height_In == 5 && id_width_counters[3] <= id_width_counters[5])begin
                temp_strip_id = 3;
                temp_y_pos = 27;
            end
            else begin
                temp_strip_id = 5;
                temp_y_pos = 42; 
            end
            //if Size is 4, and bucket size 4 is emptier
            if(Height_In == 4 && id_width_counters[1] < id_width_counters[3])begin
                temp_strip_id = 1;
                temp_y_pos = 12;
            end
            else begin
                temp_strip_id = 3;
                temp_y_pos = 27; 
            end
        end

      else begin
            //we now know that it is greater than 8
            if(Height_In == 12)begin
                temp_strip_id = 0;
                temp_y_pos = 0;
            end

            else if(Height_In < 12)begin
                //not worth doing a loop for. Just a few items to go thru. 
                //If size is 11, and bucket size 11 is emptier. place it there
                if(Height_In == 11 && id_width_counters[2] <= id_width_counters[0])begin
                    temp_strip_id = 2;
                    temp_y_pos = 16;
                end
                else begin
                    temp_strip_id = 0;
                    temp_y_pos = 0; 
                end
                //if Size is 10, and bucket size 10 is emptier
                if(Height_In == 10 && id_width_counters[4] <= id_width_counters[2])begin
                    temp_strip_id = 4;
                    temp_y_pos = 32;
                end
                else begin
                    temp_strip_id = 2;
                    temp_y_pos = 16; 
                end
                //if Size is 9, and bucket size 9 is emptier
                if(Height_In == 9 && id_width_counters[6] <= id_width_counters[4])begin
                    temp_strip_id = 6;
                    temp_y_pos = 48;
                end
                else begin
                    temp_strip_id = 4;
                    temp_y_pos = 32; 
                end
            end

            else begin
                //check occupancy of stip ID 9-11 and select the least occupied one
                if (id_width_counters[10] <= id_width_counters[11] && id_width_counters[10] <= id_width_counters[12]) begin
                    temp_strip_id = 10;
                    temp_y_pos = 80;
                    //We now know that ID 10 is the emptiest one
                end
                else if (id_width_counters[11] <= id_width_counters[12]) begin
                    temp_strip_id = 11;
                    temp_y_pos = 96;
                    //We now know that ID 11 is the emptiest one
                end
                else begin
                    temp_strip_id = 12;
                    temp_y_pos = 112;
                    //We now know that ID 12 is the emptiest one
                end
            end
        end
  
      if(id_width_counters[temp_strip_id] + Width_In > 128) begin
            //increase the strike by 1
            Strike = Strike +1;
            //set index_x_o and index_y_o to 128
            Output_x_Out = 128;
            Output_y_Out = 128;
        end
      else begin
            //allocate rectangle... how?

            //index_x_o = left_bottom index. So the position before we allocated the program+1
            Output_x_Out =id_width_counters[temp_strip_id]+1; 
            //index_y_o = bottom left corner of the begining of new data.
            Output_y_Out =temp_y_pos;
            //update occupied array width. My local copu and then the outgoing copy
            id_width_counters[temp_strip_id] = id_width_counters[temp_strip_id]+Width_In;
            Occupied_Width[temp_strip_id] = id_width_counters[temp_strip_id];
        end
    end 
endmodule