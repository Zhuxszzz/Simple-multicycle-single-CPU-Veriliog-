`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/22 15:51:09
// Design Name: 
// Module Name: RAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RAM(
input clk,
input [31:0] DAddr,
input [31:0] DataIn, // [31:24], [23:16], [15:8], [7:0]
input mRD,	// 为 0，正常读；为 1,输出高组态
input mWR,	// 为 0，写；为 1，无操作
output [31:0] Dataout
);
reg [7:0] ram [0:60]; //存储器
// 读

assign Dataout[7:0]	= (mRD==0)?ram[DAddr + 3]:8'bz; // z为高阻态
assign Dataout[15:8]	= (mRD==0)?ram[DAddr + 2]:8'bz;
assign Dataout[23:16] = (mRD==0)?ram[DAddr + 1]:8'bz;
 assign Dataout[31:24] = (mRD==0)?ram[DAddr]:8'bz;
//	写
always@( negedge clk ) begin
if( mWR==0 ) begin
ram[DAddr]	<= DataIn[31:24];
ram[DAddr+1] <= DataIn[23:16];
ram[DAddr+2] <= DataIn[15:8];
ram[DAddr+3] <= DataIn[7:0];
end
end
endmodule