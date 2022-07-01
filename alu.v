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
		5'b00000: result=opA&opB;
		5'b00010: result=opA|opB;
		5'b00110: result=opA^opB; //xor

		5'b00100: result=opA+opB;
		5'b01100: result=opA-opB;
		5'b01110: result=opA<opB?1:0; //slt


		5'b1100: result=~(opA|opB); //TODO - TI EINAI AFTO KAI GIA POU TO THELOOUME?
	endcase
end

endmodule
