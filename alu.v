module alu(opA, opB, ALUop, result, zero);

input [31:0] opA;
input [31:0] opB;

//Changed the size of the reg in order to satisfy our needs
input [4:0] ALUop;

output reg [31:0] result;
output zero; //1 if result is 0

assign zero = (result==0);

//The two registers we need for the multiplication and division that are not directly manipulated from the programmer.
reg [31:0] hi
reg [31:0] lo

always @(ALUop, opA, opB) begin
	case(ALUop)

		5'b00000: result=opA&opB; // and
		5'b00010: result=opA|opB; // or
		5'b00110: result=opA^opB;// xor
		5'b11000: result=~(opA|opB); // nor
		5'b00100: result=opA+opB; // add
		5'b01100: result=opA-opB; // sub
		//Now when we multiply and divide its not that easy we need two registers, $HI and $LO
		/* 
		 - mult
		 - multiplication of two unsigned integers.
		 - Upper 32 bits stored in special register hi and the Lower 32 bits stored in special register lo 
		*/
		5'b01000: assign {hi, lo}=opA*opB; 
		/* 
		 - div
		 - division of two unsigned integers.
		 - Remainder stored in special register hi and quotient stored in the special register lo.
		*/
		5'b01010: assign {hi, lo}=opA/opB;

		5'b10000: result=opA<<<1; // sll
		5'b10010: result=opA>>>1; // srl
		5'b10100: result=opA>>1;  // sra
		5'b10110: result=opA<<opB; // sllv
		5'b11001: result=opA>>opB; // srlv
		5'b11010: result=~(opA-opB); // bne
		5'b11100: result=(opA-opB)<=0?1:0; // blez
		5'b11110: result=(opA-opB)>0?1:0; // bgtz

		5'b11111: result=  hi ; // mfhi, assigning the 32 most significant bits of the multiplication process to a register/result
		5'b00001: result= lo ; // mflo, assigning the 32 least significant bits of the multiplication process to a register/result
		
		5'b00011: result=(opA<<16); //lui 
		5'b01110: result=opA<opB?1:0; //slt

		default: result=32'bx

	endcase
end

endmodule
