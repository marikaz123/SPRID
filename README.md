## SPRID ver. 2.0 ++ Sprawdz Numer Identyfikacyjny ++ DOS, DOSBox
<sup>MOD0723, w ramach odkurzania starych dyskietek...</sup>

Program sprawdza pod względem FORMALNYM poprawność niektórych numerów ewidencyjnych i seryjnych na podstawie cyfry kontrolnej. Nie weryfikuje natomiast ich SENSOWNOŚCI. Oznacza to, że sprawdzany numer jest potencjalnie prawidłowy, ale nie ma gwarancji co do jego autentyczności.
### LINIA POLECEŃ
```
Składnia:
          SPRID.COM <opcja[:]><NUMERID>
Opcje:
          /b[:] - Numer Identyfikacyjny (oddzialu) Banku
          /d[:] - Dowod Osobisty
          /k[:] - Numer Karty Platniczej
          /n[:] - NIP
          /p[:] - PESEL
          /r[:] - REGON
          /s[:] - Paszport
          /w[:] - Numer (nowej) Ksiegi Wieczystej
NUMERID:
          Tak jak w dokumencie z zastrzezeniem ponizej.
```
#### Info:

         SPRID.COM
         SPRID.COM /?

#### Parser linii poleceń.
- Jeżeli w numerze identyfikacyjnym występują odstępy (spacje) należy je pominąć, lub zastąpić uniwersalnym separatorem (grupy) cyfr: `-`.
- Separatory nie mogą występować bezpośrednio po sobie, oraz przed i po numerze.   
  `SPRID /b:-1120--1021-    <- 3 bledy!`
- Dopuszczalny jest separator `/` ale tylko dla nowej Księgi Wieczystej i tylko w miejscach, w których tam formalnie występuje. Nie ma on wpływu na działanie separatora uniwersalnego.
- Wielkość liter w opcjach i identyfikatorach nie ma znaczenia.
- "Białe znaki" (spacja, tabulator) są ignorowane, ale tylko przed lub po prawidłowo wpisanej opcji z numerem.
- Obcy znak w linii poleceń wyświetli info (tak jak `/?`), natomiast błąd w numerze identyfikacyjnym poda komunikat:   
  `Blad w numerze seryjnym / ewidencyjnym`
#### Przykład użycia:
Dla ID oddziału banku prawidłowa linia poleceń wygląda:
```
     najkrótsza: SPRID /b12345676
     najdluzsza: SPRID /b:1-2-3-4-5-6-7-6
       czytelna: SPRID /b:1234-5676
```
### UZUPEŁNIENIE
- Numer ID odziału banku.    
  Jest to 8 cyfr występujacych na pozycjach od 3 do 10 w numerze konta.
- Dowód osobisty.    
  Nie wymaga komentarza.
- Numer karty płatniczej.    
  VISA 13 i 16 cyfr, MasterCard 16 cyfr, American Express 15 cyfr, Diners
  Club / Carte Blanche 14 cyfr, JBC 16 cyfr.
  Aktualnie powinny działać wszystkie karty (wszystkich organizacji), jednak trzeba mieć na uwadze fakt, ze SPRID uzna za bład numery poniżej 13 i powyżej 16 cyfr.
- NIP    
  Numer NIP nadawany w Polsce.
- PESEL    
  Ocena tylko na podstawie cyfry kontrolnej. (lepiej: [Check-PESEL](https://github.com/marikaz123/Check-PESEL))
- REGON    
  Można sprawdzać wszystkie REGON-y (7, 9 i 14 cyfr), z tym, że stary, 7-cyfrowy REGON należy poprzedzić dwoma zerami.
  
> UWAGA na internetowe generatory REGON-u 14-cyfrowego!
> Tzw. "programiści" nie wiedza jak zbudowany jest REGON 14-cyfrowy i generują przypadkowe ciągi, aby tylko cyfra kontrolna calości sie zgadzała. Niestety to nie działa. Pierwsze 9 cyfr REGON-u 14-cyfrowego to również REGON i również MUSI być prawidłowy, z prawidłową dla siebie cyfrą kontrolną. Tak, REGON14 zawiera DWIE cyfry kontrolne. SPRID liczy obie, najpierw dla pierwszych 9 cyfr jako REGON9 i, dopiero po potwierdzeniu zgodności, liczy calość. Jeżeli dla REGONU14 z generatora internetowego wypada ocena NEG, wystarczy sprawdzić pierwsze 9 cyfr i wszystko jasne.
- Paszport
  Nie wymaga komentarza.
- Numer Nowej Księgi Wieczystej    
  Identyfikator Nowej Księgi Wieczystej składa sie z 3 grup znaków oddzielonych ukośnikiem:
  
  ```
  Wzor: LLCL/CCCCCCCC/K
  L=litera, C=cyfra, K=cyfra kontrolna
  ```
  SPRID dopuszcza zastosowanie ukośnikow, ale tylko w miejscach jak we wzorze.
###### screenshot
![SPRID](/IMG/SPRID_V2.PNG)
### KOPMATYBILNOŚĆ
Program został przetestowany na:
- DOSBox v0-74-3 - skompilowano aktualną wersję.
- MS-DOS v5.0+   - na maszynie wirtualnej. (SPRID v1.1) rownież na maszynie fizycznej.
### ZRÓDŁA
Przede wszystkim: https://romek.info/ut/kody.html

###### SPRID <sub>v2.0</sub> (c)1994-2023 'marikaz'
