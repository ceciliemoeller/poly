
# # ####################################################
# # # This script makes a psychTestR implementation of
# # # various online polyrhythm studies
# # # Date:20/3- 2020
# # # Author: Cecilie Møller
# # # Project group: Above + Jan Stupacher, Alexandre Celma-Miralles, Peter Vuust
# # ###################################################


library(htmltools)
library(psychTestR)

library(tibble)


# # For jsPsych
# library_dir <- "jspsych/jspsych-6.1.0"
# custom_dir <- "jspsych/js"

jspsych_dir <- "jspsych-6.1.0"

head <- tags$head(
  # jsPsych files
  
  
  # # If you want to use original jspsych.js, use this:
  # includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  includeScript(file.path(jspsych_dir, "jspsych_preloadprogressbar.js")),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-audio-button-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-slider-response.js")
  ),
  
  # Custom files
  includeScript(
    file.path(
      jspsych_dir,
      "plugins/jspsych_BPM/jspsych-audio-bpm-button-response.js"
    )
  ),
  includeCSS(file.path(jspsych_dir, "css/jspsych.css")),
  includeCSS("css/style.css")
)


# ui_sms <- tags$div(
#   head,
#   includeScript("new-timeline.js"),
#   includeScript("run-jspsych.js"),
#   tags$div(id = "js_psych")
# )

ui_exp <- tags$div(
  head,
  includeScript("exp-rand.js"),
  includeScript("new-timeline.js"),
  includeScript("run-jspsych.js"),
  tags$div(id = "js_psych")
)

# js_check_sms <- page(
#   ui = ui_sms,
#   label = "js_check_sms",
#   get_answer = function(input, ...)
#     input$jspsych_results,
#   validate = function(answer, ...)
#     nchar(answer) > 0L,
#   save_answer = TRUE
# )

poly_ratio <- page(
  ui = ui_exp,
  label = "poly_ratio",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

# PsychTestR elements


intro <- c(
welcome <-
  one_button_page(div(
    HTML("<img src='img/au_logo.png'></img> <img src='img/mib_logo.png'></img>"),
    div(
      h3(strong("Welcome!")),
      p("Thank you for your interest in participating in Center for Music in the Brain's scientific study on"),
      p(strong("musical beat perception!")),
      p("The test is fun, fast, and very simple. You will hear some musical rhythms, and your task is to simply tap along to the beat of the rhythms, using the designated button."),
      p("Recommendations: take the test in quiet surroundings, use headphones, and do not use the browser 'Safari'."),
      p("You can expect this to take 10-15 minutes."),
      p("Please note: You have to be at least 18 years old to participate."),
      )
  ),
  button_text = "I am 18 or older. Continue!"
       
    ),


# sound_check<-one_button_page(
#   
#   body = div(h4(strong("Quick sound check")),
#              
#              p("When you click the button below, you will hear some random sounds that you can use to adjust the volume of your device to a comfortable level."),
#              # p("If the experiment fails to load, or you cannot hear the sounds despite having turned up the volume, close the window and open it in a different browser, e.g., Chrome, Firefox or Edge.")
#   ),
#   button_text = "Play sounds"
# )


# p("If possible, find a fairly quiet room so you can easily concentrate on the task.")

# PAGES
device <-dropdown_page(
  label = "device",
  prompt = div(h4(strong("Device")),
               p("First, we need to know which device you are using to take the test?"),
               p("If possible, use a device with a touchscreen, alternatively a clickpad or mouse, rather than a laptop touchpad."),
               p(strong ("You can not use a keyboard.")),
               p("Please make sure you stick with your chosen input method throughout the test."),
               ),
  save_answer=TRUE,
  choices = c("Select current device", "Smartphone (touchscreen)","Tablet (touchscreen)","Laptop (click button/clickpad)", "Laptop (external mouse)", "Desktop (external mouse)"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Select current device")
      "Which device are you using to take the test? Click the small arrow on the right of the first box to see the options. We ask because it matters for the analyses of the data you provide."
    else if (answer=="") 
      "Please tell us which device you are currently using. If you select 'Other' at the bottom of the list, please state in the designated field which type of device you use to take the test."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "device", value = answer, state = state)
  }     
),

browser <- dropdown_page(
  label = "browser",
  prompt = div(h4(strong("Browser")),
               p("Which browser are you using?"),
               # HTML("<br>"),
                p("PLEASE NOTE: Safari may not work, depending on your computer's settings."),
                  ),
  save_answer=TRUE,
  choices = c("Select current browser","Firefox", "Chrome","Edge","Internet Explorer","Safari", "Opera", "I do not know"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Select current browser")
      "Please tells us which browser you use (click the small arrow on the right of the first box to see the options). We ask because it matters for the analyses of the data you provide."
    else if (answer=="") 
      "Please answer the question. If you select 'Other' at the bottom of the list, please state the name of your browser in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "browser", value = answer, state = state)
  }  
),


headphones<-dropdown_page(
  label = "headphones",
  prompt = div(h4(strong("Headphones?")),
               p("If at all possible, please use headphones!"),
               p("How do you play the sounds?"),
  ),
  save_answer=TRUE,
  choices = c("I will play sounds through...", "over-ear headphones", "on-ear headphones","in-ear headphones", "my device's internal speakers", "external speakers"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 260,
  validate = function(answer, ...) {
    if (answer=="I will play sounds through...")
      "Please tells how you will hear the sounds (click the small arrow on the right of the first box to see the options). We ask because it matters for the analyses of the data you provide."
    else if (answer=="") 
      "If you select 'Other' at the bottom of the list, please state in the designated field which kind of headphones or speakers you use."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "headphones", value = answer, state = state)
  }  
)
)

