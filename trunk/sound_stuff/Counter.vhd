library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library Const_lib;
use Const_lib.Constants_pack.all;

ENTITY Counter IS
	PORT (
		ready               : in std_logic;
		StartCounter    	  : in std_logic;
		CrossingDetected    : in std_logic;
		Count               : out std_logic_vector(15 DOWNTO 0);
		ReachedTarget       : out std_logic
	);
end Counter;

architecture behav of Counter is
	signal count_usig: unsigned(15 downto 00);
	signal reached_target: std_logic;
	signal reqCrossings: unsigned(15 downto 0);
	
	begin
	
	process(ready)
	begin
	if rising_edge(ready) then
		if CrossingDetected = '1' and reached_target = '0' then
			count_usig <= count_usig+1;
		end if;
	end if;
	if count_usig = reqCrossings then
		reached_target <= '1' ;
	end if;
	end process;
	
	Count <= std_logic_vector(count_usig);
	
	
	
	ReachedTarget <= reached_target;
end behav;