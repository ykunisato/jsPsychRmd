#' Set the Rmd file and directory for jsPsych
#'
#' @param dir_name directory name of jsPsych task
#' @param pavlovia If you set TRUE, set_jsPsych set Rmd for conducting the task in Pavlova.
#' @return Make directories for Research Compendium of CCP Lab and
#' R Markdown file for thesis at Department of Psychology, Senshu University
#' @examples # set_jsPsych("stroop")
#' @export

set_jsPsych <- function (file_name = "task", pavlovia = FALSE){
  path = getwd()
  # make stimuli directory
  if(!dir.exists(file.path(path, "stimuli"))){
    dir.create(file.path(path, "stimuli"), showWarnings = FALSE)
  }
  # make jsPsych directory
  dir_jsPsych <- "jspsych-6.1.0"
  if(!dir.exists(file.path(path,dir_jsPsych))){
    temp <- tempfile()
    download.file("https://github.com/jspsych/jsPsych/releases/download/v6.1.0/jspsych-6.1.0.zip",temp)
    dir.create(dir_jsPsych)
    unzip(temp, exdir = dir_jsPsych)
    unlink(temp)
  }
  # make RMarkdown file and directory
  if(!file.exists(file.path(path, paste0(file_name,".Rmd")))){
    if(pavlovia == TRUE){
      rmarkdown::draft(paste0(file_name,".Rmd"), template = "pavlovia", package = "jsPsychRmd", edit = FALSE)
    }else{
      rmarkdown::draft(paste0(file_name,".Rmd"), template = "jsPsych", package = "jsPsychRmd", edit = FALSE)
    }
  }
}
