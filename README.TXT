-----------------------------------------------------------------------------
     ** Sprawdz Numer Identyfikacyjny **
            ** SPRID ver. 2.1 **                       (c)1994-2023 'marikaz'
-----------------------------------------------------------------------------
                                                                Mod. 10/2023

Program sprawdza pod wzgledem FORMALNYM poprawnosc niektorych numerow ewi-
dencyjnych i seryjnych na podstawie cyfry kontrolnej. Nie weryfikuje jednak
ich SENSOWNOSCI. Oznacza to, ze sprawdzany numer jest potencjalnie prawi-
dlowy, ale nie ma gwarancji co do jego autentycznosci.


     OBSLUGA
     -------

Skladnia:
          SPRID.COM <opcja[:]><ID>

   Opcje:
          /b[:] - Numer Rozliczeniowy Banku
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
          Jak w dokumencie (bez spacji)

    Info:
          SPRID.COM [/?]

Linia polecen:

- Jezeli w numerze identyfikacyjnym wystepuja odstepy (spacje) nalezy je
  pominac, lub zastapic uniwersalnym separatorem (grupy) cyfr: '-'.

- Separatory nie moga wystepowac bezposrednio po sobie oraz przed i po
  numerze.

- Wielkosc liter w opcjach i identyfikatorach nie ma znaczenia.

- Biale znaki (spacja, tabulator) sa ignorowane ale tylko przed lub po
  prawidlowo wpisanej opcji z numerem.

- Obcy znak w linii polecen wyswietli info (tak jak '/?'), natomiast
  blad w numerze identyfikacyjnym poda komunikat:

      Blad w numerze seryjnym / ewidencyjnym

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
  Stare numery obowiazujace do 2007 roku. Obecne numery sa zgodne
  z EAN13 i powinny byc sprawdzane ta opcja.

- Numer karty platniczej.
  Aktualnie powinny dzialac wszystkie karty (wszystkich organizacji), jednak
  trzeba miec na uwadze fakt, ze SPRID uzna za blad numery ponizej 13 cyfr
  i powyzej 16.

- NIP
  Numer NIP nadawany w Polsce.

- REGON
  Mozna sprawdzac wszystkie REGON-y (7, 9 i 14 cyfr) z tym, ze stary,
  7-cyfrowy REGON nalezy poprzedzic dwoma zerami.

  !UWAGA na internetowe generatory REGON-u 14-cyfrowego!
  'Programisci' nie wiedza jak zbudowany jest REGON 14-cyfrowy i generuja
  przypadkowe ciagi aby tylko cyfra kontrolna calosci sie zgadzala.
  Niestety to nie dziala.
  Pierwsze 9 cyfr REGON-u 14-cyfrowego to rowniez REGON i rowniez MUSI
  byc prawidlowy, z prawidlowa dla siebie cyfra kontrolna. REGON14 zawiera
  de facto 2 cyfry kontrolne.
  SPRID liczy obie, najpierw dla pierwszych 9 cyfr jako REGON9 i dopiero po
  stwierdzeniu zgodnosci liczy calosc.
  Jezeli dla REGONU14 z generatora internetowego wypada ocena NEG, wystarczy
  sprawdzic pierwsze 9 cyfr. Wtedy ocena NEG to wyjasnia.

- Numer Nowej Ksiegi Wieczystej
  Identyfikator Nowej Ksiegi Wieczystej sklada sie z 3 grup znakow
  oddzielonych ukosnikiem:
  Wzor: LLCL/CCCCCCCC/K
  L=litera, C=cyfra, K=cyfra kontrolna
  SPRID dopuszcza zastosowanie ukosnikow tylko w miejscach jak we wzorze.

      KOPMATYBILNOSC
      --------------
  Program zostal przetestowany dla:
  DOSBox v0-74-3 - przeprowadzono kompilacje aktualnej wersji.
  MS-DOS v5.0+   - na maszynie virtualnej.
  MS-DOS v5.0+   - SPRID v1.1 rowniez na maszynie fizycznej.

      ZROLDLA
      -------
  https://romek.info/ut/kody.html
  Wikipedia
