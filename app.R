
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
               p("Thanks for helping us pilot test our new polyrhythm stimuli."),
               p("First, we need to know which device you are using to take the test?"),
               p("As input methods, you can use touchscreen, touchpad or mouse (left click)."),
               p(strong ("You can not use a keyboard.")),
               p("Please make sure you stick to your chosen input method throughout the test."),
               ),
  save_answer=TRUE,
  choices = c("Please choose", "Smartphone (touchscreen)","Tablet (touchscreen)","Laptop (touchpad)", "Laptop (external mouse)", "Desktop (external mouse)"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 250
)

headphones<-dropdown_page(
  label = "headphones",
  prompt = div(p("How do you play the sounds?"),
               
  ),
  save_answer=TRUE,
  choices = c("I will play sounds through...", "on-ear headphones","in-ear headphones","computer's speakers", "external speakers"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 250
)

welcome <- one_button_page(
  div(
    p("The test is fun, fast, and very simple."),
    p("You will hear some musical rhythms, and your task is to simply"),
    p(tags$em("tap along to the beat of the rhythms"),"using the designated button."),
    p("Some of the rhythms are rather complex. Do not try to imitate the rhythms."),
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


rating<-NAFC_page(
  label = "difficulty",
  prompt = "On a scale from 1-9 where 1 is extremely easy and 9 is extremely difficult, how did you find this tapping task in general?", 
  choices = c("1","2","3","4","5","6","7","8","9")
)
# CODE NAME
id <- text_input_page(
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
)

elts <- list(
  device,
  headphones,
  welcome,
  beat,
  elt_save_results_to_disk(complete = FALSE),
  poly_ratio,
  elt_save_results_to_disk(complete = TRUE),
  rating,
  id,
  elt_save_results_to_disk(complete = TRUE),
  final_page("Thanks! You're done. Your data has been saved now and you can safely close the browser window (although you browser will try to convince you otherwise when you do. The presentation will continue when everyone is ready.")
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
                        enable_admin_panel=TRUE,
                        researcher_email="cecilie@clin.au.dk",
                        problems_info="Problems? Contact cecilie@clin.au.dk",
                        display = display_options(
                         full_screen = TRUE,
                         css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
         )))

# shiny::runApp(".")
 



