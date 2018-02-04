# SAS Job
# First trying to read IFB as text/CSV/TAB delimied
# Failed. R has trouble to recognize 247 cols.

## create variable name vector
vlst<-c(
  "INFOBASE_CLNT_DMGRPHCS_KEY ",
  "EFFTV_BGN_DT ",
  "EFFTV_END_DT ",
  "PO_KEY ",
  "ZIP_PLUS_4_KEY ",
  "AXCIOM_ZIP_PLUS_4_KEY ",
  "VEHCL_AGGR_VAL_8194 ",
  "ADLS_HHLD_MLS_18_TO_24_FL_8600 ",
  "ADLS_HHLD_FMS_18_TO_24_FL_8600 ",
  "ADLS_HHLD_UNK_18_TO_24_FL_8600 ",
  "ADLS_HHLD_MLS_25_TO_34_FL_8600 ",
  "ADLS_HHLD_FMS_25_TO_34_FL_8600 ",
  "ADLS_HHLD_UNK_25_TO_34_FL_8600 ",
  "ADLS_HHLD_MLS_35_TO_44_FL_8600 ",
  "ADLS_HHLD_FMS_35_TO_44_FL_8600 ",
  "ADLS_HHLD_UNK_35_TO_44_FL_8600 ",
  "ADLS_HHLD_MLS_45_TO_54_FL_8600 ",
  "ADLS_HHLD_FMS_45_TO_54_FL_8600 ",
  "ADLS_HHLD_UNK_45_TO_54_FL_8600 ",
  "ADLS_HHLD_MLS_55_TO_64_FL_8600 ",
  "ADLS_HHLD_FMS_55_TO_64_FL_8600 ",
  "ADLS_HHLD_UNK_55_TO_64_FL_8600 ",
  "ADLS_HHLD_MLS_65_TO_74_FL_8600 ",
  "ADLS_HHLD_FMS_65_TO_74_FL_8600 ",
  "ADLS_HHLD_UNK_65_TO_74_FL_8600 ",
  "ADLS_HHLD_MLS_75_PLS_FL_8600 ",
  "ADLS_HHLD_FMS_75_PLS_FL_8600 ",
  "ADLS_HHLD_UNK_75_PLS_FL_8600 ",
  "OCC_1ST_INDIV_8604 ",
  "CHLD_HHLD_ML_00_TO_02_FL_8601 ",
  "CHLD_HHLD_FEM_00_TO_02_FL_8601 ",
  "CHLD_HHLD_UNK_00_TO_02_FL_8601 ",
  "CHLD_HHLD_ML_03_TO_05_FL_8601 ",
  "CHLD_HHLD_FEM_03_TO_05_FL_8601 ",
  "CHLD_HHLD_UNK_03_TO_05_FL_8601 ",
  "CHLD_HHLD_ML_06_TO_10_FL_8601 ",
  "CHLD_HHLD_FEM_06_TO_10_FL_8601 ",
  "CHLD_HHLD_UNK_06_TO_10_FL_8601 ",
  "CHLD_HHLD_ML_11_TO_15_FL_8601 ",
  "CHLD_HHLD_FEM_11_TO_15_FL_8601 ",
  "CHLD_HHLD_UNK_11_TO_15_FL_8601 ",
  "CHLD_HHLD_ML_16_TO_17_FL_8601 ",
  "CHLD_HHLD_FEM_16_TO_17_FL_8601 ",
  "CHLD_HHLD_UNK_16_TO_17_FL_8601 ",
  "HOME_OWNR_RENTR_8606 ",
  "LNGTH_RES_8607 ",
  "DWELLING_TYP_8608 ",
  "MRTL_STATUS_IN_HHLD_8609 ",
  "FRST_INDIV_GENDR_8610 ",
  "SECND_INDIV_GENDR_8612 ",
  "VERFCN_DT_8614 ",
  "MO_BYR_8615 ",
  "AGE_2_YY_INCRS_1ST_INDIV_8616 ",
  "AGE_2_YY_INCRS_2ND_INDIV_8617 ",
  "BK_CRD_HLDR_FL_8621 ",
  "GAS_DEPT_RTL_CRD_HLDR_FL_8621 ",
  "TRVL_ENTRMT_CRD_HLDR_FL_8621 ",
  "CR_CRD_HLDR_UNK_TYP_FL_8621 ",
  "PREM_CRD_HLDR_FL_8621 ",
  "USCL_DEPT_STR_CRD_HLDR_FL_8621 ",
  "CHLD_IN_HHLD_8622 ",
  "ADLS_NO_IN_HHLD_8628 ",
  "INC_CD_ESTD_HHLD_8641 ",
  "VEHCL_NEW_CAR_BYR_8646 ",
  "VEHCL_KNOWN_OWNED_NO_8647 ",
  "VEHCL_DMNT_LIFESTY_IND_8648 ",
  "CR_RNG_NEW_CR_8836 ",
  "VEHCL_BODY_SZ_NEWEST_CAR_8192 ",
  "PRESENCE_SR_ADL_8692 ",
  "HOME_MKT_VAL_8642 ",
  "HOME_PRCH_YY_8644 ",
  "HOME_EQTY_AVAIL_8663 ",
  "HOME_MKT_VAL_DECILES_8463 ",
  "EDU_1ST_INDIV_9509 ",
  "EDU_2ND_INDIV_9510 ",
  "IFBS_POS_MTCH_IND_8639 ",
  "NO_SRC_8640 ",
  "SPRSN_MAIL_DMA_9557 ",
  "PERSICX_CLUST_9300 ",
  "PERSICX_PRECSN_LEVL_9300 ",
  "MONEY_MAKING_OPPRTUNITIES_8236 ",
  "INVS_RL_ESTT_8244 ",
  "INVS_STKS_BND_8254 ",
  "BLU_CHIP_8278 ",
  "TECHNOLOGY_8279 ",
  "INV_8323 ",
  "HOME_LOT_SQ_FOOTAGE_RNGS_8439 ",
  "HOME_YY_BUILT_RNGS_8440 ",
  "HOME_TOT_LOAN_RNGS_8437 ",
  "HOME_PROP_TYP_DTL_8581 ",
  "HOME_LOAN_TO_VAL_RNGS_8584 ",
  "HOME_SQ_FOOTAGE_RNGS_8441 ",
  "HOME_YY_BUILT_ACTUL_8592 ",
  "HOME_EQTY_LENDABLE_RNGS_8586 ",
  "INV_RL_ESTT_8587 ",
  "HOME_ASED_VAL_RNGS_8557 ",
  "HOME_PRCH_AM_RNGS_8561 ",
  "HOME_LOAN_TYP_1_8570 ",
  "HOME_LOAN_TYP_2_8571 ",
  "HOME_PROP_TYP_8701 ",
  "HOME_OWNR_TYP_8749 ",
  "HOME_LOAN_AM_1_RNGS_8567 ",
  "HOME_LOAN_AM_2_RNGS_8568 ",
  "INVS_HGHLY_LIKELY_8337 ",
  "INVS_LIKELY_8339 ",
  "NETWORTH_IND_9356 ",
  "OVRALL_MTCH_IND_9100 ",
  "DIR_MKTG_ASSOCN_MAIL_PREFNC_FL ",
  "INTRNL_ACXIOM_OPT_OUT_MAIL_FL ",
  "INTRNL_ACXIOM_OPT_OUT_DECSD_FL ",
  "DECSD_DATA_FL ",
  "LRG_PRISON_FL ",
  "LOT_CD ",
  "DELVRY_PT_BARCD ",
  "DSF_DELVRABILITY_IND ",
  "DSF_DELVRY_TYP ",
  "VACANCY_IND ",
  "SEASL_IND ",
  "DSF_LOCATBL_ADDR_CNVSN_SERV ",
  "RCRD_MTCH_CD ",
  "NCOA_MTCHED_MOVE_TYP ",
  "MNTD_DERIVED_CLBL_FL ",
  "ACT_CD ",
  "BUS_NM ",
  "PRFX_TITLE ",
  "FRST_NM ",
  "MIDL_NM ",
  "LST_NM ",
  "SFX ",
  "ADDR_LN_1 ",
  "ADDR_LN_2 ",
  "ADDR_LN_3 ",
  "ADDR_LN_4 ",
  "CITY ",
  "STE ",
  "ZIP_CD ",
  "ZIP_PLUS_4_CD ",
  "FOGN_ADDR_FL ",
  "FOGN_ADDR_TX ",
  "YY_OF_BRTH ",
  "GENDR ",
  "ACXIOM_ID ",
  "ACXIOM_HHLD_ID ",
  "ACXIOM_BUS_NM ",
  "ACXIOM_PRFX ",
  "ACXIOM_FRST_NM ",
  "ACXIOM_MIDL_NM ",
  "ACXIOM_LST_NM ",
  "ACXIOM_SFX ",
  "ACXIOM_ADDR_LN1 ",
  "ACXIOM_ADDR_LN2 ",
  "ACXIOM_CITY ",
  "ACXIOM_STE ",
  "ACXIOM_ZIP_CD ",
  "ACXIOM_ZIP_PLUS_4_CD ",
  "FRST_INDIV_NM ",
  "SECND_INDIV_NM ",
  "ACXIOM_GENDR ",
  "AMEX_CR_CRD_GOLD_FL_2058 ",
  "AMEX_CR_CRD_REG_FL_2058 ",
  "ACTV_INVSTING_FL_2067 ",
  "OCC_DTL_IND_2360 ",
  "ADLS_HHLD_MLS_18_TO_24_FL_7600 ",
  "ADLS_HHLD_FMS_18_TO_24_FL_7600 ",
  "ADLS_HHLD_UNK_18_TO_24_FL_7600 ",
  "ADLS_HHLD_MLS_25_TO_34_FL_7600 ",
  "ADLS_HHLD_FMS_25_TO_34_FL_7600 ",
  "ADLS_HHLD_UNK_25_TO_34_FL_7600 ",
  "ADLS_HHLD_MLS_35_TO_44_FL_7600 ",
  "ADLS_HHLD_FMS_35_TO_44_FL_7600 ",
  "ADLS_HHLD_UNK_35_TO_44_FL_7600 ",
  "ADLS_HHLD_MLS_45_TO_54_FL_7600 ",
  "ADLS_HHLD_FMS_45_TO_54_FL_7600 ",
  "ADLS_HHLD_UNK_45_TO_54_FL_7600 ",
  "ADLS_HHLD_MLS_55_TO_64_FL_7600 ",
  "ADLS_HHLD_FMS_55_TO_64_FL_7600 ",
  "ADLS_HHLD_UNK_55_TO_64_FL_7600 ",
  "ADLS_HHLD_MLS_65_TO_74_FL_7600 ",
  "ADLS_HHLD_FMS_65_TO_74_FL_7600 ",
  "ADLS_HHLD_UNK_65_TO_74_FL_7600 ",
  "ADLS_HHLD_MLS_75_PLS_FL_7600 ",
  "ADLS_HHLD_FMS_75_PLS_FL_7600 ",
  "ADLS_HHLD_UNK_75_PLS_FL_7600 ",
  "ADLS_HHLD_MTCH_LVL_7600 ",
  "CHLD_HHLD_ML_00_TO_02_FL_7601 ",
  "CHLD_HHLD_FEM_00_TO_02_FL_7601 ",
  "CHLD_HHLD_UNK_00_TO_02_FL_7601 ",
  "CHLD_HHLD_ML_03_TO_05_FL_7601 ",
  "CHLD_HHLD_FEM_03_TO_05_FL_7601 ",
  "CHLD_HHLD_UNK_03_TO_05_FL_7601 ",
  "CHLD_HHLD_ML_06_TO_10_FL_7601 ",
  "CHLD_HHLD_FEM_06_TO_10_FL_7601 ",
  "CHLD_HHLD_UNK_06_TO_10_FL_7601 ",
  "CHLD_HHLD_ML_11_TO_15_FL_7601 ",
  "CHLD_HHLD_FEM_11_TO_15_FL_7601 ",
  "CHLD_HHLD_UNK_11_TO_15_FL_7601 ",
  "CHLD_HHLD_ML_16_TO_17_FL_7601 ",
  "CHLD_HHLD_FEM_16_TO_17_FL_7601 ",
  "CHLD_HHLD_UNK_16_TO_17_FL_7601 ",
  "CHLD_HHLD_MTCH_LVL_7601 ",
  "NO_CHLD_7602 ",
  "NO_CHLD_MTCH_LVL_7602 ",
  "OWNR_RNTR_IND_7606 ",
  "OWNR_RNTR_IND_MTCH_LVL_7606 ",
  "LNGTH_OF_RES_7607 ",
  "LNGTH_OF_RES_MTCH_LVL_7607 ",
  "MRTL_STATUS_7609 ",
  "MRTL_STATUS_MTCH_LVL_7609 ",
  "AGE_7616 ",
  "AGE_MTCH_LVL_7616 ",
  "CHLD_FL_7622 ",
  "CHLD_FL_MTCH_LVL_7622 ",
  "NO_ADLS_7628 ",
  "NO_ADLS_MTCH_LVL_7628 ",
  "HHLD_SZ_7629 ",
  "HHLD_SZ_MTCH_LVL_7629 ",
  "INC_CD_7641 ",
  "INC_CD_MTCH_LVL_7641 ",
  "FRST_INDIV_EDUC_7650 ",
  "FRST_INDIV_EDUC_MTCH_LVL_7650 ",
  "INVS_FL_7795 ",
  "INET_USER_FL_7797 ",
  "INC_FL_HIGHER_RNGS_8201 ",
  "ESTD_RESNTIAL_PROP_OWNED_8433 ",
  "HOME_PURCH_DT_8579 ",
  "OCC_2ND_INDIV_8605 ",
  "WRKING_WOMAN_FL_8619 ",
  "MAIL_ORD_RESPONDER_FL_8620 ",
  "AGE_8627 ",
  "AGE_FL_8627 ",
  "OCC_8637 ",
  "GNRTNS_IN_HHLD_8652 ",
  "OL_PURCHNG_IND_8653 ",
  "LIFE_STG_CD_8655 ",
  "INC_FL_NARROW_RNGS_8671 ",
  "GENDR_8688 ",
  "HOME_LOAN_TO_VAL_8704 ",
  "HOME_EQTY_AVAIL_8707 ",
  "HOME_YY_BUILT_8763 ",
  "NO_OF_LNS_OF_CR_8816 ",
  "EDUC_9514 ",
  "RACE_CD_9533 ",
  "EMAIL_APPND_IND_9780 ",
  "ETL_LD_TS ",
  "ETL_PROCS_KEY "
  )

