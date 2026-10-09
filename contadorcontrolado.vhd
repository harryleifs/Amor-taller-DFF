library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_controlado is
    Port ( clk        : in  STD_LOGIC;
           rst        : in  STD_LOGIC;
           ena        : in  STD_LOGIC;
           q          : out STD_LOGIC_VECTOR (3 downto 0);
           endCounter : out STD_LOGIC);
end contador_controlado;

architecture rtl of contador_controlado is
    signal estado, proximo_estado : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- 1. Registro de Estado
    process(clk, rst)
    begin
        if rst = '1' then
            estado <= "0000";
        elsif rising_edge(clk) then
            estado <= proximo_estado;
        end if;
    end process;

    -- 2. Lógica de Siguiente Estado
    process(estado, ena)
    begin
        proximo_estado <= estado; 
        
        if ena = '1' then
            case estado is
                when "0000" => proximo_estado <= "0001";
                when "0001" => proximo_estado <= "0010";
                when "0010" => proximo_estado <= "0011";
                when "0011" => proximo_estado <= "0100";
                when "0100" => proximo_estado <= "0101";
                when "0101" => proximo_estado <= "0110";
                when "0110" => proximo_estado <= "0111";
                when "0111" => proximo_estado <= "1000";
                when "1000" => proximo_estado <= "1001";
                when "1001" => proximo_estado <= "0000"; -- Retorna a ceros al llegar a 9
                when others => proximo_estado <= "0000";
            end case;
        end if;
    end process;

    -- 3. Decodificador de Salida (Moore Machine) usando CASE
    process(estado)
    begin
        case estado is
            when "1001" => endCounter <= '1';
            when others => endCounter <= '0';
        end case;
    end process;

    q <= estado;
end rtl;
