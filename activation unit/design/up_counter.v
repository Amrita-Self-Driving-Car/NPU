//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2021 15:40:34
// Design Name: 
// Module Name: up_counter
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


module up_counter #(parameter COUNTER_WIDTH = 6)(
input clock,
input clock_enable,
input reset,
input load_enable,
input [COUNTER_WIDTH-1:0] load_value,
output [COUNTER_WIDTH-1:0] iterator
    );
    
   reg [COUNTER_WIDTH-1:0] iterator = {COUNTER_WIDTH{1'b0}};

   always @(posedge clock)
    begin
      if (reset)
         iterator <= {COUNTER_WIDTH{1'b0}};
      else if (clock_enable)
         if (load_enable)
            iterator <= load_value;
         else
            iterator <= iterator + 1'b1;
      end
            
						
endmodule