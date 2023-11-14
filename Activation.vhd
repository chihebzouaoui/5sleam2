library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Activation is
port(
clk,rst,pompe_actif,ventilo_actif : in std_logic;
fin,pompe,ventilo : out std_logic

);end Activation;

architecture rtl of Activation is

type state is (debut, pompe_marche, pompe_termine, ventilo_terminee ,ventilo_marche);
signal present,futur : state;

begin

R : process(clk,rst)
begin
 if rst = '1' then
  present <= debut;
 elsif (clk ='1' and clk'event) then
  present <= futur;
 end if;
end process R;

A : process(present,pompe_actif,ventilo_actif)
begin
 case (present) is
    when debut =>
	   pompe <='0';
		ventilo <='0';
		fin <= '0';
	 if (pompe_actif = '1') then
	  pompe <= '1';
	  ventilo <='0';
	  fin <='0';
	  futur <= pompe_marche;
	 elsif(pompe_actif = '0' and ventilo_actif = '1' ) then
	  pompe <= '0';
	  ventilo <='1';
	  fin <='0';
     futur <= ventilo_marche;
	  else 
	  futur <= debut;
	 end if;
	 
   when pompe_marche =>
	if (pompe_actif = '0') then
	  pompe <= '1';
	  ventilo <='0';
	  fin <='1';
	  futur <= pompe_termine;
	  else
	  futur <= pompe_marche;
	 end if;
	 
	when ventilo_marche =>
	if (ventilo_actif = '0') then
	  pompe <= '0';
	  ventilo <='1';
	  fin <='1';
	  futur <= ventilo_terminee;
	  else
	  futur <= ventilo_marche;
	 end if;
	 
	when pompe_termine =>
	if (ventilo_actif = '1') then
	  pompe <= '0';
	  ventilo <='1';
	  fin <='0';
	  futur <= ventilo_marche;
	  else
	  futur <= debut;
	 end if;
	 
   when others =>
	 futur <= debut; 
	 
end case;
end process A;
end rtl;