sound_check<-one_button_page(
  
  body = div(h4(strong("Quick sound check")),
             
             p("When you click the button below, you will hear some random sounds that you can use to adjust the volume of your device to a comfortable level."),
             # p("If the experiment fails to load, or you cannot hear the sounds despite having turned up the volume, close the window and open it in a different browser, e.g., Chrome, Firefox or Edge.")
  ),
  button_text = "Play sounds"
)



# DEMOGRAPHICS



age <-dropdown_page(
  label = "age",
  prompt = div(h4(strong("We would love to know more about you...")),
               p("Thanks. You are done with the tapping part and we would like to ask just a few general questions about yourself before you leave us."),
               p(strong ("What is your age?")),
               ),
  save_answer=TRUE,
  choices = c("Please select","18-19 years","20-21","22-23","24-25","26-27","28-29","30-31","32-33","34-35","36-37","38-39","40-41","42-43","44-45","46-47","48-49","50-51","52-53","54-55","56-57","58-59","60-61","62-63","64-65","66-67","68-69","70-71","72-73","74-75","76-77","78-79","80 years or above"),
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please state your age (click the small arrow on the right of the box to see the options). We ask because it matters for the analyses of the data you provide."
    #else if (answer=="") 
   #   "Please answer the question. If you select 'Other' at the bottom of the list, please state the name of your browser in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "age", value = answer, state = state)
  }  
)


gender<-NAFC_page(
  label = "gender",
  prompt = p(strong ("Whats is your gender?")), 
  choices = c("Female", "Male","Other","I prefer not to tell you"),
)

