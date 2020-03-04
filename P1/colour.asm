TEXTO   EQU 3
GRAFICO EQU 4
BLANCO  EQU 3
ROSA    EQU 2
VERDE   EQU 1

;MACRO pausa_tecla
;espera la pulsacion de una tecla
pausa_tecla MACRO
        push ax
        mov ah,0   ;funcion para leer una tecla
        int 16h    ;interrupcion BIOS para teclado
        pop ax
ENDM

;MACRO modo_video
;cambia el modo de video (texto-3 o grafico-4)
modo_video MACRO modo
        push ax
        mov al,modo
        mov ah,0
        int 10h
        pop ax
ENDM

;MACRO pixel
;pone un pixel en la coordenada X,Y de color C
pixel MACRO X,Y,C
        push ax
        push cx
		push dx
		mov ax,Y
		mov cx,X
		mov dx,ax
        mov al,C
        mov ah,0Ch
        int 10h
        pop dx
        pop cx
		pop ax
ENDM

pila segment stack 'stack'
	dw 100h dup (?)
pila ends

datos segment 'data'
		msg_pulsa_tecla db 'pulsa para continuar...',7,'$'
datos ends


codigo segment 'code'
	assume cs:codigo, ds:datos, ss:pila
	main PROC
		mov ax,datos
		mov ds,ax

		mov dx,OFFSET msg_pulsa_tecla
		mov ah,9
		int 21h
		pausa_tecla

		modo_video GRAFICO

		;pintar una linea horizontal
		mov cx,200
		bucle1:
			pixel cx,50,BLANCO
			dec cx
			jnz bucle1

		;pintar una linea vertical
		mov cx,50
		bucle2:
			pixel 200,cx,BLANCO
			dec cx
			jnz bucle2




		pausa_tecla

		pixel 70,50,BLANCO    ;puntos blancos
		pixel 50,70,BLANCO
		pixel 60,20,VERDE
		pixel 50,80,ROSA


		pausa_tecla

		modo_video TEXTO

		mov ax,4C00h
		int 21h
	main ENDP
codigo ends

END main
