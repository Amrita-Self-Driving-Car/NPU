//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2021 17:56:53
// Design Name: 
// Module Name: Activation_TestBench
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


module Activation_TestBench;

    // Version 1.0.0 code
    //reg [31:0] activation_mem [1023:0];
    //integer i;
    //initial
    //    begin
    //        #0 $readmemb("SigTanHContent.mif", activation_mem);
    //        for(i = 510 ; i < 515 ; i = i + 1)
    //        begin
    //            #10 $display(" data[%d] = %b ", i, activation_mem[i]);
    //        end

    //        #30 $finish;
    //    end

    parameter DataWidth = 16, InWidth = 9, diff_check = 0.015625;
    parameter SF = 2.0**-11.0;
    parameter SF2 = 2.0**-14.0;

    reg clock = 1'b0;
    reg [DataWidth-1:0] sum;
    wire [DataWidth-1:0] activation_value;
    wire [DataWidth-1:0] tag_value;
    reg activation_func = 1'b0;

    reg[15:0] test_mem[19:0];
    integer i=0;

    Activation_Tag_check #(.DATAWIDTH(DataWidth), .INWIDTH(InWidth))
    ATC(.clock(clock), .sum(sum), .activation_func(activation_func), .activation_value(activation_value), .tag_value(tag_value));

    always #2 clock <= !clock;


    always @(tag_value)
    begin
        if(tag_value > 0)
        begin
            $display($time, " %d. For Sum = %b, Closest Activation Value = %b, Sum = %f, Closest Activation Value = %f",i, sum, activation_value, SF*sum, SF2*activation_value);
            i=i+1;
            #20 sum = test_mem[i];
        end
    end


    initial
    begin
        $readmemb("random_x_values_not_in_RAM.mif", test_mem);
        #0 sum = test_mem[0];
//        $display($time, " sum = %b ", sum);
        //          for(i=0;i<11;i=i+1)
        //          begin
        //              #100 sum = test_mem[i];
        //              $display($time, " For Sum = %f, tag_index = %f", SF*sum, SF*tag_index);
        //          end
        //          $monitor($time, " For Sum = %f, tag_index = %f", SF*sum, SF*tag_index);
        //           sum = 16'b1000000001000000;
        ////        #90 $display("For Sum = %f, tag_index = %f", SF*sum, SF*tag_index);
        //           #100 sum = 16'd11 << 11;
        ////        #40 $display("For Sum = %f, tag_index = %f", SF*sum, SF*tag_index);
        //           #100 sum = 16'b0011111100111101;
        ////        #40 $display("For Sum = %f, tag_index = %f", SF*sum, SF*tag_index);
        //           #200 sum = 16'b1101001010000000;
        ////        #40 $display("For Sum = %f, tag_index = %f", SF*sum, SF*tag_index);
        #2000 $finish;
    end
endmodule