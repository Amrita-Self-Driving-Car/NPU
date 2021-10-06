module Control_Unit(
  input  [63:0] instruction,
  output reg [5:0]  opcode,
  output reg [9:0]  func,
  output reg [21:0] Store_or_load_address,
  output reg [21:0] Data_register_or_address,
  output reg [21:0] Image_Buffer_Register,
  output reg [10:0] Resize_Reg_1,
  output reg [10:0] Resize_Reg_2
);
  
  parameter memory_operations = 6'd0, image_operations = 6'b1;
  
  always @(instruction)
    begin
      if(instruction[63:60] == 4'b1)
        begin
         
          opcode = instruction[59:54];
          func = instruction[53:44];

          case(opcode)
            memory_operations:
              begin
                Store_or_load_address = instruction[43:22];
                Data_register_or_address = instruction[21:0];
                Image_Buffer_Register = 22'bxxxxxxxxxxxxxxxxxxxxxx;
                Resize_Reg_1 = 11'bxxxxxxxxxxx;
                Resize_Reg_2 = 11'bxxxxxxxxxxx;
              end

            image_operations:
              begin
				Store_or_load_address = 22'bxxxxxxxxxxxxxxxxxxxxxx;
                Data_register_or_address = 22'bxxxxxxxxxxxxxxxxxxxxxx;
                Image_Buffer_Register = instruction[43:22];
                Resize_Reg_1 = instruction[21:11];
                Resize_Reg_2 = instruction[10:0];
              end
            
            default:
              begin
                Store_or_load_address = 22'bxxxxxxxxxxxxxxxxxxxxxx;
                Data_register_or_address = 22'bxxxxxxxxxxxxxxxxxxxxxx;
                Image_Buffer_Register = 22'bxxxxxxxxxxxxxxxxxxxxxx;
                Resize_Reg_1 = 11'bxxxxxxxxxxx;
                Resize_Reg_2 = 11'bxxxxxxxxxxx;
              end
          endcase
          
        end
    end
endmodule