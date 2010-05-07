ENTITY SampleClkGen IS
	PORT (
		Clk          : in std_logic;
		SampleClk    : out std_logic;
		
	);
end SampleClkGen;

architecture behav of SampleClkGen is
	
	process(clk)
	begin
	if rising_edge(clk) then
		count <= count + 1;
	end if;
	if count >= (ClockFrequency/SampleFrequency) then
		count <= 0;
	end if;
	if count < (ClockFrequency/SampleFrequency)/2 then
		SampleClk <= '1';
	else
		SampleClk <= '0';
	end if;
	
end behav;