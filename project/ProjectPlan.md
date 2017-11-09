# Enfield, Andrew - Project Plan, DATA 512 Autumn 2017

# What

I plan to use Bayesian multilevel regression and poststratification (MRP) to weight poll responses for the 2016 US Presidential election. In theory this approach can do a better job of giving underrepresented voters the proper impact in a poll's predictions, compared to other weighting methodologies (like propensity score matching or poststratification with raking).

# Why

Most electoral polls adjust, or weight, the data from participants so that a poll's sample matches the likely proportions of voters in the actual election. For example, suppose 10% of the responses in a poll are from women between the ages of 40 and 59, but the proportion of women ages 40 to 59 that are expected to vote in the election is actually 15%. At a simple level, the final prediction based on the poll data could be adjusted by weighting the responses from this set of women - this 'cell' - so they make up 15% of the prediction.

Weighting isn't without its perils. Giving too much weight to a particular cell - which can happen generally when the weight is out of line with the actual number of respondents in that cell - can cause predictions to change drastically when only a relatively few respondents change their opinion. 

This problem is often ameloriated by "trimming" the weights given to particular cells, for example so they don't exceed some cap. But this has its own problems, including that it can underrepresent particular voters who would otherwise have larger weights. The New York Times article [How One 19-Year-Old Illinois Man Is Distorting National Polling Averages][] describes this problem.  
 
> Jill Darling, the survey director at the U.S.C. Center for Economic and Social Research, noted that they had decided not to “trim” the weights (that’s when a poll prevents one person from being weighted up by more than some amount, like five or 10) because the sample would otherwise underrepresent African-American and young voters.
>
> This makes sense. Gallup got itself into trouble for this reason in 2012: It trimmed its weights, and nonwhite voters were underrepresented.
>
> In general, the choice in “trimming” weights is between bias and variance in the results of the poll. If you trim the weights, your sample will be biased — it might not include enough of the voters who tend to be underrepresented. If you don’t trim the weights, a few heavily weighted respondents could have the power to sway the survey. The poll might be a little noisier, and the margin of error higher (note that the margin of error on the U.S.C./LAT poll for black voters surges every time the heavily weighted young black voter enters the survey)."

While there are many techniques for adjusting non-representative samples - including propensity score matching - a relatively new technique, and the one I'd like to learn about and apply in this project, is called "multilevel regression and poststratification", or "MRP". As described in [Forecasting elections with non-representative polls][], the "central idea of MRP is to partition the data into ... demographic cells, estimate voter intent at the cell level using a [Bayesian] multilevel regression model, and finally aggregate the cell-level estimates in accordance with the target population’s demographic composition." As I understand it, this approach is well-suited to handle sparse "cells" - combinations of covariates that have small sample sizes, like the example in the article quoted above - because the use of Bayesian inference and shared priors combines data from multiple cells and then uses this data proportionally more with small samples and less with large samples. 

### Methodology 

I plan to:

1. Obtain information about the person for whom people plan to vote, along with demographic characteristics of the people answering the question, from opinion poll data.
2. Obtain information about how often people with different demographic characteristics vote, and the representation of these cells in the overall population, from exit poll or Census data.
3. Investigate the distributions of the data obtained in #1 and #2 and determine the degree to which the polls are representative of the expected distributions for voters. If the polls _are_ representative, then I may adjust the poll data I use in #4 artificially to under-represent at least some cells.
4. Perform multilevel regression and poststratification using the information from #1, #2, and #3.

I'll note here that completely finishing a full MRP analysis may end up being too much work. However, it might not be - I already know how to write code, how to use pandas, and know these well, and also know - at least to a small degree - how to do Bayesian inference and models with PyMC, Stan, JAGS, and I've already read and thought through papers on MRP. If it does end up beig too much, I would still expect that I'd be able to obtain, combine, and analyze the relevant data - i.e., to complete #1, #2, and #3 above.

# Data

I plan to use some and possibly all of the following data sources:

- Opinion poll data from many opinion polls [Huffington Pollster API](http://elections.huffingtonpost.com/pollster/api/v2), CC BY-NC-SA 3.0. 
- Census data
	  - [API wrapper for Python](https://pypi.python.org/pypi/census)
	  - [Census data navigator](https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml). For example, [this](https://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?pid=DEC_10_DP_DPDP1&src=pt) has has population breakdowns as of 2010, including race. [Public domain](https://ask.census.gov/prweb/PRServletCustom/YACFBFye-rFIz_FoGtyvDRUGg1Uzu5Mn*/!STANDARD?pyActivity=pyMobileSnapStart&ArticleListID=TAX_152_154)
- [Voter turnout](https://www.census.gov/data/tables/time-series/demo/voting-and-registration/p20-580.html and http://www.electproject.org/home/voter-turnout/voter-turnout-data)
- 2016 election results - [code](https://github.com/aaronhoffman/ParseNytElection2016) and [data](https://drive.google.com/open?id=0BwgLvVq0rcS7Q2NjLXlNMTk0d00) per [this Reddit thread](https://www.reddit.com/r/datasets/comments/5bzrda/election_polls_dataset/?st=j9ophiua&sh=181138f3), Apache License 2.0. 

# Note on the limitations of requiring data to be in the repository

I found a lot of data sources that have information I'd like to use - for example, this set of [October 2016 survey data from the Pew Research Center](http://www.people-press.org/dataset/october-2016-political-survey). Most of the data sources appear to be good with sharing their data and enabling people to use it, but balk at letting others reproduce it (or at least don't make it easy), which we need to be able to do so that we can check the data in to GitHub. I understand some of the benefits - making the repo entirely self-contained and "owning" the reproducibility top-to-bottom is great. But, it's a trade off, since it _does_ exclude otherwise useful data. From my perspective it's good for this class - we can just look harder or change what we do if we can't copy/reproduce the data, and encouraging this level of sharing is good too - but pragmatically I'm not sure the trade off would always be worth it. 

# Questions

Some questions I may need to answer as part of my work:

- Political scientists and election junkies have studied polling and electoral predictions for centuries. I've just started. What obvious things am I missing?
- How should I handle the propensity to vote compared to just being eligible to vote? Both articles above, as well as a number of other articles I have in my notes for this project, provide information about this question, but I don't (yet) know enough to answer it at this point.



[How One 19-Year-Old Illinois Man Is Distorting National Polling Averages]: https://www.nytimes.com/2016/10/13/upshot/how-one-19-year-old-illinois-man-is-distorting-national-polling-averages.html
[Forecasting elections with non-representative polls]: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/04/forecasting-with-nonrepresentative-polls.pdf
