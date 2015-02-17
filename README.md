# Splošno zdravstveno stanje in splošno zadovoljstvo z življenjem oseb v Sloveniji

Avtor: Mirjam Pergar

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Naslov mojega projekta je Splošno zdravstveno stanje in splošno zadovoljstvo z življenjem oseb v Sloveniji. 

Projekt se bo ukvarjal z analiziranjem splošnega zdravstvenega stanja oseb glede na starost in spol in splošnim zadovoljstvom z življenjem oseb v Sloveniji glede na spol, starost, zdravstveno stanje in glede na regije.

Vse podatke bom pridobila s SURS-a iz naslednjih povezav:

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0868510S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/17_silc_zdravje/05_08685_splosno_zdravst_stanje/&lang=2

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0868515S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/17_silc_zdravje/05_08685_splosno_zdravst_stanje/&lang=2

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0872005S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/18_08720_silc_zadovol_zivljenje/&lang=2


* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0872035S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/18_08720_silc_zadovol_zivljenje/&lang=2

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0872040S&ti=&path=../Database/Dem_soc/08_zivljenjska_raven/18_08720_silc_zadovol_zivljenje/&lang=2

V drugi fazi sem dodala še eno tabelo, ki prikazuje podatke za Evropo in sicer pričakovano življenjsko dobo glede na samoocenitev zdravja. 

* http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=hlth_silc_17&lang=en

Vsi podatki so na voljo v naslednjih oblikah: .txt, .csv, .htm, .xls.

Skozi analize teh podatkov bi rada prikazala povezavo med splošnim zdravstvenim stanjem in zadovoljstvom z življenjem oseb v Sloveniji in prikazala te podatke na zemljevidu Slovenije po regijah.

Za 4. fazo sem uvozila še štiri tabele iz katerih želim po regijah gledati povezave tudi z gospodarsko-ekonomskega vidika.

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0772615S&ti=&path=../Database/Dem_soc/07_trg_dela/10_place/02_07726_kaz_place/&lang=2

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0772610S&ti=&path=../Database/Dem_soc/07_trg_dela/10_place/02_07726_kaz_place/&lang=2

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1418806S&ti=Podjetja+po+kohezijskih+in+statisti%E8nih+regijah%2C+Slovenija%2C+letno&path=../Database/Ekonomsko/14_poslovni_subjekti/01_14188_podjetja/&lang=2

* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=05C2002S&ti=&path=../Database/Dem_soc/05_prebivalstvo/10_stevilo_preb/10_05C20_prebivalstvo_stat_regije/&lang=2

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
