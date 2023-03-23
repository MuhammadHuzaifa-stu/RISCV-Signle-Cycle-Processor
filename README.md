# RISCV-Signle-Cycle-Processor
Complete RISCV single cycle processor.
I'm uploading the verilog code which covers R-type, I-type, Store, Load, Branch and Jump(JALR + JAL). 
Just take care of address in instruction memory also the number of cycles in test_bench according to the programme you are trying to run. 
Also, right now I'm using comparater blocks in branch_condition block soon I'll update it by replacing it with only subtraction and then providing results using simple OR, AND etc operations.  
You can checkout the code in (factorial.s)/(factorial.c) file which actually implements (factorial) function. 
The machine code is available in (code.txt) file. 
You can consult provided PDF for further help!
<<<<<<<<<<<<<<<<<<<<<<< Note >>>>>>>>>>>>>>>>>>>>>>>
Still U-type instructions are left plus the branch implementation using subtraction!
