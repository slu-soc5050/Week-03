// ==========================================================================

// Lab-03 Replication - Analysis

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - analysis.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Replicates the analysis portion of Lab-03

created - 10 Sep 2016

updated - 10 Sep 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file conducts analyses on the variables created by the data.do file
and produces a Markdown output file.
*/

/*
updates -
none
*/

// ==========================================================================

/*
superordinates  -
- lab-03.dta
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
  - 10 Sep 2016
  - CHRIS

### Part 4 Questions

  11a. Missing data analysis of HETENURE and HUBUS

  There is a large amount of missing data in both variables (you can see this with the `misstable summarize` command). For HETENURE, 9.82% of the values are missing. For HUBUS, 12.50% of values are missing. Both variables are therefore over the threshold of 5.00% discussed in class. The two tree tables below (presented both with percentages and with raw values) illustrate that are large number of the values missing in HUBUS are also missing in HETENURE (about 78.50% of HETENURE values are also missing data in HUBUS). This suggests a pattern of data that are Missing at Random (MAR) because there is so much shared missingness. Further investigation would be needed to determine the extent to which they are MAR or Not Missing at Random.
***/

misstable summarize HETENURE HUBUS

misstable tree HETENURE HUBUS

misstable tree HETENURE HUBUS, frequency

/***
  11b-1. Descriptive statistics for houseSize

  This is the ordinal measure created from HRNUMHOU. Since it is an ordinal measure, mean, median, and mode are all appropriate statistics, though mean must be interpretd with the understanding that it reflects the underlying coding scheme. The modal category is 1, which corresponds to having between 1 and 5 household members. The median category is also 1 and the average for the variable (0.993) falls just under 1. All of these statistics suggest that the normative household configuration in the dataset is between 1 and 5 individuals.
***/

tabulate houseSize, sort
summarize houseSize, detail

/***
  11b-2. Descriptive statistics for bigHouse

  This is the binary measure created from HRNUMHOU. Since it is a binary measure, both mode and mean are appropriate statistics. The modal category is 0, which corresponds to having a small household. The mean is 0.086, which means that 8.6% of households are considered large (>5 individuals). Once again, all of these statistics suggest that the normative household configuration in the dataset is between 1 and 5 individuals.
***/

tabulate bigHouse, sort
summarize bigHouse

/***
  11c-1. Plot for houseSize

  Since houseSize is an ordinal measure, a bar chart is the most appropriate plot. This illustrates the modal category of 1 clearly.
***/

graph bar (count), over(houseSize) ///
  title("Ordinal Measure of Household Size") ///
  subtitle("Recoded from HRNUMHOU") ///
  scheme(s2mono) ///
  note("Produced by Christopher Prener, PhD; Data via 2011 CPS")

graph export "$projName/Plots/fig1.png", replace width(800) height(600) as(png)

/***
![fig1]()

  11c-2. Plot for bigHouse
  Since bigHouse is an binary measure, a bar chart is the most appropriate plot. This illustrates the modal category of 0 clearly.
***/

graph bar (count), over(bigHouse) ///
  title("Binary Measure of Household Size") ///
  subtitle("Recoded from HRNUMHOU") ///
  scheme(s2mono) ///
  note("Produced by Christopher Prener, PhD; Data via 2011 CPS")

graph export "$projName/Plots/fig2.png", replace width(800) height(600) as(png)

/***
![fig2]()
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
