LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity FSM is 
port(i_clk,i_resetBar: IN STD_LOGIC;
     i_load : IN std_logic;
     i_SSCS,i_MSC,i_SSC : IN std_logic;
	  i_MST,i_SST : IN std_logic;
	  o_MSTL,o_SSTL : OUT std_logic_vector(2 downto 0);
	  o_reset, o_sw: OUT STD_LOGIC);
end FSM;

architecture RTL of FSM is
	signal int_D,int_C,int_B,int_A:STD_LOGIC;
	signal int_DN,int_CN,int_BN,int_AN: STD_LOGIC;
	
	component enARdFF_2 IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	END component;
	
	
begin
	int_AN<=(int_D and i_SST)or (int_A and not i_SSCS and i_MSC) or (int_A and not i_SSCS and not i_MSC);
	int_BN<=(int_A and i_SSCS) or (int_B or not i_MST);
	int_CN<=(int_C and not i_SSC) or (int_B and i_MST);
	int_DN<=(int_D and not i_SST) or (int_C and i_SSC);
	
reg_A: enARdFF_2
	port map (i_resetBar => i_resetBar,
					i_d => int_AN,
					i_enable => '1',
					i_clock => i_clk,
					o_q => int_A);
					
reg_B: enARdFF_2
	port map (i_resetBar => i_resetBar,
				i_d => int_BN,
				i_enable => '1',
				i_clock => i_clk,
				o_q=> int_B);

reg_C: enARdFF_2
	port map (i_resetBar => i_resetBar,
				i_d => int_CN,
				i_enable => '1',
				i_clock => i_clk,
				o_q => int_C);
reg_D: enARdFF_2
	port map (i_resetBar => i_resetBar,
				i_d => int_DN,
				i_enable => '1',
				i_clock => i_clk,
				o_q => int_D);


o_MSTL(2)<=(int_C) or (int_D and not i_SST) or (int_B and i_MST);
o_MSTL(1)<=(int_A and i_SSCS and i_MSC) or (int_B and not i_MST);
o_MSTL(0)<=(int_A and not i_SSCS and not i_MSC) or (int_D and i_SST);

o_SSTL(2)<=(int_A) or (int_B and not i_MST) or (int_D and i_SST);
o_SSTL(1)<=(int_C and i_SSC) or (int_D and not i_SST);
o_SSTL(0)<=(int_B and i_MST) or (int_C and not i_SSC);	

end architecture;
