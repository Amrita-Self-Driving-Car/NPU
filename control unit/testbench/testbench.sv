module Control_Unit_Test;
  
  reg  [63:0] instruction;
  wire [5:0]  opcode;
  wire [9:0]  func;
  wire [21:0] Store_or_load_address;
  wire [21:0] Data_register_or_address;
  wire [21:0] Image_Buffer_Register;
  wire [10:0] Resize_Reg_1;
  wire [10:0] Resize_Reg_2;
  
  Control_Unit cu(.instruction(instruction), .opcode(opcode), .func(func), .Store_or_load_address(Store_or_load_address), .Data_register_or_address(Data_register_or_address), .Image_Buffer_Register(Image_Buffer_Register), .Resize_Reg_1(Resize_Reg_1), .Resize_Reg_2(Resize_Reg_2) );
  
  initial
    begin
      
      $monitor($time, " opcode = %b, func = %b, Store_or_load_address = %b, Data_register_or_address = %b, Image_Buffer_Register = %b, Resize_Reg_1 = %b, Resize_Reg_2 = %b",opcode, func, Store_or_load_address, Data_register_or_address, Image_Buffer_Register, Resize_Reg_1, Resize_Reg_2);
      
      #5 instruction = {4'b0001,6'b000000,10'b0000000000,22'b0000000000000001001000, 22'b0000000000000001001000};
      #5 instruction = {4'b0001,6'b000000,10'b0000000001,22'b0000000000000001001000, 22'b0000000000000001001000};
      #5 instruction = {4'b0001,6'b000001,10'b0000000000,22'b0000000000000001001000, 11'b00000000001,11'b00000000010};
      #5 instruction = {4'b0001,6'b000001,10'b0000000001,22'b0000000000000001001000, 11'b00000000001,11'b00000000010};
      #5 $finish;
    end
  
endmodule