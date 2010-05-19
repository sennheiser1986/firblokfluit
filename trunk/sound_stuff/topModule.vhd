----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:55 05/19/2010 
-- Design Name: 
-- Module Name:    topModule - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity topModule is
    Port ( Clk : in  STD_LOGIC;
           Clk_en : in  STD_LOGIC;
           Reset_n : in  STD_LOGIC;
           ac97_sdata_i : in  STD_LOGIC;
           ac97_bitclk : in  STD_LOGIC;
           L_o : in  STD_LOGIC_VECTOR (15 downto 0);
           R_o : in  STD_LOGIC_VECTOR (15 downto 0);
           cmd_addr : in  STD_LOGIC;
           cmd_data : in  STD_LOGIC;
           Frequency : out  STD_LOGIC_VECTOR (10 downto 0));
end topModule;

architecture Structure of topModule is

begin

component ZeroCrossingsDetector

end Structure;

