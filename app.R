
# # ####################################################
# # # This script makes a psychTestR implementation of
# # # various online polyrhythm studies
# # # Date:20/3- 2020
# # # Author: Cecilie Møller
# # # Project group: Above + Jan Stupacher, Alexandre Celma-Miralles, Peter Vuust
# # ###################################################


library(htmltools)
library(psychTestR)


# # Denne er tyvstjålet fra GMSI-scriptet
# # For jsPsych
# library_dir <- "jspsych/jspsych-6.1.0"
# custom_dir <- "jspsych/js"

jspsych_dir <- "jspsych-6.1.0"

head <- tags$head(
  # jsPsych files
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")),
 
   # Custom files
  includeScript(file.path(jspsych_dir, "plugins/jspsych_BPM/jspsych-audio-bpm-button-response.js")),
  includeCSS(file.path(jspsych_dir,"css/jspsych.css")),
  includeCSS("css/style.css")
)


ui <- tags$div(
  head,
  includeScript("new-timeline.js"),
  includeScript("run-jspsych.js"),
  tags$div(id = "js_psych")
)
# ################################## slet herfra 
# # Configure options
# config <- test_options(title="Validering af dansk Gold-MSI",
#                        admin_password="", # write a secret password here
#                        # enable_admin_panel=FALSE,
#                        researcher_email="cecilie@clin.au.dk",
#                        problems_info="Problemer? Kontakt venligst Cecilie Møller på cecilie@clin.au.dk",
#                        languages = "DA",
#                        display = display_options(
#                          full_screen = TRUE,
#                          content_background_colour = "grey",
#                          css = c(file.path(library_dir, "css/jspsych.css"),
#                                  "jspsych/css/RT_DK.css")
#                        ))
# 
# make_test(experiment,opt=config)
# ###
# 
# config <- test_options(title="Validering af dansk Gold-MSI",
#                        admin_password="", # write a secret password here
#                        # enable_admin_panel=FALSE,
#                        researcher_email="cecilie@clin.au.dk",
#                        problems_info="Problemer? Kontakt venligst Cecilie Møller på cecilie@clin.au.dk",
#                        languages = "DA",
#                        display = display_options(
#                          full_screen = TRUE,
#                          content_background_colour = "grey",
#                          css = c(file.path(library_dir, "css/jspsych.css"),
#                                  "jspsych/css/RT_DK.css")
#                        ))
# 
# make_test(
#   elts = elts,
#   opt = demo_options(
#     display = display_options(
#       full_screen = TRUE,
#       css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
#     )))
# 
# 
# bliver til 
# make_test(
#   elts = elts,
#   opt = test_options(title="MIB poly pilot, apr. 27th 2020",
#                      admin_password="", # write a secret password here
#                      # enable_admin_panel=FALSE,
#                      researcher_email="cecilie@clin.au.dk",
#                      problems_info="Problems? Contact cecilie@clin.au.dk"),
#                      display = display_options(
#                       full_screen = TRUE,
#                       css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
#       ))
####################### og hertil 

poly_ratio <- page(
  ui = ui,
  label = "poly_ratio",
  get_answer = function(input, ...) input$jspsych_results,
  validate = function(answer, ...) nchar(answer) > 0L,
  save_answer = TRUE
)

# PsychTestR elements

# welcome <- one_button_page(
#   div("Welcome! Thank you for your interest in participating in Center for Music in the Brain's scientific study on", tags$strong("beat perception!"),
#     p("It is fun, fast, and very simple. You will hear some musical rhythms, and your task is to simply", tags$em("tap along to the beat of the rhythms"),"using the button below.")
#     )
# )



# DEVICE PAGE
device <-dropdown_page(
  label = "device",
  prompt = div(h2(strong("Goodmorning")),
               p("Thanks for helping us pilot test our new polyrhythm stimuli"),
               p("First, we need to know which device you are using to take the test?"),
               ),
  save_answer=TRUE,
  choices = c("Please choose","Laptop w. touchpad", "Laptop w.external mouse", "Desktop w. external mouse", "Tablet", "Smartphone"),
  alternative_choice = TRUE,
  alternative_text = "Other",
  next_button_text = "Next"
)