demographics <- c(
# RESIDENCE
residence <- dropdown_page(
  label = "residence",
  prompt = p(strong ("Country of current residency:")),
  save_answer=TRUE,
  choices = c("Please select", "Afghanistan	", "Albania	", "Algeria	", "Andorra	", "Angola	", "Anguilla	", "Antigua & Barbuda	", "Argentina	", "Armenia	", "Australia	", 
              "Austria	", "Azerbaijan	", "Bahamas	", "Bahrain	", "Bangladesh	", "Barbados	", "Belarus	", "", "Belgium	", "Belize	", "Benin	", "Bermuda	", 
              "Bhutan	", "Bolivia	", "Bosnia & Herzegovina	", "Botswana	", "Brazil	", "Brunei Darussalam	", "Bulgaria	", "Burkina Faso	", "Burundi	", "Cambodia	", 
              "Cameroon	", "Canada	", "Cape Verde	", "Cayman Islands	", "Central African Republic	", "Chad	", "Chile	", "China	", "China - Hong Kong / Macau	", "Colombia ",
              "Comoros	", "Congo	", "Congo, Democratic Republic of	", "Costa Rica	", "Croatia	", "Cuba	", "Cyprus	", "Czech Republic	", "Denmark	", "Djibouti	", "Dominica	", 
              "Dominican Republic	", "Ecuador	", "Egypt	", "El Salvador	", "Equatorial Guinea	", "Eritrea	", "Estonia	", "Ethiopia	", "Fiji	", "Finland	", "France	", 
              "French Guiana	", "Gabon	", "Gambia	", "Georgia	", "Germany	", "Ghana	", "Greece	", "Grenada	", "Guadeloupe	", "Guatemala	", "Guinea	", 
              "Guinea-Bissau	", "Guyana	", "Haiti	", "Honduras	", "Hungary	", "Iceland ", "India	", "Indonesia	", "Iran	", "Iraq	", "Israel and the Occupied Territories	",
              "Italy	", "Ivory Coast (Cote d'Ivoire)	", "Jamaica	", "Japan	", "Jordan	", "Kazakhstan	", "Kenya	", "Korea, Democratic Republic of (North Korea)	",
              "Korea, Republic of (South Korea)	", "Kosovo	", "Kuwait	", "Kyrgyz Republic (Kyrgyzstan)	", "Laos	", "Latvia	", "Lebanon	", "Lesotho	", "Liberia	",
              "Libya	", "Liechtenstein	", "Lithuania	", "Luxembourg	", "Macedonia, Republic of	", "Madagascar	", "Malawi	", "Malaysia	", "Maldives	", "Mali	",
              "Malta	", "Martinique	", "Mauritania	", "Mauritius	", "Mayotte	", "Mexico	", "Moldova, Republic of	", "Monaco	", "Mongolia	", "Montenegro	",
              "Montserrat	", "Morocco	", "Mozambique	", "Myanmar/Burma	", "Namibia	", "Nepal", "New Zealand	", "Nicaragua	", "Niger	", "Nigeria	", "Norway	",
              "Oman	", "Pacific Islands	", "Pakistan	", "Panama	", "Papua New Guinea	", "Paraguay	", "Peru	", "Philippines	", "Poland	", "Portugal	",
              "Puerto Rico	", "Qatar	", "Republic of Ireland ", "Reunion	", "Romania	", "Russian Federation	", "Rwanda	", "Saint Kitts and Nevis	", "Saint Lucia	", "Saint Vincent and the Grenadines	",
              "Samoa	", "Sao Tome and Principe	", "Saudi Arabia	", "Senegal	", "Serbia	", "Seychelles	", "Sierra Leone	", "Singapore	", "Slovak Republic (Slovakia)	",
              "Slovenia	", "Solomon Islands	", "Somalia	", "South Africa	", "South Sudan	", "Spain	", "Sri Lanka	", "Sudan	", "Suriname	", "Swaziland	", "Sweden	",
              "Switzerland	", "Syria	", "Tajikistan	", "Tanzania", "Thailand	", "Netherlands	", "Timor Leste	", "Togo	", "Trinidad & Tobago	", "Tunisia	", "Turkey	",
              "Turkmenistan	", "Turks & Caicos Islands	", "Uganda	", "UK ", "Ukraine	", "United Arab Emirates	", "United States of America (USA)	", "Uruguay	", "Uzbekistan	",
              "Venezuela	", "Vietnam	", "Virgin Islands (UK)	", "Virgin Islands (US)	", "Yemen	", "Zambia	", "Zimbabwe", "I prefer not to tell you"
),
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please select your country from the dropdown menu. If your country is not on the list, select 'other' at the bottom of the list and write the name of your country in the designated field."
    else if (answer=="") 
      "In which country do you currently live? If you select 'Other' at the bottom of the list, please write the name of your country in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "residence", value = answer, state = state)
  }     
),


