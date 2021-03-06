//////////////////////////////////////////////////////////////////////////////////
// Company: HuT Labs
// Engineer: Vedha Krishna Yarasuri
// 
// Create Date: 20.07.2021 19:59:38
// Design Name: Neural Processing Unit
// Module Name: Activation_Tag_check
// Project Name: Self Driving Car
// Target Devices: 
// Tool Versions: 
// Description: This module implements Binary search algorithm to Find the best available 
//              location for the Tag and returns the index of the most likelihood value 
//              from the activation ROM.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Activation_Tag_check #(
        parameter DATAWIDTH = 16,
        parameter INWIDTH = 9
    )(
        input clock,
        input [DATAWIDTH-1:0] sum,
        input [1:0] activation_func,
        output reg[DATAWIDTH-1:0] activation_value,
        output reg[DATAWIDTH-1:0] tag_value
    );

    // Things to be done :                                                       status
    //    1. Need to create a for loop equivalent using counters.                positive
    //    2. use always to check if counter changes and in that create           positive
    //       conditionsl if blocks.
    //    3. Use If Blocks to write binary search algorithm.                     positive
    //    4. If sum - tag <=(less than equals to) 0.0015 stop loop and set       positive
    //       output as the corresponding tag.
    //    5. Load the corresponding activation value into a register             positive
    //    6. Based on the signal choose lower or higher 16 bits of the           positive
    //       activation value.  
    
    parameter COUNTER_WIDTH = INWIDTH;
    reg[15:0] DIFF_CHECK = 16'b0000000001000000;
    
    // Memory Settings
//    reg [DATAWIDTH-1:0] tag_rom [2**INWIDTH-1:0];
//    reg [2*(DATAWIDTH)-1:0] activation_rom [2**INWIDTH-1:0];
    
    // Initializing Memory
