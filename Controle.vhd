library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Controle is
port(
ph_sol : in STD_LOGIC_VECTOR (2 downto 0);
niveau_eau : in STD_LOGIC;
alarme_NE : out std_LOGIC;
alarme_PH : out std_LOGIC;
clk : in std_LOGIC;
rst : in std_LOGIC
);end Controle;

architecture Behavioral of Controle is
begin
process(clk,rst)
begin
 if rst = '1' then         
alarme_NE <= '0';
alarme_PH <= '0';
elsif(clk'event and clk = '1') then 
     if(niveau_eau='1')then
	  alarme_NE<='1';
	  else
	  alarme_NE<='0';
	  end if;
	  if(TO_INTEGER(UNSIGNED(ph_sol)) > 7)then
	  alarme_PH<='1';
	  else
	  alarme_PH<='0';
	  end if;
	  
end if;
end process;
end Behavioral;