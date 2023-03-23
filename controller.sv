module controller(input logic [6:0] func7,input logic [2:0] func3,input logic [6:0] opcode,
	output logic [3:0] alu_control,output logic regwrite_control, sel_B, rd_en, wr_en, 
	output logic [1:0] wb_sel, output logic cs,sel_A, output logic [2:0]br_type);
    
	always_comb
    begin
        //R type
		if (opcode == 7'b0110011) begin 
            sel_B = 0;
			sel_A = 0;
			regwrite_control = 1;
            wb_sel = 2'b00;
			rd_en = 0; 
			wr_en = 1;
			cs = 1;
			
			case (func3)
                3'd0: begin
                    if (func7 == 7'd0) alu_control = 4'b0000; // ADD
                    else if (func7 == 7'd32) alu_control = 4'b0001; // SUB
					end
                3'd1: alu_control = 4'b0010; // SLL
                3'd2: alu_control = 4'b0011; // SLT
                3'd3: alu_control = 4'b0100; // SLTU
                3'd4: alu_control = 4'b0101; // XOR
				3'd5: begin 
					if (func7 == 7'd0) alu_control = 4'b0110; // SRL
					else if (func7 == 7'd32) alu_control = 4'b0111; // SRA
					end
				3'd6: alu_control = 4'b1000; // OR
				3'd7: alu_control = 4'b1001; // AND
			endcase
		end
		
		//I type
		else if (opcode == 7'b0010011) begin
			sel_B = 1;
			sel_A = 0;
			regwrite_control = 1;
			wb_sel = 2'b00;
			rd_en = 0; 
			wr_en = 1;
			cs = 1;
			
			case (func3)
                3'd0: alu_control = 4'b0000; // ADDI
                //3'd1: alu_control = 4'b0010; // SLL
                3'd2: alu_control = 4'b0011; // SLTI
                3'd3: alu_control = 4'b0100; // SLTUI
                3'd4: alu_control = 4'b0101; // XORI
				//3'd5: begin 
					//if (func7 == 7'd0) alu_control = 4'b0110; // SRL
					//else if (func7 == 7'd32) alu_control = 4'b0111; // SRA
					//end
				3'd6: alu_control = 4'b1000; // ORI
				3'd7: alu_control = 4'b1001; // ANDI
				default : alu_control = 4'b0000; // ADDI;
			endcase
		end
		
		//Load instructions
		else if (opcode == 7'b0000011) begin
			sel_B = 1;
			sel_A = 0;
			regwrite_control = 1;
			alu_control = 4'b0000; // ADDI
			rd_en = 1; 
			wb_sel = 2'b01;
			wr_en = 1;
			cs = 0;
			
		end
		
		//Store instructions
		else if (opcode == 7'b0100011) begin
			sel_B = 1;
			sel_A = 0;
			regwrite_control = 0;
			alu_control = 4'b0000; // ADDI
			rd_en = 0; 
			wb_sel = 2'b00;
			wr_en = 0;
			cs = 0;
		end
		
		 //Branch instructions
		else if (opcode == 7'b1100011) begin 
            sel_B = 1;
			sel_A = 1;
			regwrite_control = 0;
            wb_sel = 2'b00;
			rd_en = 0; 
			wr_en = 1;
			cs = 1;
			alu_control = 4'b0000; // ADDI
			
			case (func3)
                3'b000: br_type = 3'b000; // BEQ
                3'b001: br_type = 3'b001; // BNE
                3'b100: br_type = 3'b010; // BLT
				3'b101: br_type = 3'b011; // BGE
				3'b110: br_type = 3'b100; // BLTU
				3'b111: br_type = 3'b101; // BGEU
			endcase
		end

		//JAL instructions
		else if (opcode == 7'b1101111) begin 
            sel_B = 1;
			sel_A = 1;
			regwrite_control = 1;
            wb_sel = 2'b10; 
			rd_en = 0; 
			wr_en = 1;
			cs = 1;
			alu_control = 4'b0000; // ADDI
			
		end

		//JALR instructions
		else if (opcode == 7'b1100111) begin 
            sel_B = 1;
			sel_A = 0;
			regwrite_control = 1;
            wb_sel = 2'b10; 
			rd_en = 0; 
			wr_en = 1;
			cs = 1;
			alu_control = 4'b0000; // ADDI
			
		end
	end
endmodule