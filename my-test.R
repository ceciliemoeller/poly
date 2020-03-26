library(htmltools)
library(psychTestR)

jspsych_dir <- "C:/Users/au213911/Documents/poly_online/jspsych-6.1.0"

head <- tags$head(
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")),
  includeScript(file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")),
)

ui <- tags$div(
  head, 
  includeScript("new-timeline.js"),
  includeScript("run-jspsych.js"),
  # includeScript("record-timing.js"),
  tags$div(id = "js_psych")
)

hello_world <- page(
  ui = ui,
  label = "hello_world",
  get_answer = function(input, ...) input$jspsych_results,
  validate = function(answer, ...) nchar(answer) > 0L,
  save_answer = TRUE
)

elts <- list(
  one_button_page("HEJ THOR"),
  one_button_page("Når der står 'TRYK NU', skal du trykke på mellemrumstasten."),
  hello_world,
  elt_save_results_to_disk(complete = TRUE),
  final_page("GODT KLARET! DU ER EN STJERNE!!")
)

test <- make_test(
  elts = elts,
  opt = demo_options(
    display = display_options(
      full_screen = TRUE, 
      css = file.path(jspsych_dir, "css/jspsych.css"))
  ))

shiny::runApp(test)
