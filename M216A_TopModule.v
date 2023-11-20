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
  output [7:0]Occupied_Width[12:0];  // Connect it to a 13 element Register array Occupied_Width
  output [3:0]strike_o;
  input rst_i;

wire [4:0] width_i, height_i;
wire clk_i, rst_i;

  
  //Add your code below 
  //Make sure to Register the outputs using the Register modules given above

  //Set the number of STRIPS
  parameter STRIP_ID_SIZE = 13;
  parameter STRIP_WIDTH = 128;

  reg clk_local_1 = 1'b0; //local clock that is slower than the normal clock by 4 cycles
  reg clk_local_2 = 1'b0;

  reg [7:0] temp_size;
  reg [7:0] temp_y_pos;
  reg [4:0] temp_strip_id;
  reg [7:0] id_width_counters [12:0];
  reg [3:0] Strike_local;
  reg [7:0] out_y_local = 7'b00000000;
  reg [7:0] out_x_local = 7'b00000000;
  reg [4:0] Height_In = 4'b0000;
  reg [4:0] Width_In = 4'b0000;
  reg [4:0] Height_In_0 = 4'b0000;
  reg [4:0] Width_In_0 = 4'b0000;
  reg [3:0] clk_counter = 0'b0;
  reg first_iteration = 1'b1;



always @(posedge clk_i) begin
	Height_In_0 <= height_i;
	Width_In_0 <= width_i;
	//$display("Inputs ACCORDING TO THE OUTPUT BLOCK(same clock): %d %d", Height_In, Width_In);
	clk_local_1 = ~clk_local_1;
end

always @(posedge clk_local_1) begin
	//Height_In = Height_In_0;
	//Width_In = Width_In_0;
	clk_local_2 = ~clk_local_2;
end

/*
always @(posedge clk_i) begin
	Height_In <= width_i;
	Width_In <= height_i; 
	if(first_iteration && clk_counter == 0)begin
		id_width_counters[0] <= 7'b00000000;
		id_width_counters[1] <= 7'b00000000;
		id_width_counters[2] <= 7'b00000000;
		id_width_counters[3] <= 7'b00000000;
		id_width_counters[4] <= 7'b00000000;
		id_width_counters[5] <= 7'b00000000;
		id_width_counters[6] <= 7'b00000000;
		id_width_counters[7] <= 7'b00000000;
		id_width_counters[8] <= 7'b00000000;
		id_width_counters[9] <= 7'b00000000;
		id_width_counters[10] <= 7'b00000000;
		id_width_counters[11] <= 7'b00000000;
		id_width_counters[12] <= 7'b00000000;
		Strike_local = 0;
		temp_y_pos = 0;
		temp_strip_id = 0;
	end
	
	if(first_iteration && clk_counter == 8)begin
		clk_counter = 0;
		clk_local <= ~clk_local;
		first_iteration = 1'b0; //set the flag to zero, so we only access this the first time.
	end

	if(~(first_iteration) && clk_counter == 4)begin
		clk_counter = 0;
		clk_local <= ~clk_local;
	end
	else begin
		clk_counter = clk_counter +1;
	end
end

*/


always @(posedge clk_local_2) begin

//by timing this properly we can avoid this. If we keep updating before the 4th clock cycle we should be able to avoid that without much work

/*Height_In <= width_i;
Width_In <= height_i;
Strike_local = 0;
out_y_local =  0;
out_x_local =  0;
temp_y_pos = 0;
temp_strip_id = 0; */

if(rst_i)begin
		id_width_counters[0] <= 7'b00000000;
		id_width_counters[1] <= 7'b00000000;
		id_width_counters[2] <= 7'b00000000;
		id_width_counters[3] <= 7'b00000000;
		id_width_counters[4] <= 7'b00000000;
		id_width_counters[5] <= 7'b00000000;
		id_width_counters[6] <= 7'b00000000;
		id_width_counters[7] <= 7'b00000000;
		id_width_counters[8] <= 7'b00000000;
		id_width_counters[9] <= 7'b00000000;
		id_width_counters[10] <= 7'b00000000;
		id_width_counters[11] <= 7'b00000000;
		id_width_counters[12] <= 7'b00000000;
		Strike_local = 0;
end

else begin
if(Height_In == 8)begin
	if(id_width_counters[8] <= id_width_counters[9] && id_width_counters[8] <= id_width_counters[6])
    begin
	temp_strip_id = 8;
        temp_y_pos = 64; 
        //We now know that the empiest ID is ID = 8
	end
    else if(id_width_counters[9] <= id_width_counters[6])
    begin
        temp_strip_id = 9;
        temp_y_pos = 72;
        //We now know that the empiest ID is ID 9
    end
    else
    begin
        temp_strip_id = 6;
        temp_y_pos = 48;
        //Now we know that the empiest ID is 6
    end
end

