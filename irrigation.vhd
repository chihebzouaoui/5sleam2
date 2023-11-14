library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity irrigation is
port( 
M_Humidite         : in  STD_LOGIC_VECTOR (6 downto 0);
M_l_manuelle       : in  STD_LOGIC;
M_Seuil_temp       : in  STD_LOGIC_VECTOR (4 downto 0);
M_Seuils_Hum       : in  STD_LOGIC_VECTOR (13 downto 0);
M_Temperature      : in  STD_LOGIC_VECTOR (4 downto 0);
M_temps_manuel     : in  STD_LOGIC_VECTOR (2 downto 0);
M_niveau_eau       : in STD_LOGIC;
M_ph_sol           : in STD_LOGIC_VECTOR (2 downto 0);
M_clk					 : in std_LOGIC ;	
M_rst              : in std_LOGIC ;
S_alarme_HI        : out STD_LOGIC;
S_alarme_HS        : out STD_LOGIC;
S_alarme_T         : out STD_LOGIC;
S_fin              : out std_logic;
S_pompe            : out std_logic;
S_ventilo          : out std_logic;
S_alarme_NE        : out std_LOGIC;
S_alarme_PH        : out std_LOGIC
);end irrigation;

architecture rtl of irrigation is

component surveillance
port( 
Humidite    : in STD_LOGIC_VECTOR (6 downto 0);
Seuil_temp  : in STD_LOGIC_VECTOR (4 downto 0);
Seuils_Hum  : in STD_LOGIC_VECTOR (13 downto 0);
Temperature : in STD_LOGIC_VECTOR (4 downto 0);
alarme_T    : out STD_LOGIC;
alarme_HI   : out STD_LOGIC;
alarme_HS   : out STD_LOGIC;
refroidir   : out STD_LOGIC;	
irriguer    : out STD_LOGIC;
clk         : in std_LOGIC;
rst         : in std_LOGIC
);end component;

component Activation
port( 
pompe_actif   : in std_logic;
ventilo_actif : in std_logic;
fin           : out std_logic;
pompe         : out std_logic;
ventilo       : out std_logic;
clk           : in std_logic;
rst           : in std_logic
);end component;

component Controle
port( 
niveau_eau : in STD_LOGIC;
ph_sol     : in STD_LOGIC_VECTOR (2 downto 0);
alarme_NE  : out std_LOGIC;
alarme_PH  : out std_LOGIC;
clk        : in std_LOGIC;
rst        : in std_LOGIC
);end component;

component Temps
port( 
humidite      : in  STD_LOGIC_VECTOR (6 downto 0);
l_manuelle    : in  STD_LOGIC;
Seuil_temp    : in  STD_LOGIC_VECTOR (4 downto 0);
Seuils_Hum    : in  STD_LOGIC_VECTOR (13 downto 0);
Temperature   : in  STD_LOGIC_VECTOR (4 downto 0);
temps_manuel  : in  STD_LOGIC_VECTOR (2 downto 0);
refroidir     : in STD_LOGIC;
irriguer      : in STD_LOGIC;
pompe_actif   : out STD_LOGIC;
ventilo_actif : out STD_LOGIC;
clk           : in std_LOGIC ;
rst           : in std_LOGIC 
);end component;

signal I_refroidir     : STD_LOGIC;
signal I_irriguer      : STD_LOGIC;
signal I_pompe_actif   : STD_LOGIC;
signal I_ventilo_actif :  STD_LOGIC;

begin
C_Temps : Temps port map (M_Humidite ,M_l_manuelle,M_Seuil_temp ,M_Seuils_Hum,M_Temperature,M_temps_manuel,I_refroidir,I_irriguer,I_pompe_actif,I_ventilo_actif,M_clk,M_rst);
C_surveillance: surveillance port map (M_Humidite ,M_Seuil_temp ,M_Seuils_Hum,M_Temperature,S_alarme_T,S_alarme_HI,S_alarme_HS,I_refroidir,I_irriguer,M_clk,M_rst);
C_Activation : Activation port map (I_pompe_actif,I_ventilo_actif,S_fin,S_pompe,S_ventilo,M_clk,M_rst);
C_Controle : Controle port map (M_niveau_eau,M_ph_sol,S_alarme_NE,S_alarme_PH,M_clk,M_rst);
end rtl;
