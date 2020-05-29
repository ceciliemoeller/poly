###########################################################################
# This script extracts data from the umbrella -polyrhythm study           #
#                                                                         #                                                                       #
#                                                                         #
# Date: May. 28th   2020                                                  #
# Author: Cecilie Møller                                                  #
# Project group: above + Jan Stupacher, Alexandre Celma-Miralles,         #
# Peter Vuust                                                             #
###########################################################################

# INITIALIZE
library(jsonlite)
library(dplyr)
library(ggplot2)
# SET WORKING DIRECTORY 

setwd("C:/Users/au213911/Documents/poly_online")

# LIST FILES IN WORKING DIRECTORY (ignoring folders and recursives)
files <- setdiff(list.files(paste0(getwd(),"/results"),include.dirs=F,all.files=F),list.dirs(paste0(getwd(),"/output/results"),full.names=F))
files <- files[grep(".rds$",files)]

# CREATE OUTPUT FILE
output <- data.frame(id=character(),
                     stringsAsFactors=F)




for (i in 1:length(files)) {
  results <- readRDS(paste0(getwd(),"/results/",files[i]))
  
  output[i,"id"] <- results$session$p_id
  output[i,"complete"] <- results$session$complete
  output[i,"currentTime"] <- results$session$current_time
  output[i,"startTime"] <- results$session$time_started
  output[i,"device"] <- results$results$device
  output[i,"browser"] <- results$results$browser
  output[i,"headphones"] <- results$results$headphones
 
  
  if ("language"%in%names(results$results)) {
    output[i,"age"] <- results$results$age
    output[i,"gender"] <- results$results$gender
    output[i,"residence"] <- results$results$residence
    output[i,"youth_country"] <- results$results$youth_country
    output[i,"language"] <- results$results$language
    output[i,"ollen"] <- results$results$ollen
  }
  
  
  if ("years_instr"%in%names(results$results)) {
    
    output[i,"MT_06"] <- results$results$MT_06
    output[i,"instrument"] <- results$results$instrument
    output[i,"years_instr"] <- results$results$years_instr
  
  }
 
  
  if ("duplets"%in%names(results$results)) {
    output[i,"duplets"] <- results$results$duplets
    
  }
  
  if ("comments"%in%names(results$results)) {
    output[i,"comments"] <- results$results$comments
    
  }
  

  if ("poly_ratio"%in%names(results$results)) {
    
    jsdata<- fromJSON(results$results$poly_ratio)
    
    #blabla  output[i,"spont"] <- jsdata$results$comments

  #   # create pitch data csv
  # 
  #    if(jsdata$stimulus[1]=="sounds/pitch/poly_pitch_marimba_loudness.mp3") {
  # 
  #   # output<-output
  # 
  #   tapping <- subset(jsdata, trial_type== "audio-bpm-button-response")
  #   reshaped <- t(tapping)
  # 
  #   conds<-reshaped['stimulus',]
  #   taps<-reshaped['rt',]
  #   output[i,conds]<-taps
  # 
  #   tr_ind<-reshaped['trial_index',]
  #   stim<-reshaped['stimulus',]
  #   output[i,tr_ind]<-stim
  # 
  #   rating<-subset(jsdata, trial_type=="html-slider-response")
  #   t_rating <- t(rating)
  # 
  #   tr_ind<-t_rating['trial_index',]
  #   verdict<-t_rating['response',]
  #   output[i,tr_ind]<-verdict
  # }
  # 
  #   write.csv(output, file = "./pitchtaps.csv")

##############
# # create ratio data csv

if(jsdata$stimulus[1]=="sounds/ratio/poly_ratio_loudness_check.mp3") {


  tapping <- subset(jsdata, trial_type== "audio-bpm-button-response")
  reshaped <- t(tapping)

  conds<-reshaped['stimulus',]
 taps<-reshaped['rt',]
   output[i,conds]<-taps
# 
#   tr_ind<-reshaped['trial_index',]
#   stim<-reshaped['stimulus',]
#   output[i,tr_ind]<-stim
# 
#   rating<-subset(jsdata, trial_type=="html-slider-response")
#   t_rating <- t(rating)
# 
#   tr_ind<-t_rating['trial_index',]
#   verdict<-t_rating['response',]
#   output[i,tr_ind]<-verdict
}
# 
# write.csv(output, file = "./ratiotaps.csv")


    #######################
    # create tempo data csv

    # if(jsdata$stimulus[1]=="sounds/tempo/poly_tempo_loudness_check.mp3") {
    # 
    # 
    #   tapping <- subset(jsdata, trial_type== "audio-bpm-button-response")
    #   reshaped <- t(tapping)
    # 
    #   conds<-reshaped['stimulus',]
    #   taps<-reshaped['rt',]
    #   output[i,conds]<-taps
    # 
    #   tr_ind<-reshaped['trial_index',]
    #   stim<-reshaped['stimulus',]
    #   output[i,tr_ind]<-stim
    # 
    #   rating<-subset(jsdata, trial_type=="html-slider-response")
    #   t_rating <- t(rating)
    # 
    #   tr_ind<-t_rating['trial_index',]
    #   verdict<-t_rating['response',]
    #   output[i,tr_ind]<-verdict
    # }
    # 
    # write.csv(output, file = "./tempotaps.csv")

  }
}
