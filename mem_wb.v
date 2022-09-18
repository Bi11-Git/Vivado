module mem_wb(
    clk,
    reset, 
    mem_ReadData,
    wb_ReadData,
);

//Types of mips instractions here we are working with 32 bit instractions
parameter S=32;

input clk, reset;

input [(s-1):0] mem_ReadData;

output [(s-1):0] wb_ReadData;

always @(posedge clk) begin
    if (reset == 1'b0) begin
        //all the commands sould perform an no-op
        wb_ReadData <= 32'bx // Reference the controler module, when x all the digits
    end else begin
        wb_ReadData <= mem_ReadData
    end
end




endmodule