//    initial
//        begin
//            $readmemb("XValues.mif", tag_rom);
//            $readmemb("SigTanHContent.mif",activation_rom);
//        end

    // Loading Memory
    reg load_mem_X = 1'b1;
    reg load_mem_activation = 1'b1;
    
    X_Rom tag_rom(.load_mem(load_mem_X));
    Activation_Rom activation_rom(.load_mem(load_mem_activation));
    
    // Clock Settings
    reg clock_enable = 1'b1;
    reg reset = 1'b0;
    reg load_enable = 1'b0;
    reg [COUNTER_WIDTH-1:0] load_value;
    wire [COUNTER_WIDTH-1:0] iterator;
    
    up_counter #(.COUNTER_WIDTH(COUNTER_WIDTH)) UC(.clock(clock), 
    .clock_enable(clock_enable), .reset(reset), .load_enable(load_enable), 
    .load_value(load_value), .iterator(iterator));
            
            
    // Binary Search Algorithm 
    parameter max_value_of_memory = 510; // Actually It should be 2**INWIDTH-1
    reg [COUNTER_WIDTH-1:0] start_index = {COUNTER_WIDTH{1'b0}};
    reg [COUNTER_WIDTH-1:0] end_index = max_value_of_memory;
    reg [COUNTER_WIDTH-1:0] mid_index = max_value_of_memory/2;
    reg [DATAWIDTH-1:0] difference_value = {(DATAWIDTH-1){1'b0}};
    reg difference_value_flag = 1'b0;
    reg [DATAWIDTH-1:0] mem_value = {(DATAWIDTH-1){1'b0}};
    
    
    // Activation output variables
    reg is_found = 1'b0;
    reg [2*(DATAWIDTH)-1:0] sig_tan_activation_value;
    
    always @(sum)
    begin
        start_index = {COUNTER_WIDTH{1'b0}};
        end_index = max_value_of_memory;
        mid_index = max_value_of_memory/2;
        difference_value = {(DATAWIDTH-1){1'b0}};
        difference_value_flag = 1'b0;
        mem_value = {(DATAWIDTH-1){1'b0}};
        activation_value = {(DATAWIDTH-1){1'bx}};
        
        
//        // If Num is greater than or equal to +8 then,
//        // we need to return activation value at 510 
//        if(sum>tag_rom.mem[510])
//        begin
//            tag_value = tag_rom.mem[510];
////          is_found = 1'b1;
//            sig_tan_activation_value = activation_rom.mem[510];
                
//            // Sigmoid => 1'b0     TanH => 1'b0
//            if(activation_func == 1'b0)
//                activation_value = sig_tan_activation_value[2*(DATAWIDTH)-1: DATAWIDTH];// higher 16 bits in activation_mem
//            else
//                activation_value = sig_tan_activation_value[DATAWIDTH-1: 0];// lower 16 bits in activation_func 
//        end
//        // If Num is less than or equal to -8 then,
//        // we need to return activation value at 0 
//        else
//        begin
//            if(sum>tag_rom.mem[0])
//            begin
//                tag_value = tag_rom.mem[0];
//    //          is_found = 1'b1;
//                sig_tan_activation_value = activation_rom.mem[0];
                    
//                // Sigmoid => 1'b0     TanH => 1'b0
//                if(activation_func == 1'b0)
//                    activation_value = sig_tan_activation_value[2*(DATAWIDTH)-1: DATAWIDTH];// higher 16 bits in activation_mem
//                else
//                    activation_value = sig_tan_activation_value[DATAWIDTH-1: 0];// lower 16 bits in activation_func
//            end
//        end
    end
    
    always @(start_index or end_index)
        mid_index <= (start_index + end_index)/2; 
    
    always @(iterator)
    begin
        // Now need to implement binary search.
//        #10 end_index <= mid_index - 1;
        mem_value = {tag_rom.mem[mid_index], 6'b000000} ;
//        $display("mem[i] = %b", mem_value);
        difference_value = sum - mem_value;
        difference_value_flag = difference_value[DATAWIDTH-1];
        
        if(difference_value_flag == 1)
        begin
            difference_value = (~difference_value) + 1;
        end
        
        if(difference_value <= DIFF_CHECK)
        begin
            if(difference_value_flag >=0)
            begin
                tag_value = mem_value;
//                is_found = 1'b1;
                sig_tan_activation_value = activation_rom.mem[mid_index];
                
                 // Sigmoid => 1'b0     TanH => 1'b0
                if(activation_func == 1'b0)
                    activation_value = sig_tan_activation_value[2*(DATAWIDTH)-1: DATAWIDTH];// higher 16 bits in activation_mem
                else
                    activation_value = sig_tan_activation_value[DATAWIDTH-1: 0];// lower 16 bits in activation_func 
                end
                
//              $display("tag_value = %b, sig_tan_activation_value = %b, activation_value = %b", tag_value, sig_tan_activation_value, activation_value);
        end
        else
            begin 
                if(difference_value_flag == 0)
                    start_index <= mid_index + 1;
                else
                begin
                    if(difference_value_flag == 1)
                    begin
                        end_index <= mid_index - 1;
                    end
                    else
                    begin
                        start_index <= start_index;
                        end_index <= end_index;
                    end
                end
                    
            end
//        $display("For Sum = %b, mem_value = %b, difference = %b, start_index = %d, end_index = %d, mid_index = %d, flag = %b", sum, mem_value, difference_value, start_index, end_index, mid_index, difference_value_flag);
    end
    
//    always @(posedge is_found)
//    begin
    
//    $display("inputs = %f, Complete Activation Value = %b, mid_index = %d, flag = %b", SF*sum, sig_tan_activation_value, mid_index, difference_value_flag);
//        // Sigmoid => 1'b0     TanH => 1'b0
//        if(activation_func == 1'b0)
//            activation_value = sig_tan_activation_value[2*(DATAWIDTH)-1: DATAWIDTH];// higher 16 bits in activation_mem
//        else
//            activation_value = sig_tan_activation_value[DATAWIDTH-1: 0];// lower 16 bits in activation_mem
//    end
    
endmodule
