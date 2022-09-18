module id_ex(
    clk,
    reset, 
    id_PCadr, 
    id_ReadRegister1, 
    id_ReadRegister2, 
    id_signExtend, 
    ex_PCadr, 
    ex_ReadRegister1, 
    ex_ReadRegister2, 
    ex_id_signExtend
);

//Types of mips instractions here we are working with 32 bit instractions
parameter S=32;

input clk, reset;

input [(s-1):0] id_PCadr;
input [(s-1):0] id_ReadRegister1; 
input [(s-1):0] id_ReadRegister2;
input [(s-1):0] id_signExtend;

output [(s-1):0] ex_PCadr;
output [(s-1):0] ex_ReadRegister1;
output [(s-1):0] ex_ReadRegister2;
output [(s-1):0] ex_id_signExtend;

always @(posedge clk) begin
    if (reset == 1'b0) begin
        //all the commands sould perform an no-op
        ex_PCadr <= 32'bx 
        ex_ReadRegister1 <= 32'bx 
        ex_ReadRegister2 <= 32'bx 
        ex_signExtend <= 32'bx 
    end else begin
        ex_PCadr <= id_PCadr
        ex_ReadRegister1 <= id_ReadRegister1
        ex_ReadRegister2 <= id_ReadRegister2
        ex_signExtend <= id_signExtend
    end
end


endmodule