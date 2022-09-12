




                                                name "p3"   ; 
    
;   Este programa realiza la suma de dos datos
;   el primero es un dato de 16 bits almacenado en
;   la dirección de memoria 210H y 211H, la dirección
;   210H tendra los 8 bits mas significativos, la direccion
;   212H tendra el dato 2. la suma se realiza usando solo
;   registros de 8 bits.
    
    org  100h	; 

    mov ax, 1003h  
    mov bx, 0        
    int 10h

    mov dx, 0705h   ;seccion   
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg1_size  
    mov al, 01b       
    mov bp, msg1
    mov ah, 13h       
    int 10h  
    
    mov dx, 0805h    
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg2_size  
    mov al, 01b       
    mov bp, msg2
    mov ah, 13h       
    int 10h           
         
    mov dx, 0905h   ;inst  
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg3_size  
    mov al, 01b       
    mov bp, msg3
    mov ah, 13h       
    int 10h           

    mov dx, 0A05h    ;D1 
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg4_size  
    mov al, 01b       
    mov bp, msg4
    mov ah, 13h       
    int 10h 
                     ;D2
    mov dx, 0B05h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg5_size  
    mov al, 01b       
    mov bp, msg5
    mov ah, 13h       
    int 10h 
                      ;D3
    mov dx, 0C05h     
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg6_size  
    mov al, 01b       
    mov bp, msg6
    mov ah, 13h       
    int 10h 
    
    mov dx, 0D05h     ;D4
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg7_size  
    mov al, 01b       
    mov bp, msg7
    mov ah, 13h       
    int 10h
    
    mov dx, 0F05h     ;D5
    mov bx, 0         
    mov bl, 10011111b 
    mov cx, msg8_size  
    mov al, 01b       
    mov bp, msg8
    mov ah, 13h       
    int 10h 
    
    mov [0x210],0
    mov [0x211],0
    mov [0x212],0
    mov [0x213],0
    mov [0x214],0 
    mov [0x215],0
    mov [0x216],0
    mov [0x217],0
    mov [0x218],0
    mov [0x219],0        

    mov ah, 0          
    int 10110b 
    
    mov ax,0 
    mov bh,0
    mov al,[0x210]
    add al,[0x211]
    adc ah, ah  
    add al,[0x212]
    adc ah, bh 
    add al,[0x213]
    adc ah, bh 
    add al,[0x214]
    adc ah, bh 
    
    
    
    mov [0215h],ah
    mov [0216h],al
    mov [0217h],ax       

    int 20h 
    
    
msg1:         db "Seccion D08"
msg2:         db "Introduce tus datos en la memoria:"
msg3:         db "Dato1 de 8 bits en direcciones 0x0210"
msg4:         db "Dato2 de 8 bits en direcciones 0x0211"
msg5:         db "Dato3 de 8 bits en direcciones 0x0212"
msg6:         db "Dato4 de 8 bits en direcciones 0x0213"
msg7:         db "Dato5 de 8 bits en direcciones 0x0214"
msg8:         db "Lisseth Abigail Martinez Castillo"

msg_tail:
msg1_size = msg2 - msg1
msg2_size = msg3 - msg2
msg3_size = msg4 - msg3
msg4_size = msg5 - msg4
msg5_size = msg6 - msg5
msg6_size = msg7 - msg6
msg7_size = msg8 - msg7
msg8_size = msg_tail - msg8                  