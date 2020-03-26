####################################################
# This script makes psychTestR implementation of
# various online polyrhythm studies                 
# Date:20/3- 2020                                                         
# Author: Cecilie Møller                            
# Project group: Above + Jan Stupacher, Alexander Celma-Miralles, Peter Vuust             
###################################################


# INITIALIZE

library(psychTestR)
library(htmltools)


welcome<-one_button_page(
  div("Welcome! Thank you for your interest in participating in Center for Music in the Brain's scientific study on", tags$strong("beat perception!"),
    p("It is fun, fast, and very simple. You will hear some drum sounds, and your task is to simply", tags$em("tap along to the beat of the drum sounds"),"using the button below")
    )
)

audio<- audio_NAFC_page(
  label = "3:4",
  prompt = div(
    p("Take a moment to feel the beat of the rhythms. When you feel a steady beat, please tap along to the beat using the 'TAP HERE' button below."),
    p("When the rhythm stops, click 'NEXT' ")  ),
  
  choices = c("TAP HERE", "NEXT" ),
  url="https://media.gold-msi.org/test_materials/MPT/training/in-tune.mp3", type="mp3",
 
  save_answer = T,
  wait=FALSE
  # validate = function(answer, ...) {
  #   if (answer=="NEXT")
  #     "Angiv venligst hvilken type udstyr du benytter."
  #   # else if (answer=="TAP HERE") 
  #     # "Angiv venligst hvilken type udstyr du benytter. Hvis du ikke anvender et tastatur, kan du ikke deltage i testen nu. Du er meget velkommen tilbage senere."
  #   else TRUE
  # },
  # validate = function(answer, ...) {
  #   if (answer==""|!check.numeric(answer,only.integer=T)|nchar(answer)!=4)
  #     "Skriv venligst dit 4-cifrede postnummer i hele tal uden andre tegn."
  #   else TRUE
  # },
  # on_complete = function(answer, state, ...) {
  #   set_global(key = "zip_code", value = answer, state = state)
  # }
)



# uia <- tags$div(
#   head,
#   # includeScript("jspsych/run_jsaudio.js"),
#   tags$div(id = "js_audio", style = "min-height: 90vh")
# )
# 
# audio_<-page(
#   label = "poly",
#   ui=uia,
#     get_answer = function(input, ...) input$poly_results,
#     validate = function(answer, ...) {
#       if (answer=="NEXT")
#             ""
#           # else if (answer=="TAP HERE")
#             # "Angiv venligst hvilken type udstyr du benytter. Hvis du ikke anvender et tastatur, kan du ikke deltage i testen nu. Du er meget velkommen tilbage senere."
#           else TRUE
#         
#     }
#     # save_answer = TRUE
# )


bye<-final_page("Thanks! You can close this browser window now.")

timeline <- c(
  welcome,
  audio, 
  bye
)


polytest<-make_test(elts = timeline)
shiny::runApp(polytest)

timeline <- c(
  one_button_page("Page 1"),
  one_button_page("Page 2"),
  final_page("The end")
)
test <- make_test(elts = timeline)
shiny::runApp(test)