length(vlst)
ifb<-read.table("ibs.txt", sep="\t", nrows=100, header=TRUE, stringsAsFactors=FALSE)
## failed. R can't read beyond line 20?

# SASxport
# NOTE 
# all var names are truncated to 6 letters with 
# SAS option validvarname=V6

install.packages("SASxport")
install.packages("foreign")
library("SASxport")
library("foreign")

ifb <- read.xport("H://temp//IBS.XPT") 
ifb0 <- read.xport("H://temp//IB0S.XPT") 

length(ifb) ## length(data.frame) returns # vars
ori.names<-colnames(ifb)
str(ori.names)
head(ori.names)
ori.names<-data.frame(ori.names)
ori.names$V<-paste0("V",1:246)
colnames(ori.names)[1]<-"VAR"

ori.names[230:231,]
colnames(ori.names)
which(ori.names$VAR=="OCC_8637")

colnames(ifb)[1:245]<-c(paste0("V",1:245))
colnames(ifb0)[1:245]<-c(paste0("p",1:245))
colnames(ifb)[240:246] ## [246] - cin_clnt

### create life event
b.a<-merge(ifb, ifb0, by.x="CIN_CLNT",by.y="CIN_CLNT")
length(b.a) #491 vars
colnames(b.a)[1:5]	## CIN.CLNT is [1] then V1-V245

