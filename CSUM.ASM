;-------------------------------------------------------------/ SPRID v2 /---
; CheckSumW : Suma kontrolna oparta o wagi
; CheckSumL : Suma kontrolna liczona algorytmem Luhn'a - zmodyfikowanym
;----------------------------------------------------------------------------

CheckSumW       PROC
                LOCALS
                mov si,OFFSET id
                xor dx,dx
                xor bp,bp
          @@do:
                lodsw
                mul WORD PTR [bx] ;bx=wsk. na wagi
                add bp,ax
                add bx,2
                loop @@do
                mov ax,bp
                ret
CheckSumW       ENDP

CheckSumL       PROC
                LOCALS
                mov si,OFFSET id
                xor bp,bp
                mov bx,10
          @@do:
                lodsw
                shl ax,1
                cmp ax,9
                ja @@2d
                add bp,ax
                jmp @@1d
          @@2d:
                xor dx,dx
                div bx
                add bp,ax
                add bp,dx
          @@1d:
                lodsw
                add bp,ax
                loop @@do
                mov ax,bp
                ret
CheckSumL       ENDP
