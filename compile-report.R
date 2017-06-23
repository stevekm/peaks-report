#!/usr/bin/env Rscript

## USAGE: compile_RMD_report.R report.Rmd
## Requires pandoc version 1.13+
# module load pandoc/1.13.1

# ~~~~~ GET SCRIPT ARGS ~~~~~~~ #
args <- commandArgs(TRUE)
input_dir <- args[1]


#  ~~~~~ COMPILE ~~~~~ #
Rmdfile <- "peaks-report.Rmd"
rmarkdown::render(input = Rmdfile, params = list(input_dir = input_dir))
