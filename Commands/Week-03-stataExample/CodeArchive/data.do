// ==========================================================================

// Data Cleaning for Week-03 Example

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - data.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Cleans autoMissingClean.dta data

created - 05 Sep 2016

updated - 05 Sep 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file takes the original data from autoMissingClean.dta and cleans it
for later analysis.
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

// open data
use "$projName/$newData"

// ==========================================================================

// 1. Properly recode missing data

// 1a. mpg and rep78

/* There is a wide range of missing data. Some of it (mpg and rep78) is
properly recoded already, which is illustrated below.*/

// missing data in mpg
tabulate mpg, missing

tabulate mpg, nolabel missing // to see .a and .b values

/* We do not need to know why values are missing, only that they are infact
missing data and not valid. Therefore, we can recode mpg to simplify the
missing data values. */
recode mpg (.a/.b = .)

// missing data in rep78
tabulate rep78, missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 1b. trunk
// The variable trunk has a number of -1 values that indicate missing data.
tabulate trunk

/* These values are not declared as missing in Stata's language, however,
so we need to recode them */
recode trunk (-1 = .)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 1c. turn
// The variable turn has a number of 999 values that indicate missing data.
tabulate turn

/* These values are not declared as missing in Stata's language, however,
so we need to recode them */
recode turn (999 = .)

// ==========================================================================

// 2. Recode mpg in various ways

// 2a. Recode mpg to an ordinal variable using workflow:
generate mpgOrd = mpg
recode mpgOrd (12/19 = 1) (20/29 = 2) (30/35 = 3) (41 = 4)
label define mpgOrdVals 1 "< 20" 2 "20 to 29" 3 "30 to 39" 4 ">= 40"
label values mpgOrd mpgOrdVals
label variable mpgOrd "ordinal version of mpg"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2b. Recode mpg from continuous to binary variable using workflow:
generate mpgHigh = mpg
recode mpgHigh (12/29 = 0) (30/41 = 1)
label define mpgHighVal 0 low 1 high
label values mpgHigh mpgHighVal
label variable mpgHigh "high mpg (>29)"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2c. Recoode mpg from ordinal to binary variable using workflow:
generate mpgBin = mpgOrd
recode mpgBin (1/3 = 0) (4 = 1)
label define yesNo 0 no 1 yes
label values mpgBin yesNo
label variable mpgBin "mpg > 40"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2d. Reorder mpg variables
order mpgOrd mpgHigh mpgBin, after(mpg)

// ==========================================================================
// ==========================================================================
// ==========================================================================

// save altered data
save "$projName/$newData", replace

// ==========================================================================

// exit