#construct a data frame to hold all changes
rm(chg)
chg<-subset(b.a, , select=c(CIN_CLNT))
which(colnames(b.a)=='p1') ## 247 very useful index referencer 
which(colnames(b.a)=='CIN_CLNT') ##1
which(colnames(b.a)=='V1') ## 2

# adding vars
chg$M2<-(b.a[,2]==b.a[,247]) 

## alternatively
chg[,paste0("M",2)]<-(b.a[,2]==b.a[,247])

## as.character() fixed it
length(chg)
class(b.a[,78])
class(b.a[,77])

which(colnames(b.a)=="V1") ## 2
which(colnames(b.a)=="p1") ## 247

rm(chg)
chg<-subset(b.a, , select=c(CIN_CLNT))

# vectorization. Theoratically working
chg[,paste0("M",2:246)]<-TRUE
chg[,2:246]<-(as.character(b.a[,2:246])==as.character(b.a[,247:491]))
## Error: cannot allocate vector of size 256.0 Mb

# ONE col a time using FOR loop. And apply condition
for (i in 2:246) {
	chg[,paste0("M",i)]<-as.character(b.a[,i])==as.character(b.a[,i+245])
} #[2] -> V1 [246] ->V245

## + conditions
for (i in 2:246) {
	ifelse(b.a[,i] !=" " && b.a[,i+245] !=" ", 
		chg[,paste0("M",i)]<-as.character(b.a[,i])==as.character(b.a[,i+245]),
		chg[,paste0("M",i)]<-NA)
}