else if(Height_In < 8)begin
//do for sizes: 4,5,6,7 index of the 13 item array: 2,4,6,8. Not worth doing a loop for. Just a few items to go thru.
//$display("H: %d and I concluded it wasless than", Height_In);
	if(Height_In == 7)
    begin
        if(id_width_counters[7] <= id_width_counters[8] && id_width_counters[7] <= id_width_counters[9])begin
            //We now know that the empiest ID is ID = 8
            temp_strip_id = 7;
            temp_y_pos = 57;end
        else if(id_width_counters[8] <= id_width_counters[9])begin
            //We now know that the empiest ID is ID 9
            temp_strip_id = 8;
            temp_y_pos = 64;end
        else begin
            //Now we know that the empiest ID is 6
            temp_strip_id = 9;
            temp_y_pos = 72;end
    end
    else if(Height_In == 6)
    begin 
		//$display("does it make it here for first loop %d", Height_In);
		if(id_width_counters[5] <= id_width_counters[7])begin
			//$display("So, I accepted it was %d. Since it is the first run, I should also get in here", Height_In);
            temp_strip_id = 5;
            temp_y_pos = 42;
			//$display("strip_ID: %d and y_pos: %d", temp_strip_id, temp_y_pos);
			end
		else begin
            temp_strip_id = 7; 
            temp_y_pos = 57; end
	end
            //if Size is 5, and bucket size 5 is emptier
    else if(Height_In == 5)
    begin
		if(id_width_counters[3] <= id_width_counters[5])begin
            temp_strip_id = 3;
            temp_y_pos = 27; end
        else begin
            temp_strip_id = 5;
            temp_y_pos = 42; end
	end
    //if Size is 4, and bucket size 4 is emptier
    else //the height has to be 4 if we are here
    begin
		if(id_width_counters[1] <= id_width_counters[3])begin
            temp_strip_id = 1;
            temp_y_pos = 12; end
        else begin
		//$display("does it make it here for first loop %d", Height_In);
            temp_strip_id = 3;
            temp_y_pos = 27; end
	end
end
else begin
    //we now know that it is greater than 8
    if(Height_In == 12)
        begin
            temp_strip_id = 0;
            temp_y_pos = 0;
        end

    else if(Height_In < 12)
        begin
        //not worth doing a loop for. Just a few items to go thru. 
        //If size is 11, and bucket size 11 is emptier. place it there
        if(Height_In == 11)
        begin
            if(id_width_counters[2] <= id_width_counters[0])begin
                temp_strip_id = 2;
                temp_y_pos = 16;
            end
            else begin
                temp_strip_id = 0;
                temp_y_pos = 0; 
            end
        end
        //if Size is 10, and bucket size 10 is emptier
        else if(Height_In == 10)begin 
            if(id_width_counters[4] <= id_width_counters[2])begin
                temp_strip_id = 4;
                temp_y_pos = 32;
            end
            else begin
                temp_strip_id = 2;
                temp_y_pos = 16; 
            end
        end
        //if Size is 9, and bucket size 9 is emptier
        else if(Height_In == 9)begin
            if(id_width_counters[6] <= id_width_counters[4])begin
                temp_strip_id = 6;
                temp_y_pos = 48;
            end
            else begin
                    temp_strip_id = 4;
                    temp_y_pos = 32; 
            end
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
            Strike_local = Strike_local +1;
            //set index_x_o and index_y_o to 128
            out_x_local = 128;
            out_y_local = 128;
        end
      else begin

	    //$display("Inputs ACCORDING TO THE OUTPUT BLOCK (4 times slower clock): %d %d", Height_In, Width_In);
		//$display("we are in StripID: %d, and has this many items in: %d, and the ypos is here: %d", temp_strip_id, id_width_counters[temp_strip_id], temp_y_pos);
            //index_x_o = left_bottom index. So the position before we allocated the program+1
            out_x_local = id_width_counters[temp_strip_id]; 
            //index_y_o = bottom left corner of the begining of new data.
            out_y_local = temp_y_pos;
            //update occupied array width. My local copu and then the outgoing copy
            id_width_counters[temp_strip_id] = id_width_counters[temp_strip_id]+Width_In;
	    //Occupied_Width[temp_strip_id] <= id_width_counters[temp_strip_id];
        end
end

Height_In = Height_In_0;
Width_In = Width_In_0;

end


//$display("we are in StripID: %d, and has this many items in: %d, and the ypos is here: %d", temp_strip_id, id_width_counters[temp_strip_id], temp_y_pos);

assign strike_o = Strike_local;
assign index_x_o = out_x_local;
assign index_y_o = out_y_local;
assign Occupied_Width[0] = id_width_counters[0];
assign Occupied_Width[1] = id_width_counters[1];
assign Occupied_Width[2] = id_width_counters[2];
assign Occupied_Width[3] = id_width_counters[3];
assign Occupied_Width[4] = id_width_counters[4];
assign Occupied_Width[5] = id_width_counters[5];
assign Occupied_Width[6] = id_width_counters[6];
assign Occupied_Width[7] = id_width_counters[7];
assign Occupied_Width[8] = id_width_counters[8];
assign Occupied_Width[9] = id_width_counters[9];
assign Occupied_Width[10] = id_width_counters[10];
assign Occupied_Width[11] = id_width_counters[11];
assign Occupied_Width[12] = id_width_counters[12];
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
endmodule