`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:00 03/10/2017 
// Design Name: 
// Module Name:    seven 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seven(
    input clk,
    input rst,
    output reg rclk,
	 output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp,
    output [3:0]an
    );

reg [3:0]first; //register for the first digit
reg [3:0]second; //register for the second digit
reg [3:0]third;
reg [3:0]fourth;

reg [26:0]count;
reg [6:0]min;
reg [6:0]sec;

always@(posedge clk)
begin
if(rst)
begin
count = 0;
rclk = 1'b1;
sec = 0;
min = 0;
end
count = count+1;
if(count == 50000000)
begin
rclk = !rclk;
sec = sec+1 ;
if(sec == 60)
begin
min = min+1;
sec = 0;
end
if(min == 60)
begin
min = 0;
end
count = 0;
end
end


always@(posedge rclk)
begin

if(rst)
begin
first <= 0;
second <= 0;
third <= 0;
fourth <= 0;
end

else if (first==4'd9) 
begin  //x9 reached
first <= 0;
if (second == 4'd5) //59 reached
begin
second <= 0;
third <= third + 1;
if (third == 4'd9)
begin
third <= 0;
fourth <= fourth + 1;
end
end
else
second <= second + 1;  
end
else
first <= first + 1;
end

localparam N = 18;
reg [N-1:0]co;

always @ (posedge clk)
begin
if (rst)
co <= 0;
else
co <= co + 1;
end

reg [6:0]sseg;
reg [3:0]an_temp;
always @ (*)
 begin
  case(count[N-1:N-2])
   
   2'b00 : 
    begin
     sseg = first;
     an_temp = 4'b1110;
    end
   
   2'b01:
    begin
     sseg = second;
     an_temp = 4'b1101;
    end
   
   2'b10:
    begin
     sseg = third; 
     an_temp = 4'b1011;
    end
    
   2'b11:
    begin
     sseg = fourth; 
     an_temp = 4'b0111;
    end
  endcase
 end
assign an = an_temp;

reg [6:0] sseg_temp; 
always @ (*)
 begin
  case(sseg)
   4'd0 : sseg_temp = 7'b1000000; //0
   4'd1 : sseg_temp = 7'b1111001; //1
   4'd2 : sseg_temp = 7'b0100100; //2
   4'd3 : sseg_temp = 7'b0110000; //3
   4'd4 : sseg_temp = 7'b0011001; //4
   4'd5 : sseg_temp = 7'b0010010; //5
   4'd6 : sseg_temp = 7'b0000010; //6
   4'd7 : sseg_temp = 7'b1111000; //7
   4'd8 : sseg_temp = 7'b0000000; //8
   4'd9 : sseg_temp = 7'b0010000; //9
   default : sseg_temp = 7'b0111111; //dash
  endcase
 end
assign {g, f, e, d, c, b, a} = sseg_temp; 
assign dp = 1'b1; //we dont need the decimal here so turn all of them off

endmodule