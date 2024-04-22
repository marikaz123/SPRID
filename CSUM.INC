;--------------------------------------------------------/ Part of SPRID /---

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
                mov si,OFFSET id
          @@do:
                lodsw
                shl ax,1
                cmp ax,9
                ja @@2dig
                add cSum,ax
                jmp @@1dig
        @@2dig:
                xor dx,dx
                div bx
                add cSum,ax
                add cSum,dx
        @@1dig:
                lodsw
                add cSum,ax
                loop @@do
                ret
CheckSumK       ENDP
