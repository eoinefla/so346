* Encoding: UTF-8.
*****************************************************************
*****************************************************************
*Week 8: What does it mean to be a rentier or a tenant?
*****************************************************************
*****************************************************************

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
* Note that we are working with a new dataset today, which you can download
* from moodle.
get file 'eusilc_2016.sav.sav'.


********************************************************************
***********The independent samples t-test (contd)************
********************************************************************

* In this final example, we assess whether net househole income varies significantly 
* by possession of income from property. Our grouping variable will idenitfy those
* households with and without such property (our indepenndent variable), and our
* dependent variable is net household income. 

* First we select our cases. This will be a household-level analysis, and as such,
* we select only households, and heads of household.

compute filter_6=(nat_dispinc>0  & pers_no=1).
filter by filter_6.
execute.

* Then, we examine the distribution of both variables:

descriptives variables=nat_dispinc
  /STATISTICS=MEAN STDDEV RANGE MIN MAX.

codebook prop_yn.

* Remember to check in the 'codebook' table produced form the preceding command
* what the codes are assigned to each category (0 and 1 for no/yes respectively)

t-test groups=prop_yn(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=nat_dispinc
  /CRITERIA=CI(.95).

* The key pieces of information are:
* a. In the 'Mean Difference' column, we see -34869. This is the
* difference in mean income between property holders and non-property
* holders

* b. The 95% confidence interval for this difference shows us that the 
* population difference likely falls in the range of -41732-28006. Since
* our original hypothesis asserted that the differences was >0, this 
* is evidence in favour of rejecting the null hypothesis. But this is also 
* quite a wide margin, so we need to look at additional evidence in favour
* of rejecting the null hypothesis.

* c. Under the 'Sig. (2-tailed)' column, we see a figure of of .000
* This means that the probability of observing a difference in group means of -34869
* in a series of repeated random sample draws, if the population difference
* was in fact 0, is highly unlikely.

* 8. Report your findings.
* Reject the null hypothesis:
* There is a statistically signifciant difference between property owners and
* non-property owners in mean household income, t(303.68)=-9.998, p<.05.


**************************************************************************************************
***********Procedure for conducting one-way Analysis of Variance (ANOVA)************
**************************************************************************************************

* One-way analysis of variance (ANOVA) offers a way to extend the t-test comparison
* procedure to multipe groups, drawing on a different test statistic and distribution to do
* so. We will adopt the same procedure as with other tests, to examine whether net
* household income varies significantly by categories of tenure. In this case, our tenure
* variable can have multiple categories, not only two.

* 1. Start with our basic research question:
* Is there a differences between tenure groups in mean disposable household income?

* 2. Specifcy a hypothesis:
* Ha: net household income varies by tenure group.
* Ho: net household income does not vary by tenure group.

* 3. Filter the data as required. This is the same filter as used above, so if you have already
* activated this, there is no need to repeat.
compute filter_6=(nat_dispinc>0  & pers_no=1).
filter by filter_6.
execute.

* 4. Identify an appropriate set of measures to test this, and inspect the variables:.
descriptives variables=nat_dispinc
  /STATISTICS=MEAN STDDEV RANGE MIN MAX.
frequencies variables=tenst2.

* 5. Conduct the test and interpret the output:.
ONEWAY nat_dispinc BY tenst2
  /STATISTICS DESCRIPTIVES
  /PLOT MEANS
  /MISSING ANALYSIS
  /POSTHOC=DUNNETT (1) ALPHA(0.05).

* There are several pieces of output which we need to consider.
* a. In the first table of descriptives, we see a comparison of group means
* and confidence intervals. Note how the width of the confidence interval
* is wider for those categories with a smaller number of cases (compare
* 'owned outright' with 'rented nelow market...' You can also scroll to the bottom
* of the output viewer to see a means chart comparing group means beween categories
* of tenure. 

* b. From the ANOVA table, read the Sig. figure from the 'Between Groups' row.
* This is the space which allows us to conclude if there is sufficient evidence in favour
* of rejecting the null hypothesis. Here, we see a figure of of .000
* This means that the probability of observing a difference in group means at least
* as large as those indicated in the preceding table in a series of repeated random 
* sample draws, if the population difference was in fact 0, is highly unlikely.

* c. The post-hoc comparison table shows the difference in means of each group relative
* to a control category. The figures shown in the 'Mean Difference (I-J) column are
* the group mean of each subtracted from the mean of the control category. So, in the
* 'owned with no mortgage...' row, the recorded figure shows that mean income was €26407
* higher for this group, relative to 'owned outright'. 

* 6. Report your findings.
* Reject the null hypothesis:
* There is a statistically signifciant difference in group means 
* between tenure groups, F(4)=165.687, p<.05.

**************
* Exercise 1
**************

* 1.1. Is there a statistically significant difference in mean net personal income
* between different categories of occupation? The two variables you need are
* ann_disp_inc_i and soccode2. You also need to filter your data to include individuals
* with an income above 0.


***********************
* Exercise solutions
***********************
* 1.1.
compute filter_7=(ann_disp_inc_i>0).
filter by filter_7.
execute.

codebook soccode2.

ONEWAY ann_disp_inc_i BY soccode2
  /STATISTICS DESCRIPTIVES
  /PLOT MEANS
  /MISSING ANALYSIS
  /POSTHOC=DUNNETT (1) ALPHA(0.05).

filter off.
use all.
execute.
