// ==========================================================================

// Week 03: Basic MarkDoc Example

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:\Users\`c(username)'\Desktop"
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if appropriate directories exists

global rootDir "Basic MarkDoc Example"
capture mkdir "$rootDir"
cd "$rootDir"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using week-03-markdoc.txt, text replace

// ==========================================================================

/*
file name - week-03-markdoc.do

project name - SOC5050 - Quantitative Analysis - Spring 2016

purpose - Illustrates Basic MarkDoc Commands

created - 05 Sep 2016

updated - 05 Sep 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file illustrates basic commands for MarkDoc, a user-written
package that allows you to create 'literate programming' documents that
weave together code for completing analyses with text written in Markdown
format.
*/

/*
updates -
none
*/

// ==========================================================================
/*
superordinates  -
- auto.dta (pre-installed with Stata)
*/

/*
subordinates -
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

quietly log using week-03-markdoc.smcl, replace smcl name(markdoc)

/***
# MarkDoc Example
  - SOC 5050: Quantitative Analysis
  - Christopher Prener, PhD
  - 05 Sep 2016

### Structuring the do-file
There are a total of three commands that must be included in every do-file that executes MarkDoc code. They will not appear in your output file but must be included in the do-file as they are in `week-03-markdoc.do`. See the `week-03-markdocQuickRef.pdf` file for details on those commands.
  
### Suppressing output
You can suppress output by using `//OFF` and `//ON` commands. In this example, the command for opening the data is suppressed from the output.
***/

//OFF

sysuse auto.dta, clear

//ON

/***
### Writing basic text
You can write basic text by wrapping it in the special MarkDoc comment syntax: `/***` and `***/`. All of the text included in the output file for this example is wrapped in those comment syntax symbols.

The `auto.dta` dataset contains the following variables:
***/

describe

/***
### Cleaning Up
MarkDoc does not parse text perfectly, and sometimes introduces spaces into words. For example, "those" may become "thos e". Make sure to carefully scan your file for typos before submitting it.

MarkDoc also has way of identifying code that differs slightly from standard Markdown. For code examples that appear as blocks (such as the `describe` command above), you will want to wrap them with three backticks before and after the code block. To fix the indentation, highlight the entire code block and then use the keyboard shortcut Shift+Tab to realign the text.

MarkDoc will also occasionally leave the `quietly log` command in the bottom of the output. Make sure to delete this from your output before submitting it.
***/

quietly log close markdoc

markdoc week-03-markdoc, replace export(md) install

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
