library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_descendente is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ena : in  STD_LOGIC;
           q   : out STD_LOGIC_VECTOR (3 downto 0));
end contador_descendente;

architecture rtl of contador_descendente is
    signal estado, proximo_estado : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            estado <= "0000";
        elsif rising_edge(clk) then
            estado <= proximo_estado;
        end if;
    end process;

    process(estado, ena)
    begin
        proximo_estado <= estado; 
        
        if ena = '1' then
            case estado is
                when "0000" => proximo_estado <= "1111";
                when "1111" => proximo_estado <= "1110";
                when "1110" => proximo_estado <= "1101";
                when "1101" => proximo_estado <= "1100";
                when "1100" => proximo_estado <= "1011";
                when "1011" => proximo_estado <= "1010";
                when "1010" => proximo_estado <= "1001";
                when "1001" => proximo_estado <= "1000";
                when "1000" => proximo_estado <= "0111";
                when "0111" => proximo_estado <= "0110";
                when "0110" => proximo_estado <= "0101";
                when "0101" => proximo_estado <= "0100";
                when "0100" => proximo_estado <= "0011";
                when "0011" => proximo_estado <= "0010";
                when "0010" => proximo_estado <= "0001";
                when "0001" => proximo_estado <= "0000";
                when others => proximo_estado <= "0000";
            end case;
        end if;
    end process;

    q <= estado;
end rtl;