### beautiful! KEEP in mind the differences between if and ifelse
## White space issue
a<-"" 
a==NA <-NA
a=="" <-TRUE
a==" " <-FALSE

## & vs. &&  -- & vector && record
sum(b.a$V231 !="" & b.a$p231 !="") # as countif() in EXCEL
sum(b.a[,232] !="" & b.a[,232] !="")

chg$M232<-(b.a[,232] =="" | b.a[,232+245] =="")
table(chg$M232, useNA="ifany")
chg$M232<-ifelse(b.a[,232] =="" | b.a[,232+245] =="", 1, 0)


## finally got it right. lessons learned: #############
## put assignment outside ifelse() to use vectorization
## difference between | vs. ||; & vs. &&
## 
for (i in 2:246) 
	{chg[,paste0("M",i)]<-
	ifelse(
		b.a[,i] =="" | b.a[,i+245] =="", 
		NA,
		1*(as.character(b.a[,i])!=as.character(b.a[,i+245]))
		)
	} 

## col label
colnames(chg)[2:246]<-vlst
colnames(chg)[1:10]
  
## Summary table
## can't do table(chg) w no column specified
## lapply instead
K<-lapply(chg,table) ##list w 246 elements. Can't use useNA option
KS<-sapply(chg,table) ## works too. the same output format
head(KS,2)

