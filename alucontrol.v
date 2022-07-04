module alucontrol(AluOp,FnField,AluCtrl);

//Changed the size of the reg in order to satisfy our needs
input [3:0] AluOp;
input [5:0] FnField; //for R-type instructions

//Changed the size of the reg in order to satisfy our needs
output reg [4:0] AluCtrl;


always@(AluOp or FnField)begin
    casex({AluOp,FnField})
    
        //Type R        
        10'b1000_100100:AluCtrl=5'b00000; //and
        10'b1000_100101:AluCtrl=5'b00010; //or
        10'b1000_100110:AluCtrl=5'b00110; //xor
        10'b1000_100111:AluCtrl=5'b11000; //nor

        10'b1000_100000:AluCtrl=5'b00100; //add
        10'b1000_100010:AluCtrl=5'b01100; //sub
        10'b1000_011000:AluCtrl=5'b01000; //mult
        10'b1000_011010:AluCtrl=5'b01010; //div

        10'b1000_000000:AluCtrl=5'b10000; //sll
        10'b1000_000010:AluCtrl=5'b10010; //srl
        10'b1000_000011:AluCtrl=5'b10100; //sra
        10'b1000_000100:AluCtrl=5'b10110; //sllv
        10'b1000_000110:AluCtrl=5'b11001; //srlv

        10'b1000_101010:AluCtrl=5'b01110; //slt
        10'b1000_010000:AluCtrl=5'b1111; //mfhi
        10'b1000_010010:AluCtrl=5'b0001; //mflo


        //Type I
        10'b0001_xxxxxx:AluCtrl=5'b00000; //andi
        10'b0010_xxxxxx:AluCtrl=5'b00010; //ori
        10'b0011_xxxxxx:AluCtrl=5'b00110; //xori

        10'b0000_xxxxxx:AluCtrl=5'b00100; //addi / jump

        10'b0001_xxxxxx:AluCtrl=5'b01100; //beq
        10'b0110_xxxxxx:AluCtrl=5'b11010; //bne
        10'b0111_xxxxxx:AluCtrl=5'b11100; //blez
        10'b1001_xxxxxx:AluCtrl=5'b11110; //bgtz

        10'b1010_xxxxxx:AluCtrl=5'b00011; //lui
        10'b1011_xxxxxx:AluCtrl=5'b00111; //slti

        10'b0000_xxxxxx:AluCtrl=5'b00100; //lw / sw /  A + B
    
        //in order not to create a latch we are going to add a default with 4 udefiend bits
        default:AluCtrl=4'bxxxx;
    
    endcase

end


endmodule

