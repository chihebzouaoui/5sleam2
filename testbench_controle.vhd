library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_controle is
end test_controle;

architecture rtl of test_controle is

component Controle 
port(
ph_sol : in STD_LOGIC_VECTOR (2 downto 0);
niveau_eau : in STD_LOGIC;
alarme_NE : out std_LOGIC;
alarme_PH : out std_LOGIC;
clk : in std_LOGIC;
rst : in std_LOGIC
);end component;

signal ph_sol1 : STD_LOGIC_VECTOR (2 downto 0);
signal niveau_eau1 : STD_LOGIC;
signal alarme_NE1 : std_LOGIC;
signal alarme_PH1 : std_LOGIC;
signal clk1 : std_LOGIC;
signal rst1 : std_LOGIC;

begin
DUT : Controle port map(ph_sol1 , niveau_eau1 , alarme_NE1 , alarme_PH1 , clk1 , rst1);
clk1 <= not clk1 after 20 ns;

process
begin

rst1 <= '0';
wait for 50 ns;

rst1 <= '1';
wait for 50 ns;

rst1 <= '0';
ph_sol1 <="000";
niveau_eau1 <= '0';
wait for 50 ns;

rst1 <= '0';
ph_sol1 <= "001";
niveau_eau1 <= '0';
wait for 50 ns;

rst1 <= '0';
ph_sol1 <= "000";
niveau_eau1 <= '1';
wait for 50 ns;

rst1 <='0';
ph_sol1 <="111";
niveau_eau1 <='0';
wait for 50 ns;

rst1 <= '0';
ph_sol1 <= "010";
niveau_eau1 <= '0';
wait for 50 ns;

rst1 <= '1';
ph_sol1 <= "000" ;
niveau_eau1 <= '0';
wait for 50 ns;


rst1 <= '1';
ph_sol1 <= "111";
niveau_eau1 <= '1';
wait for 50 ns;

rst1 <='1';
ph_sol1 <="111";
niveau_eau1 <='0';
wait for 50 ns;


rst1 <= '1';
ph_sol1 <= "000";
niveau_eau1 <= '1';
wait for 100 ns;

end process;
end rtl;