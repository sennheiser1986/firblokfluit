ENTITY FreqCalc IS
	PORT (
		SampleTime          : in std_logic;
		Count               : in std_logic;
		Frequency           : out std_logic;
		
	);
end FreqCalc;

architecture behav of FreqCalc is
	
	Frequency <= ((Count/2)/SampleTime)/SampleFrequency;
	
end behav;