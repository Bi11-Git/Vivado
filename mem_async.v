module mem_async(a,d);
//asynchronous memory with 256 32-bit locations
//for instruction memory
parameter S=32;
parameter L=256;

input [$clog2(L) - 1:0] a;
output [(S-1):0] d;
//The b out has 32 bit not which is 4 bytes
reg [S-1:0] memory [L-1:0]; //Attention: Word not byte addressable
assign d=memory[a];
//when we do a+1 we are not moving to the next byte but we are moving to the next word, that means 4 bytes at a times
initial $readmemh("meminstr.dat", memory);

endmodule
