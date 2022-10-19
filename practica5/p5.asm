name "p5"
include 'emu8086.inc'  

        org 100h
        jmp ini
    
cadnum db ?,?,?,?,?   ;variable de 16 bits
nhex   db ?,?         ;contiene el valor en hexadecimal convertido despues de obtener la cadena ascii
auxb   db ?

;;;;division  
numer  db 0,0 ;numerador
den    db 0
coc    db 0,0
resid  db 0
;;;;;;;;;;;;;;

resBCD db 0,0,0,0,0,0


ini:
        xor ax, ax      
        lea di, cadnum  
        mov dx, 5      
        call get_string  ;funcion get_string, almacena en la var que apunta di y dependiendo del valor de dx
        
        lea si, nhex    ;apunta a si 
        
        mov     al,[di] ;mando a al el valor actual en di en ascii
        call    numbyte
        mov     al,[auxb]
        mov     [si],al
        inc     si
        inc     di 
    
        mov     al,[di]
        call    numbyte
        mov     al,[auxb]
        mov     [si],al
        
        lea     si,nhex
        lea     di,numer 
        mov     cx, 2
        call    copy_si_di
        ;;;;;;;;hasta aqui tengo la cadena en hexa en nhex
        lea     di,resBCD ;DI apunta al lugar donde guardo los residuos 
        add     di,4

ciclo:
        mov al,10
        mov [den],al
        call div16bit     
        jz f_ciclo 
        mov al,[resid]
        mov [di], al
        dec di
        push di
        lea si,coc
        lea di,numer
        mov cx,2
        call copy_si_di
        pop di
        jmp ciclo

        
f_ciclo:
        mov al,[resid]
        mov [di],al
        mov al,0   
        
        ;;;;;;;;hasta aqui el resultado esta en la variable resBCD 
        lea si, resBCD
        add si, 4
        mov cx, 5 ;;checar si es correcto el conteo
        call c_ascii_si
        lea si, resBCD 
        gotoxy 0,2
        call print_string
         
        mov al,0
        int 0x20
        
        
div16bit:
        push ax
        mov ah, 0
        mov al,[numer]  
        test [den],0xff  ;checamos que el denominador sea diferente de 0 es una compuerta and
        jz div_zero 
        div [den]
        mov [coc],al  
        mov al,[numer+1] 
        div [den]
        mov [coc+1], al
        mov [resid],ah
        clc
        jmp ediv32_8                            
        div_zero:
        mov al,0xff
        mov [coc],al
        mov [coc+1],al
        mov [resid],al
        stc
        ediv32_8:
        test [coc],0xFF
        jnz no_zero
        test [coc+1],0xFF
        jnz no_zero
no_zero:
        pop ax
        ret 
    
numbyte:; convierte 2 numeros ascii en un byte y lo almacena de auxb al 
        call    asc2num
        mov     bl,16
        mul     bl
        mov     [auxb],al
        inc     di
        mov     al,[di]
        call    asc2num
        add     al,[auxb]
        mov     [auxb],al
        ret
        
asc2num: ;funcion que recibe en <al> un valor en ascii, retorna en <al> el valor en hexadecimal 
        sub     al,48
        cmp     al,9
        jle     f_asc
        sub     al,7
        cmp     al,15
        jle     f_asc
        sub     al,32
f_asc:  ret  
 
copy_si_di:  ;rutina que copia el arreglo indicado por el registro SI
    push ax  ;al arreglo indicado por el arreglo DI
    push cx
    push si
    push di
copy:
    mov al,[si]
    mov [di], al 
    inc si
    inc di
    loop copy
    pop di
    pop si
    pop cx
    pop ax
    ret  
    

c_ascii_si:  ;convierte ascii si
    push ax  
    push cx
    push si  
ascii:
    add [si], 0x30
    dec si
    loop ascii
    pop si
    pop cx
    pop ax
    ret                
                    

DEFINE_GET_STRING 
DEFINE_PRINT_STRING
    ret




