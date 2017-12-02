library(foreign)

# TODO add basic documentation, including pointer to README for info about getting the source data

convert_sav_to_csv <- function(workingdir, input_filename, output_filename_prefix, column_subset=NULL) {
  setwd(workingdir)
  d = read.spss(input_filename, to.data.frame=TRUE)

  # output labels (before we filter, if we filter, so we don't lose the labels)
  labels <- attributes(d)$variable.labels
  write.csv(labels, paste(output_filename_prefix, "labels.csv"))
  
  # if we have a set of columns, then filter to just them
  if (!is.null(column_subset)) {
    d = d[column_subset]
  }
    
  write.csv(d, paste(output_filename_prefix, ".csv", sep=""), row.names = FALSE)
  
  return(d)
}

convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project/Oct16', 
                   'Oct16 public.sav', 'pew_poll', c('state','sex','q10horseGP','race3m1','race3m2','weight'))

convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_population.sav', 
                         'cps_population', c('RACE','WTSUPP','SEX','STATECENSUS'))

convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_votes.sav', 
                         'cps_votes', c('RACE','WTFINL','SEX','STATEFIP','VOTED'))


