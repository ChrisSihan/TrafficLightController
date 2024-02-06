library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2to1 is
    Port (
        i_A : in STD_LOGIC_vector(3 downto 0);      -- Input A
        i_B : in STD_LOGIC_vector(3 downto 0);        -- Input B
        i_S : in STD_LOGIC;        -- Select signal
        o_Y : out STD_LOGIC_vector(3 downto 0)       -- Output Y
    );
end entity Mux_2to1;

architecture Behavioral of Mux_2to1 is
begin
    process (i_A, i_B, i_S)
    begin
        if i_S = '0' then
            o_Y <= i_A;  -- Select input A
        else
            o_Y <= i_B;  -- Select input B
        end if;
    end process;
end architecture Behavioral;
