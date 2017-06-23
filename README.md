# peaks-report
A quick R Markdown HTML report template that will make a barplot and table with the number of peaks in all `peaks.bed` files in the target dir. 

# Usage

```bash
./compile-report.R "/path/to/my_peaks_dir"
```

## Example
You can try it out on the included test data:

```bash
./compile-report.R test/
```

# Software
- R version 3.3.0+
  - `ggplot2`
  - `DT`
  - `scales`
- pandoc 1.13+
