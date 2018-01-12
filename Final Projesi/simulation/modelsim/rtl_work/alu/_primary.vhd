library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        zero            : out    vl_logic;
        ALU_result      : out    vl_logic_vector(31 downto 0);
        read_data_1     : in     vl_logic_vector(31 downto 0);
        read_data_2     : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        ALU_control     : in     vl_logic_vector(3 downto 0)
    );
end alu;
