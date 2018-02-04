library(sqldf)

rm(All_MarketShare2)
All_MarketShare2<-data.frame(sample(1:500, 500))
names(All_MarketShare2)<-c('DATE_VAUM')
All_MarketShare2$Industry_Assets<-501:1000

sqldf("select count(*) from All_MarketShare2 a where a.DATE_VAUM<=1000")
sqldf("select avg(a.Industry_Assets) from All_MarketShare2 a where a.DATE_VAUM<=320")
sqldf("select avg(a.Industry_Assets) from All_MarketShare2 a where a.DATE_VAUM>320")

### Mario's code
test<-c(if(All_MarketShare2$DATE_VAUM<=320) {All_MarketShare2$Industry_Assets2<-
		All_MarketShare2$Industry_Assets} else All_MarketShare2$Industry_Assets2<-0)
###

summary(All_MarketShare2$Industry_Assets2[All_MarketShare2$Industry_Assets>320])
summary(All_MarketShare2$Industry_Assets2[All_MarketShare2$Industry_Assets<=320])

All_MarketShare2$Industry_Assets2<-ifelse(All_MarketShare2$DATE_VAUM<=320, All_MarketShare2$Industry_Assets,0)

sqldf("select avg(a.Industry_Assets2) from All_MarketShare2 a where a.DATE_VAUM<=320")
sqldf("select avg(a.Industry_Assets2) from All_MarketShare2 a where a.DATE_VAUM>320")

for (i in 1:nrow(All_MarketShare2)){
   if (All_MarketShare2$DATE_VAUM[i]<=320) {All_MarketShare2$Industry_Assets2[i]<-
		All_MarketShare2$Industry_Assets[i]} 
   else {All_MarketShare2$Industry_Assets2[i]<-0}   	
}

#sql has default loop
T<-sqldf("select a.*
	     ,case when a.DATE_VAUM<=320 then a.Industry_Assets else 0 end as Industry_Assets2
       from All_MarketShare2 a")

sqldf("select avg(a.Industry_Assets2) from T a where a.DATE_VAUM<=320")
sqldf("select avg(a.Industry_Assets2) from T a where a.DATE_VAUM>320")

