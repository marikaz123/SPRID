## SPRID ver. 2.0 ++ Sprawdz Numer Identyfikacyjny ++ dla DOS (DOSBox)
<sup>MOD0923, w ramach odkurzania starych dyskietek...</sup>

Program sprawdza pod względem FORMALNYM poprawność niektórych numerów ewidencyjnych i seryjnych na podstawie cyfry kontrolnej. Nie weryfikuje natomiast ich SENSOWNOŚCI. Oznacza to, że sprawdzany numer jest potencjalnie prawidłowy, ale nie ma gwarancji co do jego autentyczności.

### OBSŁUGA
```
Składnia:
          SPRID.COM <opcja[:]><ID>
   Opcje:
          /b[:] - Numer Identyfikacyjny (oddzialu) Banku
          /d[:] - Dowod Osobisty
          /e[:] - EAN (8 lub 13 cyfr)
          /i[:] - ISBN / ISSN (stare)
          /k[:] - Numer Karty Platniczej
          /n[:] - NIP
          /p[:] - PESEL
          /r[:] - REGON (9 lub 14 cyfr)
          /s[:] - Paszport
          /w[:] - Numer Ksiegi Wieczystej (nowej)
      ID:
          Jak w dokumencie (bez spacji).
```
#### Info:

         SPRID.COM [/?]

#### Linia poleceń.
- Jeżeli w numerze identyfikacyjnym występują odstępy (spacje) należy je pominąć, lub zastąpić uniwersalnym separatorem cyfr: `-`.
- Separatory nie mogą występować bezpośrednio po sobie, oraz przed i po numerze.   
- Wielkość liter w opcjach i identyfikatorach nie ma znaczenia.
- "Białe znaki" (spacja, tabulator) są ignorowane, ale tylko przed lub po prawidłowo wpisanej opcji z numerem.
- "Obcy" znak w linii poleceń wyświetli info (tak jak `/?`), natomiast błąd w numerze identyfikacyjnym poda komunikat:   
  `Blad w numerze seryjnym / ewidencyjnym`
#### Przykład użycia:
Dla rachunku rozliczeniowego banku prawidłowa linia poleceń wygląda:
```
     najkrótsza: SPRID /b12345676
     najdluzsza: SPRID /b:1-2-3-4-5-6-7-6
       czytelna: SPRID /b:1234-5676
```
### UWAGI
- Numer ID odziału banku.    
  Jest to 8 cyfr występujacych na pozycjach od 3 do 10 w numerze konta.
- ISBN / ISSN   
  Chodzi o stare numery (sprzed chyba 2007 roku). Obecnie te numery są zgodne z EAN13.
- Numer karty płatniczej.    
  Aktualnie powinny działać wszystkie karty (wszystkich organizacji), jednak trzeba mieć na uwadze fakt, ze SPRID uzna za bład numery poniżej 13 i powyżej 16 cyfr.
- NIP    
  Numer NIP nadawany w Polsce.
- PESEL    
  Ocena tylko na podstawie cyfry kontrolnej. (lepiej: [Check-PESEL](https://github.com/marikaz123/Check-PESEL))
- REGON    
  Można sprawdzać wszystkie REGON-y (7, 9 i 14 cyfr) z tym, że stary, 7-cyfrowy REGON należy poprzedzić dwoma zerami.
   
  #### UWAGA na internetowe generatory REGON-u 14-cyfrowego!
  **"Programiści" nie wiedza jak zbudowany jest REGON 14-cyfrowy i generują przypadkowe ciągi, aby tylko cyfra kontrolna calości się zgadzała.   
  Niestety to nie działa.   
  Pierwsze 9 cyfr REGON-u 14-cyfrowego to również REGON i również MUSI być prawidłowy, z prawidłową dla siebie cyfrą kontrolną. REGON14 zawiera de facto DWIE cyfry kontrolne. SPRID liczy obie. Najpierw dla 
  pierwszych 9 cyfr jako REGON9 i dopiero po potwierdzeniu zgodności, liczy calość. Jeżeli dla REGONU14 z generatora internetowego wypada ocena NEG, wystarczy sprawdzić pierwsze 9 cyfr i wszystko jasne.**

- Numer Nowej Księgi Wieczystej    
  Identyfikator Nowej Księgi Wieczystej składa sie z 3 grup znaków oddzielonych ukośnikiem:
  
  ```
  Wzor: LLCL/CCCCCCCC/K
  L=litera, C=cyfra, K=cyfra kontrolna
  ```
  SPRID dopuszcza zastosowanie ukośnikow, ale tylko w miejscach, gdzie formalnie występują, czyli jak we wzorze.
###### screenshot
![SPRID](/IMG/SPRID_V2.PNG)
### KOPMATYBILNOŚĆ
Program został przetestowany na:
- DOSBox v0-74-3 - skompilowano aktualną wersję.
- MS-DOS v5.0+   - na maszynie wirtualnej. V1.1 również na maszynie fizycznej.
### ZRÓDŁA
Przede wszystkim: https://romek.info/ut/kody.html

###### SPRID <sub>v2.1</sub> (c)1994-2023 'marikaz'
