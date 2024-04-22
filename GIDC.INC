;--------------------------------------------------------/ Part of SPRID /---

GetIDfromCon     PROC
                 LOCALS
                 mov si,80h
                 cmp BYTE PTR [si],1
                 je @@exit
                 xor ax,ax
                 mov di,OFFSET id
                 inc si
                 cld
       @@findSw:
                 lodsb
                 cmp al,9
                 je @@findSw
                 cmp al,20h
                 je @@findSw
                 cmp al,0dh
                 je @@exit
                 cmp al,'/'
                 jne @@exit

                 lodsb
                 or al,100000b
                 cmp al,'b'
                 je @@switchB
                 cmp al,'d'
                 je @@switchD
                 cmp al,'e'
                 je @@switchE
                 cmp al,'i'
                 je @@switchI
                 cmp al,'k'
                 je @@switchK
                 cmp al,'n'
                 je @@switchN
                 cmp al,'p'
                 je @@switchP
                 cmp al,'r'
                 je @@switchR
                 cmp al,'s'
                 je @@switchS
                 cmp al,'w'
                 je @@switchW
                 jmp @@exit
@@switchB:       ;---------------------------------------------------- /b ---
                 lodsb
                 cmp al,':'
                 je @@b
                 dec si
            @@b:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,4
                 mov cx,8
                 jmp @@getDigits
@@switchD:       ;---------------------------------------------------- /d ---
                 lodsb
                 cmp al,':'
                 je @@d
                 dec si
            @@d:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,1
                 mov cx,3
        @@getLD:
                 lodsb
                 cmp al,'-'
                 jne @@skp0
                 lodsb
         @@skp0:
                 and al,11011111b
                 cmp al,'A'
                 jb @@err1
                 cmp al,'Z'
                 ja @@err1
                 sub al,'A'
                 stosw
                 loop @@getLD
                 mov cx,6
                 jmp @@getDigits
@@switchE:       ;---------------------------------------------------- /e ---
                 lodsb
                 cmp al,':'
                 je @@e
                 dec si
            @@e:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,9
                 mov cx,13
@@getDigitsE:
                 lodsb
                 cmp al,'-'
                 jne @@skp10
                 lodsb
        @@skp10:
                 cmp al,30h
                 jb @@lLoopE
                 cmp al,39h
                 ja @@err1
                 sub al,'0'
                 stosw
                 loop @@getDigitsE
                 jmp @@skipBC
       @@lLoopE:
                 cmp cx,5
                 jne @@err1
                 dec si
                 cmp BYTE PTR [si-1],'-'
                 je @@err1
                 jmp @@skipBC
@@switchI:       ;---------------------------------------------------- /i ---
                 lodsb
                 cmp al,':'
                 je @@i
                 dec si
            @@i:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,10
                 mov cx,10
@@getDigitsI:
                 lodsb
                 cmp al,'-'
                 jne @@skp11
                 lodsb
        @@skp11:
                 cmp al,30h
                 jb @@chkISSN
                 cmp al,39h
                 ja @@chkX1
                 sub al,30h
                 stosw
                 loop @@getDigitsI
                 jmp  @@skipBC
      @@chkISSN:
                 cmp cx,2
                 jne @@err1
                 dec si                  ;korekta
                 cmp byte ptr [si-1],'-'
                 je @@err1
                 jmp @@skipBC
        @@chkX1:
                 dec cx            ;korekta (bo nie cyfra)
                 cmp cx,2
                 jne @@chkX2
                 or al,100000b
                 cmp al,'x'
                 jne @@err1
                 mov al,10
                 stosw
                 jmp @@skipBC
        @@chkX2:
                 cmp cx,0
                 jne @@err1
                 or al,100000b
                 cmp al,'x'
                 jne @@err1
                 mov al,10
                 stosw
                 jmp @@skipBC
@@switchK:       ;---------------------------------------------------- /k ---
                 lodsb
                 cmp al,':'
                 je @@k
                 dec si
            @@k:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,6
                 mov cx,16
@@getDigitsK:
                 lodsb
                 cmp al,'-'
                 jne @@skp3
                 lodsb
         @@skp3:
                 cmp al,30h
                 jb @@lLoopK
                 cmp al,39h
                 ja @@err1
                 sub al,'0'
                 stosw
                 loop @@getDigitsK
                 jmp @@skipBC
       @@lLoopK:
                 cmp cx,3
                 ja @@err1
                 dec si
                 cmp BYTE PTR [si-1],'-'
                 je @@err1
                 jmp @@skipBC
@@switchN:       ;---------------------------------------------------- /n ---
                 lodsb
                 cmp al,':'
                 je @@n
                 dec si
            @@n:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,5
                 mov cx,10
                 jmp @@getDigits
@@switchP:       ;---------------------------------------------------- /p ---
                 lodsb
                 cmp al,':'
                 je @@p
                 dec si
            @@p:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,2
                 mov cx,11
                 jmp @@getDigits
