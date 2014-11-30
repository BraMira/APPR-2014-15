# Obdelava, uvoz in čiščenje podatkov.

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).

procenti <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)","Neznano (%)","Povprečje")
procenti[1:5]<-  c("Povsem nezadovoljen","Nezadovoljen", "Zadovoljen","Zelo zadovoljen", "Neznano")
stanja <- c("Zelo slabo", "Slabo","Srednje","Dobro","Zelo dobro")

source("lib/xml.r", encoding="UTF-8")
ZdrStarost <- uvozi.starost()
ZdrSpol <- uvozi.spol()
ZadRegije<-uvozi.regije()
source("uvoz/uvoz.r", encoding = "UTF-8")


