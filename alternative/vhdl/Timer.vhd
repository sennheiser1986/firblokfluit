ENTITY Timer IS
	PORT (
		SampleClk                 : in std_logic;
		StartCounter    	  : in boolean;
		ReachedTarget       : in boolean;
		SampleTime          : out std_logic;
		
	);
end Timer;

architecture behav of Timer is
	
	
	process(sampleClk)
	begin
	if rising_edge(sampleClk) and NOT(ReachedTarget) then
		if StartCounter then
			SampleTime <= SampleTime + 1;
		end if;
	end if;
	
end behav;