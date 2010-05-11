library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library Const_lib;
use Const_lib.Constants_pack.all;

ENTITY Counter IS
	PORT (
		ready               : in std_logic;
		StartCounter    	: in std_logic;
		Count               : out std_logic_vector(15 DOWNTO 0);
		ReachedTarget       : out std_logic;
		
	);
end Counter;

architecture behav of Counter is
	signal count_usig: unsigned(15 downto 00);
	
	begin
	
	process(sampleClk, ReachedTarget)
	begin
	if rising_edge(sampleClk) then
		if CrossingDetected and ReachedTarget = '0' then
			count_usig <= count_usig+1;
		end if;
	end if;
	end process;
	
	Count <= std_logic_vector(count_usig);
	
	if Count = reqCrossings then
		ReachedTarget <= '1' ;
	end if;
	
end behav;