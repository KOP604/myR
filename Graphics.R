#Age pyramid
vgi.set()
vgi.packages()
require(ggplot2)
df <- data.frame(Type = sample(c('Male', 'Female', 'Female'), 1000, replace=TRUE),
                 Age = sample(18:60, 1000, replace=TRUE))

AgesFactor <- ordered( cut(df$Age, breaks = c(18,seq(20,60,5)), 
                           include.lowest = TRUE))

df$Age <- AgesFactor

#Male
gg <- ggplot(data = df, aes(x=Age))

gg.male <- gg + 
  geom_bar( subset = .(Type == 'Male'), 
            aes( y = ..count../sum(..count..), fill = Age)) +
  scale_y_continuous('', formatter = 'percent') + 
  opts(legend.position = 'none') +
  opts(axis.text.y = theme_blank(), axis.title.y = theme_blank()) + 
  opts(title = 'Male', plot.title = theme_text( size = 10) ) +  
  coord_flip()    

#Female
gg.female <- gg + 
  geom_bar( subset = .(Type == 'Female'), 
            aes( y = ..count../sum(..count..), fill = Age)) +
  scale_y_continuous('', formatter = 'percent', trans = 'reverse') + 
  opts(legend.position = 'none') +
  opts(axis.text.y = theme_blank(), 
       axis.title.y = theme_blank(), 
       title = 'Female') +
  opts( plot.title = theme_text( size = 10) ) +
  coord_flip()

gg.ages <- gg + 
  geom_bar( subset = .(Type == 'Male'), aes( y = 0, fill = alpha('white',0))) +
  geom_text( aes( y = 0,  label = as.character(Age)), size = 3) +
  coord_flip() +
  opts(title = 'Ages',
       legend.position = 'none' ,
       axis.text.y = theme_blank(),
       axis.title.y = theme_blank(),
       axis.text.x = theme_blank(),
       axis.ticks = theme_blank(),          
       plot.title = theme_text( size = 10))       
