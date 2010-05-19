library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library Const_lib;
use Const_lib.Constants_pack.all;

ENTITY FreqCalc IS
	PORT (
		SampleTime          : in std_logic_vector(15 DOWNTO 0);
		Count               : in std_logic_vector(15 DOWNTO 0);
		Frequency           : out std_logic_vector(10 DOWNTO 0)		
	);
end FreqCalc;

architecture behav of FreqCalc is	
	signal usig_count : unsigned (15 downto 0);
	signal usig_freq  : unsigned (10 downto 0);
	signal usig_time  : unsigned (15 downto 0);

begin
	usig_time  <= unsigned(SampleTime);
	usig_count <= unsigned(Count);
	usig_freq  <= usig_count / 2 / usig_time * ClockFrequency;
	
	Frequency <= std_logic_vector(usig_freq);
end behav;