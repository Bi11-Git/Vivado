 .data
    var1:      .word      5
.text
.global main
main:
addi $t1,$zero,10
addi $t2,$zero,10

and $t3, $t2, $t1
or $t3, $t2, $t1
xor $t3, $t2, $t1
nor $t3, $t2, $t1
andi $t3, $t2, 100
ori $t3, $t2, 100
xori $t3, $t2, 100

add $t3, $t2, $t1
addi $t3, $t2, 100
sub $t3, $t2, $t1
mult $t2, $t1
div $t2, $t1

sll $t3, $t2, 2
srl $t3, $t2, 2
sra $t3, $t2, 2
sllv $t3, $t2, $t1
srlv $t3, $t2, $t1

addi $t3,$zero,63

j a
addi $t3,$zero,0
a:

beq $zero,$zero,b
addi $t3,$zero,0
b:

bne $zero,1,c
addi $t3,$zero,0
c:

blez $zero d
addi $t3,$zero,0
d:

bgtz $t2, e
addi $t3,$zero,0
e:

mult $t3, $t2
mfhi $t3
mflo $t3
lui $t3,100
slt $t3, $t2, $t1
slti $t3, $t2, 100
