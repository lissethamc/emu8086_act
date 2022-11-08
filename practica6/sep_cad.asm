include 'emu8086.inc'       
        NAME    "p6"
        ORG     0100H
        jmp     main

linea   DB      81 DUP (0)  ;Arreglo de cadena
t_linea DB      0           ;Tamaño de cadena
salir   DB      0           ;Bandera para terminar un ciclo
datos   DW      10 DUP (0)  ;arreglo de datos.
opers   DB      6  DUP (0) 
base    DB      16   
currOp  DB      0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

timesOp DB      0       ;cuenta cuantas veces se repite el mismo operador       
cantOp  DB      0
                                       
Total   DB      6 DUP (0)

Res     DW      0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NvaLine DB      0dh,0ah 
msg1    DB      "Dame el nombre del archivo. usa el formato 8.3",0dH,0aH
msg2    DB      "Escribe una linea, maximo 80 caracteres",0dH,0aH
msg3    DB      "Presiona <ESC> PARA SALIR",0dH,0aH
msg4    DB      "s",0dH,0aH
msge01  DB      "Funcion No Valida",0dh,0aH
msge02  DB      "Archivo No Encontrado",0dH,0aH
msge03  DB      "Ruta No Valida",0dH,0aH
msge04  DB      "Handle No Disponible",0dH,0aH
msge05  DB      "Acceso Denegado",0dH,0aH
msge06  DB      "Handle no valido",0dH,0aH
msge07  DB      "Caracter no valido",0dH,0aH
msge08  DB      "s",0dh,0aH
msge09  DB      "s",0dH,0aH
msge0A  DB      "s",0dH,0aH
msge0B  DB      "s",0dH,0aH
msge0C  DB      "s",0dH,0aH
msge0D  DB      "s",0dH,0aH
msge0E  DB      "s",0dH,0aH
msge0F  DB      "s",0dH,0aH
msge10  DB      "Excede el número de caracteres",0dH,0aH
msge11  DB      "-",0dH,0aH  

msge12  DB      "Lisseth Abigail Martinez Castillo"
msge13  DB      "Ingrese una cadena, puede contener:" 
msge14  DB      "5 Operadores"   
msge15  DB      "Operandos de 4 digitos (rellenar con 0, ejemplo 0002)"
msge16  DB      "El resultado es: " 
msge17  DB      ".",0dH,0aH

tmsge01 DW      msge02 - offset msge01
tmsge02 DW      msge03 - offset msge02
tmsge03 DW      msge04 - offset msge03
tmsge04 DW      msge05 - offset msge04
tmsge05 DW      msge06 - offset msge05
tmsge06 DW      msge07 - offset msge06
tmsge07 DW      msge08 - offset msge07
tmsge08 DW      msge09 - offset msge08
tmsge09 DW      msge0A - offset msge09
tmsge0A DW      msge0B - offset msge0A
tmsge0B DW      msge0C - offset msge0B
tmsge0C DW      msge0D - offset msge0C
tmsge0D DW      msge0E - offset msge0D
tmsge0E DW      msge0F - offset msge0E
tmsge0F DW      msge10 - offset msge0F
tmesge12 DW     msge12 - offset msge11 
tmesge13 DW     msge13 - offset msge12
tmesge14 DW     msge14 - offset msge13
tmesge15 DW     msge15 - offset msge14
tmesge16 DW     msge16 - offset msge15
tmesge17 DW     msge17 - offset msge16

    
       
leecad: push    di
        push    si
        push    cx 
        push    ax 
        mov     [t_linea],cl
ntecla: jcxz    enc
        mov     ah,0
        int     16H
        mov     [si],al
        inc     si
        dec     cx
        cmp     al,1BH
        jne     sigue
        mov     [salir],1
        jmp     FINCAD
sigue:  cmp     al,0DH
        je      FINCAD
        cmp     al,08H
        je      borra
        mov     ah,0EH
        int     10H
        jmp     ntecla