welcome <- one_button_page(
  div(
    p("The test is fun, fast, and very simple."),
    p("You will hear some musical rhythms, and your task is to simply"),
    p(tags$em("tap along to the beat of the rhythms"),"using the designated button."),
    p("Some of the rhythms are rather complex. Do not try to imitate the rhythms"),
    p("Simply tap along to the steady underlying beat."),
    
))

beat <- one_button_page(
  div(
    p("To make sure we are on the same page, here are some examples of what we mean when we say 'the beat':"),
    HTML("<br>"),
    p("The beat is like a clock’s tick."),
    p("The beat is the steady pulse you feel when listening to music."),
    p("The beat is what you would naturally clap along to, or tap your foot to."),
    p("Your feet emphasize the beat when you walk at a constant pace in time with music.")
))

# CODE NAME
id <- c(text_input_page(
  label = "anonymous id",
  prompt = div(
               HTML("<br>"),
               p("Almost done!"),
               HTML("<br>"),
               p("(Voluntary:) We may want to ask you questions based on your data in the near future."),
               p("If you like, you can make up a code name and write it here, so we can identify you."),
               p(strong("CODE NAME:"))),
  save_answer = T,
  button_text = "Næste"
))

elts <- list(
  device,
  welcome,
  beat,
  elt_save_results_to_disk(complete = FALSE),
  poly_ratio,
  elt_save_results_to_disk(complete = TRUE),
  id,
  final_page("Thanks! You're done. Please wait for the rest of the gang to finish.")
)

 # make_test(
 #  elts = elts,
 #  opt = demo_options(
 #    display = display_options(
 #      full_screen = TRUE,
 #      css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
 #  )))

 make_test(
     elts = elts,
     opt = test_options(title="MIB poly pilot, apr. 27th 2020",
                        admin_password="test", # write a secret password here
                        # enable_admin_panel=FALSE,
                        researcher_email="cecilie@clin.au.dk",
                        problems_info="Problems? Contact cecilie@clin.au.dk",
                        display = display_options(
                         full_screen = TRUE,
                         css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
         )))

# shiny::runApp(".")
# 
# # ####################################################
# # # This script makes a psychTestR implementation of
# # # various online polyrhythm studies
# # # Date:20/3- 2020
# # # Author: Cecilie Møller
# # # Project group: Above + Jan Stupacher, Alexander Celma-Miralles, Peter Vuust
# # ###################################################
# #
# 
# 
# 
# library(htmltools)
# library(psychTestR)
# 
# jspsych_dir <- "C:/Users/au213911/Documents/poly_online/jspsych-6.1.0"
# 
# head <- tags$head(
#   includeScript(file.path(jspsych_dir, "jspsych.js")),
#   includeScript(file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")),
#   #includeScript(file.path(jspsych_dir, "plugins/jspsych_BPM/jspsych-audio-bpm-button-response.js")),
#   # includeScript(file.path(jspsych_dir, "plugins/jspsych-audio-keyboard-response.js")),
#   # includeScript(file.path(jspsych_dir, "plugins/jspsych-audio-button-response.js")),
# )
# 
# ui <- tags$div(
#   head,
#   includeScript("new-timeline.js"),
#   includeScript("run-jspsych.js"),
#   tags$div(id = "js_psych")
# )
# 
# hello_world <- page(
#   ui = ui,
#   label = "hello_world",
#   get_answer = function(input, ...) input$jspsych_results,
#   validate = function(answer, ...) nchar(answer) > 0L,
#   save_answer = TRUE
# )
# 
# elts <- list(
#   one_button_page("HEJ THOR"),
#   one_button_page("Når der står 'TRYK NU', skal du trykke på mellemrumstasten."),
#   hello_world,
#   elt_save_results_to_disk(complete = TRUE),
#   final_page("GODT KLARET! DU ER EN STJERNE!!")
# )
# 
# 
# #########################
# # RUN EXPERIMENT        #
# #########################
# 
# make_test(
#   elts = elts,
#   opt = demo_options(
#     display = display_options(
#       full_screen = TRUE,
#       css = file.path(jspsych_dir, "css/jspsych.css"))
#   ))
# 
# 
# 
# 
# # shiny::runApp(".")


