library verilog;
use verilog.vl_types.all;
entity alu_control_unit is
    port(
        ALU_control     : out    vl_logic_vector(3 downto 0);
        ALUOp           : in     vl_logic_vector(2 downto 0);
        funct           : in     vl_logic_vector(5 downto 0)
    );
end alu_control_unit;
