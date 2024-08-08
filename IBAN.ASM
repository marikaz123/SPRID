;-/ ChkIBAN:PROC rev. A2 /------------------------------------/ SPRID v2 /---
;
; 0) PL 54 2060 1041 0343 8498 7077 5852   <- numer pozyskany z generatora
;                                             internetowego.
; GetIDfromCon:
; 1) 206010410343849870775852PL54
; 2) P=25, L=21
; 3) 206010410343849870775852252154
;
; ChkIBAN:
; 4) 206010410343849870775852252154 MOD 97 == 1 ? POZ : NEG
;
;--------------------------------------------------------------/ marikaz /---

.MODEL TINY
.CODE
.386

PUBLIC ChkIBAN
EXTRN  iban_PL:BYTE


ChkIBAN         PROC
                LOCALS
                lea si,iban_PL
                mov cx,5
           @@1:
                lea di,@@tmp+2
                push cx
                mov cx,6
                cld
                rep movsb
                std
                push si
                mov cx,8
                mov ebx,1
                xor ebp,ebp
                lea si,@@tmp+7
                xor edx,edx
           @@2:
                xor eax,eax
                lodsb
                mul ebx
                add ebp,eax
                shl ebx,1
                mov eax,ebx
                shl ebx,2
                add ebx,eax
                loop @@2
                mov eax,ebp
                div @@axv
                mov al,dl
                aam
                xchg ah,al            ; .
                mov WORD PTR @@tmp,ax ;   . little endian
                pop si
                pop cx
                loop @@1
                cld
                mov ax,WORD PTR @@tmp
                xchg al,ah    ;poz=1
                ret
EVENDATA
@@axv DD 97
@@tmp DB 0,0,6 DUP (?)

ChkIBAN         ENDP
                END
