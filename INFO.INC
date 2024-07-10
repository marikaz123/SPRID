;-----------------------------------------------------------/ SPRID v2.3 /---

infoMsg DB "SPRID ver. 2.3 * Sprawdz Numer Identyfikacyjny * (c)1994 'marikaz'",13,10
DB 13,10
DB 'Program sprawdza pod wzgledem formalnym poprawnosc niektorych numerow',13,10
DB 'seryjnych i ewidencyjnych. NIE WERYFIKUJE NATOMIAST ICH SENSOWNOSCI.',13,10
DB 'Szczegolowe informacje w README.TXT.',13,10
DB 13,10
DB '   SPRID.COM {OPCJE[:]}<ID>',13,10
DB 13,10
DB ' OPCJE:  /A  IBAN (PL)                   /B  ID Banku',13,10
DB '         /D  Dowod Osobisty              /E  EAN (8 lub 13 cyfr)',13,10
DB '         /I  ISBN/ISSN (stare)           /K  Karta Platnicza',13,10
DB '         /N  NIP (PL)                    /P  PESEL',13,10
DB '         /R  REGON (9 lub 14 cyfr)       /S  Paszport',13,10
DB '         /W  Ksiega Wieczysta (nowa)',13,10
DB 13,10
DB '    ID:  Jak w dokumencie.',13,10
DB '         Odstepy nalezy pominac lub zastapic znakiem minus [-].',13,10
DB '$'
