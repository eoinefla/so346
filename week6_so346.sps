* Encoding: UTF-8.
*******************************************************************************************
*******************************************************************************************
*Week 6: Household-level determinants of ineqaulity and its consequences (1)
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


**************************************************
*******Summary statistics and graphs*******
**************************************************

* We are working wit household microdata today. This is different to the type
* you have worked with so far, which was mainly country-level. Let's take a look
* at some characteristcs of this dataset.
codebook nat_totinc nat_dispinc aggp2 sex wrk_time hrs_uwm tenst2 edlevel2 marital i_eu_aropov60_oecd repay_burd

* And also some descriptive statistics and graphs of our income variables.
means tables=nat_totinc nat_dispinc
 /cells=count mean median stddev min max.

graph /histogram = nat_totinc.
graph /histogram = nat_dispinc.


***********************************
*******Making selections*******
***********************************

* Sometimes, it is necessery to restrict our analyses to sub-groups of a particular dataset.
* In this case, we want to exclude anyone with an income of 0. There are many reasons an
* individual or household may have zero income - only one being unemployment. A proportion
* of any population will be transitioning between jobs at any given time, but there are also households
* potentially living from investment yields, or in poverty and relying on friends or relatives.

* To make selections in SPSS, we use the following command:

compute filter_1=(nat_dispinc>0).
filter by filter_1.
execute.

* The above command defines a filter called 'filter_1', which selects cases only
* if they have values on nat_dispinc greater than 0.

* Compare the results from repeating the following command to those you
* originally found above:. 
means tables=nat_totinc nat_dispinc
 /cells=count mean median stddev min max.

* Remember, filters must be turned off to use the entire dataset of values again. 
filter off.
use all.
execute.

* You may need to specify more complex filtering condiitons - such as vlaues on multiple
* variables, or different conditions. To select only cases with an income above 0, and less
* than or equal to 200,000, we would do the following:.
compute filter_2=(nat_dispinc>0 & nat_dispinc <=200000).
filter by filter_2.
execute.

* Finally, we may wish to limit our analysis to just households. Householders are identified by
* being assigned a person number of 1 in the survey, identified by the variable 'pers_no'.
compute filter_2=(nat_dispinc>0 & nat_dispinc <=200000 & pers_no=1).
filter by filter_2.
execute.

* Once again, check and see what the sample size is in the descriptives table:.
means tables=nat_totinc nat_dispinc
 /cells=count mean median stddev min max.

* Remember, filters must be turned off to use the entire dataset of values again.
filter off.
use all.
execute.


***********************************
*******Comparing groups*******
***********************************

* Let's examine individual income more closey, starting with the gender split
* of earnings. There are separate variables in the daatset for individual and 
* household income. The following command splits our output by sex:.
means tables=ann_tot_inc_i ann_disp_inc_i  by sex
 /cells=count mean median stddev min max.

* We have mentioned already, that some of the disparity in earnings may be down
* to full vs part time. Breaking our findings down by sub-goups such as this is a process
* known as statistical control (as opposed to experimental control). If the difference in
* earnings holds after we have 'removed' the effect of part vs full time by splitting
* our output, then it is possible we may be getting closer to the 'true' gender effect.
* In reality, it is more complex than this, but it is a start.

**************
* Exercise 1
**************
* 1.1. Compute a filter to restrict the sample to only individuals with an indivdiual 
* net income greater than 0.

* 1.2. Generate a table showing mean and median earnings by gender, but also by 
* the variable 'wrk_time'.

* 1.3. Does the gender difference in income remain present? Does it differ by part vs full-time?

* 1.4. Are mean full-time earnings more variable for males or females?

******************************************
*******Comparing groups contd*******
******************************************

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
* Exercise 2
**************

* 2.1. Is there an association between tenure status and economic stress?


***********************
* Exercise solutions
***********************

* 1.1.
compute filter_3=(ann_disp_inc_i >0).
filter by filter_3.
execute.

* 1.2.
means tables=ann_tot_inc_i ann_disp_inc_i  by sex by wrk_time
 /cells=count mean median stddev min max.

* If you REALLY want to see it, the code for graphing the breakdown of
* working time by gender is as follows.

GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=wrk_time COUNT()[name="COUNT"] sex MISSING=LISTWISE
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: wrk_time=col(source(s), name("wrk_time"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  DATA: sex=col(source(s), name("sex"), unit.category())
  GUIDE: axis(dim(1), label("Full/part time"))
  GUIDE: axis(dim(2), label("Percent"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Sex"))
  GUIDE: text.title(label("Stacked Bar Percent of Full/part time by Sex"))
  SCALE: cat(dim(1), include("1", "2"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include("1", "2"))
  ELEMENT: interval.stack(position(summary.percent(wrk_time*COUNT, base.all(acrossPanels()))),
    color.interior(sex), shape.interior(shape.square))
END GPL.
