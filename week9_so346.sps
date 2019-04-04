* Encoding: UTF-8.
********************************************************************
********************************************************************
*Week 9: Attitudes to welfare, redistribution, and inequality
********************************************************************
********************************************************************

* Today, we will work with the European Social Survey.
* The version of the dataset we will use is the amalgamted
* European file with all countries[ESS8_16 from moodle]

* We will examine one variable in this session, whether respondents
* agree that large differences in income are accaptable. 

frequencies variables = dfincac

* There are several ways we can modify this. First, we are using the entire
* dataset. To select only the Irish group, we use a filter. 

codebook cnty.

* To see what code each country has been assignment, check the codebook
* for the variable cnty. Ireland (IE) has been coded 12, so we compute a filter
* as follows:

compute filter_1=(cnty=12).
filter by filter_1.
execute.

* To turn off the filter and use all cases, you use the following piece of code:

filter off.
use all.
execute.

* By repeating commands before and after filters, you can compare Irish responses
* to the combined European average. 


**************
* Exercise 1
**************
* 1.1. What percentage of European respondents agree with the statement?

* 1.2. What percentage of Irish respondent agree with the statement?

* 1.3. What percentage of Swedish respondents agree with the statement?


* There are other ways to sort output and compare groups. You can ask SPSS
* to split the output by a sorting varaible, and then compare results from any
* piece of analysis across those groups. 
sort cases by cnty.
split file layered by cnty.

* Remember to deactivate any active selection before proceeding.
* Now, when you repeat your commands, they will be organised in each 
* output table by country.
frequencies variables = dfincac.

* To turn the split file function off, use the following (but 
* keep it active for now):.
split file off.


**************************************************
*******Assessing variation in attitudes*******
**************************************************

* We will examine variation in attitudes to redistribution by political orientation.
* Here, we suggest that a respondent's location on the left-right political spectrum
* has some bearing on their attitude toward redistribution.

codebook dfincac lrscale.

* Ha: support for income differences is negatively correlated with right-wing beliefs.
* Ho: support for income differences is uncorrelated with right-wing beliefs.


* We can test this several ways. First, we could look at the entire European Dataset:.
nonpar corr
  /variables=dfincac lrscale
  /print=spearman twotail nosig
  /missing=pairwise.

* ...or just Ireland
compute filter_1=(cnty=12).
filter by filter_1.
execute.

nonpar corr
  /variables=dfincac lrscale
  /print=spearman twotail nosig
  /missing=pairwise.

* ...or we can split the file and compare the strength and direction of correlation
* across all countries:.
filter off.
use all.
execute.

sort cases by cnty.
split file layered by cnty.

nonpar corr
  /variables=dfincac lrscale
  /print=spearman twotail nosig
  /missing=pairwise.


*******************************************
*******Your second assignment*******
*******************************************

* For the remainder of this session, we will work on the following:

* Using the assignment guide provided on Moodle, consider parts
* 1-3, and select a set of variables (one dependent, three independent).

* Open your chosen dataset in SPSS, and identify your variables using
* the 'codebook command' (see above).

* Consider which method of analysis might be used to test association between
* your dependent, and each of your three independents. 