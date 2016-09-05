MarkDoc Example
===============

-   SOC 5050: Quantitative Analysis
-   Christopher Prener, PhD
-   05 Sep 2016

### Structuring the do-file

There are a total of three commands that must be included in every
do-file that executes MarkDoc code. They will not appear in your output
file but must be included in the do-file as they are in
`week-03-markdoc.do`. See the `week-03-markdocQuickRef.pdf` file for
details on those commands.

### Suppressing output

You can suppress output by using `//OFF` and `//ON` commands. In this
example, the command for opening the data is suppressed from the
output.

### Writing basic text

You can write basic text by wrapping it in the special MarkDoc comment
syntax: `/***` and `***/`. All of the text included in the output file
for this example is wrapped in those comment syntax symbols.

The `auto.dta` dataset contains the following variables:

```stata
          .  describe

          Contains data from /Applications/Stata/ado/base/a/auto.dta
            obs:            74                          1978 Automobile Data
           vars:            12                          13 Apr 2014 17:45
           size:         3,182                          (_dta has notes)
          ------------------------------------------------------------------------------------------
                        storage   display    value
          variable name   type    format     label      variable label
          ------------------------------------------------------------------------------------------
          make            str18   %-18s                 Make and Model
          price           int     %8.0gc                Price
          mpg             int     %8.0g                 Mileage (mpg)
          rep78           int     %8.0g                 Repair Record 1978
          headroom        float   %6.1f                 Headroom (in.)
          trunk           int     %8.0g                 Trunk space (cu. ft.)
          weight          int     %8.0gc                Weight (lbs.)
          length          int     %8.0g                 Length (in.)
          turn            int     %8.0g                 Turn Circle (ft.)
          displacement    int     %8.0g                 Displacement (cu. in.)
          gear_ratio      float   %6.2f                 Gear Ratio
          foreign         byte    %8.0g      origin     Car type
          ------------------------------------------------------------------------------------------
          Sorted by: foreign
```

### Cleaning Up

MarkDoc does not parse text perfectly, and sometimes introduces spaces
into words. For ex ample, "those" may become "those". Make sure to
carefully scan your file for typos before submitting it.

MarkDoc also has way of identifying code that differs slightly from
standard Markdown. Fo r code examples that appear as blocks (such as the
`describe` command above), you will w ant to wrap them with three
backticks before and after the code block. To fix the indentation,
highlight the entire code block and then use the keyboard shortcut
Shift+Tab to realign the text.

MarkDoc will also occasionally leave the `quietly log` command in the
bottom of the output. Make sure to delete this from your output before
submitting it.
