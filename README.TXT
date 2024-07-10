-----------------------------------------------------------------------------
     ** Sprawdz Numer Identyfikacyjny **
     **        SPRID ver. 2.3         **                   (c)1994 'marikaz'
-----------------------------------------------------------------------------
                                                                     MOD0724

Program sprawdza pod wzgledem FORMALNYM poprawnosc niektorych numerow
ewidencyjnych i seryjnych na podstawie cyfry kontrolnej. Nie weryfikuje
jednak ich SENSOWNOSCI poza (czesciowo) REGON14 i IBAN.
W aktualnej wersji (od v2.0) SPRID pracuje z OBECNIE (2023 rok) nadawanymi
w dokumentach numerami.

     OCENA POZ
     oznacza, ze sprawdzany numer jest potencjalnie prawidlowy
     czylijest zgodny ze wzorcem nadawania tego numeru, ale nie
     ma gwarancji, ze kiedykolwiek zostal nadany.

     OCENA NEG
     stwierdza jednoznacznie, ze numer jest NIEPRAWIDLOWY i nie
     powinien sie znalezsc w zadnym dokumencie.


     OBSLUGA
     -------

Skladnia:
          SPRID.COM {OPCJE[:]}<ID>

   OPCJE:
          /a[:]  IBAN (tylko PL)
          /b[:]  Numer ID Banku
          /d[:]  Dowod Osobisty
          /e[:]  EAN (8 lub 13 cyfr)
          /i[:]  ISBN/ISSN (stare) -> patrz Uwagi
          /k[:]  Numer Karty Platniczej
          /n[:]  NIP (tylko PL)
          /p[:]  PESEL
          /r[:]  REGON (9 lub 14 cyfr - patrz UWAGI)
          /s[:]  Paszport
          /w[:]  Numer Ksiegi Wieczystej (nowej)

      ID:
          Jak w dokumencie (bez spacji)

    Info:
          SPRID.COM /?

Linia polecen:

- Jezeli w numerze identyfikacyjnym wystepuja odstepy (spacje) nalezy je
  pominac, lub zastapic uniwersalnym separatorem: [-] znak minus.
- Separatory nie moga wystepowac bezposrednio po sobie oraz przed i po
  numerze.
- Wielkosc liter w opcjach i identyfikatorach nie ma znaczenia.
- Obcy znak w linii polecen wyswietli info (/?), natomiast blad w numerze
  identyfikacyjnym poda komunikat:

      Blad w numerze identyfikacyjnym.

Przyklad uzycia:

Dla ID banku prawidlowa linia polecen wyglada:

   najkrotsza: SPRID /b12345676
   najdluzsza: SPRID /b:1-2-3-4-5-6-7-6
     czytelna: SPRID /B:1234-5676


   UWAGI DO OPCJI
   --------------

- IBAN, opcja /A
  Tylko numery rachunkow nadawane w Polsce.
  W zwiazku z tym, prefix PL jest domyslny i mozna go pominac.

  WZOR: AAKKBBBBCCCDXXXXXXXXXXXXXXXX
          AA - prefiks kraju, tylko PL
          KK - suma kontrolna
        BBBB - identyfikator banku
         CCC - identyfikator oddzialu
           D - cyfra kontrolna
        X..X - cyfry ustalane przez bank wg. wlasnego klucza

  UWAGA!
  Numer IBAN zawiera numer ID banku - cyfry: BBBBCCCD.
  Opcja /A (IBAN) sprawdza najpierw ID banku (wewnetrznie wywoluje opcje /B)
  i dopiero PO stwierdzeniu poprawnosci tego numeru, sprawdza calosc.
  Dla oceny POZ oba te numery musza byc poprawne.

- Numer ID (odzialu) banku, opcja /B
  Jest to 8 cyfr wystepujacych na pozycjach od 3 do 10 w numerze konta,
  czyli numerze IBAN bez perfiksu PL.

- ISBN / ISSN, opcja /I
  Ta opcja jako jedyna operuje na starych numerach, obowiazujacych do 2007r.
  Obecnie te numery sa zgodne z EAN13 i musza byc sprawdzane opcja /E

- Numer karty platniczej, opcja /K
  Aktualnie powinny dzialac wszystkie karty (wszystkich organizacji), jednak
  trzeba miec na uwadze fakt, ze SPRID uzna za blad numery ponizej 13 cyfr
  i powyzej 16.

- NIP, opcja /N
  Numer NIP nadawany w Polsce.

- REGON, opcja /R
  Mozna sprawdzac wszystkie REGON-y (7, 9 i 14 cyfr) z tym, ze stary,
  7-cyfrowy REGON nalezy poprzedzic dwoma zerami.

   UWAGA na internetowe generatory REGON14!
   Programisci generatorow internetowych nie wiedza jak zbudowany
   jest REGON 14-cyfrowy i generuja przypadkowe ciagi aby tylko
   cyfra kontrolna calosci sie zgadzala. NIESTETY, TO NIE DZIALA.
   REGON-14 zawiera 2 numery REGON i 2 cyfry kontrolne.
   Oznacza to tyle, ze po usunieciu ostatnich 5 cyfr z REGON
   14-cyfr. powinien pozostac PRAWIDLOWY 9-cyfrowy REGON. Dlatego
   SPRID liczy oba te numery, najpierw dla pierwszych 9 cyfr jako
   REGON9 i dopiero PO stwierdzeniu poprawnosci sprawdza calosc.
   Dla oceny POZ oba te numery musza byc poprawne.

- Numer Nowej Ksiegi Wieczystej, opcja /W
  Identyfikator Nowej Ksiegi Wieczystej sklada sie z 3 grup znakow
  oddzielonych ukosnikiem: LLCL/CCCCCCCC/K
  L=litera, C=cyfra, K=cyfra kontrolna
  SPRID dopuszcza stosowanie ukosnikow tylko w miejscach gdzie formalnie
  wystepuja.

  UWAGA!
  Opcja najslabiej przetestowana (brak dostepnych generatorow).


      KOPMATYBILNOSC
      --------------
DOSBox v0.74-3 - kompilacja aktualnej wersji.
MS-DOS v5.0+   - na maszynie virtualnej.
MS-DOS v5.0+   - SPRID v1.0 na maszynie fizycznej.
                 Aktualnej wersji nie testowano.
FreeDOS v1.3   - na maszynie wirtualnej.


      ZROLDLA
      -------
R.J.Zylla   https://romek.info/ut/kody.html
GENAPPS.pl  https://www.genapps.pl - poprawnie dzialajace generatory
