name "p4";

    org 100h
    
    mov ax, 1003
    mov bx, 0
    int 10h
    
    mov dx, 0705h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg1_size  
    mov al, 01b       
    mov bp, msg1
    mov ah, 13h       
    int 10h
    
    mov dx, 0905h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg2_size  
    mov al, 01b       
    mov bp, msg2
    mov ah, 13h       
    int 10h 
    
    mov dx, 0B05h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg3_size  
    mov al, 01b       
    mov bp, msg3
    mov ah, 13h       
    int 10h   
    
    mov dx, 0C05h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg4_size  
    mov al, 01b       
    mov bp, msg4
    mov ah, 13h       
    int 10h  
    
    mov dx, 0D05h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg5_size  
    mov al, 01b       
    mov bp, msg5
    mov ah, 13h       
    int 10h 
    
    mov ah, 0
    int 10110b
    
    mov ax, 0
    mov bx, 0
              
    mov ax,[Base]
    mov cx,[Exp]
    cmp cx, 01h ;si son iguales se hace la siguiente linea, sino, se la salta
    je exp1
    
    dec cx
    
    ;primer caso, ambos operandos son la  base
    mov [OP1], ax
    mov [OP2], ax
    call mult 
    mov ax,[aux]
    mov bx,[aux+2]
    mov [CurrVal],ax   ;respaldo del resultado de la operacion anterior SE DEBE TRABAJAR SOBRE ESTE PORQUE aux SE SOBREESCRIBE
    mov [CurrVal+2],bx
    
    
    ;resto de los casos
it:
    ;;se multiplica la base con los LSB del resultado anterior 
    mov ax,[Base] 
    mov bx,[CurrVal]
    
    mov [OP1], ax
    mov [OP2], bx 
    call mult
    
    mov ax,[aux]
    mov bx,[aux+2]
    mov [Restem1],ax 
    mov [Restem1+2],bx 
    
    ;;se multiplica la base con los MSB del resultado anterior 
    mov ax,[Base] 
    mov bx,[CurrVal+2]
    
    mov [OP1], ax
    mov [OP2], bx 
    call mult
    
    mov ax,[aux]
    mov bx,[aux+2]
    mov [Restem2],ax 
    mov [Restem2+2],bx 
    
    mov ax,[Restem1+2]
    mov bx,[Restem2]
    add ax, bx 
    
    mov [CurrVal+2], ax
    mov ax, [Restem1]
    mov [CurrVal], ax    
    
    loop it 
    
    mov ax,[CurrVal]
    mov bx,[CurrVal+2]
    mov [ResFinal],ax   ;respaldo del resultado de la operacion anterior SE DEBE TRABAJAR SOBRE ESTE PORQUE aux SE SOBREESCRIBE
    mov [ResFinal+2],bx
    
    mov ah,0
    int 20h
    
    Base    dw 0
    Exp     dw 0
    ResFinal dw 0,0 
    
    CurrVal dw 0,0 ;almacena los 32 bits con los que estamos trabajando actualmente, resultado de la ultima operacion de multiplicacion (respaldo)              
    
     
    ;; variables que contienen el resultado de ambas multiplicaciones al separar la multiplicacion de 32x16 en 2 de 16x16
    Restem1 dw 0,0  ;almacena el resultado que obtenemos al hacer la multiplicacion 16x16 del LSB original
    Restem2 dw 0,0  ;almacena el resultado que obtenemos al hacer la multiplicacion 16x16 del MSB original
    
    ;;variables internas para el control de la multiplicacion
    
    OP1     dw 0
    OP2     dw 0
    aux     dw 0,0  ;variable que contiene el resultado de las multiplicaciones, de ax y dx 
    
    
    msg1:   db "Seccion D05 Lisseth Abigail Martinez Castillo"
    msg2:   db "Introduce tus datos en las variables:"
    msg3:   db "Base, variable de entrada, base de 16 bits"
    msg4:   db "Exp, variable de entrada, exponente max de 16 bits"
    msg5:   db "ResFinal variable salida"
    msg_tail:
    msg1_size = msg2 - msg1
    msg2_size = msg3 - msg2
    msg3_size = msg4 - msg3
    msg4_size = msg5 - msg4
    msg5_size = msg_tail - msg5   
    
    ret
mult:
    push ax
    push bx
    mov ax,[OP1]
    mov bx,[OP2]
    mul bx
    mov [aux],ax
    mov [aux+2],dx
    pop bx
    pop ax
    ret
     
exp1:            
    mov ah, 00h
    mov [ResFinal], ax   
    int 20h 
    




