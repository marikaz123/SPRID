;-----------------------------------------------------------/ SPRID v2.3 /---

CheckSum        PROC
                LOCALS
                mov si,OFFSET id
                xor dx,dx
          @@do:
                lodsw
                mul WORD PTR [bx]
                add cSum,ax
                add bx,2
                loop @@do
                ret
CheckSum        ENDP

CheckSumK       PROC
                LOCALS
                mov bx,10
                mov si,OFFSET id
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
CheckSumK       ENDP
