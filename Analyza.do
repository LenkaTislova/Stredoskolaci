*** Analýza dat k BP ***

clear

*Adresar
capture cd c:/BP/

** soubor s vysledky
capture log close
log using "Analyza", text replace

*Nacteni
import excel "C:\BP\Template.xlsx", sheet("Celý") firstrow

lab var Skola "gymnazium nebo uciliste"
lab def sko 1 "Gymnazium" 2 "Uciliste"

***Obecne info***
tab2 A Skola, mis col

*prestiz
mean L if Skola==1
mean L if Skola==2

*priprava do zivota jejich skoly
ttest La==Lb if Skola==1
ttest La==Lc if Skola==2

ttest Lc, by(Skola)

***H1***
recode F3 (66 = 1) (0/10 = 0), gen(nezna)
recode F1-F3 (66 = .)

ttest F2==F1 if Skola==1
ttest F2==F1 if Skola==2

ttest F3==F2 if Skola==1
ttest F3==F2 if Skola==2

ttest F1==F3 if Skola==1
ttest F1==F3 if Skola==2

ttest F1, by(Skola)
ttest F2, by(Skola)
ttest F3, by(Skola)

*Celkovy pocet vazeb
ttest G1, by (Skola)
ttest G2, by (Skola)
ttest G3, by (Skola)

ttest K1, by(Skola)
ttest K3, by(Skola)

*reg M2 K3
*reg M2 K3 if Skola==1
*reg M2 K3 if Skola==2

**Vyroky*
*recode M1-M6 (666 = .)
*graph box M1-M6, over(Skola) legend(cols(1))

ttest M1, by (Skola)
ttest M2, by (Skola)
ttest M3, by (Skola)
ttest M4, by (Skola)
ttest M5, by (Skola)
ttest M6, by (Skola)

ttest M5 if J4==1, by (Skola) 
ttest M6 if J4==1, by (Skola)

ttest M1 if J4==1, by (Skola)
ttest M3 if J4==1, by (Skola)

*ttest M1 if nezna==1, by(Skola) //nezna z F3 - nezná tam nikoho, nemuze soudit
*ttest M6 if nezna==1, by(Skola)
*ttest M1 if Skola==2, by(nezna)
*ttest M1 if Skola==1, by(nezna)
*ttest M3 if Skola==1, by(nezna)


reg M1 c.J1##Skola

//graph box La Lb Lc, over(Skola) legend(cols(1))
//graph box F1-F3, over(Skola) legend(cols(1))

***Predsudky***
*Hodnoceni skol*
//vztah skola + pohlaví + L ??? jak
*tab2 L Skola, mis col //uarazeni sve skoly s ohledem na pestiz
*tab2 La Skola, mis col //tva skola pripravila do zivota
*tab2 Lc Skola, mis col //druhé skoly

*Vyroky*
*tab2 M1Skola, mis col
*tab2 M2 Skola, mis col
*tab2 M3 Skola, mis col
*tab2 M4 Skola, mis col
*tab2 M5 Skola, mis col
*tab2 M6 Skola, mis col

***Socialni kapital***
*tab2 Skola F1, mis col
*tab2 Skola F2, mis col
*tab2 Skola F3, mis col //vztah k lidem z ...

**Vzdelani rodicu**
*tab2 Skola C, mis col
*tab2 Skola D, mis col

*reg Skola A
*reg Skola C D
*reg A C D i.Skola

*reg Skola L
*reg Skola L M4

*reg Evenku G1
*reg Evenku G1 G2
*reg Skola Evenku G1 G2

log close
exit





