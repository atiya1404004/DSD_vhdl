-- fpga4student.com: FPGA Projects, Verilog projects, VHDL projects 
-- VHDL code for ALU
-- @fpga4student
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
-----------------------------------------------
---------- ALU 8-bit VHDL ---------------------
-----------------------------------------------
entity ALU is
  generic ( 
     constant N: natural := 1  -- number of shited or rotated bits
    );
  
    Port (
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 2 inputs 8-bit
    ALU_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);  -- 1 input 4-bit for selecting function
    ALU_Out   : out  STD_LOGIC_VECTOR(7 downto 0); -- 1 output 8-bit 
    overflow,zero,sign,Carryout : out std_logic        -- Carryout flag
    );
end ALU; 
architecture Behavioral of ALU is

signal ALU_Result : std_logic_vector (7 downto 0);
signal tmp: std_logic_vector (8 downto 0);

begin
   process(A,B,ALU_Sel)
 begin
  case(ALU_Sel) is
  when "0000" => -- Addition
   ALU_Result <= A + B ; 
  when "0001" => -- Subtraction
   ALU_Result <= A - B ;
  when "0010" => -- Multiplication
   ALU_Result <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),8)) ;
  when "0011" => -- 1's complement
  ALU_Result <= not A;
-- ALU_Result <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),8)) ;
--   ALU_Result <= std_logic_vector(to_unsigned(to_integer(unsigned(A))/to_integer(unsigned(B)),8)) ;
  when "0100" => -- Logical shift left
   ALU_Result <= std_logic_vector(unsigned(A) sll N);
  when "0101" => -- Logical shift right
   ALU_Result <= std_logic_vector(unsigned(A) srl N);
  when "0110" => --  Rotate left
   ALU_Result <= std_logic_vector(unsigned(A) rol N);
  when "0111" => -- Rotate right
   ALU_Result <= std_logic_vector(unsigned(A) ror N);
  when "1000" => -- Logical and 
   ALU_Result <= A and B;
  when "1001" => -- Logical or
   ALU_Result <= A or B;
  when "1010" => -- Logical xor 
   ALU_Result <= A xor B;
  when "1011" => -- Logical nor
   ALU_Result <= A nor B;
  when "1100" => -- Logical nand 
   ALU_Result <= A nand B;
  when "1101" => -- Logical xnor
   ALU_Result <= A xnor B;
  when "1110" => -- Greater comparison
   if(A>B) then
    ALU_Result <= x"01" ;
   else
    ALU_Result <= x"00" ;
   end if; 
  when "1111" => -- Equal comparison   
   if(A=B) then
    ALU_Result <= x"01" ;
   else
    ALU_Result <= x"00" ;
   end if;
  when others => ALU_Result <= A + B ; 
  end case;
 end process;
 ALU_Out <= ALU_Result; -- ALU out
 zero <= '1' when ALU_Result(7 downto 0) = "00000000" else '0'; 
 sign <= ALU_Result(7);
 
 with ALU_Sel select
		overflow <=
			((A(7) nor B(7)) and ALU_Result(7)) or
(A(7) and B(7) and not ALU_Result(7)) when "0000",
(not A(7) and B(7) and ALU_Result(7)) or 
(A(7) and not B(7) and not ALU_Result(7)) when "0001",
'0' when others;
 tmp <= ('0' & A) + ('0' & B);
 Carryout <= tmp(8); -- Carryout flag
end Behavioral;