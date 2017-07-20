#!/usr/bin/env Rscript

## USAGE: compile_RMD_report.R report.Rmd
## Requires pandoc version 1.13+
# module load pandoc/1.13.1

message("
        Remember to have pandoc/1.13.1+ loaded!
        module load pandoc/1.13.1
        ")

# ~~~~~ PACKAGES ~~~~~ # 
library("optparse")
library("tools")

# ~~~~~ GET SCRIPT ARGS ~~~~~~~ #
option_list <- list(
    make_option(c("-n", "--name"), type="character", default=FALSE,
                dest="report_name", help="A different output name to use for the report file (excluding file extension)"),
    make_option(c("--height"), type="numeric", default=12,
                dest = "plot_height", help="Height for boxplot [default %default]",
                metavar="plot_height"),
    make_option(c("--width"), type="numeric", default=10,
                dest = "plot_width", help="Width for boxplot [default %default]",
                metavar="plot_width")
)

opt <- parse_args(OptionParser(option_list=option_list), positional_arguments = TRUE)

report_name <- opt$options$report_name 
plot_height <- opt$options$plot_height
plot_width <- opt$options$plot_width

input_dir <- opt$args[1] # input directory

# report template file
Rmdfile <- "peaks-report.Rmd"

#  ~~~~~ COMPILE ~~~~~ #
if(report_name != FALSE){
    old_ext <- file_ext(Rmdfile)
    new_Rmdfile <- sprintf('%s.%s', report_name, old_ext)
    file.copy(from = Rmdfile, to = new_Rmdfile, overwrite = TRUE)
    Rmdfile <- new_Rmdfile
}
rmarkdown::render(input = Rmdfile, params = list(input_dir = input_dir, 
                                                 plot_height = plot_height, 
                                                 plot_width = plot_width))
