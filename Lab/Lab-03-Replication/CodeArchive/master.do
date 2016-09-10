// ==========================================================================

// Lab-03 Replication

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// confirm necessary packages present

which markdoc

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:/Users/`c(username)'/Desktop"
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if source data exists

global sourceData "34434-0001-Data.dta"
capture confirm file "$sourceData"

if _rc==601 {
  display in red "This do-file requires that the source dataset be saved in your working folder."
  exit
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if appropriate directories exist

global projName "Lab-03-Replication"
capture mkdir $projName

capture mkdir "$projName/CodeArchive"
capture mkdir "$projName/Plots"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using "$projName/$projName.txt", text replace

// ==========================================================================

/*
file name - master.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Replicate's Lab 03

created - 10 Sep 2016

updated - 10 Sep 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file replicates Parts 2 through 4 of Lab-03.
*/

/*
updates -
none
*/

// ==========================================================================

/*
superordinates  -
- 34434-0001-Data.dta
*/

/*
subordinates -
- data.do
- analysis.do
*/

// ==========================================================================

// copy source data to new directory

global newData "lab-03.dta"
copy $sourceData "$projName/$newData", replace

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. execute data cleaning file
do "data.do"

// 2. execute data analysis / markdoc file
do "analysis.do"

// ==========================================================================
// ==========================================================================
// ==========================================================================

// copy code to code archive

copy "master.do" "$projName/CodeArchive/master.do", replace
copy "data.do" "$projName/CodeArchive/data.do", replace
copy "analysis.do" "$projName/CodeArchive/analysis.do", replace

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
