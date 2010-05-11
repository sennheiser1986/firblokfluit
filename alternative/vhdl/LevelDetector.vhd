library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library Const_lib;
use Const_lib.Constants_pack.all;

ENTITY LevelDetector IS
	PORT (
		Filter_out      : in std_logic_vector(15 DOWNTO 00);
		StartCounter    : out std_logic;
		
	);
end LevelDetector;

architecture behav of LevelDetector is
	
	begin
	if(abs(Filter_out)>threshold)
		StartCounter <= '1';
	else 
		StartCounter <= '0';
	end if;
end behav;
