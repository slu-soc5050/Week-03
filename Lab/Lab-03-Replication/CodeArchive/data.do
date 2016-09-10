// ==========================================================================

// Lab-03 Replication - Data

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - data.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Replicates data manipulation steps for Lab-03

created - 10 Sep 2016

updated - 10 Sep 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file replicates the questions from Part 3 of Lab-03 that involve
manipulating the CPS data.
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

// open data
use "$projName/$newData"

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 10a. recode missing data in HETENURE

tabulate HETENURE // view data
tabulate HETENURE, nolabel // view value for BLANK, which is -1

recode HETENURE -1=.

// ==========================================================================

// 10b. recode missing data in HUBUS

tabulate HUBUS // view data
tabulate HUBUS, nolabel // view value for BLANK, which is -1

recode HUBUS -1=.a -2=.b -3=.c 2=0
/* note that I also recoded HUBUS so that it becomes a properly formatted
binary variable. */

label define hubusNew 0 no 1 yes .a blank .b "don't know" .c refused
label values HUBUS hubusNew

// ==========================================================================

// 10c. recode values for HRNUMHOU to ordinal

tabulate HRNUMHOU // view data

generate houseSize = HRNUMHOU
recode houseSize 0=0 1/5=1 6/10=2 11/16=3
label define houseSize 0 none 1 "1-5" 2 "6-10" 3 ">10"
label values houseSize houseSize
label variable houseSize "Recode: Number of Household Members"

// ==========================================================================

// 10d. recode values for houseSize to binary

generate bigHouse = houseSize
recode bigHouse 0/1 = 0 2/3=1
label define bigHouse 0 no 1 yes
label values bigHouse bigHouse
label variable bigHouse "Recode: Large Household (>5 people)"

// ==========================================================================
// ==========================================================================
// ==========================================================================

// save altered data
save "$projName/$newData", replace

// ==========================================================================

// exit
