pdf("slike/grafi.pdf", paper= "a4")


#GRAF 1

zdr <- as.matrix(ZdrStarost[substr(names(ZdrStarost), 1, 6) == "Skupaj"])
colnames(zdr) <- 2005:2013
barplot(zdr, beside = TRUE, 
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr), 
        xlim = c(0,70), ylim=c(0,50), main = "Zdravstveno stanje oseb po vseh starostih")

VseStarosti <- c("Skupaj", "16-25","26-35","36-45","46-55","56-65","66+")


#GRAF 2

zdr2013 <- as.matrix(ZdrStarost[grep("2013$", names(ZdrStarost))])
colnames(zdr2013) <- VseStarosti
barplot(zdr2013, beside = TRUE,
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr2013), 
        xlim = c(0,50), ylim=c(0,60), main = "Zdravstveno stanje oseb po starostih v letu 2013") 
        


#GRAF 3

skupaj <- as.matrix(ZdrSpol[substr(names(ZdrSpol),1,2)=="S."])
colnames(skupaj)<-2005:2013
barplot(skupaj, beside=TRUE,
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(skupaj), main = "Zdravstveno stanje obeh spolov skupaj",
        xlim = c(0,70),ylim=c(0,50))


#GRAF 4

Leto2013 <- as.matrix(ZdrSpol[substr(names(ZdrSpol),3,6)=="2013"])
colnames(Leto2013) <- c("Skupaj", "Moški", "Ženske")
barplot(Leto2013 , beside =TRUE, 
        legend.text = rownames(Leto2013), xlim=c(0,30),ylim=c(0,50),
        main = "Zdravstveno stanje oseb v letu 2013",
        col = c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"))

#GRAF 5

stanja2013 <- as.matrix(ZadStanje[c(1,5,6,10),c(7:10)])
colnames(stanja2013) <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)")
barplot(stanja2013, beside = TRUE, xlim= c(0,25),ylim= c(0,60),
        legend.text = c("Moški-Zelo dobro", "Moški-Zelo slabo","Ženske- Zelo dobro", "Ženske-Zelo slabo"),
        col = c("antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        main = "Zadovoljstvo z življenjem glede na zdravstveno stanje v letu 2013",
        sub = "Zadovoljstvo v procentih")


#GRAF 6

starosti2013 <- as.matrix(ZadStarosti[c(2,4,6,9,11,13),c(7:10)])
colnames(starosti2013) <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)")
barplot(starosti2013,beside = TRUE, xlim = c(0,35),ylim=c(0,60),
        col = c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3","lightgreen"),
        legend.text = c("Moški 16-25 let", "Moški 36-45 let", "Moški 55-65 let","Ženske 16-25 let", "Ženske 36-45 let", "Ženske 55-65 let"),
        main = "Zadovoljstvo z življenjem glede na starost v letu 2013",
        sub = "Zadovoljstvo v procentih")
        

dev.off()


