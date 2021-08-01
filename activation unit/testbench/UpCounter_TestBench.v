//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2021 16:11:59
// Design Name: 
// Module Name: UpCounter_TestBench
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

module UpCounter_TestBench;

parameter COUNTER_WIDTH = 5;

reg clock = 1'b0;
reg clock_enable = 1'b1;
reg reset = 1'b0;
reg load_enable = 1'b0;
reg [COUNTER_WIDTH-1:0] load_value;
wire [COUNTER_WIDTH-1:0] iterator;
integer i;

always #5 clock <= !clock;

up_counter #(.COUNTER_WIDTH(COUNTER_WIDTH)) UC(.clock(clock), 
.clock_enable(clock_enable), .reset(reset), .load_enable(load_enable), 
.load_value(load_value), .iterator(iterator));

initial
    begin
        $monitor($time, " clock = %b clock_enable = %b reset = %b load_enable = %b load_value = %b iterator = %b", 
        clock, clock_enable, reset, load_enable, load_value, iterator);
        
        #33 load_enable = 1'b1; load_value = 5'b11110;
        #34 load_enable = 1'b0;
        #53 reset = 1'b1;
        #70 $finish;
    end
endmodule