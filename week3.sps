* Encoding: UTF-8.
**************************************************************
**************************************************************
*Week 3: Loading datasets and basic data inspection
**************************************************************
**************************************************************

*******************************
*******Getting started*******
*******************************

* Today, we introduce some basic workflow in SPSS, taking you
* through the use of syntax, and some basic steps common to most
* projects/data analysis sessions. We will work with both the 
* European Social Survey, and World Bank datasets, so please ensure
* these are both downloaded from moodle, and saved in your folder.

* One useful shortcut you may wish to use when you start an SPSS session 
* involves setting a working directory.
* This will allow you to switch between datasets quickly and easily.
* Setting your directory tells SPSS to work from a specific folder
* on your computer when loading and saving files. 
* You should use the folder where you saved
* your module datasets in week 2 for this.
* Note: your folder address will differ from mine, so follow my steps either  
* in-class, or via the accompanying video tutorial. 
cd 'X:\so346\datasets'.

* Note: your directory will differ from mine, so remember to use your own folder
* names and path.
* You can confirm this has worked with the following command.
show dir.

* Now you can open your data using commands. This will allow you to
* switch between datasets quickly in future, when working with additional data.
get file 'ESS8_16.sav'.
get file 'world_bank.sav'.

* Switch back to the ESS for now.
get file 'ESS8_16.sav'.

* The command to save a dataset is as follows.
save outfile 'ESS8_16.sav'.

***************************************************
*******Taking a closer look at variables*******
***************************************************

* What might we use as an indicator of public sentiment toward inequality?
* There are a number of options, try inspecting these, and take
* a look at the tables to see more.
CODEBOOK  gincdif dfincac smdfslv basinc sbstrec lrscale 

* This command is useful, as it gives additional information. For a cleaner and simpler table,
* you should use this.
FREQUENCIES VARIABLES=gincdif dfincac smdfslv basinc sbstrec lrscale 

************************************************
*******Introducing a second variable*******
************************************************

* In sociology, we are always interested in explanation (why are scores on variables distributed a certain way,
* and what factors might explain this variation?) When we have concepts in mind, we also usually have some 
* hypotheses in mind also about what might 'explain' our observations. Now that we have seen public attitudes 
* toward inequality are distributed a certain way, what might explain the distribution of attitudes? 
* Political orientation may play a role, and we can check this through the 'lrscale' variable.

* First, let's sort the variable into left, centrist, and right groupings.
RECODE lrscale (0 thru 3=1) (4 thru 6=2) (7 thru 10=3) INTO lrscale3.
VARIABLE LABELS  lrscale3 'Political orientation (left, centrist, right)'.
EXECUTE.

* This has created a new variable called lrscale3, which will be 
* easier to interpret in tabular form.
* We also need to assign labels to each of the categories.
VALUE LABELS
lrscale3
1 'Left'
2 'Centre'
3 'Right'.
EXECUTE.

* Finally, we will limit our analysis to just the Irish sub-set for now.
compute filter_$=(cnty=12).
filter by filter_$.
execute.

* This is the code to deactivate a filter if needed (don't run this for now).
FILTER OFF.
USE ALL.
EXECUTE.

* To check whether political orientation is associated with attitudes toward inequaity, we can 
* tabulate both together as follows.
* For the following command, you need to highlight all of the text within the indicator 
* (from CROSSTABS to /CELLS=COUNT ROW).
CROSSTABS
  /TABLES=lrscale3 BY dfincac
  /CELLS=COUNT ROW

CROSSTABS
  /TABLES=lrscale3 BY sbstrec
  /CELLS=COUNT ROW

**************
* Exercise 1
**************
* 1.1. What percentage of leftists strongly disagree with the acceptability of large
* differences in income?
* 1.2. Does political orientation appear to be related to support for social welfare?

*************************************
******Level of measurement******
*************************************

* For this section, switch to the world bank dataset. 
get file 'world_bank.sav'.

* Remember from last week, that level of measurement determines  
* the kinds of summary statistics you can report. For nominal/ordinal measures
* like those in the previous exercise, we use cross-tabs (but can also use other
* methods of correlaton which we will look at later in the module).

*************************************
*******Summary statistics*******
*************************************

* Scale variables can be summarized using descriptive statistics.

DESCRIPTIVES VARIABLES=top1 gini ls
  /STATISTICS=MEAN STDDEV RANGE MIN MAX.

* SPSS returns the following information:
* N - the sample size, or number of respondents/units/cases
* Range - the difference between the minimum and maximum values
* Minimum - smallest recorded value
* Maximum - highest recorded value
* Mean - the arithmetic mean
* Standard deviation - interval above and below the mean containing 
* approximately 68% of respondents/units/cases.

**************
* Exercise 2
**************
* 2.1. What are the minimum and maximum levels of unemployment?
* 2.2. What was value of mean service employment?
* 2.3. What were the mean and standard deviation of unionisation?

* You may recall that there are many ways to calculate averages. The arithmetic mean is one.
* Another is to take the middle value in a set of data that have been arranged in rank order.
* This is called the median value.
* You can return this figure in a number of ways in
* SPSS. Let's try it with the inequality variables and some others.

FREQUENCIES VARIABLES=gini unemp_nat fdiin_gdp
  /NTILES=4
  /STATISTICS=STDDEV RANGE MINIMUM MAXIMUM MEAN MEDIAN
  /ORDER=ANALYSIS.

* The first table is most important - you will find the mean and median here.
* Why do you think the mean is larger than the median in some cases?
* We will explain this further in the coming class.

************************************************
*******Summary statistics by group*******
************************************************

* Exploring and explaining differences and inequalities between groups is a central task of
* quantitative sociology. We can start to explore this by splitting our summary figures by groups. 

* Let's examine levels of inequality by region. Is inequality higher in non-EU countries?
* Is it higher in developing countries? Note that there are fewer countries in the developing group,
* so these scores are not representative. 

MEANS TABLES=gini top1 ls by eu 
  /CELLS=COUNT MEAN MEDIAN STDDEV MIN MAX.

MEANS TABLES=gini top1 ls by un_developed
  /CELLS=COUNT MEAN MEDIAN STDDEV MIN MAX.

* This is a useful command, and you can use the BY option to split the output by any category.
* You can also specify which summary statistics should be included by using the /CELLS= option.
