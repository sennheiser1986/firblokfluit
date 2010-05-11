library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY Timer IS
	PORT (
		Clk                 : in std_logic;
		StartCounter    	: in std_logic;
		ReachedTarget       : in std_logic;
		SampleTime          : out std_logic;
		
	);
end Timer;

architecture behav of Timer is
	signal sampleTime_usig : unsigned(15 downto 0);
	
	begin
	
	process(Clk, ReachedTarget)
	begin
	if rising_edge(Clk) and (ReachedTarget = '0') then
		if StartCounter then
			sampleTime_usig <= sampleTime_usig + 1;
		end if;
	end if;	
	end process;
	
	SampleTime <= std_logic_vector(sampleTime_usig);
	
end behav;