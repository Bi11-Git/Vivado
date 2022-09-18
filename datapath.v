module datapath(clk, reset, RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp,OpCode);

input clk;
input reset;

input RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch;

wire [31:0] Instruction;

input [3:0] ALUOp;
//Changed the size of the reg in order to satisfy our needs
wire [4:0] ALUCtrl;
wire [31:0] ALUout;
wire Zero;

output [5:0] OpCode;
assign OpCode = Instruction[31:26];

wire [31:0] PC_adr;

wire [31:0] ReadRegister1;
wire [31:0] ReadRegister2;

wire [4:0] muxinstr_out;
wire [31:0] muxalu_out;
wire [31:0] muxdata_out;

wire [31:0] ReadData;

wire [31:0] signExtend;

wire PCsel;
//PIPELINE VARIABLES

wire [31:0] id_instr;
wire [31:0] id_PCadr;
wire [31:0] wb_ReadData;
wire [31:0] ex_PCadr;
wire [31:0] ex_ReadRegister1;
wire [31:0] ex_ReadRegister2; 
wire [31:0] ex_id_signExtend;
wire [31:0] mem_ALUout;
wire [31:0] mem_zero;


/*
    Pipeline stagets of the canonical pipeline
*/
/*
    IF
*/
mem_async meminstr(PC_adr[7:0],Instruction); //Instruction memory
//IF/ID (out -> Instruction)
if_id ifid(
    clk, 
    reset, 
    Instruction, 
    id_instr
);


/*
    ID
*/

pclogic PC(clk, reset, signExtend, PC_adr, PCsel); //generate PC

rf registerfile(clk,RegWrite,id_instr[25:21],id_instr[20:16],muxinstr_out, ReadRegister1, ReadRegister2, muxdata_out); //Registers

mux #(5) muxinstr(RegDst, id_instr[20:16],id_instr[15:11],muxinstr_out);//MUX for Write Register

signextend Signextend(signExtend, id_instr[15:0]); //Sign extend
//ID/EX
//We dont use it somewhere at the moment but its necessary to have the id_PCadr forwarded to our next register in the pipeline.
//out -> id_PCadr(32), ReadRegister1(32), ReadRegister2(32),signExtend(32)

id_ex instractionDecodeInstrFetch(
    clk,
    reset, 
    PC_adr, 
    ReadRegister1, 
    ReadRegister2, 
    signExtend, 
    ex_PCadr,
    ex_ReadRegister1, 
    ex_ReadRegister2, 
    ex_id_signExtend
);





/*
    EX
*/
andm andPC(Branch, Zero, PCsel); //AndPC (branch & zero) Calculating the new value for th program counter

mux #(32) muxalu(AluSrc, ex_ReadRegister2, ex_id_signExtend, muxalu_out);//MUX for ALU

alu Alu( ex_ReadRegister1, muxalu_out, ALUCtrl, ALUout, Zero); //ALU

alucontrol AluControl(ALUOp, Instruction[5:0], ALUCtrl); //ALUControl
//EX/MEM
//out -> ex_PCsel(1), ex_ALUout(32), ex_zero(1)
ex_mem execMemory(
    clk, 
    reset, 
    ALUout, 
    Zero,
    mem_ALUout,
    mem_zero
);



/*
    MEM
*/
mem_sync memdata(clk, mem_ALUout[7:0], ReadData, ReadRegister2, MemRead, MemWrite); //Data memory
//MEM/WB
//out -> mem_ReadData(32)
mem_wb memmoryWriteback(
    clk, 
    reset,
    ReadData, 
    wb_ReadData
);



/*
    WB
*/
mux #(32) muxdata(MemtoReg, ALUout, wb_ReadData, muxdata_out); //MUX for Data memory



endmodule
