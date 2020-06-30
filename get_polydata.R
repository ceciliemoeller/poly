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
library(gglearn2)
# SET WORKING DIRECTORY 

setwd("C:/Users/au213911/Documents/poly_online")

# LIST FILES IN WORKING DIRECTORY (ignoring folders and recursives)
files <- setdiff(list.files(paste0(getwd(),"/results"),include.dirs=F,all.files=F),list.dirs(paste0(getwd(),"/output/results"),full.names=F))
files <- files[grep(".rds$",files)]

# CREATE OUTPUT FILE
output <- data.frame(id=character(),
                     stringsAsFactors=F)
# 
# # test <- data.frame(id=character(),
#                   stringsAsFactors=F)


for (i in 1:length(files)) {
  results <- readRDS(paste0(getwd(),"/results/",files[i]))
  
  output[i,"id"] <- results$session$p_id
  output[i,"complete"] <- results$session$complete
  output[i,"currentTime"] <- results$session$current_time
  output[i,"startTime"] <- results$session$time_started
  output[i,"device"] <- results$results$device
  output[i,"browser"] <- results$results$browser
  output[i,"headphones"] <- results$results$headphones
 
  if ("age"%in%names(results$results)) {

  output[i,"age"] <- results$results$age
  output[i,"gender"] <- results$results$gender
  }
  if ("language"%in%names(results$results)) {

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

    # make js data into dataframe
    jsdata<- fromJSON(results$results$poly_ratio)
  
    
    #look in first row of the dataframe to see which condition (pitch/tempo/ratio) this participant was in and paste into output (a way to double check the code)
    output[i,"soundcheck"]<-jsdata$stimulus[1]
  

    # extract relevant rows, i.e. only those containing tapping data
     tapping_all <- subset(jsdata, trial_type== "audio-bpm-button-response")
     
     
     # save spontaneous taps in output
     output[i,"spontaneous_taps"]<-tapping_all$rt[1]
    
     #remove spontaneous taps (duplicate column name)
     tapping <- subset(tapping_all, stimulus!= "sounds/spontaneous_tap_15s.mp3")

     # and restructure
      reshaped <- t(tapping)

      # Extract stimulus names
      conds<-reshaped['stimulus',]
      
      # extract taps
      taps<-reshaped['rt',]
      # and paste the taps into the column in output which is named according to conds (stimulus name)
      output[i,conds]<-taps
# 
# # extract stimulus presentation order and ratings
# 
#     tr_ind<-reshaped['trial_index',]
#     stim<-reshaped['stimulus',]
#     output[i,tr_ind]<-stim
# 
#     rating<-subset(jsdata, trial_type=="html-slider-response")
#     t_rating <- t(rating)
# 
#     tr_ind<-t_rating['trial_index',]
#     verdict<-t_rating['response',]
#     output[i,tr_ind]<-verdict

  }
}

# MAKE FILES
output_p<- subset(output, soundcheck== "sounds/pitch/poly_pitch_marimba_loudness.mp3")
emptycols <- colSums(is.na(output_p)) == nrow(output_p)
output_p <- output_p[!emptycols]

output_t<- subset(output, soundcheck== "sounds/tempo/poly_tempo_loudness_check.mp3")
emptycols <- colSums(is.na(output_t)) == nrow(output_t)
output_t <- output_t[!emptycols]


output_r<- subset(output, soundcheck== "sounds/ratio/poly_ratio_loudness_check.mp3")
emptycols <- colSums(is.na(output_r)) == nrow(output_r)
output_r <- output_r[!emptycols]


# write.csv(output_p, file = "./pitchtaps.csv")
# write.csv(output_t, file = "./tempotaps.csv")
# write.csv(output_r, file = "./ratiotaps.csv")
# write.csv(output, file = "./ptrtaps.csv")


ggplot(output, aes(x = soundcheck, fill=complete)) + 
  geom_bar()+
  labs(title = 'EXPERIMENT (incl. our own data')+
  theme(axis.text.x = element_text(angle = 270))+
  facet_wrap(~complete)

##################
# PLOT PILOTS ONLY
##################

###
# For plot inspiration, check out:

# gglearn(dataset = output)
# 

# Remove our own data in order to assess effect of browser/headphones instructions
output <- output %>%
  arrange(currentTime)
pilots_only<-output[24:length(output),]

pilots_only<-pilots_only[!is.na(pilots_only$id),]

#plot

ggplot(pilots_only, aes(x = soundcheck, fill=complete)) + 
  geom_bar()+
  labs(title = 'EXPERIMENT(incl. our own data')+
  theme(axis.text.x = element_text(angle = 270))+
  facet_wrap(~complete)
  

ggplot(pilots_only, aes(x = browser)) + 
  geom_bar()+
  labs(title = 'BROWSER')+
facet_wrap(~complete)

ggplot(pilots_only, aes(x = device)) + 
  geom_bar()+
  labs(title = 'DEVICE')+
  facet_wrap(~complete)

ggplot(pilots_only, aes(x = headphones)) + 
  geom_bar()+
  labs(title = 'HEADPHONES?')+
  theme(axis.text.x = element_text(angle = 270))+
  # scale_y_continuous(breaks=seq(0, 16, 5))+
  facet_wrap(~complete)

ggplot(pilots_only, aes(x = headphones)) + 
  geom_bar()+
  labs(title = 'HEADPHONES by device')+
  theme(axis.text.x = element_text(angle = 270))+
  # scale_y_continuous(breaks=seq(0, 16, 5))+
  facet_wrap(~device)



# ###############################################################################################
# ##make easy-access date object
# 
# output$time<- as.POSIXlt.POSIXct(output$currentTime)
# 
# show_date <- output
# show_date<-show_date %>% select(id, currentTime, time, device, browser, headphones, comments, soundcheck)
# 
# ################################################################################################
# # # # Recruitment since X (check show_date)
# # #
# # scores_recent <- scores[scores$currentTime > 			1583244398,]
# # scores<-scores_recent
# ################################################################################################



