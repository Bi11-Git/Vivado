module ex_mem(
    clk,
    reset, 
    ex_ALUout, 
    ex_zero,   
    mem_ALUout, 
    mem_zero
);

//Types of mips instractions here we are working with 32 bit instractions
parameter S=32;

input clk, reset;

input [(s-1):0] ex_ALUout;
input [1:0] ex_zero; 


output [(s-1):0] mem_ALUout;
output [1:0] mem_zero;

always @(posedge clk) begin
    if (reset == 1'b0) begin
        //all the commands sould perform an no-op
        mem_ALUout <= 32'bx // Reference the controler module, when x all the digits
        mem_zero <= 32'bx
    end else begin
        mem_ALUout <= ex_ALUout
        mem_zero <= ex_zero
    end
end




endmodule