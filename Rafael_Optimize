

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


  reg clk_local_1 = 1'b0; 
  reg clk_local_2 = 1'b0;

  reg [7:0] temp_y_pos;
  reg [7:0] temp_x_pos;
  reg [4:0] temp_strip_id;
  wire [7:0] id_width_counters [12:0];
  reg [7:0] id_width_counters_int [12:0];
  reg [3:0] Strike_local = 3'b000;
  reg [7:0] out_y_local = 8'b00000000;
  reg [7:0] out_x_local = 8'b00000000;
  wire [7:0] out_y_local_wire;
  wire [7:0] out_x_local_wire;
  reg [4:0] Height_In = 5'b00000;
  reg [4:0] Width_In = 5'b00000;

assign id_width_counters[0] = id_width_counters_int[0];
assign id_width_counters[1] = id_width_counters_int[1];
assign id_width_counters[2] = id_width_counters_int[2];
assign id_width_counters[3] = id_width_counters_int[3];
assign id_width_counters[4] = id_width_counters_int[4];
assign id_width_counters[5] = id_width_counters_int[5];
assign id_width_counters[6] = id_width_counters_int[6];
assign id_width_counters[7] = id_width_counters_int[7];
assign id_width_counters[8] = id_width_counters_int[8];
assign id_width_counters[9] = id_width_counters_int[9];
assign id_width_counters[10] = id_width_counters_int[10];
assign id_width_counters[11] = id_width_counters_int[11];
assign id_width_counters[12] = id_width_counters_int[12];

