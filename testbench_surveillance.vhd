library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_surveillance is
end test_surveillance;

architecture rtl of test_surveillance is

component surveillance 
port(
Humidite : in STD_LOGIC_VECTOR (6 downto 0);
Seuil_temp : in STD_LOGIC_VECTOR (4 downto 0);
Seuils_Hum : in STD_LOGIC_VECTOR (13 downto 0);
Temperature : in STD_LOGIC_VECTOR (4 downto 0);
alarme_T : out STD_LOGIC;
alarme_HI : out STD_LOGIC;
alarme_HS : out STD_LOGIC;
refroidir : out STD_LOGIC;
irriguer : out STD_LOGIC;
clk : in std_LOGIC;
rst : in std_LOGIC

);end component;

signal Humidite1 : STD_LOGIC_VECTOR (6 downto 0);
signal Seuil_temp1 : STD_LOGIC_VECTOR (4 downto 0);
signal Seuils_Hum1 : STD_LOGIC_VECTOR (13 downto 0);
signal Temperature1 : STD_LOGIC_VECTOR (4 downto 0);
signal alarme_T1 , alarme_HI1 , alarme_HS1 , refroidir1 , irriguer1 : std_logic;
signal clk1 :  std_logic := '0';
signal rst1 : std_LOGIC;

begin

DUT : surveillance port map(Humidite1 , Seuil_temp1 , Seuils_Hum1 , Temperature1 , alarme_T1 , alarme_HI1 , alarme_HS1 , refroidir1 , irriguer1 , clk1 , rst1);
clk1 <= not clk1 after 20 ns;

process
begin
 rst1 <= '0';
 alarme_T1 <= '0';
 refroidir1 <= '0';
 wait for 50 ns;
 
  rst1 <= '1';
 alarme_T1 <= '1';
 refroidir1 <= '1';
 wait for 50 ns;
 
 rst1 <= '1';
 alarme_T1 <= '0';
 refroidir1 <= '0';
 wait for 50 ns;
 
 rst1 <= '0';
 alarme_HI1 <= '1';
 irriguer1 <= '1';
 wait for 50 ns;
 
 rst1 <= '1';
 alarme_HI1 <= '1';
 irriguer1 <= '1';
 wait for 50 ns;
 
 rst1 <= '1';
 alarme_HI1 <= '0';
 irriguer1 <= '0';
 wait for 50 ns;
 
 rst1 <= '0';
 alarme_HI1 <= '0';
 irriguer1 <= '0';
 wait for 50 ns;
 
 rst1 <= '1';
 alarme_HS1 <= '1';
 wait for 50 ns;
 
 rst1 <= '1';
 alarme_HS1 <= '0';
 wait for 50 ns;
 
 rst1 <= '0';
 alarme_HS1 <= '1';
 
 rst1 <= '0';
 alarme_HS1 <= '0';
 wait for 100 ns; 

end process;
end rtl;