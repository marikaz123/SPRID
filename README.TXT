-----------------------------------------------------------------------------
     ** Sprawdz Numer Identyfikacyjny **
     **        SPRID ver. 2.1         **               (c)1994-2023 'marikaz'
-----------------------------------------------------------------------------

Program sprawdza pod wzgledem FORMALNYM poprawnosc niektorych numerow ewi-
dencyjnych i seryjnych na podstawie cyfry kontrolnej. Nie weryfikuje jednak
ich SENSOWNOSCI.

Ocena POZ oznacza, ze sprawdzany numer jest potencjalnie prawidlowy, ale
nie ma gwarancji, ze kiedykolwiek zostal nadany.

Ocena NEG oznacza jednoznacznie, ze numer jest nieprawidlowy i nie powinien
znalezc sie w zadnym dokumencie.

 UWAGA!
 SPRID w aktualnej wersji (od v2.0) pracuje z AKTUALNIE (2023 rok)
 nadawanymi w dokumentach numerami (poza ISBN/ISSN).


     OBSLUGA
     -------

Skladnia:
          SPRID.COM {Opcje[:]}<ID>

   Opcje:
          /b[:]  Numer Rozliczeniowy Banku
          /d[:]  Dowod Osobisty
          /e[:]  EAN (8 lub 13 cyfr)
          /i[:]  ISBN / ISSN (stare)
          /k[:]  Numer Karty Platniczej
          /n[:]  NIP
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
  pominac, lub zastapic uniwersalnym separatorem (grupy) cyfr: ' - '.
- Separatory nie moga wystepowac bezposrednio po sobie oraz przed i po
  numerze.
- Wielkosc liter w opcjach i identyfikatorach nie ma znaczenia.
- Biale znaki (spacja, tabulator) sa ignorowane tylko przed lub po
  wpisanej opcji z numerem.
- Obcy znak w linii polecen wyswietli info (tak jak '/?'), natomiast
  blad w numerze identyfikacyjnym poda komunikat:

      Blad w numerze seryjnym / ewidencyjnym.

Przyklad uzycia:

Dla ID oddzialu banku prawidlowa linia polecen wyglada:

   najkrotsza: SPRID /b12345676
   najdluzsza: SPRID /b:1-2-3-4-5-6-7-6
     czytelna: SPRID /b:1234-5676


   UWAGI
   -----

- Numer rozliczeniowy odzialu banku.
  Jest to 8 cyfr wystepujacych na pozycjach od 3 do 10 w numerze konta.

- ISBN / ISSN
  Stare numery obowiazujace do 2007 roku. Obecne te numery sa zgodne
  z EAN13 i powinny byc sprawdzane opcja /e (EAN).

- Numer karty platniczej.
  Aktualnie powinny dzialac wszystkie karty (wszystkich organizacji), jednak
  trzeba miec na uwadze fakt, ze SPRID uzna za blad numery ponizej 13 cyfr
  i powyzej 16.

- NIP
  Numer NIP nadawany w Polsce.

- REGON
  Mozna sprawdzac wszystkie REGON-y (7, 9 i 14 cyfr) z tym ze stary,
  7-cyfrowy REGON nalezy poprzedzic dwoma zerami.

     ======================================================================
       UWAGA dla osob chcacych testowac ta opcje z REGON-em 14-cyfrowym!
     ======================================================================
     'Programisci' generatorow internetowych nie wiedza jak zbudowany
     jest REGON 14-cyfrowy i generuja przypadkowe ciagi aby tylko cyfra
     kontrolna calosci sie zgadzala.
     NIESTETY, TO NIE DZIALA.
     REGON-14 zawiera 2 numery REGON i 2 cyfry kontrolne dla kazdego z nich.
     Oznacza to tyle, ze po usunieciu ostatnich 5 cyfr z REGON-u
     14 cyfrowego powinien pozostac PRAWIDLOWY 9-cyfrowy REGON. Dlatego
     SPRID sprawdza oba te numery, najpierw dla pierwszych 9 cyfr jako REGON9
     i dopiero po stwierdzeniu poprawnosci sprawdza calosc.
     Jezeli dla REGONU 14-cyf. z generatora internetowego wypada ocena NEG,
     wystarczy sprawdzic pierwsze 9 cyfr tego numeru...

- Numer Nowej Ksiegi Wieczystej
  Identyfikator Nowej Ksiegi Wieczystej sklada sie z 3 grup znakow
  oddzielonych ukosnikiem:
  Wzor: LLCL/CCCCCCCC/K
  L=litera, C=cyfra, K=cyfra kontrolna
  SPRID dopuszcza zastosowanie ukosnikow tylko w miejscach gdzie formalnie
  wystepuja.


      KOPMATYBILNOSC
      --------------
  DOSBox v0.74-3 - przeprowadzono kompilacje aktualnej wersji.
  MS-DOS v5.0+   - na maszynie virtualnej.
  MS-DOS v5.0+   - SPRID v1.0 rowniez na maszynie fizycznej.


      ZROLDLA
      -------
https://romek.info/ut/kody.html

