#!/usr/bin/env Rscript

# ~~~~~ PACKAGES ~~~~~ # 
library("tools")


# ~~~~~ FUNCTIONS ~~~~~ # 
msprintf <- function(fmt, ...) {
    message(sprintf(fmt, ...))
}

mycat <- function(text){
    # print formatted text in Rmd
    cat(gsub(pattern = "\n", replacement = "  \n", x = text))
}

remove_ext <- function(input_file){
    # remove extension from filename
    old_ext <- file_ext(input_file)
    filename_base <- gsub(pattern = sprintf('.%s$', old_ext), replacement = '', x = basename(input_file))
    return(filename_base)
}

sort_bed_df <- function(df){
    # sort a bed df and remove duplicate entries
    df <- df[1:3]
    df <- df[ order(df[,1], df[,2]), ]
    df <- df[! duplicated(df), ]
    return(df)
}

make_filename <- function (input_file, new_ext, out_dir = FALSE) {
    # Convert '/path/to/file.bed' to '/path/to/file_annotations.tsv'
    old_ext <- file_ext(input_file)
    filename_base <- gsub(pattern = sprintf('.%s$', old_ext), replacement = '', x = basename(input_file))
    filename_new <- sprintf('%s.%s', filename_base, new_ext)
    new_path <- file.path(dirname(input_file), filename_new)
    if(out_dir != FALSE){
        new_path <- file.path(out_dir, new_path)
        dir.create(path = dirname(new_path), recursive = TRUE, showWarnings = FALSE)
    }
    return(new_path)
}

check_numlines <- function(input_file, min_value = 0) {
    # make sure a file has >0 lines
    has_enough_lines <- FALSE
    if (length(readLines(input_file)) > min_value) has_enough_lines <- TRUE
    return(has_enough_lines)
}


validate_file <- function(input_file) {
    # make sure that all files are .bed, and that they have >0 lines
    # validation passes if all files are .bed
    all_exist <- all(file.exists(input_file))
    if ( ! isTRUE(all_exist)) {
        msprintf("WARNING: Input file do not exist:\n%s\nFile will not be processed\n\n", input_file)
        return(FALSE)
    }
    all_bed <- all(grepl(pattern = '*.bed$', x = basename(input_file)))
    if ( ! isTRUE(all_bed)) {
        msprintf("WARNING: Input file is not .bed:\n%s\nFile will not be processed\n\n", input_file)
        return(FALSE)
    }
    all_min_linenum <- all(sapply(input_file, check_numlines))
    if ( ! isTRUE(all_min_linenum)) {
        msprintf("WARNING: Input file does not have enough lines:\n%s\nFile will not be processed\n\n", input_file)
        return(FALSE)
    }
    return(TRUE)
}



find_all_beds <- function (input_dirs) {
    # find all .bed files in the supplied dirs
    return(dir(input_dirs, pattern = '.bed', full.names = TRUE, recursive = TRUE))
}


get_sampleID <- function(input_file, id_dirname = FALSE){
    # get the sample ID for a file
    # right now just use the basename but maybe some day do something fancier here
    sampleID <- basename(input_file)
    if(isTRUE(id_dirname)) sampleID <- basename(dirname(input_file))
    return(sampleID)
}

get_sample_outdir <- function(parent_outdir, sampleID, create = TRUE){
    # make a path for the sample's output directory
    output_path <- file.path(parent_outdir, sampleID)
    if(isTRUE(create)) dir.create(output_path, recursive = TRUE)
    return(output_path)
}



