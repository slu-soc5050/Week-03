// ==========================================================================

// Analysis Example for Week-03

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - analysis.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Illustrates analysis commands for Week-03

created - 05 Sep 2016

updated - 05 Sep 2016

author - Chris
*/

// ==========================================================================

/*
full description -
This do-file illustrates the MarkDoc, misstable, and tabulate commands
included in this week's lecture. Graphs and tables of new variables
using commands from weeks 01 and 02 are also included.
*/

/*
updates -
none
*/

// ==========================================================================

/*
superordinates  -
- autoMissingClean.dta
- master.do
*/

/*
subordinates -
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// start MarkDoc log
quietly log using "$projName/$projName-markdoc.smcl", ///
  replace smcl name(markdoc)

// OFF
// ==========================================================================
// ON

/***
# $projName
  - SOC 5050: Quantitative Analysis
  - 05 Sep 2016
  - Chris

### MarkDoc
This do-file contains code for MarkDoc - a user written package that helps implement literate programming within Stata. By design, you should not need to edit any of the MarkDoc commands - they are built to be flexible and responsive to the choices you make when writing the `master.do` file. The only command you *may* see on output is the command to end the MarkDoc log (look down below). Make sure to delete this before submitting your assignment.

### Analyzing Missing Data
In `data.do`, missing data were cleaned for a number of variables: `mpg`, `trunk`, and `turn`. Missing data were also present in `rep78`, but did not need any additional cleaning. Missing data can be visualized using the `tabulate` command.

  1. The variable `mpg` has missing data. There are a total of n=6 values that are missing from the variable, or about 8.11% of the observations. This is a large proportion of the observations and presents a threat to generalizability.
***/

tabulate mpg, missing

/***
  2. It can get tedious to export a large number of frequency tables. It is much simplier to use the `misstable` command to summarize the amount of missing data in your dataset. Of the four variables that have missing data, the only variable that does not have a potentially problematic quanity of missing data is the variable `turn` (missing n=3 (4.05%) observations). The other three variables (`mpg`, `rep78`, and `trunk`) all have greater than 5.00% of missing data.

***/

misstable summarize mpg rep78 trunk turn

/***
  3. An additional concern with missing data is whether or not they are missing completely at random (MCAR). The table below suggests (but does not prove) that observed data in the dataset do not predict missingness - there appears to be no pattern where data in one variable predicts missingness in another.
***/

misstable tree mpg rep78 trunk turn, frequency

/***
  4. The above table suggests a different issue, however. The bottom number, 58, refers to the total number of observations that are not missing any data. 58/74 = .7838 or 78.38%. Nearly 22% of the observations have missing data in them, which falls well below the threshold of 5%.

### Reviewing New Variables
After cleaning missing data, I created a number of new variables `data.do`.

  5. One of those variables is `mpgOrd`, an ordinal version of the original `mpg` variable. To illustrate how to embed images in your documents, I'll include both the source code and the proper Markdown formatted html link.
***/

tabulate mpgOrd

graph bar (count), over(mpgOrd) scheme(s2mono) ///
  title("Fig 1. - Fuel Efficiency in Miles per Gallon") ///
  subtitle("1978 Vehicles") ///
  note("Produced by Christopher Prener, PhD; Modified Stata data")
  
graph export "$projName/Plots/fig1.png", as(png) width(800) height(600) replace

/***
![fig1]()
***/

// OFF
// ==========================================================================

// end MarkDoc log
quietly log close markdoc

// convert MarkDoc log to Markdown
markdoc "$projName/$projName-markdoc", ///
	replace export(md) install

// ==========================================================================
// ==========================================================================
// ==========================================================================

// exit
