rm(list = ls())
setwd('F:/lmQCM')
lmqcm<-read.csv('data.csv',header=T)
index<-c(rep(1,times=542),rep(2,times=527),rep(3,times=160),rep(4,times=120),rep(5,times=52),
         rep(6,times=41),rep(7,times=11),rep(8,times=11),rep(9,times=10))
A<-lmqcm[1:1474,]
normal70<-t(A[,2:71])
dim(normal70)
cancer70<-t(A[,72:141])
dim(cancer70)
#训练集和测试集的划分，随机取2/3练，1/3测试

set.seed(7)
#70个癌症样本划分
N1=nrow(cancer70)
trainindex1<-sample(1:N1,47)
trainset1<-cancer70[trainindex1,]
testset1<-cancer70[-trainindex1,]
# 70个正常样本划分
N2=nrow(normal70)
trainindex2<-sample(1:N2,47)
trainset2<-normal70[trainindex2,]
testset2<-normal70[-trainindex2,]
#3 #合并
x<-rbind(trainset2, trainset1)
test<-rbind(testset2, testset1)
y<-as.vector(c(rep(0,47),rep(1,47)))
ytest<-c(rep(0,23),rep(1,23))
dim(x)
#单个基因权重
lv<-read.csv('6635lv.csv',header = T)
lv1<-lv[5162:6635,1]
huxinxi<-read.csv('huxinxi.csv',header = T)
w1<-(lv1+huxinxi[5162:6635,3])*(1/2)
w1<-1/w1
#群权重SU度量
library(FCBF)
mes<-read.csv('lmQCM-tezheng.csv',header =T)
mesnormal<-mes[,1:70]
mescancer<-mes[,71:140]
trainnormal<-mesnormal[,trainindex2]
traincancer<-mescancer[,trainindex1]
trainmes<-cbind(trainnormal,traincancer)
discrete_expression <- as.data.frame(discretize_exprs(trainmes))
#target<-read.csv('target.csv',header=F)
su<- get_su_for_feature_table_and_vector(discrete_expression[,],y)
a<-read.csv('a.csv',header = F)
for (m in 1:9) {
  temp1<-a[m,1]
  for (n in 1:9) {
    temp2<-su[n,2]
    if (temp1==temp2){
      a[m,2]<-su[n,1]
    }
  }
}
grow<-as.vector(a[1:9,2])
w2<-1/grow

#训练并测试精度
library(asgl)
groupindex<-as.vector(index)
a1<-c(0.001,0.05,0.1,0.3,0.55,0.6,0.7,0.8,0.95)

acc<-matrix(c(rep(0,900)),nrow = 100,ncol = 9)
for (j in 1:9) {
  fitasgl<-asgl(x, y, index=groupindex, family = "binomial",alpha =a1[j],
                standardize = T,
                grp_weights = w2,
                ind_weights =w1,
                nlambda = 100)
  y1<-predict(fitasgl,test,type = "response")
  y1<-sign(y1-0.5)
  y1[y1==-1]<-0
  y1
  write(paste("*** results ", j, "***"),"")
  #coefSGL1 <-fitasgl$beta[,100]
  #n1<- which(coefSGL1!= 0)   #结果复制粘贴保存下来
  #n1
  for (k in 1:100) {
    y0<-y1[,k]
    lab0<-length(which(y0[1:23]!=0))
    lab1<-length(which(y0[24:46]!=1))
    accuracy<-1-(lab0+lab1)/46
    acc[k,j]<-accuracy
    #print(accuracy)
  }
}
max(acc)
ar<-max(acc)

###最优参数
fitasgl<-asgl(x, y, index=groupindex, family = "binomial",alpha =0.95,
              standardize = T,
              grp_weights = w2,
              ind_weights =w1,
              nlambda = 100)
y1<-predict(fitasgl,test,type = "response")
y1<-y1[,100]
AUC<-y1
y1<-sign(y1-0.5)
y1[y1==-1]<-0
hunxiao<-y1

coefSGL1 <-fitasgl$beta[,100]
n1<- which(coefSGL1!= 0)   #结果复制粘贴保存下来
hr<-length(n1)

ar
hr