# CHILDHOOD/YOUTH COUNTRY
youth_country <- dropdown_page(
  label = "youth_country",
  prompt = p(strong ("Country in which you spent the formative years of your childhood and youth:")),
  save_answer=TRUE,
  choices = c("Please select", "Afghanistan	", "Albania	", "Algeria	", "Andorra	", "Angola	", "Anguilla	", "Antigua & Barbuda	", "Argentina	", "Armenia	", "Australia	", 
              "Austria	", "Azerbaijan	", "Bahamas	", "Bahrain	", "Bangladesh	", "Barbados	", "Belarus	", "", "Belgium	", "Belize	", "Benin	", "Bermuda	", 
              "Bhutan	", "Bolivia	", "Bosnia & Herzegovina	", "Botswana	", "Brazil	", "Brunei Darussalam	", "Bulgaria	", "Burkina Faso	", "Burundi	", "Cambodia	", 
              "Cameroon	", "Canada	", "Cape Verde	", "Cayman Islands	", "Central African Republic	", "Chad	", "Chile	", "China	", "China - Hong Kong / Macau	", "Colombia ",
              "Comoros	", "Congo	", "Congo, Democratic Republic of	", "Costa Rica	", "Croatia	", "Cuba	", "Cyprus	", "Czech Republic	", "Denmark	", "Djibouti	", "Dominica	", 
              "Dominican Republic	", "Ecuador	", "Egypt	", "El Salvador	", "Equatorial Guinea	", "Eritrea	", "Estonia	", "Ethiopia	", "Fiji	", "Finland	", "France	", 
              "French Guiana	", "Gabon	", "Gambia	", "Georgia	", "Germany	", "Ghana	", "Greece	", "Grenada	", "Guadeloupe	", "Guatemala	", "Guinea	", 
              "Guinea-Bissau	", "Guyana	", "Haiti	", "Honduras	", "Hungary	", "Iceland ", "India	", "Indonesia	", "Iran	", "Iraq	", "Israel and the Occupied Territories	",
              "Italy	", "Ivory Coast (Cote d'Ivoire)	", "Jamaica	", "Japan	", "Jordan	", "Kazakhstan	", "Kenya	", "Korea, Democratic Republic of (North Korea)	",
              "Korea, Republic of (South Korea)	", "Kosovo	", "Kuwait	", "Kyrgyz Republic (Kyrgyzstan)	", "Laos	", "Latvia	", "Lebanon	", "Lesotho	", "Liberia	",
              "Libya	", "Liechtenstein	", "Lithuania	", "Luxembourg	", "Macedonia, Republic of	", "Madagascar	", "Malawi	", "Malaysia	", "Maldives	", "Mali	",
              "Malta	", "Martinique	", "Mauritania	", "Mauritius	", "Mayotte	", "Mexico	", "Moldova, Republic of	", "Monaco	", "Mongolia	", "Montenegro	",
              "Montserrat	", "Morocco	", "Mozambique	", "Myanmar/Burma	", "Namibia	", "Nepal", "New Zealand	", "Nicaragua	", "Niger	", "Nigeria	", "Norway	",
              "Oman	", "Pacific Islands	", "Pakistan	", "Panama	", "Papua New Guinea	", "Paraguay	", "Peru	", "Philippines	", "Poland	", "Portugal	",
              "Puerto Rico	", "Qatar	", "Republic of Ireland ", "Reunion	", "Romania	", "Russian Federation	", "Rwanda	", "Saint Kitts and Nevis	", "Saint Lucia	", "Saint Vincent and the Grenadines	",
              "Samoa	", "Sao Tome and Principe	", "Saudi Arabia	", "Senegal	", "Serbia	", "Seychelles	", "Sierra Leone	", "Singapore	", "Slovak Republic (Slovakia)	",
              "Slovenia	", "Solomon Islands	", "Somalia	", "South Africa	", "South Sudan	", "Spain	", "Sri Lanka	", "Sudan	", "Suriname	", "Swaziland	", "Sweden	",
              "Switzerland	", "Syria	", "Tajikistan	", "Tanzania", "Thailand	", "Netherlands	", "Timor Leste	", "Togo	", "Trinidad & Tobago	", "Tunisia	", "Turkey	",
              "Turkmenistan	", "Turks & Caicos Islands	", "Uganda	", "UK ", "Ukraine	", "United Arab Emirates	", "United States of America (USA)	", "Uruguay	", "Uzbekistan	",
              "Venezuela	", "Vietnam	", "Virgin Islands (UK)	", "Virgin Islands (US)	", "Yemen	", "Zambia	", "Zimbabwe", "I prefer not to tell you"
  ),
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "From the dropdown menu please select the country you grew up in. If your country is not on the list, select 'other' at the bottom of the list and write the name of your country in the designated field."
    else if (answer=="") 
      "In which country did you grow up? If you select 'other' at the bottom of the list then please write the name of your country in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "youth_country", value = answer, state = state)
  }     
),



