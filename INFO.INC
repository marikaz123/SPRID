
;----------/ Part of SPRID v2.0 /---

infoMsg DB 13,10," SPRID  ver. 2.0 :: Sprawdz Numer Identyfikacyjny :: (c)1994-2023 'marikaz'",13,10
        DB '----------------------------------------------------------------------------',13,10
        DB ' Program sprawdza pod wzgledem FORMALNYM poprawnosc niektorych numerow',13,10
        DB ' ewidencyjnych i seryjnych. NIE WERYFIKUJE NATOMIAST ICH SENSOWNOSCI.',13,10,13,10
        DB ' Uzycie:',13,10
        DB '         sprid <Opcja[:]><ID>',13,10
        DB '  Opcje:',13,10
        DB '         /b - ID Oddzialu Banku (1)     /d - Dowod Osobisty',13,10
        DB '         /k - Numer Karty Platniczej    /n - NIP',13,10
        DB '         /p - PESEL                     /r - REGON (9 lub 14 cyfr) (2)',13,10
        DB '         /s - Paszport                  /w - Numer Nowej Ksiegi Wieczystej',13,10
        DB '     ID:',13,10
        DB '         Jak w dokumencie (3)',13,10
        DB ' ----- ',13,10
        DB ' (1) ID oddzialu banku to cyfry od 3 do 10 numeru konta.',13,10
        DB ' (2) Mozna takze sprawdzic stary numer 7-cyfrowy, ale w takim przypadku przed',13,10
        DB "     numerem nalezy dopisac dwa zera.",13,10
        DB ' (3) Jezeli w numerze wystepuja odstepy (spacje) nalezy je pominac albo',13,10
        DB "     zastapic myslnikiem '-'. Myslnik moze rowniez posluzyc jako uniwersalny",13,10
        DB '     separator grupy cyfr. Nigdzie nie jest jednak wymagany.',13,10,13,10
        DB ' Pozostale wazne informacje znajduja sie w pliku README.TXT',13,10
        DB '$'