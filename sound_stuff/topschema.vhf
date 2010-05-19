--------------------------------------------------------------------------------
-- Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 10.1.03
--  \   \         Application : sch2vhdl
--  /   /         Filename : topschema.vhf
-- /___/   /\     Timestamp : 05/19/2010 16:43:18
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2vhdl.exe -intstyle ise -family virtex2p -flat -suppress -w "G:/School sem2/LabMMPDS/firblokfluit/sound_stuff/topschema.sch" topschema.vhf
--Design Name: topschema
--Device: virtex2p
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesis and simulted, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity topschema is
   port ( ac97_bitclk  : in    std_logic; 
          ac97_sdata_i : in    std_logic; 
          Clk          : in    std_logic; 
          Clk_en       : in    std_logic; 
          cmd_addr     : in    std_logic_vector (7 downto 0); 
          cmd_data     : in    std_logic_vector (15 downto 0); 
          L_o          : in    std_logic_vector (15 downto 0); 
          Reset_en     : in    std_logic; 
          R_o          : in    std_logic_vector (15 downto 0); 
          Frequency    : out   std_logic_vector (10 downto 0));
end topschema;

architecture BEHAVIORAL of topschema is
   signal XLXN_24      : std_logic_vector (15 downto 0);
   signal XLXN_25      : std_logic_vector (15 downto 0);
   signal XLXN_28      : std_logic;
   signal XLXN_29      : std_logic;
   signal XLXN_30      : std_logic;
   signal XLXN_33      : std_logic;
   signal XLXN_36      : std_logic_vector (15 downto 0);
   signal XLXN_37      : std_logic_vector (15 downto 0);
   component dc97
      port ( reset_n      : in    std_logic; 
             clk          : in    std_logic; 
             ac97_sdata_i : in    std_logic; 
             ac97_bitclk  : in    std_logic; 
             L_o          : in    std_logic_vector (15 downto 0); 
             R_o          : in    std_logic_vector (15 downto 0); 
             cmd_addr     : in    std_logic_vector (7 downto 0); 
             cmd_data     : in    std_logic_vector (15 downto 0); 
             ac97_sdata_o : out   std_logic; 
             ac97_sync    : out   std_logic; 
             ac97_reset   : out   std_logic; 
             ready        : out   std_logic; 
             L_i          : out   std_logic_vector (15 downto 0); 
             R_i          : out   std_logic_vector (15 downto 0));
   end component;
   
   component filter
      port ( ready      : in    std_logic; 
             clk_en     : in    std_logic; 
             reset_n    : in    std_logic; 
             R_i        : in    std_logic_vector (15 downto 0); 
             filter_out : out   std_logic_vector (15 downto 0));
   end component;
   
   component FreqCalc
      port ( SampleTime : in    std_logic_vector (15 downto 0); 
             Count      : in    std_logic_vector (15 downto 0); 
             Frequency  : out   std_logic_vector (10 downto 0));
   end component;
   
   component LevelDetector
      port ( Filter_out   : in    std_logic_vector (15 downto 0); 
             StartCounter : out   std_logic);
   end component;
   
   component Timer
      port ( Clk           : in    std_logic; 
             StartCounter  : in    std_logic; 
             ReachedTarget : in    std_logic; 
             SampleTime    : out   std_logic_vector (15 downto 0));
   end component;
   
   component ZeroCrossingsDetector
      port ( ready            : in    std_logic; 
             Filter_out       : in    std_logic_vector (15 downto 0); 
             CrossingDetected : out   std_logic);
   end component;
   
   component Counter
      port ( ready            : in    std_logic; 
             StartCounter     : in    std_logic; 
             CrossingDetected : in    std_logic; 
             ReachedTarget    : out   std_logic; 
             Count            : out   std_logic_vector (15 downto 0));
   end component;
   
begin
   XLXI_1 : dc97
      port map (ac97_bitclk=>ac97_bitclk,
                ac97_sdata_i=>ac97_sdata_i,
                clk=>Clk,
                cmd_addr(7 downto 0)=>cmd_addr(7 downto 0),
                cmd_data(15 downto 0)=>cmd_data(15 downto 0),
                L_o(15 downto 0)=>L_o(15 downto 0),
                reset_n=>Reset_en,
                R_o(15 downto 0)=>R_o(15 downto 0),
                ac97_reset=>open,
                ac97_sdata_o=>open,
                ac97_sync=>open,
                L_i=>open,
                ready=>XLXN_30,
                R_i(15 downto 0)=>XLXN_24(15 downto 0));
   
   XLXI_2 : filter
      port map (clk_en=>Clk_en,
                ready=>XLXN_30,
                reset_n=>Reset_en,
                R_i(15 downto 0)=>XLXN_24(15 downto 0),
                filter_out(15 downto 0)=>XLXN_25(15 downto 0));
   
   XLXI_3 : FreqCalc
      port map (Count(15 downto 0)=>XLXN_36(15 downto 0),
                SampleTime(15 downto 0)=>XLXN_37(15 downto 0),
                Frequency(10 downto 0)=>Frequency(10 downto 0));
   
   XLXI_4 : LevelDetector
      port map (Filter_out(15 downto 0)=>XLXN_25(15 downto 0),
                StartCounter=>XLXN_29);
   
   XLXI_5 : Timer
      port map (Clk=>Clk,
                ReachedTarget=>XLXN_33,
                StartCounter=>XLXN_29,
                SampleTime(15 downto 0)=>XLXN_37(15 downto 0));
   
   XLXI_6 : ZeroCrossingsDetector
      port map (Filter_out(15 downto 0)=>XLXN_25(15 downto 0),
                ready=>XLXN_30,
                CrossingDetected=>XLXN_28);
   
   XLXI_7 : Counter
      port map (CrossingDetected=>XLXN_28,
                ready=>XLXN_30,
                StartCounter=>XLXN_29,
                Count(15 downto 0)=>XLXN_36(15 downto 0),
                ReachedTarget=>XLXN_33);
   
end BEHAVIORAL;


