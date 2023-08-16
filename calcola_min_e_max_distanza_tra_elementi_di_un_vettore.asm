#$s4 contiene la min/max distanza temporanea
#$s5 contiene il selettore, il quale se settato a 0 calcola la min distanza se settato a 1 la distanza max tra gli elementi del vettore di byte
#$t0 è il puntatore per il ciclo più esterno
#$t1 è il putatore per il ciclo più interno
#$s2 contiene il risultato della differenza tra le coppie di numeri volta per volta che poi viene trasformata in v.a.
#$s0 contiene il byte situato nella cella di memoria puntata da $t0
#$s1 contiene il byte situato nella cella di memoria puntata da $t1
#$t4 contiene l'indirizzo di partenza dell'area di memoria nella quale viene scritto il risultato
#$t2 contiene l'indirizzo di memoria successivo all'ultimo byte del vettore di input 
#la sottrazione tra il primo e il secondo byte del vettore viene riportata incondizionatamente in modo tale da settare
#il registro che contiene il min/max temporaneo
.data 0x10010000
input: .byte -50,-32,93,52
end:
selettore: .byte 0


.data 0x10010128
output: .space 1
ric: .space 4
 #modificare il programma per ottenere l'ordinamento
#degli elementi del vettore

.text
la $t0,input
la $t2,end
la $t4,output
la $t6,ric
la $t5,selettore
lb $s5,($t5)
addi $t1,$t0,1
#lb $s0,($t0)
#lb $s1($t1)
#sub $s2,$s0,$s1
#abs $s2,$s2
#add $s4,$s2,$0
#addi $t1,$t1,1
		ricopia:lb $s0,($t0)
		sb $s0,($t6)
		addi $t0,$t0,1
		addi $t6,$t6,1
		slt $t3,$t0,$t2
		bne $t3,$zero,ricopia
  		ordina:
  		lb $s0,($t0)
  		lb $s1,($t1)
  		slt $t3,$s0,$s1
  		beq $t3,$zero,piccolo
  		addi $t1,$t1,1
  		slt $t3,$t1,$t2
  		beq $t3,$zero,esterno1
  		j ordina
  		
  		piccolo:#add $t4,$s1,$zero
  		#add $s1,$s0,$zero
  		#add $s0,$t4,$zero
  		sb $s0,($t1)
  		sb $s1,($t0)
  		j ordina
  		
  		esterno1:addi $t0,$t0,1
  		slt $t3,$t0,$t2
  		beq $t3,$zero,fine1
  		addi $t1,$t0,1
  		j ordina
  		 fine1:j fine1
  		 
  		

   ciclo:lb $s0,($t0)
         lb $s1($t1)
         sub $s2,$s0,$s1
         abs $s2,$s2
         slt $t3,$s2,$s4
         xor $t7,$t3,$s5    #l'istruzione di xor serve per far in modo di utilizzare lo stesso branch sia se si sta
         bne $t7,$0,aggiorna # cercando la max che la min distanza invece di utilizzare due branch.
continua:addi $t1,$t1,1      #si torna in continua dopo aver aggiornato il valore di $s4
         slt $t3,$t1,$t2  
         beq $t3,$0,esterno 
         j ciclo            
esterno:addi $t0,$t0,1    #si entra in questo ciclo quando il puntatore interno è arrivato all'ultimo byte
        slt $t3,$t0,$t2   #qui si controlla che il puntatore esterno non sia arrivato alla fine, in caso si aggiorna
        beq $t3,$0,fine   #alla posizione successiva e si assegna a $t1 il valore successivo di $t0, altrimenti
        addi $t1,$t0,1    #termina l'esecuzione del programma
        j ciclo
aggiorna:move $s4,$s2     #routine dove si aggiorna il registro che contine il max/min temporaneo
         j continua
fine:sb $s4,($t4)
     j fine

