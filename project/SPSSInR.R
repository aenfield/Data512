library(foreign)

# For more information about this file, and the data used by this code, refer to the README.md in this repo.
#
# The notebook uses the subset of data provided in this repo - the notebook works in a standalone fashion
# and doesn't require that you retrieve any data from the original sources. 
#
# However, if you do want to generate the data used by the notebook from the original sources, run the 
# SPSSInR.R script. This script does three things: 
#
# 1. It uses the full-featured SPSS import code in R's 'foreign' package to load data from the source 
# SPSS .sav files. This data includes both rows, as well as column titles and 'labels' for each column 
# that provide a longer description of that field. I wasn't able to find similar functionality native to 
# Python or in a well-supported Python library.
# 2. Filters the source data to just the subset of columns the notebook requires.
# 3. Writes out the subset of the data as .csv files.

# load a SPSS .sav file and then output both the data and labels as two separate .csv files
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

# To use this code with your own copies of the source data, change the working directory and input 
# filenames below as needed. For more information about the source data, see the README.

# Pew Research Center poll data
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project/Oct16', 
                   'Oct16 public.sav', 'pew_poll', c('state','sex','q10horseGP','race3m1','race3m2','weight'))

# CPS population data
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_population.sav', 
                         'cps_population', c('RACE','WTSUPP','SEX','STATECENSUS'))

# CPS voter data
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_votes.sav', 
                         'cps_votes', c('RACE','WTFINL','SEX','STATEFIP','VOTED'))