## For more ctrl/details, write own func for LAPPLY
## how come lapply knows x refer to the column in my data??

create.table<-function(x) {
table(x, useNA="ifany")	
prop.table(table(x, useNA="ifany"))	
}
K<-lapply(chg[,2:246],create.table) ## beautiful ##

## dump list output to a text file. 
## list can't be saved as RData, it's not rectagular
sink("L:\\PLuo\\R\\Freq_by_LAPPLY.txt", append=FALSE)
  print(lapply(chg[,2:246],create.table)) 
sink()

## A single level in an element of a list
K$ZIP_PLUS_4_KEY
K$ZIP_PLUS_4_KEY[1]
K$ZIP_PLUS_4_KEY[2]
K$ZIP_PLUS_4_KEY[3]


### create text file for all table output
# sink("L:\\PLuo\\R\\Freq.txt", append=TRUE)
# for (i in 2:200) 
#	{
#	print(colnames(chg)[i])
#  K<-table(chg[,i],useNA="ifany")	
#	print(K)
#	print(prop.table(K))
# }
# sink()

## access a list
K$CHLD_HHLD_ML_00_TO_02_FL_8601
K$CHLD_HHLD_ML_00_TO_02_FL_8601[x="1"] #.0004487162####. WHY = ??

## look for all vars where x=1>threshold %
which(names(K)=="CHLD_HHLD_ML_00_TO_02_FL_8601 ") #30

## NOT working
K[30][x="1"] #got to be K$XX[x=="1"]
K$CHLD_HHLD_ML_00_TO_02_FL_8601[x="1"]
K$CHLD_HHLD_ML_00_TO_02_FL_8601[x="1"]>.00034
K$CHLD_HHLD_ML_00_TO_02_FL_8601[x="1"]>.00054


## query all the tables that have x=1>.1
catch.me<-function(x){
 ifelse(x[1]>=.1, 100, NA)
}

sink("L:\\PLuo\\R\\FreqS.txt", append=FALSE)
print(lapply(K,catch.me) != NA)
sink()  #lapply plus self-made function seem to be working

get.me<-lapply(K,catch.me)
get.me[235]

summ<-summary(get.me[1:246])
head(summ)


## test SASxport package. Nothing to do w the above
# corresponding SAS code. Test xport in r.sas in //Zprogramming

library("SASxport")

test<-
read.xport("H://temp//IBS.XPT",
           force.integer=TRUE,
           formats=NULL,
           name.chars=NULL,
           names.tolower=FALSE,
           keep=NULL,
           drop=NULL,
           as.is=0.95, 
           verbose=FALSE,
           as.list=FALSE,
           include.formats=FALSE
           ) ## worked
##
head(test) ##
describe(test) ## gives N, nmiss, and # unique values
contents(test) ## very useful function for large data.frame
               ## give var, labels, levels, class
               ## Well contents() has something else. Wait
               ## DO NOT USE UNTIL IT'S CLEAR

?read.xport
## following prom is for test example. nothing to do with my















  
  

  



