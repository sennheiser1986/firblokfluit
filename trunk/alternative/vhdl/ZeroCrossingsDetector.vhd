library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY ZeroCrossingsDetector IS
	PORT (
		ready               : in std_logic;
		Filter_out          : in std_logic_vector(15 DOWNTO 0)  -- sfix16_En10
		CrossingDetected    : out std_logic;
	);
end ZeroCrossingsDetector;


architecture behav of ZeroCrossingsDetector is
	signal prevSample, currSample  : std_logic_vector(15 DOWNTO 0) ;
	signal posPrevSign,posCurrSign : boolean;
	
	begin
	
	currSample <= Filter_out;
	
	process(ready)
	begin
	if rising_edge(ready) then
		if abs(prevSamp)>threshold and abs(currSample)>threshold then
			if prevSample>Threshold then
				posPrevSign <= '1';
			end if;
			if prevSample<-Threshold then
				posPrevSign <= '0';
			end if;
			
			if currSample>Threshold then
				posCurrSign <= '1';
			end if;
			if currSample<-Threshold then
				posCurrSign <= '0';
			end if;
			
			if NOT(posPrevSign = posCurrSign) then
				CrossingDetected <= '1';
			else
				CrossingDetected <= '0';
			end if;
		 else
			CrossingDetected <= '0';
		 end if;
		 prevSample <= currSample;
	 end if;
	 end process;
	 

end behav;
	 
		