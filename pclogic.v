module pclogic(clk, reset, ain, aout, pcsel);

input reset;
input clk;
input [31:0] ain;
//pecsel = branch & zero
input pcsel;

output reg [31:0] aout;

always @(posedge clk ) begin
	if (reset==1)
		aout<=32'b0;
	else
		if (pcsel==0) begin
			aout<=aout+1; // we have +1 and not +4 bc as we said the mem is word(4bytes) and not byte adressable
		end
		if (pcsel==1) begin
			aout<=ain+aout+1; //branch
	end
end


endmodule
