	component soc_design is
		port (
			clk_clk                                  : in    std_logic                     := 'X';             -- clk
			ddr_address                              : in    std_logic_vector(29 downto 0) := (others => 'X'); -- address
			ddr_burstcount                           : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- burstcount
			ddr_waitrequest                          : out   std_logic;                                        -- waitrequest
			ddr_readdata                             : out   std_logic_vector(31 downto 0);                    -- readdata
			ddr_readdatavalid                        : out   std_logic;                                        -- readdatavalid
			ddr_read                                 : in    std_logic                     := 'X';             -- read
			ddr_writedata                            : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			ddr_byteenable                           : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			ddr_write                                : in    std_logic                     := 'X';             -- write
			full_external_connection_export          : out   std_logic_vector(7 downto 0);                     -- export
			memory_mem_a                             : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                            : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                            : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                          : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                           : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                          : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                         : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                         : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                          : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                       : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                            : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                           : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                         : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                           : out   std_logic;                                        -- mem_odt
			memory_mem_dm                            : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                         : in    std_logic                     := 'X';             -- oct_rzqin
			start_address_external_connection_export : out   std_logic_vector(29 downto 0)                     -- export
		);
	end component soc_design;

	u0 : component soc_design
		port map (
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                               clk.clk
			ddr_address                              => CONNECTED_TO_ddr_address,                              --                               ddr.address
			ddr_burstcount                           => CONNECTED_TO_ddr_burstcount,                           --                                  .burstcount
			ddr_waitrequest                          => CONNECTED_TO_ddr_waitrequest,                          --                                  .waitrequest
			ddr_readdata                             => CONNECTED_TO_ddr_readdata,                             --                                  .readdata
			ddr_readdatavalid                        => CONNECTED_TO_ddr_readdatavalid,                        --                                  .readdatavalid
			ddr_read                                 => CONNECTED_TO_ddr_read,                                 --                                  .read
			ddr_writedata                            => CONNECTED_TO_ddr_writedata,                            --                                  .writedata
			ddr_byteenable                           => CONNECTED_TO_ddr_byteenable,                           --                                  .byteenable
			ddr_write                                => CONNECTED_TO_ddr_write,                                --                                  .write
			full_external_connection_export          => CONNECTED_TO_full_external_connection_export,          --          full_external_connection.export
			memory_mem_a                             => CONNECTED_TO_memory_mem_a,                             --                            memory.mem_a
			memory_mem_ba                            => CONNECTED_TO_memory_mem_ba,                            --                                  .mem_ba
			memory_mem_ck                            => CONNECTED_TO_memory_mem_ck,                            --                                  .mem_ck
			memory_mem_ck_n                          => CONNECTED_TO_memory_mem_ck_n,                          --                                  .mem_ck_n
			memory_mem_cke                           => CONNECTED_TO_memory_mem_cke,                           --                                  .mem_cke
			memory_mem_cs_n                          => CONNECTED_TO_memory_mem_cs_n,                          --                                  .mem_cs_n
			memory_mem_ras_n                         => CONNECTED_TO_memory_mem_ras_n,                         --                                  .mem_ras_n
			memory_mem_cas_n                         => CONNECTED_TO_memory_mem_cas_n,                         --                                  .mem_cas_n
			memory_mem_we_n                          => CONNECTED_TO_memory_mem_we_n,                          --                                  .mem_we_n
			memory_mem_reset_n                       => CONNECTED_TO_memory_mem_reset_n,                       --                                  .mem_reset_n
			memory_mem_dq                            => CONNECTED_TO_memory_mem_dq,                            --                                  .mem_dq
			memory_mem_dqs                           => CONNECTED_TO_memory_mem_dqs,                           --                                  .mem_dqs
			memory_mem_dqs_n                         => CONNECTED_TO_memory_mem_dqs_n,                         --                                  .mem_dqs_n
			memory_mem_odt                           => CONNECTED_TO_memory_mem_odt,                           --                                  .mem_odt
			memory_mem_dm                            => CONNECTED_TO_memory_mem_dm,                            --                                  .mem_dm
			memory_oct_rzqin                         => CONNECTED_TO_memory_oct_rzqin,                         --                                  .oct_rzqin
			start_address_external_connection_export => CONNECTED_TO_start_address_external_connection_export  -- start_address_external_connection.export
		);

