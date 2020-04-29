###########################################################################
# This script extracts data from the ratio part of the umbrella -poly-    #
# rhythm pilotstudy conducted at a virtual MIB-lab meeting Apr. 27th      #
# 2020                                                                    #
#                                                                         #
#                                                                         #
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
    
    
    if ("anonymous id"%in%names(results$results)) {
      output[i,"anonymous_id"] <- results$results$"anonymous id"
      
    }
    
    if ("difficulty"%in%names(results$results)) {
      output[i,"difficulty"] <- results$results$difficulty
    
    }
    
    if ("poly_ratio"%in%names(results$results)) {
      
      jsdata<- fromJSON(results$results$poly_ratio)
      
      tapping <- subset(jsdata, trial_type== "audio-bpm-button-response")
      reshaped <- t(tapping)
      conds<-reshaped['stimulus',]
      rt<-reshaped['rt',]
      output[i,conds]<-rt
      
    }
  }


write.csv(output, file = "./pilottaps.csv")
