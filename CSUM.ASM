;-------------------------------------------------------------/ SPRID v2 /---
; CheckSumW : Suma kontrolna oparta o wagi
; CheckSumL : Suma kontrolna liczona algorytmem Luhn'a - zmodyfikowanym
;----------------------------------------------------------------------------

CheckSumW       PROC
                LOCALS
                mov si,OFFSET id
                xor dx,dx
          @@do:
                lodsw
                mul WORD PTR [bx] ;bx=wsk. na wagi
                add cSum,ax
                add bx,2
                loop @@do
                ret
CheckSumW       ENDP

CheckSumL       PROC
                LOCALS
                mov si,OFFSET id
                mov bx,10
          @@do:
                lodsw
                shl ax,1
                cmp ax,9
                ja @@2d
                add cSum,ax
                jmp @@1d
          @@2d:
                xor dx,dx
                div bx
                add cSum,ax
                add cSum,dx
          @@1d:
                lodsw
                add cSum,ax
                loop @@do
                ret
CheckSumL       ENDP