# 
# 
# 
# 
# 
# 
# 
# 
# 
# 





################ OLD STUFF################



# 
# # INITIALIZE
# 
# library(psychTestR)
# library(htmltools)
# 
# 
# welcome<-one_button_page(
#   div("Welcome! Thank you for your interest in participating in Center for Music in the Brain's scientific study on", tags$strong("beat perception!"),
#     p("It is fun, fast, and very simple. You will hear some drum sounds, and your task is to simply", tags$em("tap along to the beat of the drum sounds"),"using the button below")
#     )
# )
# 
# audio<- audio_NAFC_page(
#   label = "3:4",
#   prompt = div(
#     p("Take a moment to feel the beat of the rhythms. When you feel a steady beat, please tap along to the beat using the 'TAP HERE' button below."),
#     p("When the rhythm stops, click 'NEXT' ")
#     ),
#   
#   choices = c("TAP HERE", "NEXT" ),
#   url="sounds/ambi_-13-5_mono_short.mp3",
#   # url="https://media.gold-msi.org/test_materials/MPT/training/in-tune.mp3", type="mp3"
#  
#   save_answer = T,
#   wait=FALSE
# )
# 
# ui <- tags$div(
#   head, 
#   includeScript("new-timeline.js"),
#   includeScript("run-jspsych.js"),
#   includeScript("record-timing.js"),
#   tags$div(id = "js_psych")
# )
# 
# record_taps <- page(
#   ui = ui,
#   label = "hello_world",
#   get_answer = function(input, ...) input$jspsych_results,
#   validate = function(answer, ...) nchar(answer) > 0L,
#   save_answer = TRUE
# )
# 
# 
# bye<-final_page("Thanks! You can close this browser window now.")
# 
# timeline <- c(
#   welcome,
#   audio,
#   record_taps,
#   bye
# )
# 
# 
# make_test(elts = timeline)
# 
# 
# # shiny::runApp(".")
# 
# 
# 
# 
# 
# # validate = function(answer, ...) {
# #   if (answer=="NEXT")
# #     "Angiv venligst hvilken type udstyr du benytter."
# #   # else if (answer=="TAP HERE") 
# #     # "Angiv venligst hvilken type udstyr du benytter. Hvis du ikke anvender et tastatur, kan du ikke deltage i testen nu. Du er meget velkommen tilbage senere."
# #   else TRUE
# # },
# # validate = function(answer, ...) {
# #   if (answer==""|!check.numeric(answer,only.integer=T)|nchar(answer)!=4)
# #     "Skriv venligst dit 4-cifrede postnummer i hele tal uden andre tegn."
# #   else TRUE
# # },
# # on_complete = function(answer, state, ...) {
# #   set_global(key = "zip_code", value = answer, state = state)
# # }
# 
# # uia <- tags$div(
# #   head,
# #   # includeScript("jspsych/run_jsaudio.js"),
# #   tags$div(id = "js_audio", style = "min-height: 90vh")
# # )
# # 
# # audio_<-page(
# #   label = "poly",
# #   ui=uia,
# #     get_answer = function(input, ...) input$poly_results,
# #     validate = function(answer, ...) {
# #       if (answer=="NEXT")
# #             ""
# #           # else if (answer=="TAP HERE")
# #             # "Angiv venligst hvilken type udstyr du benytter. Hvis du ikke anvender et tastatur, kan du ikke deltage i testen nu. Du er meget velkommen tilbage senere."
# #           else TRUE
# #         
# #     }
# #     # save_answer = TRUE
# # )
# 
# # timeline <- c(
# #   one_button_page("Page 1"),
# #   one_button_page("Page 2"),
# #   final_page("The end")
# # )
# # test <- make_test(elts = timeline)
# # shiny::runApp(test)