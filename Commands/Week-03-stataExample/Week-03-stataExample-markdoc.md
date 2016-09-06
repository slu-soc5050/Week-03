# Week-03-Example

-   SOC 5050: Quantitative Analysis
-   05 Sep 2016
-   Chris

### MarkDoc

This do-file contains code for MarkDoc - a user written package that
helps implement lite rate programming within Stata. By design, you
should not need to edit any of the MarkDoc commands - they are built to
be flexible and responsive to the choices you make when writing the
`master.do` file. The only command you *may* see on output is the
command to end the MarkDoc log (look down below). Make sure to delete
this before submitting your assignment.

### Analyzing Missing Data

In `data.do`, missing data were cleaned for a number of variables:
`mpg`, `trunk`, and `t urn`. Missing data were also present in `rep78`,
but did not need any additional cleaning. Missing data can be
visualized using the `tabulate` command.

1.  The variable `mpg` has missing data. There are a total of n=6 values
    that are missing from the variable, or about 8.11% of
    the observations. This is a large proportion of the observations and
    presents a threat to generalizability.

```stata
.  tabulate mpg, missing

     Mileage |
       (mpg) |      Freq.     Percent        Cum.
-------------+-----------------------------------
          12 |          2        2.70        2.70
          14 |          6        8.11       10.81
          15 |          2        2.70       13.51
          17 |          4        5.41       18.92
          18 |          9       12.16       31.08
          19 |          8       10.81       41.89
          20 |          3        4.05       45.95
          21 |          5        6.76       52.70
          22 |          5        6.76       59.46
          23 |          3        4.05       63.51
          24 |          4        5.41       68.92
          25 |          5        6.76       75.68
          26 |          3        4.05       79.73
          28 |          3        4.05       83.78
          29 |          1        1.35       85.14
          31 |          1        1.35       86.49
          34 |          1        1.35       87.84
          35 |          2        2.70       90.54
          41 |          1        1.35       91.89
           . |          6        8.11      100.00
-------------+-----------------------------------
       Total |         74      100.00
```

2.  It can get tedious to export a large number of frequency tables. It
    is much simpler to use the `misstable` command to summarize the
    amount of missing data in your dataset. O f the four variables that
    have missing data, the only variable that does not have a potentially
    problematic quantity of missing data is the variable `turn`
    (missing n=3 (4.05%) observations). The other three variables
    (`mpg`, `rep78`, and `trunk`) all have greater than 5.00% of
    missing data.

```stata
.  misstable summarize mpg rep78 trunk turn
                                                               Obs<.
                                                +------------------------------
               |                                | Unique
      Variable |     Obs=.     Obs>.     Obs<.  | values        Min         Max
  -------------+--------------------------------+------------------------------
           mpg |         6                  68  |     19         12          41
         rep78 |         5                  69  |      5          1           5
         trunk |         4                  70  |     17          5          23
          turn |         3                  71  |     17         31          51
  -----------------------------------------------------------------------------
```

3.  An additional concern with missing data is whether or not they are
    missing completely at random (MCAR). The table below suggests (but
    does not prove) that observed data in the dataset do not predict
    missingness - there appears to be no pattern where data in one
    variable predicts missingness in another.

```stata
.  misstable tree mpg rep78 trunk turn, frequency

  Nested pattern of missing values
         mpg      rep78      trunk       turn
  -------------------------------------------
           6          0          0          0
                                            0
                                 0          0
                                            0
                      6          0          0
                                            0
                                 6          0
                                            6
          68          5          0          0
                                            0
                                 5          2
                                            3
                     63          4          0
                                            4
                                59          1
                                           58
  -------------------------------------------
 (number missing listed first)
```

4.  The above table suggests a different issue, however. The bottom
    number, 58, refers to the total number of observations that are not
    missing any data. 58/74 = .7838 or 78.38%. Nearly 22% of the
    observations have missing data in them, which falls well below the
    th reshold of 5%.

### Reviewing New Variables

After cleaning missing data, I created a number of new variables
`data.do`.

5.  One of those variables is `mpgOrd`, an ordinal version of the
    original `mpg` variable. To illustrate how to embed images in your
    documents, I'll include both the source code and the proper Markdown
    formatted html link.

```stata
.  tabulate mpgOrd

    ordinal |
 version of |
        mpg |      Freq.     Percent        Cum.
------------+-----------------------------------
       < 20 |         31       45.59       45.59
   20 to 29 |         32       47.06       92.65
   30 to 39 |          4        5.88       98.53
      >= 40 |          1        1.47      100.00
------------+-----------------------------------
      Total |         68      100.00

.  graph bar (count), over(mpgOrd) scheme(s2mono) ///
   title("Fig 1. - Fuel Efficiency in Miles per Gallon") ///
   subtitle("1978 Vehicles") ///
   note("Produced by Christopher Prener, PhD; Modified Stata data")



.  graph export "$projName/Plots/fig1.png", as(png) width(800) height(600) replace
(file Week-03-stataExample/Plots/fig1.png written in PNG format)
```
![fig1](https://raw.githubusercontent.com/slu-soc5050/Week-03/master/Commands/Week-03-stataExample/Plots/fig1.png)

### Additional Notes
After I created this file in Stata, I opened it in Atom and edited it. There were a couple typos, and I fixed the block code exports so that they conform to Markdown standards (using the triple backticks to wrap the code blocks). Finally, I deleted the MarkDoc command that was attached to the end of the file in error.
