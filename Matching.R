# pre/propensity score matching

/*HIGHLIGHT and copy. Then read from clipboard
0.11,101
0.13,103
0.11,102
treatment<-read.table("clipboard", sep=",")
names(treatment)<-c("pscoreT","idT")
str(treatment)

0.334,8
0.11,5
0.131,4
0.107,7
0.13,2

control<-read.table("clipboard", sep=",")
names(control)<-c("pscoreC","idC")

str(control)

################# Nearest Neighbour w replacement
#initialize two vectors
IdSelectedControl<-c()
MatchedToTreatID<-c()

for (i in 1:nrow(treatment)){
  for (j in 1:nrow(control)){
    abs(treatment$pscoreT[i]-control$pscoreC[j])->ScoreDistance
    if (j==1) {BestDistance<- 99}
    if (ScoreDistance < BestDistance) {BestDistance<-ScoreDistance
                                       idd<-control$idC[j]}
    if (j==nrow(control))
        {IdSelectedControl<-c(IdSelectedControl, idd)
         MatchedToTreatID<-c(MatchedToTreatID,treatment$idT[i])
        }
}
}
str(IdSelectedControl)
str(MatchedToTreatID)


###################### Caliper w replacement
IdSelectedControl<-c()
MatchedToTreatID<-c()

for (i in 1:nrow(treatment)){
  for (j in 1:nrow(control)){
    if (j==1) {BestDistance<- 99}
    if ((treatment$pscoreT[i] - 0.005)<=control$pscoreC[j]
        & control$pscoreC[j]<=(treatment$pscoreT[i] + 0.005)) 
    { 
      abs(treatment$pscoreT[i]-control$pscoreC[j])->ScoreDistance
      if (ScoreDistance < BestDistance) {BestDistance<-ScoreDistance
                                        idd<-control$idC[j]}
    } 
  }
    if (j==nrow(control) & BestDistance < 99)
    {IdSelectedControl<-c(IdSelectedControl, idd)
     MatchedToTreatID<-c(MatchedToTreatID,treatment$idT[i])}
}
str(IdSelectedControl)
str(MatchedToTreatID)

############################ radius 
IdSelectedControl<-c()
MatchedToTreatID<-c()

for (i in 1:nrow(treatment)){
  for (j in 1:nrow(control))
  {
    if ((treatment$pscoreT[i] - 0.005)<=control$pscoreC[j]
        & control$pscoreC[j]<=(treatment$pscoreT[i] + 0.005)) 
  {idd<-control$idC[j]
    IdSelectedControl<-c(IdSelectedControl, idd)
    MatchedToTreatID<-c(MatchedToTreatID,treatment$idT[i])}
}}


str(IdSelectedControl)
str(MatchedToTreatID)

### Nearest Neighbour w/o replacement. 
# Once a match is determined, the records will be taken out of matching 
# process

carbon<-control
control<-carbon

IdSelectedControl<-c()
MatchedToTreatID<-c()

for (i in 1:nrow(treatment)){
  for (j in 1:nrow(control)){
    abs(treatment$pscoreT[i]-control$pscoreC[j])->ScoreDistance
    if (j==1) {BestDistance<- 99}
    if (ScoreDistance < BestDistance) {BestDistance<-ScoreDistance
        idd<-control$idC[j] 
        frozen<-j}
  }
    if (j==nrow(control))
    {IdSelectedControl<-c(IdSelectedControl, idd)
     MatchedToTreatID<-c(MatchedToTreatID,treatment$idT[i])
    control<-control[1:nrow(control) !=frozen,]
  }
}
str(IdSelectedControl)
str(MatchedToTreatID)
control


#Just exercises
#append data

names(control) [1]<-"pscore"
names(treatment) [1]<-"pscore"
names(control) [2]<-"ID"
names(treatment) [2]<-"ID"

#overlay
tot<-rbind(treatment, control)
str(tot)

#data ASG_2011; set ASG_2011;  if uid='' then delete;

treatment.test<-treatment[treatment$pscore>.11,]
treatment.test<-treatment[treatment$pscore!=.11,]
treatment.test

#data ; set ;
#if adv_typ='CFP Real-Time' OR adv_typ='CFP Scheduled' then S='CFP';
#else S=adv_typ;
#if adv_typ='Sit Adv' then S='';
#drop adv_typ;
#run;

test$S<-ifelse(test$pscore==.11 | test$pscore==.12, "CFP", "NA")
test










