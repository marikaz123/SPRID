;-/ GetIDformCon:PROC rev. B /------------------------------/ SPRID v2.3 /---

.MODEL TINY
.CODE
.386

SW        EQU '/'
SEP       EQU '-'
COL       EQU ':'
TAB       EQU 9
SPACE     EQU 20h
CR        EQU 0Dh
TOU       EQU 0DFh
TOL       EQU 20h

CHKDEC    MACRO
          cmp al,'0'
          jb @@esn
          cmp al,'9'
          ja @@esn
          ENDM

CHKALPHA  MACRO
          and al,TOU
          cmp al,'Q'
          je @@esn
          cmp al,'V'
          je @@esn
          cmp al,'A'
          jb @@esn
          cmp al,'Z'
          ja @@esn
          ENDM

SKIPSEPKW MACRO
          LOCAL @skp,@exi
          cmp BYTE PTR [si],'/'
          je @skp
          cmp BYTE PTR [si],'-'
          jne @exi
   @skp:  inc si
   @exi:
          ENDM

SKIPCOL   MACRO
          LOCAL @skp
          cmp BYTE PTR [si],COL
          jne @skp
          inc si
    @skp:
          cmp BYTE PTR [si],SEP  ;blad dla '--'
          je @@esn
          ENDM

PUBLIC GetIDfromCon
EXTRN  statSW:BYTE,iban_PL:BYTE
EXTRN  id:WORD

GetIDfromCon    PROC
                LOCALS
                mov si,80h
                cmp BYTE PTR [si],4 ;brak id
                jbe @@ecl
                inc si
skpBCH:
                cmp BYTE PTR [si],TAB
                je @@skp0
                cmp BYTE PTR [si],SPACE
                je @@skp0
                jmp switch
        @@skp0:
                inc si
                jmp skpBCH
switch:
                mov di,OFFSET id
                lodsb
                cmp al,CR
                je exitp
                cmp al,SW
                jne @@ecl
                xor ax,ax
                lodsb
                or al,TOL
                cmp al,'a'
                je caseA
                cmp al,'b'
                je caseB
                cmp al,'d'
                je caseD
                cmp al,'e'
                je caseE
                cmp al,'i'
                je caseI
                cmp al,'k'
                je caseK
                cmp al,'n'
                je caseN
                cmp al,'p'
                je caseP
                cmp al,'r'
                je caseR
                cmp al,'s'
                je caseS
                cmp al,'w'
                je caseW
                jmp @@ecl
;--------------------------------------------------------------------- /A ---
caseA:          ;IBAN
                mov statSW,11
                SKIPCOL
                cmp BYTE PTR [si],'9'
                jbe @@num
                lodsb
                or al,TOL
                cmp al,'p'
                jne @@esn
                cmp BYTE PTR [si],SEP
                jne @@a1
                inc si
          @@a1:
                lodsb
                or al,TOL
                cmp al,'l'
                jne @@esn
                cmp BYTE PTR [si],SEP
                jne @@num
                inc si
         @@num:
                lea di,[iban_PL+28]
                mov cx,2
        @@mvcs:
                lodsb
                CHKDEC
                sub al,30h
                stosb
                cmp BYTE PTR [si],SEP
                jne @@a2
                inc si
          @@a2:
                loop @@mvcs
                lea di,iban_PL
                mov cx,24
        @@mvin:
                lodsb
                CHKDEC
                sub al,30h
                stosb
                cmp BYTE PTR [si],SEP
                jne @@a3
                inc si
                @@a3:
                loop @@mvin
                cmp BYTE PTR [si-1],SEP
                je @@esn
                jmp @@eop
;--------------------------------------------------------------------- /B ---
caseB:          ;ID BANKU
                mov statSW,4
                SKIPCOL
                mov cx,8
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                cmp cx,1
                jne @@esn
                jmp @@eop
;--------------------------------------------------------------------- /D ---
caseD:          ;DOWOD OSOBISTY
                mov statSW,1
                SKIPCOL
                mov cx,3
                call _GAIDFC
                jc @@esn
                mov cx,6
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                cmp cx,1
                jne @@esn
                jmp @@eop
;--------------------------------------------------------------------- /E ---
caseE:          ;EAN8 / EAN13
                mov statSW,9
                SKIPCOL
                mov cx,13
                call _GDIDFC
                dec cx
                cmp cx,0
                jne @@e8
                cmp BYTE PTR [si-1],SEP
                je @@esn
                jmp @@eop
          @@e8:
                cmp cx,5
                jne @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                jmp @@eop
;--------------------------------------------------------------------- /I ---
caseI:          ;ISBN / ISSN
                mov statSW,10
                SKIPCOL
                mov cx,9
                call _GDIDFC
                cmp cx,0
                jz @@gicn
                cmp cx,2
                jnz @@esn
                sub si,1
        @@gicn:
                lodsb
                cmp BYTE PTR [si],sep ;!
                je @@esn
                cmp al,'9'
                jbe @@din
                or al,TOL
                cmp al,'x'
                jne @@esn
                mov al,10
                stosw
                jmp @@eop
         @@din:
                cmp al,'0'
                jb @@esn
                sub al,'0'
                stosw
                jmp @@eop