@@switchR:       ;---------------------------------------------------- /r ---
                 lodsb
                 cmp al,':'
                 je @@r
                 dec si
            @@r:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,7
                 mov cx,14
@@getDigitsR:
                 lodsb
                 cmp al,'-'
                 jne @@skp4
                 lodsb
         @@skp4:
                 cmp al,30h
                 jb @@lLoopR
                 cmp al,39h
                 ja @@err1
                 sub al,'0'
                 stosw
                 loop @@getDigitsR
                 jmp @@skipBC
       @@lLoopR:
                 cmp cx,5
                 jne @@err1
                 dec si
                 cmp BYTE PTR [si-1],'-'
                 je @@err1
                 jmp @@skipBC
@@switchS:       ;---------------------------------------------------- /s ---
                 lodsb
                 cmp al,':'
                 je @@s
                 dec si
            @@s:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,3
                 mov cx,2
        @@getLS:
                 lodsb
                 cmp al,'-'
                 jne @@skp1
                 lodsb
         @@skp1:
                 and al,11011111b
                 cmp al,'A'
                 jb @@err1
                 cmp al,'Z'
                 ja @@err1
                 sub al,'A'
                 stosw
                 loop @@getLS
                 mov cx,7
                 jmp @@getDigits
@@switchW:       ;---------------------------------------------------- /w ---
                 lodsb
                 cmp al,':'
                 je @@w
                 dec si
            @@w:
                 cmp BYTE PTR [si],'-'
                 je @@err1
                 mov statSW,8
                 ;LL**/********/*
                 mov cx,2
        @@getDW:
                 lodsb
                 cmp al,'-'
                 jne @@skp5
                 lodsb
         @@skp5:
                 and al,11011111b
                 cmp al,'X'
                 jne @@skpX0
                 mov al,10          ;Wartosc dla X = 10
                 stosw
                 jmp @@loopGDW
        @@skpX0:
                 cmp al,'A'
                 jb @@err1
                 cmp al,'Z'
                 ja @@err1
                 cmp al,'Q'
                 je @@err1
                 sub al,54
                 cmp al,26
                 ja @@subQ0 ;odejmij 1 od wartosci liter > Q
                 stosw
                 jmp @@loopGDW
        @@subQ0:
                 dec ax
                 stosw
      @@loopGDW:
                 loop @@getDW
                 ;**D*/********/*
                 lodsb
                 cmp al,'-'
                 jne @@skp6
                 lodsb
         @@skp6:
                 cmp al,'0'
                 jb @@err1
                 cmp al,'9'
                 ja @@err1
                 sub al,'0'
                 stosw
                 ;***L/********/*
                 lodsb
                 cmp al,'-'
                 jne @@skp7
                 lodsb
         @@skp7:
                 and al,11011111b
                 cmp al,'X'
                 jne @@skpX1
                 mov al,10         ;Wartosc dla X = 10
                 stosw
                 jmp @@get8dig
        @@skpX1:
                 cmp al,'A'
                 jb @@err1
                 cmp al,'Z'
                 ja @@err1
                 cmp al,'Q'
                 je @@err1
                 sub al,54
                 cmp al,26
                 ja @@subQ1
                 jmp @@storL
        @@subQ1:
                 dec al
        @@storL:
                 stosw
      @@get8dig:
                 ;****/DDDDDDDD/*
                 mov cx,8
                 lodsb
                 cmp al,'/'
                 je @@skp0s
                 dec si
      @@getDigW:
                 lodsb
                 cmp al,'-'
                 jne @@skp8
        @@skp0s:
                 lodsb
         @@skp8:
                 cmp al,'0'
                 jb @@err1
                 cmp al,'9'
                 ja @@err1
                 sub al,'0'
                 stosw
                 loop @@getDigW
                 ;****/********/C
                 lodsb
                 cmp al,'/'
                 je @@skp1s
                 dec si
                 lodsb
                 cmp al,'-'
                 jne @@skp9
        @@skp1s:
                 lodsb
         @@skp9:
                 cmp al,'0'
                 jb @@err1
                 cmp al,'9'
                 ja @@err1
                 sub al,'0'
                 stosw
                 jmp @@skipBC
@@getDigits:
                 lodsb
                 cmp al,'-'
                 jne @@skp2
                 lodsb
         @@skp2:
                 cmp al,30h
                 jb @@err1
                 cmp al,39h
                 ja @@err1
                 sub al,'0'
                 stosw
                 loop @@getDigits
@@skipBC:
                 lodsb
                 cmp al,20h
                 je @@skipBC2
                 cmp al,9
                 je @@skipBC2
                 cmp al,0dh
                 je @@exit
                 jmp @@err1
@@skipBC2:
                 lodsb
                 cmp al,20h
                 je @@skipBC2
                 cmp al,9
                 je @@skipBC2
                 cmp al,0dh
                 je @@exit
                 mov statSW,0
@@exit:
                 ret
@@err1:
                 mov ax,-1        ;blad linii polecen
                 ret
GetIDfromCon     ENDP
