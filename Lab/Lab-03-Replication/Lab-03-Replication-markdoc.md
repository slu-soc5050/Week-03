Lab-03-Replication
==========

-   SOC 5050: Quantitative Analysis
-   10 Sep 2016
-   CHRIS

### Part 4 Questions

11a. Missing data analysis of `HETENURE` and `HUBUS`

There is a large amount of missing data in both variables (you can see
this with the `mis stable summarize` command). For `HETENURE`, 9.82% of
the values are missing. For `HUBUS`, 12 .50% of values are missing. Both
variables are therefore over the threshold of 5.00% dis cussed in class.
The two tree tables below (presented both with percentages and with raw
values) illustrate that are large number of the values missing in `HUBUS`
are also missing in `HETENURE` (about 78.50% of `HETENURE` values are also
missing data in `HUBUS`). This suggests a pattern of data that are
Missing at Random (MAR) because there is so much shared missingness.
Further investigation would be needed to determine the extent to which
the y are MAR or Not Missing at Random.

```stata
  .  misstable summarize HETENURE HUBUS
                                                                 Obs<.
                                                  +------------------------------
                 |                                | Unique
        Variable |     Obs=.     Obs>.     Obs<.  | values        Min         Max
    -------------+--------------------------------+------------------------------
        HETENURE |    14,852             136,456  |      3          1           3
           HUBUS |              18,921   132,387  |      2          0           1
    -----------------------------------------------------------------------------

  .  misstable tree HETENURE HUBUS

    Nested pattern of missing values
         HUBUS   HETENURE
    ---------------------
            13%        10%
                        3
            87          0
                       87
    ---------------------
   (percent missing listed first)

  .  misstable tree HETENURE HUBUS, frequency

    Nested pattern of missing values
         HUBUS   HETENURE
    ---------------------
        18,921     14,852
                    4,069
       132,387          0
                  132,387
    ---------------------
   (number missing listed first)
```

11b-1. Descriptive statistics for `houseSize`

This is the ordinal measure created from `HRNUMHOU`. Since it is an
ordinal measure, mean, median, and mode are all appropriate statistics,
though mean must be interpreted with the understanding that it reflects
the underlying coding scheme. The modal category is 1, which
corresponds to having between 1 and 5 household members. The median
category is also 1 and the average for the variable (0.993) falls just
under 1. All of these statistics suggest that the normative household
configuration in the dataset is between 1 and 5 individuals.

```stata
  .  tabulate houseSize, sort

      Recode: |
    Number of |
    Household |
      Members |      Freq.     Percent        Cum.
  ------------+-----------------------------------
          1-5 |    123,961       81.93       81.93
         none |     14,332        9.47       91.40
         6-10 |     12,690        8.39       99.79
          >10 |        325        0.21      100.00
  ------------+-----------------------------------
        Total |    151,308      100.00

  . summarize houseSize, detail

               Recode: Number of Household Members
  -------------------------------------------------------------
        Percentiles      Smallest
   1%            0              0
   5%            0              0
  10%            1              0       Obs             151,308
  25%            1              0       Sum of Wgt.     151,308

  50%            1                      Mean           .9934438
                          Largest       Std. Dev.      .4325961
  75%            1              3
  90%            1              3       Variance       .1871394
  95%            2              3       Skewness       .1236794
  99%            2              3       Kurtosis       6.086994
```

11b-2. Descriptive statistics for bigHouse

This is the binary measure created from `HRNUMHOU`. Since it is a binary
measure, both mode and mean are appropriate statistics. The modal
category is 0, which corresponds to having a small household. The mean
is 0.086, which means that 8.6% of households are considered large
(>5 individuals). Once again, all of these statistics suggest that
the normative household configuration in the dataset is between 1 and 5
individuals.

```stata
  .  tabulate bigHouse, sort

      Recode: |
        Large |
    Household |
  (>5 people) |      Freq.     Percent        Cum.
  ------------+-----------------------------------
           no |    138,293       91.40       91.40
          yes |     13,015        8.60      100.00
  ------------+-----------------------------------
        Total |    151,308      100.00

  . summarize bigHouse

      Variable |        Obs        Mean    Std. Dev.       Min        Max
  -------------+---------------------------------------------------------
      bigHouse |    151,308    .0860166    .2803895          0          1
```

11c-1. Plot for `houseSize`

Since `houseSize` is an ordinal measure, a bar chart is the most
appropriate plot. This illustrates the modal category of 1 clearly.

```stata
  .  graph bar (count), over(houseSize) ///
     title("Ordinal Measure of Household Size") ///
     subtitle("Recoded from HRNUMHOU") ///
     scheme(s2mono) ///
     note("Produced by Christopher Prener, PhD; Data via 2011 CPS")

  .  graph export "$projName/Plots/fig1.png", replace width(800) height(600) as(png)
  (file Lab-03-Replication/Plots/fig1.png written in PNG format)
```

![fig1]()

11c-2. Plot for `bigHouse`

Since `bigHouse` is an binary measure, a bar
chart is the most appropriate plot. This illustrates the modal category
of 0 clearly.

```stata
  .  graph bar (count), over(bigHouse) ///
     title("Binary Measure of Household Size") ///
     subtitle("Recoded from HRNUMHOU") ///
     scheme(s2mono) ///
     note("Produced by Christopher Prener, PhD; Data via 2011 CPS")

  .  graph export "$projName/Plots/fig2.png", replace width(800) height(600) as(png)
  (file Lab-03-Replication/Plots/fig2.png written in PNG format)
```

![fig2]()

### Post-Export from Stata Work
After exporting from Stata, I opened this file in Atom. I fixed the header, which did not have a title passed to it from Stata. I added in backticks for variable names (which I did not include in the do-files, they were generating error r(132) and I decided that it was faster to use Find and Replace in Atom to add them). I also added in the triple backtick symbols for codeblocks. Finally, I fixed a couple of small typos and removed errant spaces introduced by MarkDoc. 
