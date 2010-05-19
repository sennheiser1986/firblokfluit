--------------------------------------------------------------------------------
-- Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 10.1.03
--  \   \         Application : sch2vhdl
--  /   /         Filename : schema.vhf
-- /___/   /\     Timestamp : 05/19/2010 14:52:07
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2vhdl.exe -intstyle ise -family virtex2p -flat -suppress -w "G:/School sem2/LabMMPDS/firblokfluit/sound_stuff/schema.sch" schema.vhf
--Design Name: schema
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

entity schema is
   port ( );
end schema;

architecture BEHAVIORAL of schema is
   signal XLXN_2                         : std_logic_vector (15 downto 0);
   signal XLXN_12                        : std_logic_vector (15 downto 0);
   signal XLXN_20                        : std_logic;
   signal XLXN_23                        : std_logic_vector (15 downto 0);
   signal XLXN_24                        : std_logic_vector (15 downto 0);
   signal XLXN_25                        : std_logic;
   signal XLXN_26                        : std_logic;
   signal XLXN_28                        : std_logic;
   signal XLXI_1_ac97_bitclk_openSignal  : std_logic;
   signal XLXI_1_ac97_sdata_i_openSignal : std_logic;
   signal XLXI_1_clk_openSignal          : std_logic;
   signal XLXI_1_cmd_addr_openSignal     : std_logic_vector (7 downto 0);
   signal XLXI_1_cmd_data_openSignal     : std_logic_vector (15 downto 0);
   signal XLXI_1_L_o_openSignal          : std_logic_vector (15 downto 0);
   signal XLXI_1_reset_n_openSignal      : std_logic;
   signal XLXI_1_R_o_openSignal          : std_logic_vector (15 downto 0);
   signal XLXI_2_clk_en_openSignal       : std_logic;
   signal XLXI_2_reset_n_openSignal      : std_logic;
   signal XLXI_6_Clk_openSignal          : std_logic;
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
   
   component LevelDetector
      port ( Filter_out   : in    std_logic_vector (15 downto 0); 
             StartCounter : out   std_logic);
   end component;
   
   component ZeroCrossingsDetector
      port ( ready            : in    std_logic; 
             Filter_out       : in    std_logic_vector (15 downto 0); 
             CrossingDetected : out   std_logic);
   end component;
   
   component Timer
      port ( Clk           : in    std_logic; 
             StartCounter  : in    std_logic; 
             ReachedTarget : in    std_logic; 
             SampleTime    : out   std_logic_vector (15 downto 0));
   end component;
   
   component Counter
      port ( ready            : in    std_logic; 
             StartCounter     : in    std_logic; 
             CrossingDetected : in    std_logic; 
             ReachedTarget    : out   std_logic; 
             Count            : out   std_logic_vector (15 downto 0));
   end component;
   
   component FreqCalc
      port ( SampleTime : in    std_logic_vector (15 downto 0); 
             Count      : in    std_logic_vector (15 downto 0); 
             Frequency  : out   std_logic_vector (10 downto 0));
   end component;
   
begin
   XLXI_1 : dc97
      port map (ac97_bitclk=>XLXI_1_ac97_bitclk_openSignal,
                ac97_sdata_i=>XLXI_1_ac97_sdata_i_openSignal,
                clk=>XLXI_1_clk_openSignal,
                cmd_addr(7 downto 0)=>XLXI_1_cmd_addr_openSignal(7 downto 0),
                cmd_data(15 downto 0)=>XLXI_1_cmd_data_openSignal(15 downto 0),
                L_o(15 downto 0)=>XLXI_1_L_o_openSignal(15 downto 0),
                reset_n=>XLXI_1_reset_n_openSignal,
                R_o(15 downto 0)=>XLXI_1_R_o_openSignal(15 downto 0),
                ac97_reset=>open,
                ac97_sdata_o=>open,
                ac97_sync=>open,
                L_i=>open,
                ready=>XLXN_28,
                R_i(15 downto 0)=>XLXN_2(15 downto 0));
   
   XLXI_2 : filter
      port map (clk_en=>XLXI_2_clk_en_openSignal,
                ready=>XLXN_28,
                reset_n=>XLXI_2_reset_n_openSignal,
                R_i(15 downto 0)=>XLXN_2(15 downto 0),
                filter_out(15 downto 0)=>XLXN_12(15 downto 0));
   
   XLXI_3 : LevelDetector
      port map (Filter_out(15 downto 0)=>XLXN_12(15 downto 0),
                StartCounter=>XLXN_20);
   
   XLXI_4 : ZeroCrossingsDetector
      port map (Filter_out(15 downto 0)=>XLXN_12(15 downto 0),
                ready=>XLXN_28,
                CrossingDetected=>XLXN_26);
   
   XLXI_6 : Timer
      port map (Clk=>XLXI_6_Clk_openSignal,
                ReachedTarget=>XLXN_25,
                StartCounter=>XLXN_20,
                SampleTime(15 downto 0)=>XLXN_23(15 downto 0));
   
   XLXI_7 : Counter
      port map (CrossingDetected=>XLXN_26,
                ready=>XLXN_28,
                StartCounter=>XLXN_20,
                Count(15 downto 0)=>XLXN_24(15 downto 0),
                ReachedTarget=>XLXN_25);
   
   XLXI_8 : FreqCalc
      port map (Count(15 downto 0)=>XLXN_24(15 downto 0),
                SampleTime(15 downto 0)=>XLXN_23(15 downto 0),
                Frequency=>open);
   
end BEHAVIORAL;


