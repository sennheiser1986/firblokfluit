library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library Const_lib;
use Const_lib.Constants_pack.all;

ENTITY FreqCalc IS
	PORT (
		SampleTime          : in std_logic_vector(15 DOWNTO 0);
		Count               : in std_logic_vector(15 DOWNTO 0);
		Frequency           : out std_logic_vector(10 DOWNTO 0);;
		
	);
end FreqCalc;

architecture behav of FreqCalc is	
	Frequency <= ((Count/2)/SampleTime)*ClockFrequency;
end behav;