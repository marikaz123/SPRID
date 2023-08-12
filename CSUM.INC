;---------------------------------------------------/ Part of SPRID v2.0 /---
; CheckSum :PROC - REV.A
; CheckSumK:PROC - REV.A
;--------------------------------------------------------------/ marikaz /---

CheckSum        PROC
                LOCALS
                mov si,OFFSET id
                xor dx,dx
         @@doN:
                lodsw
                mul WORD PTR [bx]
                add cSum,ax
                add bx,2
                loop @@doN
                ret
CheckSum        ENDP

CheckSumK       PROC
                LOCALS
                mov si,OFFSET id
         @@doK:
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
                loop @@doK
                ret
CheckSumK       ENDP
