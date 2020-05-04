#' Set the Rmd file and directory for jsPsych
#'
#' @param dir_name directory name of jsPsych task (set "task" in default)
#' @param folder If you set TRUE, set_jsPsych make directory and put file in it(set TRUE in default)
#' @param pavlovia If you set TRUE, set_jsPsych set Rmd for conducting the task in Pavlova (set FALSE in default)
#' @return Make directories for Research Compendium of CCP Lab and
#' R Markdown file for thesis at Department of Psychology, Senshu University
#' @examples # set_jsPsych("stroop")
#' @export

set_jsPsych <- function (file_name = "task", folder = TRUE, pavlovia = FALSE){
  if(folder == TRUE){
    path = file.path(getwd(), file_name)
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
  # add jspsych-fullscreen_jp.js
  file.copy(
    from = system.file("extdata", "jspsych-fullscreen_jp.js", package = "jsPsychRmd"),
    to = file.path(path_jsPsych, "plugins")
  )
  # make RMarkdown file and directory
  if(!file.exists(file.path(path, "index.Rmd"))){
    if(pavlovia == TRUE){
      rmarkdown::draft(file.path(path, "index.Rmd"), template = "pavlovia", package = "jsPsychRmd", edit = FALSE)
    }else{
      rmarkdown::draft(file.path(path, "index.Rmd"), template = "jsPsych", package = "jsPsychRmd", edit = FALSE)
    }
  }
}
