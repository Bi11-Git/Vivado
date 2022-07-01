module alu(opA, opB, ALUop, result, zero);

input [31:0] opA;
input [31:0] opB;

//Changed the size of the reg in order to satisfy our needs
input [4:0] ALUop;

output reg [31:0] result;
output zero; //1 if result is 0

assign zero = (result==0);

always @(ALUop, opA, opB) begin
	case(ALUop)

		5'b00000: result=opA&opB; // and
		5'b00010: result=opA|opB; // or
		5'b00110: result=opA^opB;// xor
		5'b11000: result=~(opA|opB); // nor
		5'b00100: result=opA+opB; // add
		5'b01100: result=opA-opB; // sub
		5'b01000: result=opA*opB; // mult
		5'b01010: result=opA/opB; // div
		5'b10000: result=opA<<<1; // sll
		5'b10010: result=opA>>>1; // srl
		5'b10100: result=opA>>1;  // sra
		5'b10110: result=opA<<opB; // sllv
		5'b11001: result=opA>>opB; // srlv
		5'b11010: result=~(opA-opB); // bne
		5'b11100: result=(opA-opB)<=0?1:0; // blez
		5'b11110: result=(opA-opB)>0?1:0; // bgtz
		//5'b11111: result=  ? ; // mfhi
		//5'b00001: result= ? ; // mflo
		5'b00011: result=(opA<<16); //lui 
		5'b01110: result=opA<opB?1:0; //slt

	endcase
end

endmodule
