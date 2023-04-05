module RISCV_R(input logic clk, reset);
	
	logic [31:0] inst,rdata1,rdata2,result,wdata2,out,y,read_data,y2,adder_out,pc_out,pc_input,jump;
	logic write,sel_B,sel_A,rd_en,wr_en,cs,br_taken;
	logic [3:0] aluop;
	logic [3:0]mask;
	logic [2:0]br_type;
	logic [1:0]wb_sel;
	
	// adder
	adder add1 (.pc_in(pc_out) , .adder_out(adder_out));
	
	//mux for pc and branch/jump
	mux2x1 m4 (.a(adder_out),.b(result),.s(br_taken),.y(pc_input));
	
	//PC
	pc_reg pcreg1 (.clk(clk),.reset(reset),.in(pc_input) ,.pc_out(pc_out));
	//counter c1 (clk, reset, pc);
	
	//Intruction memory
	Instmem I1 (.Address(pc_out), .Instruction(inst));
	
	//register file
	regfile r1 (.raddr1(inst[19:15]),.raddr2(inst[24:20]),.waddr(inst[11:7]), 
				.wdata(wdata2),.RegWrite(write),.Clk(clk),.rdata1(rdata1),.rdata2(rdata2));
	
	//Immediate generator
	imme_gen im1 (.in(inst),.out(out));
	
	//mux for rs1 and pc
	mux21 m2 (.a(rdata1),.b(pc_out),.s(sel_A),.y(y2));
	
	//mux for rs2 and immediate 12'
	mux21 m1 (.a(rdata2),.b(out),.s(sel_B),.y(y));
	
	//ALU
	ALU A1 (.a(y2),.b(y),.alu(aluop),.result(result));
	
	// Branch Condition
	branchcond br1 (.rs1(rdata1),.rs2(rdata2),.opcode(inst),.br_type(br_type),.br_taken(br_taken));
	
	// LSU
	LSU L1 (.inst(inst),.mask(mask));

	//data memory
	data_memory dm1 (.addr(result),.write_data(rdata2),.mask(mask),.clk(clk),.reset(reset),
					 .rd_en(rd_en),.wr_en(wr_en),.cs(cs),.read_data(read_data));
	
	// adder for jump
	adder add2 (.pc_in(pc_out) , .adder_out(jump));

	//mux for ALU and Data_memory and jump 32'
	mux4x1 m3 (.a(result),.b(read_data),.c(jump),.s(wb_sel),.y(wdata2));
	
	//controller
	controller co1 (.func7(inst[31:25]),.func3(inst[14:12]),.opcode(inst[6:0]),
					.alu_control(aluop),.regwrite_control(write),.sel_B(sel_B),
					.rd_en(rd_en),.wr_en(wr_en),.wb_sel(wb_sel),.cs(cs),
					.sel_A(sel_A),.br_type(br_type));
	
endmodule
