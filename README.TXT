-----------------------------------------------------------------------------
** SPRID ver. 2.0 ** Sprawdz Numer Identyfikacyjny ** (c)1994-2023 'marikaz'
-----------------------------------------------------------------------------

Program sprawdza pod wzgledem FORMALNYM poprawnosc niektorych numerow ewi-
dencyjnych i seryjnych na podstawie cyfry kontrolnej. Nie weryfikuje jednak
ich SENSOWNOSCI. Oznacza to, ze sprawdzany numer jest potencjalnie prawi-
dlowy, ale nie ma gwarancji co do jego autentycznosci.


   LINIA POLECEN
   --------------

Skladnia:
         SPRID.COM <opcja[:]><NUMERID>

  Opcje:
         /b[:] - Numer identyfikacyjny oddzialu banku
         /d[:] - Dowod osobisty
         /k[:] - Numer karty platniczej
         /n[:] - NIP
         /p[:] - PESEL
         /r[:] - REGON
         /s[:] - Paszport
         /w[:] - Numer nowej Ksiegi Wieczystej

NUMERID:
         Taki jak w dokumencie z zastrzezeniem ponizej.

   Info:
         SPRID.COM
         SPRID.COM /?

Parser linii polecen.

- Jezeli w numerze identyfikacyjnym wystepuja odstepy (spacje) nalezy je
  pominac, lub zastapic uniwersalnym separatorem (grupy) cyfr: '-'.

- Separatory nie moga wystepowac bezposrednio po sobie oraz przed i po
  numerze.
          SPRID /b:-1120--1021-    <- 3 bledy

- Dopuszczalny jest separator '/' ale tylko dla nowej Ksiegi Wieczystej
  i tylko w miejscach w ktorych tam formalnie wystepuje. Nie ma on
  wplywu na dzialanie separatora uniwersalnego z zastrzezeniem jak wyzej.

- Wielkosc liter w opcjach i numerach ID nie ma znaczenia.

- Biale znaki (spacja, tabulator) sa ignorowane ale tylko przed i po
  prawidlowo wpisanej opcji z numerem.

- Obcy znak w linii polecen wyswietli info (tak jak '/?'), natomiast
  blad w numerze poda komunikat: "Blad w numerze seryjnym/ewidencyjnym"

Przyklad uzycia:

Dla ID oddzialu banku prawidlowa linia polecen wyglada:
najkrotsza:
 SPRID /b12345676
i najdluzsza:
 SPRID /b:1-2-3-4-5-6-7-6
oraz czytelna:
 SPRID /b:1234-5676

   UZUPELNIENIE
   ------------
Do numerow seryjnych i ewidencyjnych.

- Numer ID odzialu banku.
  Jest to 8 cyfr wystepujacych na pozycjach od 3 do 10 w numerze konta.

- Dowod osobisty.
  Mie wymaga komentarza.

- Numer karty platniczej.
  VISA 13 i 16 cyfr, MasterCard 16 cyfr, American Express 15 cyfr, Diners
  Club / Carte Blanche 14 cyfr, JBC 16 cyfr.
  Aktualnie powinny dzialac wszystkie karty (wszystkich organizacji), jednak
  trzeba miec na uwadze fakt, ze SPRID uzna za blad numery ponizej 13 cyfr
  i powyzej 16.

- NIP
  Numer NIP nadawany w Polsce.

- PESEL
  Ocena tylko na podstawie cyfry kontrolnej. (lepiej: CHKPESEL)

- REGON
  Mozna sprawdzac wszystkie REGON-y (7, 9 i 14 cyfr).
  Z tym, ze stary, 7-cyfrowy REGON nalezy poprzedzic dwoma zerami.

  Wazna UWAGA na temat REGON-u 14-cyfrowego!

  Podczas wlasnych testow SPRID-a nalezy uwazac na generatory internetowe.
  'Programisci' nie wiedza jak zbudowany jest REGON 14-cyfrowy i generuja
  przypadkowe ciagi aby tylko cyfra kontrolna calosci sie zgadzala.
  Niestety to nie dziala. Prawidlowy REGON14 musi zawierac w sobie PRAWIDLOWY
  REGON9 z PRAWIDLOWA dla siebie cyfra kontrolna.
  Tak, REGON14 zawiera DWIE cyfry kontrolne.
  SPRID liczy obie, najpierw dla pierwszych 9 cyfr jako REGON9 i dopiero po
  stwierdzeniu zgodnosci liczy calosc.
  Jezeli dla REGONU14 z generatora intern. ocena wypada NEG, wystarczy
  sprawdzic pierwsze 9 cyfr. Wtedy ocena NEG wszystko wyjasnia.

- Paszport
  Nie wymaga komentarza.

- Numer Ksiegi Wieczystej

   KOPMATYBILNOSC
   --------------
   Program zostal przetestowany dla:
   DOSBox v0-74-3
   MS-DOS v5.0, 6.22 na maszynie virtualnej
   MS-DOS v5.0+ (SPRID v1.1) rowniez na maszynie fizycznej.

   ZROLDLA
   -------
   Przede wszystkim:
   https://romek.info/ut/kody.html

---/ EOF /---------------------------------------------------/ SPRID v2.0 /--