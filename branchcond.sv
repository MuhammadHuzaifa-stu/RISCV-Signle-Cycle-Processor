module branchcond(input logic [31:0] rs1,rs2,opcode, input logic [2:0]br_type, output logic br_taken);
    
	always_comb
    begin
		if (opcode[6:0] == 7'b1100011) begin
			case(br_type)
			3'd000: br_taken = (rs1 == rs2) ? 1:0; // BEQ
			3'd001: br_taken = (rs1 != rs2) ? 1:0; // BNE
			3'd010: br_taken = ($signed(rs1) < $signed(rs2)) ? 1:0; // BLT 
			3'd011: br_taken = ($signed(rs1)>= $signed(rs2)) ? 1:0; // BGE
			3'd100: br_taken = ($unsigned(rs1) < $unsigned(rs2)) ? 1:0; // BLTU 
			3'd101: br_taken = ($unsigned(rs1)>= $unsigned(rs2)) ? 1:0; // BGEU
			default: br_taken = 0;
			endcase
		end
		else if ((opcode[6:0] == 7'b1101111) | (opcode[6:0] == 7'b1100111)) br_taken = 1;
		else br_taken = 0;
	end
endmodule