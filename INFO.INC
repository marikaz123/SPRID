;--------------------------------------------------------/ Part of SPRID /---

infoMsg DB 13,10," SPRID ver. 2.1 * Sprawdz Numer Identyfikacyjny * (c)1994-2023 'marikaz'",13,10
DB 13,10
DB ' Program sprawdza pod wzgledem FORMALNYM poprawnosc niektorych numerow',13,10
DB ' ewidencyjnych i seryjnych. NIE WERYFIKUJE NATOMIAST ICH SENSOWNOSCI.',13,10
DB 13,10
DB ' Uzycie:',13,10
DB '         sprid <Opcja[:]><ID>',13,10
DB '  Opcje:',13,10
DB '         /b  Nr Rozliczeniowy Banku       /d  Dowod Osobisty',13,10
DB '         /e  EAN (8 lub 13 cyfr)          /i  ISBN / ISSN (stare)',13,10
DB '         /k  Karta Platnicza              /n  NIP',13,10
DB '         /p  PESEL                        /r  REGON (9 lub 14 cyfr)',13,10
DB '         /s  Paszport                     /w  Ksiega Wieczysta (nowa)',13,10
DB '     ID:',13,10
DB '         Jak w dokumencie. Jezeli w ID wystepuja spacje nalezy je pominac',13,10
DB "         lub zastapic znakiem ' - ' (myslnik).",13,10
DB 13,10
DB ' Szczegolowe informacje znajduja sie w README.TXT ',13,10
DB '$'