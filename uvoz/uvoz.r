# 2. faza: Uvoz podatkov

uvoziREGIJE <- function(){
  return(read.table("podatki/SplZadZivljREGIJE.csv", sep = ";", as.is = TRUE,
                    
                    fileEncoding = "Windows-1250"))
  
}
cat("Uvažam podatke o splošnem zadovoljstvu z življenjem po REGIJAH ...\n")
SplZadZivljREGIJE <- uvoziREGIJE()

uvoziSTANJE <- function(){
  return(read.table("podatki/ZadovoljstvoSTANJE1213.csv", sep = ";",as.is = TRUE, skip = 6,na.strings= "NA",
                    col.names=c("Spol", "Zdravstveno stanje",paste0(procenti, "_2012"), paste0(procenti, "_2013")),
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na ZDRAVSTVENO STANJE ...\n")
ZadovoljstvoSTANJE1213 <- uvoziSTANJE()

procenti <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)","Neznano (%)","Povprečje")
procenti[1:5]<-  c("Povsem nezadovoljen","Nezadovoljen", "Zadovoljen","Zelo zadovoljen", "Neznano")

uvoziSTAROST1 <- function(){
  return(read.table("podatki/ZadovoljstvoSTAROST1213.csv", sep = ";", skip= 6,as.is = TRUE, na.strings= "NA",
                    col.names = c("Starosti","Spol", paste0(procenti, "_2012"), paste0(procenti, "_2013")),
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na STAROSTI ...\n")
ZadovoljstvoSTAROST1213 <- uvoziSTAROST1()

uvoziSTAROST2 <- function(){
  return(read.table("podatki/SplZdrStSTAROST.csv", sep = ";", as.is = TRUE,skip = 5,
                    
                    col.names = c("Starosti",paste0(stanja1,"_", 2005),paste0(stanja1, "_", 2006),paste0(stanja1, "_", 2007),paste0(stanja1, "_", 2008),paste0(stanja1, "_", 2009),paste0(stanja1, "_", 2010),paste0(stanja1, "_", 2011),paste0(stanja1, "_", 2012),paste0(stanja1, "_", 2013)),
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o zdravstvenem stanju glede na STAROST ...\n")
SplZdrStSTAROST <- uvoziSTAROST2()

stanja <- c("Zelo slabo", "Slabo","Srednje","Dobro","Zelo dobro")
stanja1 <- c("Zelo dobro","Dobro","Srednje","Slabo","Zelo slabo")
stanja2 <- c("ZD","D","SR","S","ZS")

uvoziSPOL1 <- function(){
  return(read.table("podatki/SPOL/skupajSPOL.csv", sep=";", as.is= TRUE, skip= 2,
                    row.names = 1,
                      col.names = c("Stanje",paste0("S", 2005:2013)),fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o zdravstvenem stanju oseb glede na OBA SPOLA ...\n")
skupajSPOL <- uvoziSPOL1()

uvoziSPOL2 <- function(){
  return(read.table("podatki/SPOL/moskiSPOL.csv", sep=";", as.is= TRUE, skip= 2,
                    row.names = 1,
                    col.names = c("Stanje",paste0("M", 2005:2013)),fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o zdravstvenem stanju MOŠKIH ...\n")
moskiSPOL <- uvoziSPOL2()

uvoziSPOL3 <- function(){
  return(read.table("podatki/SPOL/zenskeSPOL.csv", sep=";", as.is= TRUE, skip= 2,
                    row.names = 1,
                    col.names = c("Stanje",paste0("Z", 2005:2013)),fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o zdravstvenem stanju ŽENSK...\n")
zenskeSPOL <- uvoziSPOL3()


#Združimo vse spole
SPOL1<- merge(moskiSPOL, zenskeSPOL, by=0, all = TRUE)
rownames(SPOL1)<- SPOL1$Row.names
SPOL1 <- SPOL1[-1]
SPOL <- merge(SPOL1, skupajSPOL, by = 0, all = TRUE)

