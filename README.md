# Splošno zdravstveno stanje in splošno zadovoljstvo z življenjem oseb v Sloveniji

Avtor: Mirjam Pergar

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Naslov mojega projekta je Splošno zdravstveno stanje in splošno zadovoljstvo z življenjem oseb v Sloveniji. 

Projekt se bo ukvarjal z analiziranjem splošnega zdravstvenega stanja oseb glede na starost in spol in splošnim zadovoljstvom z življenjem oseb v Sloveniji glede na spol, starost, zdravstveno stanje in glede na regije.

Vse podatke bom pridobila s SURS-a iz naslednjih povezav:

1.) http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0868510S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/17_silc_zdravje/05_08685_splosno_zdravst_stanje/&lang=2

2.) http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0868515S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/17_silc_zdravje/05_08685_splosno_zdravst_stanje/&lang=2

3.) http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0872005S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/18_08720_silc_zadovol_zivljenje/&lang=2


4.) http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0872035S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/18_08720_silc_zadovol_zivljenje/&lang=2

5.) http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0872040S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/18_08720_silc_zadovol_zivljenje/&lang=2

Vsi podatki so na voljo v naslednjih oblikah: .txt, .csv, .htm, .xls.

Skozi analize teh podatkov bi rada prikazala povezavo med splošnim zdravstvenim stanjem in zadovoljstvom z življenjem oseb v Sloveniji in prikazala te podatke na zemljevidu Slovenije po regijah.

## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
