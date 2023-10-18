setwd('F:/lmQCM')
C<-read.csv('DEG.csv',header = T)
C1<-C[,-1]
library(lmQCM)
gamma=seq(0.1,0.9,0.1)
n<-c()
for (i in c(1:9)){
M<-lmQCM(C1,gamma=gamma[i],normalization = T)
n[i]<-length(M@clusters.id)
}
plot(gamma[1:9],n,col = "red",xlab="gamma",ylab="modules",type="b",lty=1)
M<-lmQCM(C1,gamma = 0.2,normalization = T)
#Extract module feature genes as mes

g1<-M@clusters.id[[1]];g2<-M@clusters.id[[2]];g3<-M@clusters.id[[3]]
g4<-M@clusters.id[[4]];g5<-M@clusters.id[[5]];g6<-M@clusters.id[[6]]
g7<-M@clusters.id[[7]];g8<-M@clusters.id[[8]];g9<-M@clusters.id[[9]]
g10<-M@clusters.id[[10]];g11<-M@clusters.id[[11]];g12<-M@clusters.id[[12]]
g13<-M@clusters.id[[13]];g14<-M@clusters.id[[14]];g15<-M@clusters.id[[15]]
g16<-M@clusters.id[[16]];g17<-M@clusters.id[[17]]

x1<-C[c(g1),];x2<-C[c(g2),];x3<-C[c(g3),];x4<-C[c(g4),];x5<-C[c(g5),]
x6<-C[c(g6),];x7<-C[c(g7),];x8<-C[c(g8),];x9<-C[c(g9),];x10<-C[c(g10),]
x11<-C[c(g11),];x12<-C[c(g12),];x13<-C[c(g13),];x14<-C[c(g14),];x15<-C[c(g15),]
x16<-C[c(g16),];x17<-C[c(g17),]

X<-rbind(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17)
write.csv(X, "data.csv",quote = FALSE)

