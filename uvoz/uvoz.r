# 2. faza: Uvoz podatkov

#Pred začetkom zaženi naslednje funkcije:

procenti <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)","Neznano (%)","Povprečje")
procenti[1:5]<-  c("Povsem nezadovoljen","Nezadovoljen", "Zadovoljen","Zelo zadovoljen", "Neznano")

stanja <- c("Zelo slabo", "Slabo","Srednje","Dobro","Zelo dobro")
stanja1 <- c("Zelo dobro","Dobro","Srednje","Slabo","Zelo slabo")

# uvoziREGIJE <- function(){
#   return(read.table("podatki/SplZadZivljREGIJE.csv", sep = ";", as.is = TRUE,
#                     
#                     fileEncoding = "Windows-1250"))
#   
# }
# cat("Uvažam podatke o splošnem zadovoljstvu z življenjem po REGIJAH ...\n")
# SplZadZivljREGIJE <- uvoziREGIJE()

uvoziSTANJE <- function(){
  return(read.table("podatki/ZadovoljstvoSTANJE1213.csv", sep = ";",as.is = TRUE, skip = 6,na.strings= "NA",
                    
                    col.names=c("Spol", "Zdravstveno stanje",paste0(procenti, "_2012"), paste0(procenti, "_2013")),
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na ZDRAVSTVENO STANJE ...\n")
ZadStanje <- uvoziSTANJE()



uvoziSTAROST1 <- function(){
  return(read.table("podatki/ZadovoljstvoSTAROST1213.csv", sep = ";", skip= 6,as.is = TRUE, na.strings= "NA",
                    
                    col.names = c("Starosti","Spol", paste0(procenti, "_2012"), paste0(procenti, "_2013")),
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na STAROSTI ...\n")
ZadStarost <- uvoziSTAROST1()


  
uvoziSTAROST2 <- function(){
  return(read.table("podatki/SplZdrStSTAROST.csv", sep = ";", as.is = TRUE,skip = 5,
                    row.names=1,
                    col.names = c("Starosti",paste0(stanja1,"_", 2005),paste0(stanja1, "_", 2006),paste0(stanja1, "_", 2007),paste0(stanja1, "_", 2008),paste0(stanja1, "_", 2009),paste0(stanja1, "_", 2010),paste0(stanja1, "_", 2011),paste0(stanja1, "_", 2012),paste0(stanja1, "_", 2013)),
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o zdravstvenem stanju glede na STAROST ...\n")
ZdrStarost <- uvoziSTAROST2()






uvoziSPOL <- function(){
  return(read.table("podatki/SPOL/SplZdrStSPOL.csv", sep=";", as.is = TRUE, skip = 4,
                    row.names=1,
                    col.names = c("Stanje",paste0("S", 2005:2013), paste0("M", 2005:2013), paste0("Z",2005:2013)),
                    fileEncoding = "Windows-1250"))
}
cat("Uavažam podatke o zdravstvenem stanju oseb glede na SPOL... \n")
ZdrSpol <- uvoziSPOL()