# MOTHER TONGUE
language <- text_input_page(
  label = "language",
  width = "290px",
  prompt = p(strong ("Which language(s) do you consider your mother tongue (the language(s) of the family you grew up in)?"),
             p("If you are bilingual, please write the names of both languages beginning with the one with the strongest influence in your daily life.")),
  save_answer=TRUE,
  button_text = "Next"
)
)


# # MOTHER TONGUE
# language <- dropdown_page(
#   label = "language",
#   prompt = p(strong ("Which language(s) do you consider your mother tongue (the language(s) of the family you grew up in)?"),
#           p("If you are bilingual, please select the option 'Other or bilingual' and state the names of the languages beginning with the one with the strongest influence in your daily life.")),
#   save_answer=TRUE,
#   choices = c("Please select",  "Arabic", "Bengali", "Chinese", "Danish", "English", "Hindi", "Japanese", "Portuguese", "Punjabi", "Russian", "Spanish", 
#                "I prefer not to tell you"
#   ),
#   alternative_choice = TRUE,
#   alternative_text = "Other or bilingual (please state which)",
#   next_button_text = "Next",
#   max_width_pixels = 290,
#   validate = function(answer, ...) {
#     if (answer=="Please select")
#       "Please select your mother tongue from the dropdown menu. If your mother tongue is not on the list, or if you are bilingual, select 'Other or bilingual' at the bottom of the list and write the name(s) of the language(s) in the designated field."
#     else if (answer=="") 
#       "If you select 'Other or bilingual' at the bottom of the list, please write the name(s) of the language(s) in the designated field."
#     else TRUE
#   },
#   on_complete = function(answer, state, ...) {
#     set_global(key = "residence", value = answer, state = state)
#   }     
# )
# )

# MUSICAL EXPERIENCE

music_exp <- c(


# ollen
ollen<-NAFC_page(
  label = "ollen",
  prompt = p(strong ("Which title best describes you?")), 
  choices = c("Nonmusician", "Music-loving nonmusician","Amateur musician","Serious amateur musician","Semiprofessional musician","Professional musician"),
  on_complete = function(answer, state, ...) {
    set_global(key = "ollen", value = answer, state = state)
    if (answer == "Nonmusician"|answer =="Music-loving nonmusician") skip_n_pages(state,3)
  }
  ),

#gold-msi item 06 from musical training subscale

MT_06<-NAFC_page(
  label = "MT_06",
  prompt = p(strong ("I can play the following number of musical instruments:")),
  choices = c("0", "1","2","3","4","5","6 or more"),
),

# gold-msi instrument item
instrument <-dropdown_page(
  label = "instrument",
  prompt = p(strong ("The instrument I play best (including voice) is...")), 
  save_answer=TRUE,
  choices = c("Please select","I don't play any instrument", "alto", "basoon", "cello", "clarinete", "double bass", "drums", "flute", "guitar", "harp", "horn", 
              "oboe", "piano", "saxophone", "trumpet", "tuba", "trombone",  "voice", "violin", "xylophone",  "I prefer not to tell you"),
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please select the instrument you play best from the dropdown menu."
    else if (answer=="") 
      "If your instrument is not on the list, please select 'Other' at the bottom of the list and write the name of the instrument you play best in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "instrument", value = answer, state = state)
  }
),

