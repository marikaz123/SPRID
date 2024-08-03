;----------------------------------------------------------------------------
; Sprawdz numer Identyfikacyjny :: SPRID v2.4 :: MOD0724
;----------------------------------------------------------------------------
; Program sprawdza pod wzgledem formalnym poprawnosc niektorych numerow
; ewidencyjnych i seryjnych.
;--------------------------------------------------------------/ marikaz /---

_TEXT SEGMENT WORD PUBLIC 'CODE'
      ASSUME cs:_TEXT

PUBLIC iban_PL,id,statSW
EXTRN  ChkIBAN:PROC,GetIDfromCon:PROC

PRINTMSG MACRO msg
         mov dx,OFFSET msg
         mov ah,9
         int 21h
         ENDM

CPOZ  = 2     ;  . Atrybut dla napisu
CNEG  = 4     ;.
IDLEN = 32d

.386
ORG 100h
Main            PROC
                call GetIDfromCon
                cmp ax,1
                je prnInfoMsg
                cmp ax,2
                je prnErrMsg1
chkSW1:         ;DOWOD
                cmp statSW,1
                jne chkSW2
                mov bx,OFFSET dxv
                mov cx,9
                call CheckSumW
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
                call CheckSumW
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
                call CheckSumW
                mov ax,cSum
                mov bx,10
                div bx
                or dx,dx
                jz verPoz
                jmp verNeg
chkSW4:         ;ID BANKU
                cmp statSW,4
                jne chkSW5
                mov bx,OFFSET bxv
                mov cx,8
                call CheckSumW
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
                call CheckSumW
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
                ;mov ax,19    ;max dla karty
                 mov ax,16
                sub ax,cx
                mov cx,IDLEN
                sub cx,ax
                push cx
                shl cx,1
                lea di,[id+(IDLEN-1)*2]
                mov si,di
                sub si,cx
                mov cx,ax
                std
                rep movsw ;do prawej
                pop cx
                mov ax,0
                rep stosw
                cld
                mov cx,IDLEN SHR 1 ;!
                call CheckSumL
                mov ax,cSum
                xor dx,dx
                div bx
                or dx,dx
                jz verPoz
                jmp verNeg
chkSW7:         ;REGON
                cmp statSW,7
                jne chkSW8
                mov [id+30],cx ;(cx=5:9c, cx=0:14c)
                mov cx,8
                mov bx,OFFSET rxv
                call CheckSumW
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
                call CheckSumW
                mov ax,cSum
                mov bx,11
                div bx
                cmp dx,10
                jne skp14
                mov dx,0
         skp14:
                cmp [id+13*2],dx
                je verPoz
                jmp verNeg
chkSW8:         ;KSIEGA W.
                cmp statSW,8
                jne chkSW9
                mov bx,OFFSET wxv
                mov cx,12
                call CheckSumW
                mov ax,cSum
                mov bx,10
                div bx
                cmp [id+12*2],dx
                je verPoz
                jmp verNeg
chkSW9:         ;EAN
                cmp statSW,9
                jne chkSW10
                cmp cx,0      ;cx=0 EAN13, cx=5 EAN8
                jne ean8
                mov cx,12
                mov bx,OFFSET exv
                call CheckSumW
                mov ax,cSum
                mov bx,10
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+12*2],dx
                je verPoz
                jmp verNeg
          ean8:
                mov cx,7
                mov bx,OFFSET exv+2
                call CheckSumW
                mov ax,cSum
                mov bx,10
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+7*2],dx
                je verPoz
                jmp verNeg
chkSW10:        ;ISBN/ISSN
                cmp statSW,10
                jne chkSW11
                cmp cx,2
                je issn
                mov cx,9
                mov bx,OFFSET ixv
                call CheckSumW
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
                call CheckSumW
                mov bx,11
                mov ax,cSum
                div bx
                mov ax,bx
                sub ax,dx
                xor dx,dx
                div bx
                cmp [id+7*2],dx
                je verPoz
                jmp verNeg
chkSW11:        ;IBAN
                cmp statSW,11
                jne chkSW12
                mov si,OFFSET iban_PL
                mov di,OFFSET id
                mov cx,8
         mvIDb:
                movsb
                inc di
                loop mvIDb
                mov bx,OFFSET bxv
                mov cx,8
                call CheckSumW
                mov bx,10
                mov ax,cSum
                div bx
                or dx,dx
                jnz verNeg
                call ChkIBAN
                cmp ax,1
                je verPoz
                jmp verNeg
chkSW12:
                cmp statSW,12
                jne prnInfoMsg
                or cx,cx
                jz skipL
                mov ax,IDLEN
                sub ax,cx
                mov cx,IDLEN
                sub cx,ax
                push cx
                shl cx,1
                lea di,[id+(IDLEN-1)*2]
                mov si,di
                sub si,cx
                mov cx,ax
                std
                rep movsw ;wrow. do prawej
                pop cx
                mov ax,0  ;i dop. 0
                rep stosw
         skipL:
                cld
                mov cx,IDLEN SHR 1
                call CheckSumL
                mov ax,cSum
                xor dx,dx
                div bx
                or dx,dx
                jnz verNeg

verPoz:
                PRINTMSG pozMsg
                mov al,CPOZ
                call PutColor
                jmp exit
verNeg:
                PRINTMSG negMsg
                mov al,CNEG
                call PutColor
                jmp exit
prnErrMsg1:
                PRINTMSG errMsg1
                jmp exit
prnInfoMsg:
                PRINTMSG infoMsg
exit:
                ret
Main            ENDP

PutColor        PROC
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
                dec di
                stosb
                inc di
                stosb
                inc di
                stosb
                ret
PutColor        ENDP

                INCLUDE csum.asm
EVENDATA
id      DW IDLEN DUP (?)  ;NUMER
cSum    DW 0
iban_PL DB 24 DUP (?),2,5,2,1,?,?          ;2,5 = P  2,1 = L
wxv     DW 1,3,7,1,3,7,1,3,7,1,3,7         ;Nowa KW
nxv     DW 6,5,7,2,3,4,5,6,7               ;NIP
bxv     DW 3,9,7,1,3,9,7,1                 ;BANK ID
sxv     DW 7,3,9,1,7,3,1,7,3               ;PASZPORT
dxv     DW 7,3,1,9,7,3,1,7,3               ;DOW. OS.
pxv     DW 9,7,3,1,9,7,3,1,9,7             ;PESEL
rxv     DW 8,9,2,3,4,5,6,7                 ;REGON9
rEv     DW 2,4,8,5,0,9,7,3,6,1,2,4,8       ;REGON14
exv     DW 1,3,1,3,1,3,1,3,1,3,1,3         ;EAN13 / EAN8 (EAN8=exv+1)
ixv     DW 10,9,8,7,6,5,4,3,2              ;ISBN / ISSN (ISSN=ixv+2)
statSW  DB 0

errMsg1 DB 'Blad w numerze ID. Pomoc: sprid.com /?, README.TXT',13,10,'$'
negMsg  DB 13,10,9,'Ocena formalna: NEG',13,10,13,10,'$'
pozMsg  DB 13,10,9,'Ocena formanla: POZ',13,10,13,10,'$'

        INCLUDE info.inc

_TEXT           ENDS
                END Main