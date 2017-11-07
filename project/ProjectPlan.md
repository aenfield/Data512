# Enfield, Andrew - DATA 512 Project Plan, Autumn 2017

# What

I plan to use Bayesian multi-level regression and post-stratification to weight poll responses for the 2016 US Presidential election. In theory this approach can do a better job of giving underrepresented voters the proper impact in a poll's prediction, compared to other weighting methodologies (like propensity score matching or post stratification with raking).

# Why

Most electoral polls adjust, or weight, the data from participants so that a poll's sample matches the likely proportions of voters in the actual election. For example, suppose 10% of the responses in a poll are from women between the ages of 40 and 59, but the proportion of women ages 40 to 59 that are expected to vote in the election is actually 15%. At a simple level, the final prediction based on the poll data could be adjusted by weighting the responses from this set of women - this 'cell' - so they make up 15% of the prediction.

Weighting isn't without its perils. Giving too much weight to a particular cell - which can happen generally when the weight is out of line with the actual number of respondents in that cell - can cause predictions to change drastically when only a relatively few respondents change their opinion. 

This problem is often ameloriated by "trimming" the weights given to particular cells, for example so they don't exceed some cap. But this has its own problems, including that it can underrepresent particular voters who would otherwise have larger weights. 

The New York Times article [How One 19-Year-Old Illinois Man Is Distorting National Polling Averages][] describes this problem.  
 
> Jill Darling, the survey director at the U.S.C. Center for Economic and Social Research, noted that they had decided not to “trim” the weights (that’s when a poll prevents one person from being weighted up by more than some amount, like five or 10) because the sample would otherwise underrepresent African-American and young voters.
> This makes sense. Gallup got itself into trouble for this reason in 2012: It trimmed its weights, and nonwhite voters were underrepresented.
> In general, the choice in “trimming” weights is between bias and variance in the results of the poll. If you trim the weights, your sample will be biased — it might not include enough of the voters who tend to be underrepresented. If you don’t trim the weights, a few heavily weighted respondents could have the power to sway the survey. The poll might be a little noisier, and the margin of error higher (note that the margin of error on the U.S.C./LAT poll for black voters surges every time the heavily weighted young black voter enters the survey)."

TBD maybe - not sure it's needed, but could helpful to contrast with MRP? But perhaps the limitations above are enough - i.e., we don't need to go into detail about the specific approaches that 

TBD depending on the decision in the prev TBD, if we're not going to go into detail we could at least - in one or two sentences - say that the other approaches are common ways for the how to do weighting, since we used the terms in the intro question and probably want to tie them into the more detailed description here.

TBD describe MRP, with links to descriptions - at least one or a few papers, but perhaps something shorter? Or the paper but pull out a quote from the paper saying

# Data

TBD describe data sources

# Note on the limitations of requiring data to be in the repository

TBD The rule, and what it gives (that you own the reproducibility). Downside: most data sources appear to be good with sharing their data and enabling people to use it, but balk (or at least don't make it easily possibly) for others to reproduce it. So, it's a trade off. It's fine for this class - we can just look harder or change what we do if we can't reproduce the data - but pragmatically I'm not sure the trade off would always be worth it.

# Questions

TBD finish the start at questions below

TBD add more? 

- TBD Political scientists and election junkies have studied polling and electoral predictions for centuries. I've just started. What obvious things am I missing?
- TBD How to handle propensity vote, vs. eligibility. Don't want to weight by "past vote" per (the main article) and (the vote one)

# What if 

TBD say that going all the way to MRP might be too much. However, I know how to write code, how to use pandas, and know these well. I also know - at least to a degree - how to do Bayesian inference and models with PyMC, Stan, JAGS, AND I've read papers on MRP. 

TBD If it is too much, my fall back plan is: TBD (find the data, understand the data - viz, numbers; perhaps do PSM or post-strat)



[How One 19-Year-Old Illinois Man Is Distorting National Polling Averages]: https://www.nytimes.com/2016/10/13/upshot/how-one-19-year-old-illinois-man-is-distorting-national-polling-averages.html
