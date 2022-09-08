name "practica2"

org 100h

	mov al, 1
	mov bh, 0
	mov bl, 1001_1111b
	mov cx, msg2 - offset msg1 
	mov dl, 7                  
	mov dh, 8                  
	push cs
	pop es
	mov bp, offset msg1
	mov ah, 13h
	int 10h 
	
	mov bl, 1111_0101b
	mov cx, msg3 - offset msg2  
	mov dl, 7
	mov dh, 11
	mov bp, offset msg2
	mov ah, 13h
	int 10h  
	
	mov bl, 1111_1000b
	mov cx, msgend - offset msg3  
	mov dl, 7
	mov dh, 14
	mov bp, offset msg3
	mov ah, 13h
	int 10h
	
	mov dx, 2182h 
	mov cx, 2645h
	mov bx, 1198h
	mov ax, 9893h
	
	jmp msgend
	
msg1    db "Hola mundo"
msg2    db "Universidad de Guadalajara"
msg3    db "Lisseth Abigail Martinez Castillo"

msgend:
        mov ah,0
        int 16h
        int 20h
        
