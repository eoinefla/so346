* Encoding: UTF-8.
***************************************************************************************
***************************************************************************************
*Week 4: Summarising and comparing income inequality between countries
***************************************************************************************
***************************************************************************************

*******************************
*******Getting started*******
*******************************

* If you wish,  you may follow these steps to set your working directory.
* If you wish to proceed without doing this, you can open the World Bank
* dataset manually by double-clicking on the file in your module folder.
cd 'X:\so346\datasets'.

* Note: your directory will differ from mine, so remember to use your own folder
* names and path.
* You can confirm this has worked with the following command.
show dir.

* Now you can open your data using commands. This will allow you to
* switch between datasets quickly in future, when working with additional data.
get file 'world_bank.sav'.

*************************************
******Level of measurement******
*************************************

* Remember from week 2, that level of measurement determines  
* the kinds of summary statistics you can report. For nominal/ordinal measures
* like those in the previous exercise, we use tables and cross-tabs (but can also 
* use other methods of correlaton which we will look at later in the module). For
* scale variables, we can use the following procedures.

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
* Exercise 1
**************
* 1.1. What are the minimum and maximum levels of unemployment?
* 1.2. What was value of mean service employment?
* 1.3. What were the mean and standard deviation of unionisation?

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


*************************************************
***********Basic data visualisation***********
*************************************************

***********************************
***********Histograms***********
***********************************

* Histograms are appropriate for visualising scale variables. Let's take a look at 
* how they are produced. Start by inspecting the data.

DESCRIPTIVES VARIABLES=top1 ls gini
  /STATISTICS=MEAN STDDEV RANGE MIN MAX.

* GRAPH is the base command for producing many different types of graph in SPSS.
* By adding options, we can modify the format and content of the graph easily. Let's 
* start with a basic graph. 

GRAPH /histogram = top1.

*And let's also take a look at height and weight

GRAPH /histogram = ls.
GRAPH /histogram = gini.

* You will notce that SPSS provides summary statistics next to the graph for reference.

* How do we interpret a histogram?
* A histogram is used to show the distribution or spread of values of a particular variable.
* The bars represent set ranges of values known as 'bins'.

* The best analogy to explain the notion of a bin is to imagine writing down every country's 
* gini score from the entire dataset on a separate piece of paper. Next imagine lining up 20 clear, 
* empty bins in a row. Each bin will be labelled with a certain range: 0-10, 10-20, 20-30, 30-40 and so on. 
* Finally, imagine taking each country's piece of paper with their score for gini 
* written down, and throwing it into the bin corresponding to the range their score falls into. So, 
* Ireland with a score of 31.8 goes in bin 4, Denmark with a score of 28.2 goes in bin 3, 
* and so on. 

* By the time you work through all countries, some bins will be very full (for ranges
* which many fall into), and others comparatively empty.

*Take a look at the histogram again:

graph /histogram = gini.

* Most of the respondents seem to be falling into the 25-35 range, as these bars are
* tallest. There are comparatively fewer in the larger bins (50 and over), as there
* are few countries in the dataset who recorded scores in this range.

* We can modify the graph by adding extra lines of code, and running these together. Select and run
* the following four lines of code to annotate and title your graph. You can change the text as you wish.

graph /histogram = gini
  /TITLE='Global Gini, 2015'
  /SUBTITLE='World Bank Data'
  /FOOTNOTE='Gini coefficient scaled 0-100'.

**********************************
***********Bar Charts**********
**********************************

* Bar charts are generally used for two purposes - to display summary statistics across groups,
* or to display the distribution of a nominal or ordinal variable. We can use them to split output
* by another categorical variable, and to display summary statistics for each group. Is mean Gini
* higher in EU vs non-EU countries?

graph /bar=mean(gini) by eu.

* You can use the same extensions as above to modify the appearance of the graph:

graph /bar=mean(gini) by eu
  /TITLE='Gini Inequality by EU/non-EU (2015)'
  /SUBTITLE='World Bankd Data'
  /FOOTNOTE='Gini coefficient scaled 0-100'.

************************************
***********Scatterplots***********
************************************

* Scatterplots are constructed by plotting the location of a case on a two-dimensional chart,
* using scores from two variables. In the examples which follow, we will explore the relationship
* between several factors noted in Alderson and Nielsen's paper from last week. Does inequality
* vary with respect to globalisation? What about unionisation?

* There are two simple commands you can use to produce a bivariate scatterplot.
* For both of these, by convention, we list the dependent variable last so that it appears
* in its correct position on the y-axis.

graph/scatter union with gini

graph
/scatterplot(bivar)= union with gini
/title "Scatterplot of Gini Inequality with Unionisation Rates (2015)".

* What about their proposition that globalisation and foreign investment play a role? 
* We can explore this using measures of international trade volume and investment.

graph/scatter trade with gini.
graph/scatter fdiin_gdp with gini.

* What can you conclude from these graphs? Does Gini appear to be related to 
* either variable?
