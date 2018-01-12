library verilog;
use verilog.vl_types.all;
entity control_unit is
    port(
        RegDst          : out    vl_logic;
        Branch          : out    vl_logic;
        MemRead         : out    vl_logic;
        MemtoReg        : out    vl_logic;
        ALUOp           : out    vl_logic_vector(2 downto 0);
        MemWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        RegWrite        : out    vl_logic;
        jump            : out    vl_logic;
        bne             : out    vl_logic;
        jal             : out    vl_logic;
        lui             : out    vl_logic;
        lbu             : out    vl_logic;
        lhu             : out    vl_logic;
        sb              : out    vl_logic;
        sh              : out    vl_logic;
        opcode          : in     vl_logic_vector(5 downto 0)
    );
end control_unit;
