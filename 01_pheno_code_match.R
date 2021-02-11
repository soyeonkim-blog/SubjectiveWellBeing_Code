setwd("C:\\Users\\soyeo\\Desktop\\KCHIP_SWB\\2020_GC")
getwd()

library(dplyr)
library(data.table)

p <- fread("pheno_code.csv", header=T)
head(p)
p$p2 <- paste(p$V1, p$V2, sep=".")

df <- fread("GeneticCorrelation_TotalResult.txt")
head(df)
mg <- merge(p, df, by="p2", all.y=T)
head(mg)

mg1 <- subset(mg, V2=="UKB_BN")
mg1$dataset <- mg1$V2
mg1$Phenotype_Code <- mg1$V1 
mg1$Phenotype_Description <- mg1$V3 
head(mg1)

mg2 <- subset(mg, V2!="UKB_BN" | is.na(V2)==T)
mg2$dataset <- mg2$V1
mg2$Phenotype_Code <- mg2$V2 
mg2$Phenotype_Description <- mg2$V3 
tail(mg2)

rb <- rbind(mg1, mg2)
head(rb)
rb2 <- select(rb, p2, dataset, Phenotype_Code, Phenotype_Description, rg:gcov_int_se)
head(rb2)
names(rb2)[names(rb2)=="p2"] <- c("Trait")

arr <- arrange(rb2, p)
head(arr)
write.csv(arr, file="arr.csv", row.names=F)
