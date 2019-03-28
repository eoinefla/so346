* Encoding: UTF-8.
*******************************************************************************************
*******************************************************************************************
*Week 6: Household-level determinants of ineqaulity and its consequences (2)
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
* Note that we are working with a new dataset today, which you can download
* from moodle.
get file 'eusilc_2016.sav.sav'.


*********************************************************
*******Comparing groups contd from week 6*******
*********************************************************

* Let's try one more example with tabular data. Our reading for this week focuses on 
* economic stress, using a specific indicator. We will use burden of debt repayment as
* an indicator of potential economic stress levels. We will examine the degree of association
* between this, and tenure status. First, we need to limit the data to households only.
filter off.
use all.
execute.

compute filter_4=(pers_no=1).
filter by filter_4.
execute.

* You can inspect the variables as follows:

frequencies variables=repay_burd tenst2

* You will notice that an 'x' category remains in repay_burd, which
* we need to code as missing. We will also define the 'not applicable' category 
* as missing, in order to make the table easier to read. We do this as follows:.
missing values repay_burd('x  ', '4').

* Finally, we can specify the table. We include here an additional measure
* which allows us to sumamrise the degree of correspondence between
* both variables. This can be interpreted similarly to the correlation coefficients we
* examined in the previous week, with .1-.2 being a small effect, .2-.4 moderate, and
* .4+ strong.

crosstabs
  /tables=tenst2 by repay_burd
  /statistics=phi
  /cells=count row

**************
* Exercise 1
**************

* 1.1. Is there an association between tenure status and economic stress?


************************************
************************************
* Confidence intervals for mean
************************************
************************************

* Let's examine our income variables a little closer.
* The question we are asking here is how confident we can be that a result drawn
* from a sample is generalizable to the population from which it was drawn. Based on
* material covered in week 6 on confidence intervals, we can assess the extent to which
* means noted in our dataset may be generalised to the wider population. In other words,
* how confident are we in concluding that average income is in fact €xxxx.

*We can start with a simpler investigation - take a look at the following output:

EXAMINE VARIABLES=nat_dispinc.
  /PLOT BOXPLOT HISTOGRAM
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95.

* Most of this output, you are familiar with (Mean, Median, etc). The two figure of
* the 95% 'Confidence Interval' columns are a range within which the mean is likely to fall 
* (€52471 - €53902). Remember the logic and calculation underlying this from our lecture.

* It is tempting to interpret this as "we can be 95% certain that the true population
* mean falls between this range". To be more precise, it means that, given the sample size,
* if we were we to conduct a series of repeat draws from the data and to calculate the mean
* on each, 95% of these calculated means would fall in the range €52471 - €53902.


****************************************************************************************
***********Procedure for conducting the independent samples t-test************
****************************************************************************************

* This is fine, but doesn't explain variation in income. What are the factors that are
* likely to affect, or explain differences in, personal or household income? We talked
* about gender before as an important indivdual factor, and can explore this using the t-test.
* There are several variations of this test, and the version we will examine is for comparing
* the means of separate groups. We will follow the standard logic of hypothesis testing
* and reporting.

* 1. Start with our basic research question:
* Is there a differences between genders in mean personal income?

* 2. Specifcy a hypothesis:
* Ha: the difference in mean income between genders > 0
* Ho: the difference in mean income between genders = 0

* 3. Filter the data as required.
compute filter_5=(ann_disp_inc_i>0).
filter by filter_5.
execute.

* 4. Identify an appropriate set of measures to test this, and inspect the variables:.
descriptives variables=ann_disp_inc_i
  /STATISTICS=MEAN STDDEV RANGE MIN MAX.

frequencies variables=sex.
 
* 5. Check the categories/coding of the grouping variable:.
codebook sex.

* 6. Examine the breakdown of descriptive statistics by gender:.
means tables=ann_disp_inc_i by sex.

examine variables=ann_disp_inc_i BY sex
  /PLOT HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95.
* Check the confidence intervals.
* Is the standard error small relative to the mean?
* Is the 95% confidence interval wide or narrow?

* 7. Conduct the test and interpret the output:.
t-test groups=sex(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=ann_disp_inc_i
  /CRITERIA=CI(.95).

* The key pieces of information are:
* a. In the 'Mean Difference' column, we see 5227.79. This is the
* difference between the mean for males, and the mean for females.

* b. The 95% confidence interval for this difference shows us that the 
* population difference likely falls in the range of 4404-6051. Since
* our original hypothesis asserted that the differences was >0, this 
* is evidence in favour of rejecting the null hypothesis.

* c. Under the 'Sig. (2-tailed)' column, we see a figure of of .0000
* This means that the probability of observing a difference between means of 5227.79
* in a series of repeated random sample draws, if the population difference
* was in fact 0, is highly unlikely.

* 8. Report your findings.
* Reject the null hypothesis:
* There is a statistically signifciant difference between males and
* females in mean income, t(12494)=12.44, p<.05.

**************
* Exercise 2
**************

* 2.1. Repeat the preceding t-test, but this time test whether working hours (hrs_uwm)
* differ by gender.


***********************
* Exercise solutions
***********************

* 2.1.
t-test groups=sex(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=hrs_uwm
  /CRITERIA=CI(.95).
