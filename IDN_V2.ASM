;----------------------------------------------------------------------------
; ** SPRawdz numer IDentyfikacyjny :: SPRID v2.1 :: MOD1023 **
;----------------------------------------------------------------------------
; Program sprawdza pod wzgledem formalnym poprawnosc niektorych numerow
; ewidencyjnych i seryjnych.
;--------------------------------------------------------------/ marikaz /---

         CPOZ = 2
         CNEG = 4

PRINTMSG MACRO msg
         mov dx,OFFSET msg
         mov ah,9
         int 21h
         ENDM

_TEXT SEGMENT WORD PUBLIC 'CODE'
      ASSUME cs:_TEXT
ORG 100h
.386

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
                mov cSum,0
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
                jne chkSW9
                mov bx,OFFSET wxv
                mov cx,12
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                cmp [id+12*2],dx
                je verPoz
                jmp verNeg
chkSW9:
                cmp statSW,9
                jne chkSW10
                cmp cx,0      ;CX=marker (cx=0 EAN13, cx=5 EAN8)
                jne ean8
                mov cx,12
                mov bx,OFFSET exv
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+12*2],dx
                je verPOZ
                jmp verNEG
          ean8:
                mov cx,7
                mov bx,OFFSET exv+2
                call CheckSum
                mov ax,cSum
                mov bx,10
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+7*2],dx
                je verPOZ
                jmp verNEG
chkSW10:
                cmp statSW,10
                jne exit
                cmp cx,2
                je issn
                ;isbn
                mov cx,9
                mov bx,OFFSET ixv
                call CheckSum
                mov bx,11
                mov ax,cSum
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+9*2],dx
                je verPOZ
                jmp verNEG
          issn:
                mov cx,7
                mov bx,OFFSET ixv+4
                call CheckSum
                mov bx,11
                mov ax,cSum
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+7*2],dx
                jne verNEG
verPoz:
                PRINTMSG pozMsg
                mov al,CPOZ
                call PColor
                jmp exit
verNeg:
                PRINTMSG negMsg
                mov al,CNEG
                call PColor
                jmp exit
prnErrMsg1:
                PRINTMSG errMsg1
                jmp exit
prnInfoMsg:
                PRINTMSG infoMsg
exit:
                ret

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
exv     DW 1,3,1,3,1,3,1,3,1,3,1,3     ;EAN13 / EAN8 (EAN8=exv+1)
ixv     DW 10,9,8,7,6,5,4,3,2          ;ISBN / ISSN (ISSN=ixv+2)
statSW  DB 0

errMsg1 DB 'Blad w numerze identyfikacyjnym / seryjnym.',13,10
        DB 'Pomoc: sprid.com /?, szczegolowe info w README.TXT',13,10,'$'
negMsg  DB 13,10,9,'Ocena formalna: NEG',13,10,13,10,'$'
pozMsg  DB 13,10,9,'Ocena formanla: POZ',13,10,13,10,'$'

                INCLUDE info.inc

Main            ENDP

PColor          PROC
                mov dx,0b800h
                mov es,dx
                mov ah,3
                mov bh,0
                int 10h
                sub dh,2
                add dl,25
                xor bx,bx
                mov bl,dh
                shl bx,5
                mov di,bx
                shl bx,2
                add di,bx
                mov dh,0
                shl dx,1
                add di,dx
                dec di      ;atrybut
                stosb
                inc di
                stosb
                inc di
                stosb
                ret
PColor          ENDP

                INCLUDE gidc.inc
                INCLUDE csum.inc

_TEXT           ENDS
                END Main