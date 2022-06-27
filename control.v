module control(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP);

input [5:0] opcode;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;

output reg [1:0] AluOP;


always @(opcode) begin
    case (opcode)
        
        // "x" in a bitsequence means that we do not care about the value of this specific bit 
        //R type
        6'b000000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b100100_0_10; //r
        
        //Bitwise
        
        
        //Arithmetic
        
        //Shift
        
        //Branch
        6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'bx0x000_1_01; //beq
        
        
        //Register transfer
        6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b011110_0_00; //lw
        6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'bx1x001_0_00; //sw
        
        //In order now not to keep the "state" of the previous cycle wich also means that we will create memmory cells(the compiler)
        //We introduce a default value so no state needs to be  stored and we always pass a value even an dummy one.
        //An den eixame to defaul kai dhmiourgousame kelia mnhmhs tote to kykloma mas den tha htan syndiastiko.
        default: {RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,AluOP}=9'bxxx_xxx_x_xx;
        //We can also find the signal for the no-op
    
    endcase

end
 

endmodule