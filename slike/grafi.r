cairo_pdf("slike/starosti.pdf", family="Arial", onefile=TRUE)

#GRAF 1

zdr <- as.matrix(ZdrStarost[substr(names(ZdrStarost), 1, 6) == "Skupaj"])
colnames(zdr) <- 2005:2013
barplot(zdr, beside = TRUE, 
        ylab = "Število oseb",las=2,
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr), 
        xlim = c(0,70), ylim=c(0,50), main = "Graf 1: Zdravstveno stanje oseb po vseh starostih")



VseStarosti <- c("Skupaj", "16-25","26-35","36-45","46-55","56-65","66+")

#GRAF 2

zdr2013 <- as.matrix(ZdrStarost[grep("2013$", names(ZdrStarost))])
colnames(zdr2013) <- VseStarosti
barplot(zdr2013, beside = TRUE,
        xlab = "Starostne skupine",ylab = "Število oseb",
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr2013), 
        xlim = c(0,50), ylim=c(0,60), main = "Graf 2: Zdravstveno stanje oseb po starostih v letu 2013") 
        
dev.off()
cairo_pdf("slike/spoli.pdf", family="Arial", onefile=TRUE)
#GRAF 3

skupaj <- as.matrix(ZdrSpol[substr(names(ZdrSpol),1,2)=="S."])
colnames(skupaj)<-2005:2013
barplot(skupaj, beside=TRUE,
        ylab = "Število oseb",las=2,
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(skupaj), main = "Graf 3: Zdravstveno stanje obeh spolov skupaj",
        xlim = c(0,70),ylim=c(0,50))


#GRAF 4

Leto2013 <- as.matrix(ZdrSpol[substr(names(ZdrSpol),3,6)=="2013"])
colnames(Leto2013) <- c("Skupaj", "Moški", "Ženske")
barplot(Leto2013 , beside =TRUE, 
        ylab = "Število oseb",
        legend.text = rownames(Leto2013), xlim=c(0,30),ylim=c(0,50),
        main = "Graf 4: Zdravstveno stanje oseb po spolu v letu 2013",
        col = c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"))
dev.off()

cairo_pdf("slike/zad_stanje.pdf", family="Arial", onefile=TRUE)
#GRAF 5

stanje1 <- grep("M Z",rownames(ZadStanje))
stanje2 <- grep("Z Z",rownames(ZadStanje))
let2013 <- grep("en_2013",names(ZadStanje))
stanja2013 <- as.matrix(ZadStanje[c(stanje1,stanje2),let2013])
colnames(stanja2013) <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)")
barplot(stanja2013, beside = TRUE, xlim= c(0,25),ylim= c(0,60),
        legend.text = c("Moški-Zelo dobro", "Moški-Zelo slabo","Ženske- Zelo dobro", "Ženske-Zelo slabo"),
        col = c("antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        main = "Graf 5: Zadovoljstvo z življenjem \n glede na zdravstveno stanje v letu 2013",
        xlab = "Zadovoljstvo v procentih",ylab = "Število oseb")

dev.off()

cairo_pdf("slike/zad_star.pdf", family="Arial", onefile=TRUE)
#GRAF 6

leta1 <- grep("M 16",rownames(ZadStarosti))
leta2 <- grep("M 36",rownames(ZadStarosti))
leta3 <- grep("M 56",rownames(ZadStarosti))
leta4 <- grep("Z 16",rownames(ZadStarosti))
leta5 <- grep("Z 36",rownames(ZadStarosti))
leta6 <- grep("Z 56",rownames(ZadStarosti))
leto2013 <- grep("en_2013$",names(ZadStarosti))
starosti2013 <- as.matrix(ZadStarosti[c(leta1,leta2,leta3,leta4,leta5,leta6),leto2013])
colnames(starosti2013) <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)")
barplot(starosti2013,beside = TRUE, xlim = c(0,35),ylim=c(0,60),
        col = c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3","lightgreen"),
        legend.text = c("Moški 16-25 let", "Moški 36-45 let", "Moški 55-65 let",
                        "Ženske 16-25 let", "Ženske 36-45 let", "Ženske 55-65 let"),
        main = "Graf 6: Zadovoljstvo z življenjem glede \n na starost v letu 2013",
        ylab = "Število oseb",xlab = "Zadovoljstvo v procentih")
        

dev.off()


