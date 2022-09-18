module control(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP);

input [5:0] opcode;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;

output reg [3:0] AluOP;


always @(opcode) begin
    case (opcode)
        
        // "x" in a bitsequence means that we do not care about the value of this specific bit 

        //bitwise
        //Type R
        6'b000000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b100100_0_1000;//r

        //Type I
        6'b001100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010100_0_0001;//andi
        6'b001101:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010100_0_0010;//ori
        6'b001110:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010100_0_0011;//xori
        6'b001000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010100_0_0000;//addi

        //Branch/jump
        6'b000010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b000000_0_0000; //j
        6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'bx0x000_1_0001; //beq
        6'b000101:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010000_1_0110; //bne
        6'b000110:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010000_1_0111; //blez
        6'b000111:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010000_1_1001; //bgtz

        //Register manipulation
        6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b011110_0_0000; //lw
        6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'bx1x001_0_0000; //sw
        6'b001111:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010100_0_1010; //lui
        6'b001010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=11'b010100_0_1011; //slti
        
        //In order now not to keep the "state" of the previous cycle wich also means that we will create memmory cells(the compiler)
        //We introduce a default value so no state needs to be  stored and we always pass a value even an dummy one.
        //An den eixame to defaul kai dhmiourgousame kelia mnhmhs tote to kykloma mas den tha htan syndiastiko.
        default: {RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,AluOP}=11'bxxx_xxx_x_xxxx;
        //We can also find the signal for the no-op
    
    endcase

end
 

endmodule