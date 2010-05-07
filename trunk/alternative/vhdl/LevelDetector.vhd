ENTITY LevelDetector IS
	PORT (
		SignalIn            : in std_logic;
		StartCounter    : out boolean;
		
	);
end LevelDetector;

architecture behav of LevelDetector is
	
	begin
	StartCounter <= abs(SignalIn)>threshold;

end behav;