;--------------------------------------------------------------------- /K ---
caseK:          ;KARTA KREDYTOWA
                mov statSW,6
                SKIPCOL
                mov cx,16
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                dec cx       ;!
                cmp cx,3
                ja @@esn     ;cx <0,3>
                jmp @@eop
;--------------------------------------------------------------------- /N ---
caseN:          ;NIP (PL)
                mov statSW,5
                SKIPCOL
                mov cx,10
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                cmp cx,1
                jne @@esn
                jmp @@eop
;--------------------------------------------------------------------- /P ---
caseP:          ;PESEL
                mov statSW,2
                SKIPCOL
                mov cx,11
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                cmp cx,1
                jne @@esn
                jmp @@eop
;--------------------------------------------------------------------- /R ---
caseR:          ;REGON
                mov statSW,7
                SKIPCOL
                mov cx,14
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                dec cx
                jz @@eop    ;REGON14
                cmp cx,5
                je @@eop    ;REGON9
                jmp @@esn
;--------------------------------------------------------------------- /S ---
caseS:          ;PASZPORT
                mov statSW,3
                SKIPCOL
                mov cx,2
                call _GAIDFC
                jc @@esn
                mov cx,7
                call _GDIDFC
                jc @@esn
                cmp BYTE PTR [si-1],SEP
                je @@esn
                cmp cx,1
                jne @@esn
                jmp @@eop
;--------------------------------------------------------------------- /W ---
caseW:          ;KSIEGA W.
                mov statSW,8
                SKIPCOL
                mov cx,2
          @@LL: ;LLCA/XXXXXXXX/K : bez Q i V, X=10
                lodsb
                CHKALPHA
                cmp al,'X'
                jne @@noX
                mov al,10
                jmp @@skP
         @@noX:
                sub al,'A'-11
                cmp al,26       ;.
                jbe @@skP       ;.
                sub al,1        ; . korekta wartosci dla liter:
                cmp al,30       ;.  po P nie ma Q i po U nie ma V
                jna @@skP       ;.
                sub al,1        ;.
         @@skP:
                stosw
                cmp BYTE PTR [si],SEP
                jne @@s1
                inc si
          @@s1:
                loop @@LL
                cmp BYTE PTR [si],SEP
                je @@esn
                lodsb ;D
                CHKDEC
                sub al,'0'
                stosw
                cmp BYTE PTR [si],SEP
                jne @@s2
                inc si
          @@s2:
                cmp BYTE PTR [si],SEP ;A
                je @@esn
                lodsb
                CHKALPHA
                cmp al,'X'
                jne @@noX2
                mov al,10
                jmp @@skP2
        @@noX2:
                sub al,'A'-11
                cmp al,26
                jbe @@skP2
                sub al,1
                cmp al,30
                jna @@skP2
                sub al,1
        @@skP2:
                stosw
                SKIPSEPKW
                mov cx,8 ;XXXXXXXX
         @@gxx:
                lodsb
                CHKDEC
                sub al,'0'
                stosw
                cmp BYTE PTR [si],SEP
                jne @@s3
                inc si
          @@s3:
                loop @@gxx
                cmp BYTE PTR [si],'/'
                jne @@cnum
                cmp BYTE PTR [si-1],SEP
                je @@esn
                inc si
        @@cnum:
                lodsb
                CHKDEC
                sub al,'0'
                stosw
                cmp BYTE PTR [si],SEP
                je @@esn
;----------------------------------------------------------------------------
@@eop:
                cmp BYTE PTR [si],CR
                je exitp
                cmp BYTE PTR [si],TAB
                je @@skp1
                cmp BYTE PTR [si],SPACE
                je @@skp1
                jmp @@ecl
        @@skp1:
                inc si
                jmp @@eop
exitp:
                mov ax,0
                ret
@@ecl:
                mov ax,1
                ret
@@esn:
                mov ax,2
                ret
GetIDfromCon    ENDP

_GDIDFC         PROC
                LOCALS
                lodsb
                CHKDEC
                sub al,'0'
                stosw
                cmp BYTE PTR [si],SEP
                jne @@skp
                inc si
         @@skp:
                cmp BYTE PTR [si],SPACE
                je @@eop
                cmp BYTE PTR [si],TAB
                je @@eop
                cmp BYTE PTR [si],CR
                je @@eop
                loop _GDIDFC
         @@esn:
                stc
                ret
         @@eop:
                clc
                ret
_GDIDFC         ENDP

_GAIDFC         PROC
                LOCALS
                lodsb
                and al,TOU
                cmp al,'A'
                jb @@esn
                cmp al,'Z'
                ja @@esn
                sub al,'A'-10
                stosw
                cmp BYTE PTR [si],SEP
                jne @@skp
                inc si
         @@skp:
                loop _GAIDFC
                clc
                ret
         @@esn:
                stc
                ret
_GAIDFC         ENDP
                END
