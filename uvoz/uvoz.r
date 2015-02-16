# 2. faza: Uvoz podatkov

#Pred začetkom zaženi naslednje funkcije:

procenti <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)","Neznano (%)","Povprečje")
procenti[1:5]<-  c("Povsem nezadovoljen","Nezadovoljen", "Zadovoljen","Zelo zadovoljen", "Neznano")
starosti <- c("Starostne skupine - SKUPAJ","16-25 let","26-35 let","36-45 let","46-55 let","56-65 let","66 ali več let")
stanja <- c("Zelo slabo", "Slabo","Srednje","Dobro","Zelo dobro")
stanja1 <- rev(stanja)

"Uvoz tabel HTML"

source("lib/xml.r", encoding="UTF-8")
ZdrStarost <- uvozi.starost()
ZdrSpol <- uvozi.spol()
ZadRegije<-uvozi.regije()

#TABELA 1
#Tabela zadovoljstva z življenjem glede na zdravstveno stanje

uvoziSTANJE <- function(){
  t <- read.table("podatki/ZadovoljstvoSTANJE1213.csv", sep = ";",as.is = TRUE, skip = 7,na.strings= "NA",
                    col.names=c("Spol", "Zdravstveno stanje",paste0(procenti, "_2012"), 
                                paste0(procenti, "_2013")),
                    fileEncoding = "Windows-1250")[c(-6,-12:-17),c(-1,-2)]
  row.names(t) <- c(paste("M",stanja1),paste("Z",stanja1))
  return(t)
}
  
cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na ZDRAVSTVENO STANJE ...\n")
ZadStanje <- uvoziSTANJE()

#TABELA 2
#Tabela zadovoljstva z življenjem glede na starosti

uvoziSTAROST <- function(){
  r <- read.table("podatki/ZadovoljstvoSTAROST1213.csv", sep = ";", skip= 15,as.is = TRUE, na.strings= "NA",
                  blank.lines.skip=TRUE,
                  
                  col.names = c("Spol","Starostne skupine",paste0(procenti, "_2012"), paste0(procenti, "_2013")),
                  fileEncoding = "Windows-1250")[-8,c(-1,-2)]
  row.names(r) <- c(paste("M", starosti),paste("Z", starosti))
  return(r)
}
ZadStarosti <- uvoziSTAROST()

#TABELA X
#Tabela pričakovanih življenjskih dob glede na samooceno zdravja v Evropi

uvoziEVROPA <- function(){
  e <- read.csv2("podatki/LE1.csv",sep=",", as.is = TRUE, 
                  na.strings = ":",
              
                  fileEncoding = "Windows-1250")[-3]
  return(e)
}
ZivEvr <- uvoziEVROPA()

ZivZad <-data.frame(matrix(data = NA, nrow = 31, ncol=6))
rownames(ZivZad) <- unique(ZivEvr$GEO[1:62])
colnames(ZivZad) <- c("Moski_2004","Zenske_2004","Povprecje_2004","Moski_2012","Zenske_2012","Povprecje_2012")
attach(ZivEvr)
ZivZad$Moski_2004 <- as.numeric(Value[SEX=="Males" & TIME == "2004"])
ZivZad$Zenske_2004 <- as.numeric(Value[SEX=="Females" & TIME =="2004"])
ZivZad$Moski_2012 <- as.numeric(Value[SEX=="Males" & TIME == "2012"])
ZivZad$Zenske_2012 <- as.numeric(Value[SEX=="Females" & TIME =="2012"])
detach(ZivEvr)
ZivZad$Povprecje_2004 <- apply(ZivZad[1:2],1 ,function(x) round(mean(x),1))
ZivZad$Povprecje_2012 <- apply(ZivZad[4:5],1 ,function(x) round(mean(x),1))
cat("Uvažam evropske podatke...\n")

cat("Uvažam tabele za 4. fazo ... \n")
#TABELA Y
#Tabela povprečne neto plače po občinah 2005-2013

uvoziPLACE <- function(){
  y <- read.table("podatki/PovpPl.csv",sep=";", as.is = TRUE, na.strings = "-",
                  row.names=1,
                  col.names = c("Občine",2005:2013),
                  fileEncoding = "Windows-1250")

  
  return(y)
}
PovpPl <- uvoziPLACE()

#TABELA Y1
#Tabela povprečne neto plače po regijah 2005-2013
uvoziPLACER <- function(){
  y1 <- read.table("podatki/PovpR.csv",sep=";",as.is=TRUE,
                   row.names =1, 
                   col.names = c("Regije",c(2005:2013)),
                   fileEncoding = "Windows-1250")[-9,]
  return(y1)
}
PovpR <- uvoziPLACER()

#TABELA Z
#Tabela ekonomske rasti po regijah v 2000-2012
uvoziEkoRast <- function(){
  z <- read.table("podatki/EkoRast.csv",sep=";",as.is=TRUE,
                  col.names=c("BDP","Regije",2000:2012),
                  fileEncoding="Windows-1250")[,-1]
  rownames(z)<-t(z[1])
  return(z)
}
EkoRast <- uvoziEkoRast()[,-1]

#TABELA PODJETIJ
#Tabela podjetij po regijah 2008-2013
pod <-c("Število podjetij","Število oseb,ki delajo","Prihodek",
        "Število oseb,ki delajo na podjetje v regiji")
uvoziPODJETJA <-function(){
  p<-read.table("podatki/Podjetja.csv",sep=";",as.is=TRUE,
                row.names=1,
                col.names=c("Regije",paste0(pod,"_2008"),paste0(pod,"_2009"),paste0(pod,"_2010"),
                            paste0(pod,"_2011"),paste0(pod,"_2012"),paste0(pod,"_2013")),
                fileEncoding = "Windows-1250")[-9,]
  return(p)
}
Podjetja <- uvoziPODJETJA()
cat("Tabele uvožene! \n")