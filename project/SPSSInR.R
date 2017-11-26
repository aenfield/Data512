library(foreign)

#setwd('~/work/github/Data512/project')
setwd('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project/Oct16')
d = read.spss('Oct16 public.sav', to.data.frame=TRUE)

labels <- attributes(d)$variable.labels
write.csv(labels, 'Oct16 public labels.csv')

write.csv(d, 'Oct16 public.csv')


setwd('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project')
d = read.spss('cps_00001.sav', to.data.frame=TRUE)

labels <- attributes(d)$variable.labels
write.csv(labels, 'cps_00001 labels.csv')

write.csv(d, 'cps_00001.csv')