borra:  dec     si
        dec     si
        inc     cx
        inc     cx
        mov     ah,0eH
        int     10H
        mov     al,20H
        int     10H
        mov     al,08
        int     10H
        jmp     ntecla
enc:    lea     di,msge10  ;Excede el número de caracteres
        mov     cx,msge11 - offset msge10
        mov     dh,0
        mov     dl,0
        call    imprime
        mov     dh,03
	    mov     dl,0
	    mov     bh, 0
	    mov     ah, 2
	    int     10h
        lea     si,linea
        mov     cx,30
        call    limpia
        lea     di,msg2  ;Escribe una linea, maximo 80 caracteres
        mov     cx,msg3 - offset msg2
        mov     dh,1
        mov     dl,0
        call    imprime
        mov     dh,03
	    mov     dl,0
	    mov     bh, 0
	    mov     ah, 2
	    int     10h
	    call    BorraLinea
        mov     dh,03
	    mov     dl,0
	    mov     bh, 0
	    mov     ah, 2
	    int     10h
        lea     si,linea
        mov     cx,30
        jmp     ntecla
FINCAD: dec     si
        mov     [si],0
        mov     ah,0eH
        mov     al,0dH
        int     10H
        mov     al,0aH
        int     10H
        sub     [t_linea],cl
        pop     ax
        pop     cx
        pop     si
        pop     di 
        ret    
             
imprime:
       	push    bx
       	push    ax
       	push    es
       	mov     al,1
    	mov     bh,0
    	mov     bl,0011_1011b
    	push    cs
    	pop     es
    	mov     bp,di
    	mov     ah,13h
    	int     10h
    	pop     es
    	pop     ax
    	pop     bx
    	ret
    	
BorraLinea:
        push    ax
        push    bx
        push    cx
        mov     cx,80
        mov     al,32
        mov     bh,0
        mov     ah,0aH
        int     10H
        pop     cx
        pop     bx
        pop     ax
        ret 
        
limpia: push    si
        push    cx
l_lim:  mov     [si],0
        inc     si
        loop    l_lim
        pop     cx
        pop     si
        ret	        

asc2num:
        sub     al,48
        cmp     al,9
        jle     f_asc
        sub     al,7
        cmp     al,15
        jle     f_asc
        sub     al,32
f_asc:  ret        

main:   
        lea     di,msge12  ;Excede el número de caracteres
        mov     cx,msge13 - offset msge12
        mov     dh,5
        mov     dl,5
        call    imprime 
        
        lea     di,msge13  ;Excede el número de caracteres
        mov     cx,msge14 - offset msge13
        mov     dh,6
        mov     dl,5
        call    imprime
        
        lea     di,msge14  ;Excede el número de caracteres
        mov     cx,msge15 - offset msge14
        mov     dh,7
        mov     dl,5
        call    imprime
        
        lea     di,msge15  ;Excede el número de caracteres
        mov     cx,msge16 - offset msge15
        mov     dh,8
        mov     dl,5
        call    imprime
                    
                    
        mov     dh,9
        mov     dl,5
        mov     ah,2
        int     10h
        
        xor     ax,ax
        xor     dx,dx
        mov     cx,30    ;cx debe tener el tamaño de la cadena para la funcion leecad
        lea     si,linea ;Arreglo en el que se almacenara la cadena.
        call    leecad
        lea     di,datos
        lea     dx,opers
        mov     al,[si]
        cmp     al,0
        je      fin
        call    asc2num
        cmp     al,0fh
        ja      c_err ;Error de caracter.
        mov     [di],ax
nvocar: inc     si
        mov     al,[si]
        test    al,0FFh
        je      fin
        call    asc2num
        cmp     al,0fh
        ja      leeop
        push    dx
        push    ax
        mov     ax,[di]
        mov     bl,[base]
        mul     bx
        mov     [di],ax
        pop     ax
        pop     dx
        add     [di],ax
        jmp     nvocar
leeop:  push    di
        mov     di,dx
        mov     al,[si]
        cmp     al,'*'
        je      op0
op1:    cmp     al,'/'
        je      op0
