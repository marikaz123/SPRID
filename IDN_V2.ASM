;----------------------------------------------------------------------------
; ** SPRawdz numer IDentyfikacyjny :: SPRID v2.0 :: MOD0723 **
;----------------------------------------------------------------------------
; Program sprawdza pod wzgledem formalnym poprawnosc niektorych numerow
; ewidencyjnych i seryjnych.
;--------------------------------------------------------------/ marikaz /---

PRINTMSG MACRO msg
         mov dx,OFFSET msg
         mov ah,9
         int 21h
         ENDM

code            SEGMENT USE16 'code'
                ASSUME cs:code
                ORG 100h

IFDEF CPU386
  %OUT CPU386
 .386
ELSE
  %OUT JUMPS
  JUMPS
ENDIF

Main            PROC
                call GetIDfromCon
                cmp ax,-1          ;blad w linii cmd
                je prnErrMsg1
                cmp statSW,0       ;blad danych
                jne chkSW1
                jmp prnInfoMsg

chkSW1:         ;DOWOD
                cmp statSW,1
                jne chkSW2
                mov bx,OFFSET dxv
                mov cx,9
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                or dx,dx
                jz verPoz
                jmp verNeg

chkSW2:         ;PESEL
                cmp statSW,2
                jne chkSW3
                mov bx,OFFSET pxv
                mov cx,10
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                cmp [id+20],dx
                je verPoz
                jmp verNeg

chkSW3:         ;PASZPORT
                cmp statSW,3
                jne chkSW4
                mov bx,OFFSET sxv
                mov cx,9
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                or dx,dx
                jz verPoz
                jmp verNeg

chkSW4:         ;BANK (oddzial)
                cmp statSW,4
                jne chkSW5
                mov bx,OFFSET bxv
                mov cx,8
                call CheckSum
                mov bx,10
                mov ax,cSum
                div bx
                or dx,dx
                jz verPoz
                jmp verNeg

chkSW5:         ;NIP
                cmp statSW,5
                jne chkSW6
                mov bx,OFFSET nxv
                mov cx,9
                call CheckSum
                mov ax,cSum
                mov bx,11
                div bx
                cmp dx,10
                je verNeg
                cmp [id+18],dx
                je verPoz
                jmp verNeg

chkSW6:         ;NUMER KARTY
                cmp statSW,6
                jne chkSW7
                or cx,cx
                jz skipAlign
                mov ax,16
                sub ax,cx
                push cx
                shl cx,1
                lea di,[id+15*2]
                mov si,di
                sub si,cx
                mov cx,ax
                std
                rep movsw           ;numery < 16 cyfr wyrownaj do prawej.
                pop cx
                mov ax,0
                rep stosw           ;dopelnij do 16 cyfr zerami
                cld
     skipAlign:
                mov cx,8
                mov bx,10
                call CheckSumK
                mov ax,cSum
                xor dx,dx
                div bx
                or dx,dx
                je verPoz
                jmp verNeg

chkSW7:         ;REGON
                cmp statSW,7
                jne chkSW8
                mov [id+30],cx        ;marker dlugosci (5=9c, 0=14c)
                mov cx,8
                mov bx,OFFSET rxv
                call CheckSum
                mov ax,cSum
                mov bx,11
                div bx
                cmp dx,10
                jne skp10
                mov dx,0
         skp10:
                cmp [id+8*2],dx
                jne verNeg
                cmp WORD PTR [id+15*2],0       ;REGON14
                je reg14
                jmp verPoz
         reg14:
                mov bx,OFFSET rEv
                mov cx,13
                mov cSum,0           ;2 raz dla REGON14
                call CheckSum
                mov ax,cSum
                mov bx,11
                div bx
                cmp dx,10
                jne skp14
                mov dx,0
         skp14:
                cmp [id+13*2],dx
                jne verNeg
                jmp verPoz

chkSW8:         ;KSIEGA WIECZYSTA
                cmp statSW,8
                jne exit
                mov bx,OFFSET wxv
                mov cx,12
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                cmp [id+12*2],dx
                je verPoz
                jmp verNeg

exit:
                ret
verPoz:
                PRINTMSG pozMsg
                jmp exit
verNeg:
                PRINTMSG negMsg
                jmp exit
prnErrMsg1:
                PRINTMSG errMsg1
                jmp exit
prnInfoMsg:
                PRINTMSG infoMsg
                jmp exit

EVENDATA
cSum    DW 0
id      DW 16 DUP (0)
wxv     DW 1,3,7,1,3,7,1,3,7,1,3,7     ;Nowa KW
nxv     DW 6,5,7,2,3,4,5,6,7           ;NIP
bxv     DW 3,9,7,1,3,9,7,1             ;BANK (oddzial)
sxv     DW 7,3,9,1,7,3,1,7,3           ;PASZPORT
dxv     DW 7,3,1,9,7,3,1,7,3           ;DOW. OS.
pxv     DW 9,7,3,1,9,7,3,1,9,7         ;PESEL
rxv     DW 8,9,2,3,4,5,6,7             ;REGON9
rEv     DW 2,4,8,5,0,9,7,3,6,1,2,4,8   ;REGON14
statSW  DB 0

errMsg1 DB 'Blad w numerze identyfikacyjnym / seryjnym.',13,10
        DB "Pomoc: 'sprid.com /?'. Szczegolowe info w README.TXT",13,10,'$'
negMsg  DB 9,'Ocena formalna: NEG',13,10,'$'
pozMsg  DB 9,'Ocena formanla: POZ',13,10,'$'

                INCLUDE info.inc

Main            ENDP

                INCLUDE gidc.inc
                INCLUDE csum.inc

code            ENDS
                END Main