# custom made question on instrument experience

years_instrument <- dropdown_page(
  label = "years_instr",
  prompt = p(strong("For how many years have you played a musical instrument (including voice)?")),
  save_answer=TRUE,
  choices = c("Please select", "I don't play any instrument", "Less than one year", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20",	"21",	"22",	"23",	"24",	"25",	"26",	"27",	"28",	"29",	"30",	"31",	"32",	"33","34",	"35",	"36",	"37",	"38",	"39",	"40",	"41",	"42",
              "43",	"44",	"45",	"46",	"47",	"48",	"49",	"50",	"51",	"52",	"53",	"54",	"55",	"56",	"57",	"58",	"59",	"60",	"61",	"62",	"63",	"64","65",	"66",	"67",
              "68",	"69",	"70",	"71",	"72",	"73",	"74",	"75",	"76",	"77",	"78",	"79",	"80 years or more", "I prefer not to tell you"),

  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played a musical instrument (click the small arrow on the right of the box to see the options). We ask because it matters for the analyses of the data you provide."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "age", value = answer, state = state)
  }  
) 
)
# onset_age <- dropdown_page(
#   label = "age",
#   prompt = p(strong("What age did you start to play an instrument?")),
#   save_answer=TRUE,
#   choices = c("Please select", "I don't play any instrument", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
#               "18",	"19",	"20",	"21",	"22",	"23",	"24",	"25",	"26",	"27",	"28",	"29",	"30",	"31",	"32",	"33","34",	"35",	"36",	"37",	"38",	"39",	"40",	"41",	"42",
#               "43",	"44",	"45",	"46",	"47",	"48",	"49",	"50",	"51",	"52",	"53",	"54",	"55",	"56",	"57",	"58",	"59",	"60",	"61",	"62",	"63",	"64","65",	"66",	"67",
#               "68",	"69",	"70",	"71",	"72",	"73",	"74",	"75",	"76",	"77",	"78",	"79",	"80 or above", "I prefer not to tell you"),
#   # alternative_choice = TRUE,
#   # alternative_text = "I prefer not to tell you",
#   next_button_text = "Next",
#   max_width_pixels = 250,
#   validate = function(answer, ...) {
#     if (answer=="Please select")
#       "Please state the age at which you started to play a musical instrument (click the small arrow on the right of the box to see the options). We ask because it matters for the analyses of the data you provide."
#     else TRUE
#   },
#   on_complete = function(answer, state, ...) {
#     set_global(key = "age", value = answer, state = state)
#   }  
# ) 
# # GOLD-MSI MUSICAL TRAINING SUBSCALE ITEMS
# 
# MT_01<-NAFC_page(
#   label = "MT_01",
#   prompt = p(strong ("I engaged in regular, daily practice of a musical instrument (including voice) for the following number of years:")), 
#   choices = c("0", "1","2","3","4-5","6-9","10 or more"),
# )
# MT_02<-NAFC_page(
#   label = "MT_02",
#   prompt = p(strong ("At the peak of my interest, I practised my primary instrument for the following number of hours per day:")), 
#   choices = c("0", "0.5", "1","1.5","2","3-4","5 or more"),
# )
# 
# #REVERSE ITEM 03
# MT_03<-NAFC_page(
#   label = "MT_03",
#   prompt = p(strong ("I have never been complimented for my talents as a musical performer.")), 
#   choices = c("Completely Disagree", "Strongly Disagree", "Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","Completely Agree"),
# )
# 
# MT_04<-NAFC_page(
#   label = "MT_04",
#   prompt = p(strong ("I have had formal training in music theory for the following number of years:")), 
#   choices = c("0", "0.5", "1","2","3","4-6", "7 or more"),
# )
# 
# MT_05<-NAFC_page(
#   label = "MT_05",
#   prompt = p(strong ("I have had formal training on a musical instrument (including voice) during my lifetime, for the following number of years:")), 
#   choices = c("0","0.5", "1","2","3-5","6-9","10 or more"),
# )
# 
# MT_06<-NAFC_page(
#   label = "MT_06",
#   prompt = p(strong ("I can play the following number of musical instruments:")), 
#   choices = c("0", "1","2","3","4","5","6 or more"),
# )
# 
# #REVERSE ITEM 07
# MT_07<-NAFC_page(
#   label = "MT_07",
#   prompt = p(strong ("I would not consider myself a musician.")), 
#   choices = c("Completely Disagree", "Strongly Disagree", "Disagree","Neither Agree nor Disagree","Agree","Strongly Agree","Completely Agree"),
# )
# 
# # CREATE LIST OF G_MSI ITEMS TO RANDOMISE
# g_msi_training <- join(
# MT_01,
# MT_02,
# MT_03,
# MT_04,
# MT_05,
# MT_06,
# MT_07
# )

  
# COMMENTS

