`timescale 1ps/1ps
module tb_RISCV_R;
	logic clk, reset;
	RISCV_R DUT(clk, reset);
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	//all initial blocks run parallel wise
	initial begin
		//DUT.r1.Reg[1] = 12;
		reset = 1;
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		repeat(100) @(posedge clk);
		@(posedge clk); 
		$display("5! = %d",DUT.r1.Reg[28]);
		@(posedge clk);
		reset = 1;
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		$stop;
	end
endmodule
