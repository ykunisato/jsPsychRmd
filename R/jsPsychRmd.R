#' @title Set the Rmd file and directory for jsPsych
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom rmarkdown draft
#' @param jsPsych_version If you set a specific version number of jsPsych,
#'                set_jsPsych prepare a file with that version of jsPsych.
#' @param psychophysics_version If you set version number, set_jsPsych prepare a file of jspsych-psychophysics(set FALSE in default)
#' @param folder If you set TRUE, set_jsPsych make directory that you set and put file in it(set FALSE in default)
#' @param exclude_smartphone If you set TRUE, set_jsPsych download the platform.js and set Rmd file(set FALSE in default)
#' @param pavlovia If you set TRUE, set_jsPsych set Rmd for conducting the task in Pavlova (set FALSE in default)
#' @param rc If you set name of folder of RC, set_jsPsych make directory of RC.
#' @examples # set_jsPsych("stroop")
#' @export
set_jsPsych <- function (folder = FALSE,
                         jsPsych_version = "6.3.1",
                         psychophysics_version = FALSE,
                         exclude_smartphone = FALSE,
                         pavlovia = FALSE,
                         rc = FALSE){
  tmp_wd <- getwd()
  if(rc != FALSE){
    if(rc == TRUE){
      tmp_wd <- paste0(tmp_wd,"/exercises")
    }else{
      tmp_wd <- paste0(tmp_wd,"/",rc)
    }
  }

  if(folder != FALSE){
    path = file.path(tmp_wd, folder)
    dir.create(path, showWarnings = FALSE)
  }else{
    path = tmp_wd
  }

  # make stimuli directory
  if(!dir.exists(file.path(path, "stimuli"))){
    dir.create(file.path(path, "stimuli"), showWarnings = FALSE)
    file.create(file.path(path, "stimuli/README_materials.md"), showWarnings = FALSE)
    writeLines("README about stimuli", file.path(path, "stimuli/README_materials.md"))
  }
  # make jsPsych directory
  dir_jsPsych <- paste0("jspsych-",jsPsych_version)
  path_jsPsych <- file.path(path, dir_jsPsych)
  if(!dir.exists(path_jsPsych)){
    temp <- tempfile()
    download.file(paste0("https://github.com/jspsych/jsPsych/releases/download/v",jsPsych_version,"/jspsych-",jsPsych_version,".zip"),temp)
    unzip(temp, exdir = path_jsPsych)
    unlink(temp)
  }
  # make psychophysics directory
  if(psychophysics_version != FALSE){
    if(psychophysics_version == TRUE){
      psychophysics_version <- "2.3.2"
    }
    dir_psychophysics <- paste0("jspsych-psychophysics-",psychophysics_version)
    path_psychophysics <- file.path(path, psychophysics_version)
    if(!dir.exists(path_psychophysics)){
      temp2 <- tempfile()
      download.file(paste0("https://github.com/kurokida/jspsych-psychophysics/archive/refs/tags/v",psychophysics_version,".zip"),temp2)
      unzip(temp2, exdir = path_psychophysics)
      unlink(temp2)
    }
  }
  # make RMarkdown file and directory
  if(!file.exists(file.path(path, "index.Rmd"))){
    # set Rmd template file
    path_skeleton <- system.file("rmarkdown/templates/jsPsych/skeleton/skeleton.Rmd",package = "jsPsychRmd")
    text_skeleton <- readLines(path_skeleton, warn = F)
    tmp_rmd <- file(file_name, "w")
    # あとは以下を変更してくのみ
    for (i in 1:length(text_skeleton)) {
      st <- text_skeleton[i]
      st <- str_replace(st, pattern = "output: md_document",
                        replacement = paste0("output: eln4Rmd::render_elnjp_pdf(Rmd_file = '",output_file_name,"')"))
      st <- str_replace(st, pattern = "# date_research",
                        replacement = paste0("date_research <- '",date_name, "'"))
      st <- str_replace(st, pattern = "# date_write",
                        replacement = paste0("date_write <- '",date_write, "'"))
      writeLines(st, tmp_rmd)
    }
    close(tmp_rmd)
    navigateToFile(paste0(tmp_wd,"/", file_name))

  #  if(pavlovia == TRUE){
  #    if(exclude_smartphone == TRUE){
  #      download.file('https://raw.githubusercontent.com/bestiejs/platform.js/master/platform.js', destfile = file.path(path_jsPsych,"platform.js"), method = "wget")
  #      draft(file.path(path, "index.Rmd"), template = "pavlovia_exclude_smartphone", package = "jsPsychRmd", edit = FALSE)
  #    }else{
  #      draft(file.path(path, "index.Rmd"), template = "pavlovia", package = "jsPsychRmd", edit = FALSE)
  #    }
  #  }else{
  #    if(exclude_smartphone == TRUE){
  #      download.file('https://raw.githubusercontent.com/bestiejs/platform.js/master/platform.js', destfile = file.path(path_jsPsych,"platform.js"), method = "wget")
  #      draft(file.path(path, "index.Rmd"), template = "jsPsych_exclude_smartphone", package = "jsPsychRmd", edit = FALSE)
  #    }else{
  #      draft(file.path(path, "index.Rmd"), template = "jsPsych", package = "jsPsychRmd", edit = FALSE)
  #    }
  #  }
  }
}
