* Encoding: UTF-8.
*******************************************************************************************
*******************************************************************************************
*Week 5: Summarising and comparing income inequality between countries (2)
*******************************************************************************************
*******************************************************************************************

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

**************************************************
*******Summary statistics and graphs*******
**************************************************

* In this session, we will examine correlations between several factors associated with
* inequality. As with all data analysis sessions, we begin by insepacting and visualing 
* our data. In any project, we may start with a specific hypothesis which informs our selection
* of variables, or we may explore (as we will below) multiple potentially related variables.

means tables=top1 gini unemp_ilo gni_pc healthex_exp service_emp life
 /cells=count mean median stddev min max.

* SPSS returns the following information:
* N - the sample size, or number of respondents/units/cases
* Range - the difference between the minimum and maximum values
* Minimum - smallest recorded value
* Maximum - highest recorded value
* Mean - the arithmetic mean
* Standard deviation - interval above and below the mean containing 
* approximately 68% of respondents/units/cases.

* You may also wish to view the distribution or spread of scores for those variables
* we have not yet examined (we looked at the inequality variables in week 4).

graph /histogram = unemp_ilo.
graph /histogram = healthex_exp.
graph /histogram = service_emp.
graph /histogram = life.

* Finally, we will inspect the scatterplots for each combination of variable. In this case,
* we are interested in the potential correlation between our independent variables
* unemp_ilo, healthex_exp, and service_emp with inequality. We will also include life
* as an example of one possible effect if higher inequality (i.e. an instance where we might
* hypothesise that life expectancy is dependent on inequality).

* We can do this individually for each.
graph/scatter unemp_ilo with gini.

* You can add a fit line to your graphs easily by editing within the plot region (we will do this using the
* manual method, as the ggraph command in SPSS is quite long).

* Double-click in the region of the plot to open the Chart Editor.
* On the lower row of icons along the top, click on 'Add Fit Line at Total'.
* The dialog will be default select a Linear fit (this is the type we want for now).
* Close the dialog, and your graph will now include a linear fit line.

* A quicker way to examine multiple correlations at once is to use a matrix.

graph
  /scatterplot(matrix)=top1 unemp_ilo healthex_exp service_emp
  /title= 'Matrix of factors correlated with inequality'.
* You should also repeat the above procedure to add fit lines, to make it easier
* to visually interpret the correlations.

**************
* Exercise 1
**************

1.1. Produce a scatterplot matrix of the following variables:
* gini unemp_ilo healthex_exp service_emp.

1.2. Add fit lines to better assess the direction of correlation.

1.3. Are unemployment, health expenditure, and service employment correlated
* with Gini income inequality? In what direction?

********************************************
***********Pearson correlation***********
********************************************

* Note - for the following examples, scale by scale correlations are used 
* (both variables are scale variables). For Pearson correlations, both variables 
* need to be measured at this level, although there are important exceptions.

* A Pearson correlation can be interpreted as a measure of 'closeness' of the data points to
* the regression line (the fit lines which we added in the above graph). The closer the datapoints
* conform to a clear trend in either a positive or negative direction, the stronger they are
* correlated (don't worry, we willl return to this principle several times throughout the course).

* Correlation scores fall between 0 and 1 for a positively correlated pair, and between 0 and -1
* for a negatively correlated pair.

* A score of around .3 indicates a moderate positive correlation 
* (as one variable increases, the other decreases). A correlation of -.3 is as 
* strong as that of .3, but is negative. 
* This means that as one variable increases, the other decreases.

* Let's examine how strongly unemployment correlates with inequality.
* The reason these might be correlated is that in time of high unempoyment, 
* workers are generally in a weaker position, and les able to bargain collectively
* for better work term. It is also possible that incomes may fall during periods
* of high unemployment, widening the gap between the rich who are less dependent 
* on wages, and the poor who are more dependent on wages.

correlations
  /variables=gini unemp_ilo
  /print=twotail nosig
  /missing=pairwise.

* The 'Parson correlation' row lists the value of the correlation coefficient, 
* and we see that they are positively correlated (as unemployment increases, so too does inequality). 
* Is the effect strong, moderate, or weak? 

* We can do this for any combination of variables, but the table quickly becomes crowded:

correlations
  /variables=gini top1 unemp_ilo healthex_exp service_emp
  /print=twotail nosig
  /missing=pairwise.

* You can read off any correlation between two variables by identifying one from the column, 
* and the other from the row. The cell at which they intersect is the one that contains the 
* correlation output for that pair of variables.

***********************
* Exercise solutions
***********************

*1.1. 
graph
  /scatterplot(matrix)=gini unemp_ilo healthex_exp service_emp
  /title= 'Matrix of factors correlated with inequality'.