duplets <- dropdown_page(
  label = "duplets",
  prompt = p(strong("Have you taken this exact same test before?")),
  save_answer=TRUE,
  choices = c("Please select", "No", "Yes, once before", "Yes, twice before",	"Yes, three times before",	"Yes, four times before",	"Yes, five times before",	"Yes, six or more times before"),
  # alternative_choice = TRUE,
  # alternative_text = "I prefer not to tell you",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please let us know if you tried this exact same test before. We ask because it matters for the analyses of the data you provide. If you like, you can provide additional comments in the next and final question."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "age", value = answer, state = state)
  }  
)


comments <- text_input_page(
  label = "comments",
  one_line = FALSE,
  width = "400px",
  prompt = div(
    HTML("<br>"),
    p(strong("Optional: Is there anything else you would like to tell us?")),
    HTML("<br>"),
    p("Here, you can provide comments about your experience of participating in this study, if you think it may be useful for the researchers to know."),
    p("Please do not write any personal information such as full name, email address, phone number etc."),
    p("You are also welcome to contact us by email on cecilie@clin.au.dk")
  ),
  save_answer = T,
  button_text = "Next"
)
thanks<-final_page(div(
      HTML("<img src='img/au_logo.png'></img> <img src='img/mib_logo.png'></img>"),
               div(
            h3(strong("Thanks very much!")),
            p("We hope you enjoyed taking part in this scientific experiment."),
            p("The data you provided is very valuable to us."),
            p("If you want to, you can challenge your friends and followers to try it out too. Just click the share buttons below."),
            HTML("<br>"),
            HTML('<iframe src="https://www.facebook.com/plugins/share_button.php?href=https%3A%2F%2Fmusicinthebrain.au.dk%2Fcontact%2Fcan-you-keep-the-beat%2F&layout=button&size=large&width=78&height=28&appId" width="78" height="28" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>'),
            HTML('<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-size="large" data-text="I just participated in this online scientific experiment on musical beat perception from Center for Music in the Brain, Aarhus University. Can you keep the beat? Try it out! " data-url="https://musicinthebrain.au.dk/contact/can-you-keep-the-beat/" data-via="musicbrainAU" data-lang="en" data-show-count="false">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>'),
            p("............."),
            HTML("<br>"),
            
            p("Your data has been saved now and you can safely close the browser window.")
             )
            ))


elts <- join(
   intro,
   elt_save_results_to_disk(complete = FALSE),
   sound_check,
   poly_ratio,
   elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
   age,
   gender,
   elt_save_results_to_disk(complete = FALSE),
   demographics,
   elt_save_results_to_disk(complete = FALSE),
   # randomise_at_run_time("item_order", g_msi_training),
   music_exp,
   elt_save_results_to_disk(complete = FALSE),
   duplets,
   elt_save_results_to_disk(complete = TRUE),
   comments,
   elt_save_results_to_disk(complete = TRUE),
   thanks
)


 make_test(
     elts = elts,
     opt = test_options(title="Polyrhythms, Aarhus 2020",
                        admin_password="", # write a secret password here
                        enable_admin_panel=TRUE,
                        researcher_email="cecilie@clin.au.dk",
                        problems_info="Problems? Contact cecilie@clin.au.dk",
                        display = display_options(
                         full_screen = TRUE,
                         css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
         )))

# shiny::runApp(".")


