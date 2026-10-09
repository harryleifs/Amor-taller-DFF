library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_contador_controlado is
end tb_contador_controlado;

architecture behavior of tb_contador_controlado is
    signal clk_tb        : STD_LOGIC := '0';
    signal rst_tb        : STD_LOGIC := '1';
    signal ena_tb        : STD_LOGIC := '0';
    signal q_tb          : STD_LOGIC_VECTOR(3 downto 0);
    signal endCounter_tb : STD_LOGIC;
begin

    UUT: entity work.contador_controlado
        port map (
            clk        => clk_tb,
            rst        => rst_tb,
            ena        => ena_tb,
            q          => q_tb,
            endCounter => endCounter_tb
        );

    -- Generador de reloj de 20 ns
    process
    begin
        wait for 10 ns;
        clk_tb <= not clk_tb;
    end process;

    -- Vector de pruebas
    process
    begin
        rst_tb <= '1';
        ena_tb <= '0';
        wait for 25 ns;
        
        rst_tb <= '0';
        ena_tb <= '1';
        
        -- Dejamos que el contador cuente más allá de 9 un par de veces
        wait for 250 ns;
        
        ena_tb <= '0'; -- Verificamos que endCounter se sostenga si paramos en 9
        wait for 50 ns;
        
        ena_tb <= '1'; 
        wait for 100 ns;
        
        wait;
    end process;
end behavior;
