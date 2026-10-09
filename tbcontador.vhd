library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_contador_free_run is
end tb_contador_free_run;

architecture behavior of tb_contador_free_run is
    signal clk_tb : STD_LOGIC := '0';
    signal rst_tb : STD_LOGIC := '0';
    signal ena_tb : STD_LOGIC := '0';
    signal q_tb   : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Instanciación
    UUT: entity work.contador_free_run
        port map (clk => clk_tb, rst => rst_tb, ena => ena_tb, q => q_tb);

    -- Generación de reloj constante de 10ns
    clk_tb <= not clk_tb after 5 ns;

    -- Secuencia de estímulos
    process
    begin
        -- Estado inicial
        rst_tb <= '1';
        wait for 12 ns;
        
        rst_tb <= '0';
        ena_tb <= '1';
        -- Dejamos que desborde (16 ciclos * 10ns = 160ns)
        wait for 180 ns;
        
        ena_tb <= '0'; -- Pausar
        wait for 30 ns;
        
        ena_tb <= '1'; -- Reanudar
        wait for 50 ns;
        
        rst_tb <= '1'; -- Probar reset asíncrono
        wait for 15 ns;
        rst_tb <= '0';
        wait;
    end process;
end behavior;
