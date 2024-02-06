LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

Entity FSM_controller IS
Port(i_clk,i_resetBar : IN std_logic;
     i_load : IN std_logic;
     i_SSCS,i_MSC,i_SSC : IN std_logic;
	  i_MST,i_SST : IN std_logic;
	  o_MSTL,o_SSTL : OUT std_logic_vector(2 downto 0));
END FSM_controller;

ARCHITECTURE Mealy of FSM_controller IS
    type state_type is (A,B,C,D);
	 signal presentState,nextState : state_type;
BEGIN
syncronous_process : process(i_clk)
   BEGIN
	if rising_edge(i_clk)then
	   if(i_resetBar = '0') then
		   presentState <= A;
		else
		   presentState <= nextState;
		end if;
	end if;
   end process;

Process (presentState,i_SSCS,i_MSC,i_SSC,i_MST,i_SST)	
BEGIN	
   case presentState is 
	   when A => if (i_SSCS = '1' and i_MSC = '0') THEN
		             nextState <= A;
						 o_MSTL(2) <= '1';
						 o_MSTL(1) <= '0';
						 o_MSTL(0) <= '0';
						 o_SSTL(2) <= '0';
						 o_SSTL(1) <= '0';
						 o_SSTL(0) <= '1';
					 ELSIF (i_SSCS = '0' and i_MSC = '1') THEN
		             nextState <= B;
						 o_MSTL(2) <= '1';
						 o_MSTL(1) <= '0';
						 o_MSTL(0) <= '0';
						 o_SSTL(2) <= '0';
						 o_SSTL(1) <= '0';
						 o_SSTL(0) <= '1';
					 END if;
		when B => if (i_MST = '1') THEN
						 nextState <= B;		
		             o_MSTL(2) <= '0';
						 o_MSTL(1) <= '1';
						 o_MSTL(0) <= '0';
						 o_SSTL(2) <= '0';
						 o_SSTL(1) <= '0';
						 o_SSTL(0) <= '1';
					 ELSIF (i_MST = '0') THEN
		             nextState <= C;
						 o_MSTL(2) <= '0';
						 o_MSTL(1) <= '1';
						 o_MSTL(0) <= '0';
						 o_SSTL(2) <= '0';
						 o_SSTL(1) <= '0';
						 o_SSTL(0) <= '1';
					 END if;	 
		when C => if (i_SSC = '1') THEN
		             nextState <= C;
						 o_MSTL(2) <= '0';
						 o_MSTL(1) <= '0';
						 o_MSTL(0) <= '1';
						 o_SSTL(2) <= '1';
						 o_SSTL(1) <= '0';
						 o_SSTL(0) <= '0';
					 ELSIF (i_MST = '0') THEN
		             nextState <= D;
						 o_MSTL(2) <= '0';
						 o_MSTL(1) <= '0';
						 o_MSTL(0) <= '1';
						 o_SSTL(2) <= '1';
						 o_SSTL(1) <= '0';
						 o_SSTL(0) <= '0';
					 END if;	 
		when D => if (i_SST = '1') THEN
		             nextState <= D;
						 o_MSTL(2) <= '0';
						 o_MSTL(1) <= '0';
						 o_MSTL(0) <= '1';
						 o_SSTL(2) <= '0';
						 o_SSTL(1) <= '1';
						 o_SSTL(0) <= '0';
					 ELSIF (i_SST = '0') THEN
		             nextState <= A;
						 o_MSTL(2) <= '0';
						 o_MSTL(1) <= '0';
						 o_MSTL(0) <= '1';
						 o_SSTL(2) <= '0';
						 o_SSTL(1) <= '1';
						 o_SSTL(0) <= '0';
					 END if;
   End case;
	END process;
End Mealy;	