assign out_x_local_wire = out_x_local;
assign out_y_local_wire = out_y_local;

  wire [4:0] Height_In_0;
  wire [4:0] Width_In_0;

    // Input Data Registers
    P1_Reg_5_bit Height_Reg(.DataIn(height_i), .DataOut(Height_In_0), .rst(rst_i), .clk(clk_i));				
    P1_Reg_5_bit Width_Reg(.DataIn(width_i), .DataOut(Width_In_0), .rst(rst_i), .clk(clk_i));				


    // Output Data Registers
    P1_Reg_8_bit Index_X_Reg(.DataIn(out_x_local_wire), .DataOut(index_x_o), .rst(rst_i), .clk(clk_local_1));			
    P1_Reg_8_bit Index_Y_Reg(.DataIn(out_y_local_wire), .DataOut(index_y_o), .rst(rst_i), .clk(clk_local_1));	

    P1_Reg_4_bit Strike_Reg(.DataIn(Strike_local), .DataOut(strike_o), .rst(rst_i), .clk(clk_local_2));			
    P1_Reg_8_bit Strip1_Reg(.DataIn(id_width_counters[0]), .DataOut(Occupied_Width[0]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip2_Reg(.DataIn(id_width_counters[1]), .DataOut(Occupied_Width[1]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip3_Reg(.DataIn(id_width_counters[2]), .DataOut(Occupied_Width[2]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip4_Reg(.DataIn(id_width_counters[3]), .DataOut(Occupied_Width[3]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip5_Reg(.DataIn(id_width_counters[4]), .DataOut(Occupied_Width[4]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip6_Reg(.DataIn(id_width_counters[5]), .DataOut(Occupied_Width[5]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip7_Reg(.DataIn(id_width_counters[6]), .DataOut(Occupied_Width[6]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip8_Reg(.DataIn(id_width_counters[7]), .DataOut(Occupied_Width[7]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip9_Reg(.DataIn(id_width_counters[8]), .DataOut(Occupied_Width[8]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip10_Reg(.DataIn(id_width_counters[9]), .DataOut(Occupied_Width[9]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip11_Reg(.DataIn(id_width_counters[10]), .DataOut(Occupied_Width[10]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip12_Reg(.DataIn(id_width_counters[11]), .DataOut(Occupied_Width[11]), .rst(rst_i), .clk(clk_local_2));	
    P1_Reg_8_bit Strip13_Reg(.DataIn(id_width_counters[12]), .DataOut(Occupied_Width[12]), .rst(rst_i), .clk(clk_local_2));	


always @(posedge clk_i) begin
	clk_local_1 = ~clk_local_1;
end

always @(posedge clk_local_1) begin
	clk_local_2 = ~clk_local_2;
end


always @(posedge clk_local_2) begin

if(rst_i) begin
		id_width_counters_int[0] <= 8'b000000000;
		id_width_counters_int[1] <= 8'b000000000;
		id_width_counters_int[2] <= 8'b000000000;
		id_width_counters_int[3] <= 8'b000000000;
		id_width_counters_int[4] <= 8'b000000000;
		id_width_counters_int[5] <= 8'b000000000;
		id_width_counters_int[6] <= 8'b000000000;
		id_width_counters_int[7] <= 8'b000000000;
		id_width_counters_int[8] <= 8'b000000000;
		id_width_counters_int[9] <= 8'b000000000;
		id_width_counters_int[10] <= 8'b000000000;
		id_width_counters_int[11] <= 8'b000000000;
		id_width_counters_int[12] <= 8'b000000000;
	        Strike_local = 0;
end

else if(Height_In == 8)begin
	if(id_width_counters_int[8] <= id_width_counters_int[9] && id_width_counters_int[8] <= id_width_counters_int[6])
    begin
	temp_strip_id = 8;
        temp_y_pos = 64; 
	end
    else if(id_width_counters_int[9] <= id_width_counters_int[6])
    begin
        temp_strip_id = 9;
        temp_y_pos = 72;
    end
    else
    begin
        temp_strip_id = 6;
        temp_y_pos = 48;
    end
end

else if(Height_In < 8)begin
	if(Height_In == 7)
    begin
        if(id_width_counters_int[7] <= id_width_counters_int[8] && id_width_counters_int[7] <= id_width_counters_int[9])begin
            temp_strip_id = 7;
            temp_y_pos = 57;
end
        else if(id_width_counters_int[8] <= id_width_counters_int[9])begin
            temp_strip_id = 8;
            temp_y_pos = 64;
end
        else begin
            temp_strip_id = 9;
            temp_y_pos = 72;
end
    end
    else if(Height_In == 6)
    begin 
		if(id_width_counters_int[5] <= id_width_counters_int[7])begin
            temp_strip_id = 5;
            temp_y_pos = 42;
			end
		else begin
            temp_strip_id = 7; 
            temp_y_pos = 57;
 end
	end
    else if(Height_In == 5)
    begin
		if(id_width_counters_int[3] <= id_width_counters_int[5])begin
            temp_strip_id = 3;
            temp_y_pos = 27;
 end
        else begin
            temp_strip_id = 5;
            temp_y_pos = 42;
 end
	end
    else 
    begin
		if(id_width_counters_int[1] <= id_width_counters_int[3])begin
            temp_strip_id = 1;
            temp_y_pos = 12;
 end
        else begin
            temp_strip_id = 3;
            temp_y_pos = 27;
 end
	end
end
else begin
    if(Height_In == 12)
        begin
            temp_strip_id = 0;
            temp_y_pos = 0;
        end

    else if(Height_In < 12)
        begin
        if(Height_In == 11)
        begin
            if(id_width_counters_int[2] <= id_width_counters_int[0])begin
                temp_strip_id = 2;
                temp_y_pos = 16;
            end
            else begin
                temp_strip_id = 0;
                temp_y_pos = 0; 
            end
        end
        else if(Height_In == 10)begin 
            if(id_width_counters_int[4] <= id_width_counters_int[2])begin
                temp_strip_id = 4;
                temp_y_pos = 32;
            end
            else begin
                temp_strip_id = 2;
                temp_y_pos = 16; 
            end
        end
        else if(Height_In == 9)begin
            if(id_width_counters_int[6] <= id_width_counters_int[4])begin
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
                if (id_width_counters_int[10] <= id_width_counters_int[11] && id_width_counters_int[10] <= id_width_counters[12]) begin
                    temp_strip_id = 10;
                    temp_y_pos = 80;
                end
                else if (id_width_counters_int[11] <= id_width_counters_int[12]) begin
                    temp_strip_id = 11;
                    temp_y_pos = 96;
                end
                else begin
                    temp_strip_id = 12;
                    temp_y_pos = 112;
                end
        end
    end
  
      if(id_width_counters_int[temp_strip_id] + Width_In > 128) begin
            Strike_local = Strike_local +1;
            out_x_local = 128;
            out_y_local = 128;
        end
      else begin

                out_x_local = id_width_counters_int[temp_strip_id]; 
                out_y_local = temp_y_pos;
                id_width_counters_int[temp_strip_id] <= id_width_counters_int[temp_strip_id]+Width_In;
        end

Height_In = Height_In_0;
Width_In = Width_In_0;

end

endmodule

