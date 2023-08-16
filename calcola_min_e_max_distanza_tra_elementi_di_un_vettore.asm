#il registro $s4 contine la min/max distanza (in base al valore del selettore)
#il registro $t0 è il puntatore esterno
#il registro $t1 è il puntatore interno
.data 0x10010000
input: .byte -50,-32,127,25
end:
selettore: .byte 1 #con selettore=0 calcolo la distanza minima in v.a. tra gli elementi del vettore, con sellettore=1 la massima
.data 0x10010128 #area dove scrivo il risultato
output:
.text
la $t0,input 
la $t2,end 
la $t4,output
la $t5,selettore
lb $s5,($t5)
addi $t1,$t0,1 #calcolo la distanza in v.a. tra il primo e il secondo byte assegnandola incondizionatamente a $s4 in modo tale da settare $s4 ad un valore iniziale
lb $s0,($t0)
lb $s1($t1)
sub $s2,$s0,$s1
abs $s2,$s2
add $s4,$s2,$0 
addi $t1,$t1,1#
ciclo:lb $s0,($t0)
      lb $s1($t1)
      sub $s2,$s0,$s1
      abs $s2,$s2
      slt $t3,$s2,$s4
      xor $t7,$t3,$s5#mette in xor il risultato della slt con il selettore in modo tale da aggiornare o meno $s4 sia se sto calcolando la minima che la massima distanza
      bne $t7,$0,aggiorna

     
continua:addi $t1,$t1,1
slt $t3,$t1,$t2
         beq $t3,$0,esterno
         
         j ciclo
esterno:addi $t0,$t0,1 #incremento il puntatore esterno, e se non è arrivato alla fine assegno al puntatore più interno il valore successivo di $t0
        slt $t3,$t0,$t2
        beq $t3,$0,fine 
        addi $t1,$t0,1
        j ciclo
aggiorna:move $s4,$s2# aggiorno $s4
         j continua
fine:sb $s4,($t4) #scrivo in memoria la distanza min/max in base al valore del selettore
     j fine

