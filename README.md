# peaks-report
A quick R Markdown HTML report template that will make a barplot and table with the number of peaks in all `peaks.bed` files in the target dir. 

# Usage

```bash
./compile-report.R "/path/to/my_peaks_dir"
```

## Options
- `-n`: Name of report file to output (e.g. `-n foo` outputs `foo.Rmd` and `foo.html`)
- `--height`: Height of the boxplot
- `--width`: Width of the boxplot

__NOTE:__ Large figures may not be displayed at full size when viewing the HTML, try right-clicking and selecting View Image.

## Example 
You can try it out on the included test data:

```bash
./compile-report.R test/
```
Output the report file as `test-report.html` with a 8x8 boxplot
```bash
./compile-report.R -n "test-report" --height 8 --width 8 test
```



# Software
- R version 3.3.0+
  - `ggplot2`
  - `DT`
  - `scales`
  - `optparse`
  - `tools`
- pandoc 1.13+