op2:    cmp     al,'-'
        je      op0
op3:    cmp     al,'+'
        jne     c_err
op0:    mov     [di],al
        inc     di
        mov     dx,di
        pop     di
        inc     di
        inc     di
        jmp     nvocar
c_err:  push    di
        lea     di,msge07  ;Caracter no valido
        mov     cx,msge07 - offset msge06
        mov     dh,5
        mov     dl,0
        call    imprime
        pop     di
        
fin:             
        
        ;;;;;;;;;;; creo q hasta aqui no importa dnd tengo mis ptrs pero x si acaso
        
        ;; si -> linea
        ;; di -> datos
        ;; dx -> operadores  
        ;;;;;;;;
        ;; di -> operadores
        ;; di se intercambia con dx, se respalda el valor anterior de di en la pila cuando se usa dx y se restaura despues de usarlo
        
        ;;;;;;;;;;;;
        
        
        
        push    di ;respaldo el ptr a datos 
        push    dx  
        ;;;;;; inicializo ambos "ptrs" en ambos arreglos, pero di si itera sobre opers, mientras que bx solo sera referencia para cuando quiera saber cuales son los operadores relacionados
        lea     dx, datos
        lea     di, opers
        mov     cx, 00h
       
       
       ; cuenta longitud opers, LOS ALMACENA EN cantOp           
 countopers:
        cmp     [di], 00h
        je      checkops1
        inc     cx
        inc     di
        jmp     countopers
        
        ;int     16h 
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        ;itera sobre el arreglo de operandos checando que tipo de operador es
checkops1:  ;;;;pera el primer caso
        
        mov     [cantOp], cl             
checkops:   ;;;retorno del resto de operaciones, para que no se reasigne cl al contador
        lea     di, opers   
checkopsr:  
        cmp     [di], 00h
        je      checkopers2
        cmp     [di], 2FH ; checa si es ascii de division "/"
        je      division
        cmp     [di], 2AH ; checa si el ascii de multiplicacion "*", puedo hacer la comparacion aqui pq tienen la misma jerarquia
        je      multiplicacion
        inc     di    
        inc     dx   
        inc     dx 
        loop    checkopsr
           
checkopers2:
        lea     dx, datos                               
checkops2:   ;;;retorno del resto de operaciones, para que no se reasigne cl al contador
        lea     di, opers   
cicl:  
        cmp     [di], 00h
        je      endprg
        cmp     [di], 2BH ; checa si es ascii de division "/"
        je      suma
        cmp     [di], 2DH ; checa si el ascii de multiplicacion "*", puedo hacer la comparacion aqui pq tienen la misma jerarquia
        je      resta
        inc     di    
        inc     dx   
        inc     dx 
        loop    cicl        
        
        endprg:   
        popf
        lea     di,msge16  
        mov     cx,msge17 - offset msge16
        mov     dh,11
        mov     dl,5
        call    imprime 
       
       
        
        lea     di, Total
        
        jnc     no_signo
        
        mov     [di], 2Dh
        
        
no_signo: 

        lea     si, datos
        inc     di
        inc     di
        inc     di
        inc     di   
        
        mov     ax, [si]
        mov     bl, 10h
repdiv:  
        xor     dx,dx
        div     bx
        cmp     dl, 9
        jle     numero
        add     dl, 0x07
 numero:
        add     dl, 0x30
        mov     [di], dl
       
        dec     di
        cmp     ax, 00h
        jnz     repdiv
        
        dec     di
        
     
        
        lea     si, Total 
        gotoxy  15,5 
        call    print_string
        
        
        
        xor     ax,ax       
        int     20h
        
 
 
division:
        call recorreoperadores   ;;;di apunta a opers, recorre arreglo recorreria para division
        push    ax
        push    dx  
        push    di 
        
        mov     di, dx
        xor     dx, dx
        mov     ax, [di]  ;;dx tiene la direccion de datos del dato que corresponde a la div
        ;mov  [OP1], ax
        mov     bx, [di+2]
       ; mov  [OP2],ax
        div     bx  
        mov     [Res], ax 
       ;;;;;;;;;;;;;;; mov [di],ax;;awas cone sta linea <--- NO OLVIDES LISSETH BORRAR EL OPERADOR DE LA LISTA DE OPERADORES 
        call    recorredatos
        pop     di
        pop     dx 
        pop     ax
        jmp     checkopsr
        
        

