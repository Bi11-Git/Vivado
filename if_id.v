module if_id(clk,reset, if_inst,id_inst);

//Types of mips instractions here we are working with 32 bit instractions
parameter S=32;

input clk, reset;

input [(s-1):0] if_inst;

output [(s-1):0] id_inst;

always @(posedge clk) begin
    if (reset == 1'b0) begin
        id_inst <= 32'bx // Reference the controler module, when x all the digits
    end else begin
        id_inst <= if_inst
    end
end



endmodule