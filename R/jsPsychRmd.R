#' Set the Rmd file and directory for jsPsych
#'
#' @param pavlovia If you set TRUE, set_jsPsych set Rmd for conducting the task in Pavlova (set FALSE in default)
#' @param folder If you set TRUE, set_jsPsych make directory that you set and put file in it(set FALSE in default)
#' @param exclude_smartphone If you set TRUE, set_jsPsych download the platform.js and set Rmd file(set FALSE in default)
#' @return Make directories for Research Compendium of CCP Lab and
#' R Markdown file for thesis at Department of Psychology, Senshu University
#' @examples # set_jsPsych("stroop")
#' @export

set_jsPsych <- function (pavlovia = FALSE, folder = FALSE, exclude_smartphone = FALSE){
  if(folder != FALSE){
    path = file.path(getwd(), folder)
    dir.create(path, showWarnings = FALSE)
  }else{
    path = getwd()
  }
  # make stimuli directory
  if(!dir.exists(file.path(path, "stimuli"))){
    dir.create(file.path(path, "stimuli"), showWarnings = FALSE)
    file.create(file.path(path, "stimuli/README_materials.md"), showWarnings = FALSE)
    writeLines("README about stimuli", file.path(path, "stimuli/README_materials.md"))
  }
  # make jsPsych directory
  dir_jsPsych <- "jspsych-6.1.0"
  path_jsPsych <- file.path(path, dir_jsPsych)
  if(!dir.exists(path_jsPsych)){
    temp <- tempfile()
    download.file("https://github.com/jspsych/jsPsych/releases/download/v6.1.0/jspsych-6.1.0.zip",temp)
    dir.create(path_jsPsych, showWarnings = FALSE)
    unzip(temp, exdir = path_jsPsych)
    unlink(temp)
  }
  # make RMarkdown file and directory
  if(!file.exists(file.path(path, "index.Rmd"))){
    if(pavlovia == TRUE){
      if(exclude_smartphone == TRUE){
        download.file('https://raw.githubusercontent.com/bestiejs/platform.js/master/platform.js', destfile = file.path(path_jsPsych,"platform.js"), method = "wget")
        rmarkdown::draft(file.path(path, "index.Rmd"), template = "pavlovia_exclude_smartphone", package = "jsPsychRmd", edit = FALSE)
      }else{
        rmarkdown::draft(file.path(path, "index.Rmd"), template = "pavlovia", package = "jsPsychRmd", edit = FALSE)
      }
    }else{
      if(exclude_smartphone == TRUE){
        download.file('https://raw.githubusercontent.com/bestiejs/platform.js/master/platform.js', destfile = file.path(path_jsPsych,"platform.js"), method = "wget")
        rmarkdown::draft(file.path(path, "index.Rmd"), template = "jsPsych_exclude_smartphone", package = "jsPsychRmd", edit = FALSE)
      }else{
        rmarkdown::draft(file.path(path, "index.Rmd"), template = "jsPsych", package = "jsPsychRmd", edit = FALSE)
      }
    }
  }
}
