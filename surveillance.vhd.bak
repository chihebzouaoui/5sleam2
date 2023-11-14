library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity surveillance is
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
);end surveillance;


architecture Behavioral of surveillance is
begin
process(clk,rst)
begin
 if rst = '1' then         
alarme_T <= '0';
alarme_HI <= '0';
alarme_HS <= '0';
refroidir <= '0';
irriguer <= '0';
elsif(clk'event and clk = '1') then 
     
if Temperature > Seuil_temp then
	alarme_T <= '1';
	refroidir <='1';
	
end if;

if Humidite < Seuils_Hum(6 downto 0) then
	alarme_HI <= '1';
	irriguer <='1';
end if;

if Humidite > Seuils_Hum(13 downto 7) then
	alarme_HS <= '1';
end if;

end if;
end process;
end Behavioral;
