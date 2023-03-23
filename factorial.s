.global factorial
factorial:
	addi t0,x0,0
	addi t1,x0,0
	addi t2,x0,0
	addi t3,x0,5
	addi t6,x0,1
	sub t4,t3,t6
	jal while1
while1:
	beq t4,x0,end
	bne t4,x0,while2
	while2:
	bge t0,t4,out
	add t2,t2,t3
	addi t0,t0,1
	jal while2
out:
	addi t0,x0,0
	sub t4,t4,t6
	addi t3,t2,0
	addi t2,x0,0
	jal while1
end:
	jal end
	
	
	