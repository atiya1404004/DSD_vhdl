-- fpga4student.com: FPGA Projects, Verilog projects, VHDL projects 
-- Testbench VHDL code for ALU
-- @fpga4student
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_ALU IS
END tb_ALU;
 
ARCHITECTURE behavior OF tb_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         ALU_Sel : IN  std_logic_vector(3 downto 0);
         ALU_Out : OUT  std_logic_vector(7 downto 0);
         overflow,zero,sign,Carryout : OUT  std_logic
        );
    END COMPONENT;
       --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal ALU_Sel : std_logic_vector(3 downto 0) := (others => '0');

  --Outputs
   signal ALU_Out : std_logic_vector(7 downto 0);
	signal overflow : std_logic;
	signal zero : std_logic;
	signal sign : std_logic;
   signal Carryout : std_logic;
 
-- signal i:integer;
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          ALU_Sel => ALU_Sel,
          ALU_Out => ALU_Out,
			 overflow => overflow,
			 zero => zero,
			 sign => sign,
          Carryout => Carryout
        );

   -- Stimulus process
   stim_proc: process
   begin  
      -- hold reset state for 100 ns.
      A <= x"AA";
  B <= x"80";
  ALU_Sel <= x"0";
  wait for 50 ns;
--  for i in 0 to 15 loop 
--   ALU_Sel <= ALU_Sel + x"1";
--   wait for 100 ns;
--  end loop;
  A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"1";
  wait for 50 ns;
  A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"2";
  wait for 50 ns;
   A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"3";
  wait for 50 ns;
   A <= x"8A";
  B <= x"02";
  ALU_Sel <= x"4";
  wait for 50 ns;
     A <= x"0B";
  B <= x"02";
  ALU_Sel <= x"5";
  wait for 50 ns;
     A <= x"8A";
  B <= x"02";
  ALU_Sel <= x"6";
  wait for 50 ns;
     A <= x"0B";
  B <= x"02";
  ALU_Sel <= x"7";
  wait for 50 ns;
     A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"8";
  wait for 50 ns;
     A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"9";
  wait for 50 ns;
     A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"A";
  wait for 50 ns;
     A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"B";
  wait for 50 ns;
     A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"C";
  wait for 50 ns;
     A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"D";
  wait for 50 ns;
   A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"E";
  wait for 50 ns;
   A <= x"0A";
  B <= x"02";
  ALU_Sel <= x"F";
  wait for 50 ns;

 A <= x"0F";
 B <= x"0F";
     wait;
   end process;

END;