multiplicacion:
        call recorreoperadores   ;;;di apunta a opers, recorre arreglo recorreria para multiplicaciones
        push    ax
        push    dx
        push    di
        mov     di, dx
        xor     dx, dx
        mov     ax, [di]  ;;bx tiene la direccion de datos del dato que corresponde a la div
        ;mov  [OP1], ax
        mov     bx, [di+2]
       ; mov  [OP2],ax
        mul     bx  
        mov     [Res], ax 
       ;;;;;;;;;;;;;;; mov [di],ax;;awas cone sta linea <--- NO OLVIDES LISSETH BORRAR EL OPERADOR DE LA LISTA DE OPERADORES 
        call    recorredatos
        pop     di
        pop     dx 
        pop     ax
        jmp     checkopsr
        
suma:
        call recorreoperadores   ;;;di apunta a opers, recorre arreglo recorreria para multiplicaciones
        push    ax
        push    dx
        push    di 
     
        mov     di, dx
        xor     dx, dx
        mov     ax, [di]  ;;bx tiene la direccion de datos del dato que corresponde a la div
        ;mov  [OP1], ax
        mov     bx, [di+2]
       ; mov  [OP2],ax
        add     ax,bx  
        mov     [Res], ax 
       ;;;;;;;;;;;;;;; mov [di],ax;;awas cone sta linea 
        call    recorredatos
        pop     di
        pop     dx 
        pop     ax
        jmp     cicl

resta:
        call recorreoperadores   ;;;di apunta a opers, recorre arreglo recorreria para multiplicaciones
        push    ax
        push    dx
        push    di 
       
        mov     di, dx
        xor     dx, dx
        mov     ax, [di]  ;;bx tiene la direccion de datos del dato que corresponde a la div
        ;mov  [OP1], ax
        mov     bx, [di+2]
       ; mov  [OP2],ax
        sub     ax,bx  
        mov     [Res], ax 
       ;;;;;;;;;;;;;;; mov [di],ax;;awas cone sta linea 
        call    recorredatos
        pop     di
        pop     dx 
        pop     ax 
        pushf
        jmp     cicl
        
        
       ;;;;;funcion que una vez usado un operador recorre el resto del arreglo 
       ;;;;;para ocupar ese lugar vacio, usa di, di->opers
 recorreoperadores: 
        push    ax
        push    di
    
        mov     ah, [cantOp]
        dec     ah
        mov     [cantOp], ah 
                     
        xor     ax, ax   
        
      rept:
        mov     al, b.[di+1] 
        mov     [di],al
        inc     di
        
        cmp     [di], 00H
        jne     rept  
        
        pop     di
        pop     ax
        ret
        
        ;;;;funcion que reescribe el resultado de la operacion division en los operadores, es decir a+b = c entonces c va a ocupar el espacio de a y debemos borrar b
        ;;;;recorre los datos ya utilizados, hasta ahorita: 
        ;;;;di->opers
        ;;;;dx->datos
        ;;;;hay que reasignar los ptrs para poder usar di con datos
 recorredatos:
        push    ax
        push    dx
        push    di
               
        ;lea di, datos  ;;;NO REASIGNAR DI YA RECIBE DI CON EL VALOR APUNTANDO A LA DIRECCION QUE CORRESPONDE
        
        mov     ax,[Res]
        mov     [di], ax
    rept2:     
        mov     ax,w.[di+4]
        mov     w.[di+2],ax
        inc     di
        inc     di
        cmp     w.[di], 00h
        jne     rept2
        ;mov [di+2], 00h
        
         
        
        pop     di
        pop     dx
        pop     ax
        ret
          
DEFINE_PRINT_STRING
end
        