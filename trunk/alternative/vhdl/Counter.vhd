ENTITY Counter IS
	PORT (
		SampleClk                 : in std_logic;
		SignalIn            : in std_logic;
		StartCounter    	  : in boolean;
		Count               : out std_logic;
		ReachedTarget       : out boolean;
		
	);
end Counter;

architecture behav of Counter is
	
	
	process(sampleClk)
	begin
	if rising_edge(sampleClk) then
		if CrossingDetected and ReachedTarget = '0' then
			Count <= Count+1;
		end if;
	end if;
	
	if Count = reqCrossings then
		ReachedTarget <= '1' ;
	end if;
	
end behav;