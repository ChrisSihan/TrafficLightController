LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SS_counter IS
	PORT (
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock				: IN	STD_LOGIC;
		o_Value				: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END SS_counter;

ARCHITECTURE rtl OF SS_counter IS
	SIGNAL int_a, int_na, int_b, int_nb, int_c, int_nc, int_d, int_nd : STD_LOGIC;
	SIGNAL int_notA, int_notB, int_notC, int_notD : STD_LOGIC;

	COMPONENT enARdFF_2
		PORT (
			i_resetBar	: IN	STD_LOGIC;
			i_d			: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC
		);
	END COMPONENT;

BEGIN

	-- Concurrent Signal Assignments
	int_na <= (int_a AND (NOT int_b)) OR (int_a AND (NOT int_c)) OR (int_a AND (NOT int_d)) OR ((NOT int_a) AND int_b AND int_c AND int_d);
	int_nb <= (int_b AND (NOT int_d)) OR (int_b AND (NOT int_c)) OR ((NOT int_b) AND int_c AND int_d);
	int_nc <= ((NOT int_c) AND int_d) OR (int_c AND (NOT int_d));
	int_nd <= ((NOT int_c) AND (NOT int_d)) OR (int_c AND (NOT int_d));

	msb: enARdFF_2
	PORT MAP (
		i_resetBar => i_resetBar,
		i_d => int_na,
		i_enable => i_load,
		i_clock => i_clock,
		o_q => int_a,
		o_qBar => int_notA
	);

	second_msb: enARdFF_2
	PORT MAP (
		i_resetBar => i_resetBar,
		i_d => int_nb,
		i_enable => i_load,
		i_clock => i_clock,
		o_q => int_b,
		o_qBar => int_notB
	);

	second_lsb: enARdFF_2
	PORT MAP (
		i_resetBar => i_resetBar,
		i_d => int_nc,
		i_enable => i_load,
		i_clock => i_clock,
		o_q => int_c,
		o_qBar => int_notC
	);

	lsb: enARdFF_2
	PORT MAP (
		i_resetBar => i_resetBar,
		i_d => int_nd,
		i_enable => i_load,
		i_clock => i_clock,
		o_q => int_d,
		o_qBar => int_notD
	);

	-- Output Driver
	o_Value <= int_a & int_b & int_c & int_d;

END rtl;
