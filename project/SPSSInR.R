library(foreign)

convert_sav_to_csv <- function(workingdir, input_filename, output_filename_prefix) {
  setwd(workingdir)
  d = read.spss(input_filename, to.data.frame=TRUE)
  
  labels <- attributes(d)$variable.labels
  write.csv(labels, paste(output_filename_prefix, "labels.csv"))
  
  write.csv(d, paste(output_filename_prefix, ".csv", sep=""), row.names = FALSE)
}

convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project/Oct16', 'Oct16 public.sav', 'Oct16 public')
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_00001.sav', 'cps_00001')
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_00002.sav', 'cps_00002')
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_00003.sav', 'cps_00003')
convert_sav_to_csv('~/OneDrive/Personal/School/Master\'s/DATA\ 512/Project', 'cps_00004.sav', 'cps_00004')


