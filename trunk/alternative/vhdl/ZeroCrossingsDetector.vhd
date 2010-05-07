ENTITY ZeroCrossingsDetector IS
	PORT (
		SampleClk                 : in std_logic;
		SignalIn            : in std_logic;
		CrossingDetected    : out boolean;
		
	);
end ZeroCrossingsDetector;


architecture behav of ZeroCrossingsDetector is
	signal  prevSample, currSample : ...
	boolean posPrevSign,posCurrSign
	
	currSample <= SignalIn;
	
	process(sampleclk)
	begin
	if rising_edge(sampleclk) then
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
	 
		