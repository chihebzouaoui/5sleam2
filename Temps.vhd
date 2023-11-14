library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Temps is
    port (
humidite           : in  STD_LOGIC_VECTOR (6 downto 0);
l_manuelle         : in  STD_LOGIC;
Seuil_temp         : in  STD_LOGIC_VECTOR (4 downto 0);
Seuils_Hum         : in  STD_LOGIC_VECTOR (13 downto 0);
Temperature        : in  STD_LOGIC_VECTOR (4 downto 0);
temps_manuel : in  STD_LOGIC_VECTOR (2 downto 0);
clk, rst           : in std_LOGIC ;
refroidir          : in STD_LOGIC;
irriguer           : in STD_LOGIC;
pompe_actif        : out STD_LOGIC;
ventilo_actif      : out STD_LOGIC
);end Temps;

architecture Behavioral of Temps is

begin
    process (clk, rst)
    begin
        if rst = '1' then         
            pompe_actif <= '0';
            ventilo_actif <= '0';
        elsif (clk'event and clk ='1') then
		  
		  if(l_manuelle = '0') then
		  
			if (humidite < seuils_Hum(6 downto 0)) then
            pompe_actif<= '1' ;  
				else
				pompe_actif <= '0' ;
				end if;
				
			if (Humidite < Seuil_temp) then
				ventilo_actif <= '1' ;
				else
				ventilo_actif<= '0' ;
				end if;
				
			else
			pompe_actif <= '1' ;
			pompe_actif <= '0' AFTER (to_integer(unsigned(temps_manuel)) * 1 ns);
			end if;		
			end if;	
    end process;
end Behavioral;