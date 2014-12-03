# Uvoz s spletne strani

library(XML)


stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}
#TABELA 3
#Splošno zdravstveno stanje glede na STAROST:

uvozi.starost <- function(){
  url.starost <- "podatki/stStarost2.htm"
  doc.starost <- htmlTreeParse(url.starost, useInternalNodes=TRUE, encoding="Windows-1250")
  
  tabele0 <- getNodeSet(doc.starost,"//table")
  vrstice0 <- getNodeSet(tabele0[[1]], "./tr")
  seznam0 <- lapply(vrstice0[5:length(vrstice0)-1], stripByPath, "./td")
  matrika0 <- matrix(unlist(seznam0),nrow=length(seznam0),byrow=TRUE)
  stolpci0 <- stripByPath(tabele0[[1]][[3]],"./th")[-1]
  leta <- rep(c(2005:2013),7)
  leta <- leta[order(leta)]
  colnames(matrika0)<- gsub("\n", " ", paste(stolpci0,leta))
  return(data.frame(apply(matrika0, 2, as.numeric),
                    row.names=sapply(vrstice0[5:length(vrstice0)-1],stripByPath, "./th")))
  
}
cat("Uvažam podatke o splošnem zdravstvenem stanju oseb glede na STAROST...\n")

#TABELA 4
#Splošno zdravstveno stanje glede na SPOL:

uvozi.spol <- function(){
  url.spol <- "podatki/stSpolHTML.htm"
  doc.spol <- htmlTreeParse(url.spol, useInternalNodes=TRUE, encoding = "Windows-1250")
  
  tabele <- getNodeSet(doc.spol, "//table")
  vrstice <- getNodeSet(tabele[[1]], "./tr")
  seznam <- lapply(vrstice[5:length(vrstice)-1], stripByPath, "./td")
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  stolpci <- stripByPath(tabele[[1]][[3]], "./th")[-1]
  colnames(matrika)<-gsub("\n", " ", paste(c(rep("S",9),rep("M",9),rep("Z",9)),stolpci))
  return(data.frame(apply(matrika, 2, as.numeric),
                    row.names = sapply(vrstice[5:length(vrstice)-1],stripByPath, "./th")))
}
cat("Uvažam podatke o splošnem zdravstvenem stanju oseb glede na SPOL...\n")

#TABELA 5
#Samoocena zadovoljstva z življenjem po REGIJAH:

uvozi.regije <- function() {
  url.regije <- "podatki/RegijeHTML.htm"
  doc.regije <- htmlTreeParse(url.regije, useInternalNodes=TRUE, encoding = "Windows-1250")
 
  tabele1 <- getNodeSet(doc.regije, "//table")
  
  vrstice1 <- getNodeSet(tabele1[[1]], "./tr")

  seznam1 <- lapply(vrstice1[5:length(vrstice1)-1], stripByPath, "./td")
  
  stolpci1 <- stripByPath(tabele1[[1]][[3]], "./th")[-1]
  #stolpci1 <- rep(procenti,2)
  
  matrika1 <- matrix(unlist(seznam1), nrow=length(seznam1), byrow=TRUE)
  
  colnames(matrika1) <- gsub("\n", " ", paste(stolpci1, c(rep(2012, 6), rep(2013, 6))))
  
  return(
    data.frame(apply(matrika1, 2, as.numeric),
               row.names = sapply(vrstice1[5:length(vrstice1)-1], stripByPath, "./th"))
  )
  
}
cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na REGIJE...\n")

