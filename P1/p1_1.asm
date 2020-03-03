pila segment stack 'stack'
	dw 100h dup (?)
pila ends
datos segment 'data'
	escribir db 13,10,'modo 40x25 $'
datos ends
codigo segment 'code'
	assume cs:codigo, ds:datos, ss:pila
	main PROC
		mov ax,datos
		mov ds,ax


		mov al,0
		mov ah,0
		int 10h

		mov dx,OFFSET escribir
		mov ah,9
		int 21h


		mov ah,1
		int 21h

		mov al,3
		mov ah,0
		int 10h


		mov ax,4C00h
		int 21h
	main ENDP
codigo ends

END main
