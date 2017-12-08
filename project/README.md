# README
## Predicting Elections with "Mister P" (MRP, multi-level regression and post-stratification)
## Andrew Enfield, University of Washington Data 512 Autumn 2017

# Abstract

In this project I used Bayesian multi-level regression and post-stratification (MRP), and Python and [PyMC3](https://github.com/pymc-devs/pymc3) to adjust an unrepresentative sample of election preferences and predict the outcome of the 2016 US Presidential election. My results don't match the survey from which I used the raw data, possibly because I haven't used enough predictors (in the interest of simplicity). Nonetheless, the code and explanation show an attempt at learning and applying MRP using a language and MCMC framework that I haven't found used for such a purpose before. 

**NOTE:** I'm new to this concept and PyMC3, and did this work without review. I also spent a relatively minimal amount of time on this project, as it was just a portion of the work for a particular class. If you happen upon this project and see things I did incorrectly or can do better, please let me know - it'll help me continue to learn. There's a non-exhaustive list of many things that I could do to improve this work in the Discussion section at the end of the [MRP_Presidential_Election_2016.ipynb](MRP_Presidential_Election_2016.ipynb) notebook.

# License

This code is licensed as described in the [LICENSE](LICENSE) file. The data persisted as the mrp_cells.csv file is licensed using the [CC BY 2.5 license](https://creativecommons.org/licenses/by/2.5/). (The source data described below in the Data section is not included in this CC license, and is used under the terms described in that section.)

# Data

This work uses data from the following sources:
- Pew Research Center ["October 2016 Political Survey"](http://www.people-press.org/dataset/october-2016-political-survey), under the terms of use reproduced in the appendix below. I have "incorporate[d] limited portions of the [d]ata in [this] scholarly, research or academic publications" in the pew_poll.csv file, which contains a small subset of the columns in the original report, each of which represents demographic information and poll responses from a single person. The original data is available in multiple formats, but not as a simple .csv file or files. I downloaded the data as an SPSS .sav file and used R to convert the content to a .csv that I then load from the notebook, as explained below in the Implementation section.
- [IPUMS Current Population Survey](https://cps.ipums.org/cps/), under the agreement reproduced in the appendix below. I have included "a subset of the data to meet journal requirements for accessing data related to a particular publication" in the cps_population.csv and cps_votes.csv files. The former contains cross-tabulated population data from the "IPUMS-CPS, ASEC 2016" data set; the latter contains information about how often people voted, from the "IPUMS-CPS, November 2016" monthly data set. Both files contain a row per person. (The license requests that I "supply [IPUMS] with the title and full citation for any publications, research reports, or educational materials making use of the data or documentation". I've tried to do this multiple times using the page at https://bibliography.ipums.org/user_submissions/new but always receive a "We're sorry, but something went wrong" error message. In order to help the group and fulfill the terms of use, I went ahead and sent a mail to the IPUMS team with information about the error and with all of the requested citation information.) 

I retrieved the following IPUMS CPS fields from the "IPUMS-CPS, ASEC 2016" data set (with the description provided by IPUMS):

1. YEAR (Survey year)
2. SERIAL (Household serial number)
3. HWTSUPP (Household weight, Supplement) 
4. CPSID (CPSID, household record)
5. REGION (Region and division)
6. STATEFIP (State (FIPS code))
7. STATECENSUS (State (Census code))
8. ASECFLAG (Flag for ASEC)
9. MONTH (Month)
10. PERNUM (Person number in sample unit) 11. CPSIDP (CPSID, person record)
12. WTSUPP (Supplement Weight)
13. AGE (Age)
14. SEX (Sex)
15. RACE (Race)
16. HISPAN (Hispanic origin)
17. EDUC99 (Educational attainment, 1990)

I retrieved the following IPUMS CPS fields from the "IPUMS-CPS, November 2016" monthly data set (with the description provided by IPUMS)

1. YEAR (Survey year)
2. SERIAL (Household serial number)
3. HWTFINL (Household weight, Basic Monthly) 
4. CPSID (CPSID, household record)
5. STATEFIP (State (FIPS code))
6. MONTH (Month)
7. PERNUM (Person number in sample unit)
8. CPSIDP (CPSID, person record)
9. WTFINL (Final Basic Weight)
10. AGE (Age)
11. SEX (Sex)
12. RACE (Race)
13. HISPAN (Hispanic origin)
14. EDUC99 (Educational attainment, 1990)
15. VOTED (Voted for the most recent November election)
16. VOREG (Registered for the most recent November election)



# Implementation

To reproduce the analysis, run the code in the [MRP_Presidential_Election_2016.ipynb](MRP_Presidential_Election_2016.ipynb) notebook.

The notebook uses the subset of data provided in this repo - the notebook works in a standalone fashion and doesn't require that you retrieve any data from the original sources. 

However, if you do want to generate the data used by the notebook from the original sources, run the SPSSInR.R script. This script does three things: 

1. It uses the full-featured SPSS import code in R's 'foreign' package to load data from the source SPSS .sav files. This data includes rows, as well as column titles and 'labels' for each column that provide a longer description of that field. I used R because I wasn't able to find similar functionality native to Python or in a well-supported Python library.
2. Filters the source data to just the subset of columns the notebook requires.
3. Writes out the subset of the data as .csv files.

# Fields in the generated output data file

I've persisted a copy of the final data set generated by the previously mentioned notebook in the repo as [mrp_cells.csv](mrp_cells.csv). Each row in this file is a single cell with a unique combination of values for the sex, racecmb, and state fields. The file has the following fields.

| Column      	      	  | Description |
| ----------------------- | ----------- |
| sex     | Sex. |
| racecmb     | Race/ethnicity (categories defined by the Pew poll data). |
| state     | State (including D.C.). |
| trump_prob     | Probability of Trump vote for this cell, from the Bayesian multi-level regression model. This value is calculated by multiplying the indicator variables for this cell with the mean values of the parameters estimated using MCMC. This is the probability used to calculate the votes_clinton and votes_trump fields. |
| mean     | Average probability of Trump vote for this cell, calculated as the chain is generated - i.e., in contrast to the previous field, this is the mean of the 1000 probability values calculated while generating 1000 samples from the model. |
| sd     | Standard deviation of the same data used for the 'mean' column. |
| mc_error     | Per the [doc](http://docs.pymc.io/api/stats.html), 'the simulation standard error, accounting for non-independent samples.'. |
| hpd_2.5    | The value that is higher than the lowest 2.5% of the probability values generated by the chain, from the same data used for the 'mean' column. |
| hpd_97.5     | The value that is higher than the lowest 97.5% of the probability values generated by the chain, from the same data used for the 'mean' column. |
| population     | Population of this cell, from the CPS population data. |
| votes_clinton    | Assuming everyone votes (bad assumption), the votes for Clinton based on the value of 'trump_prob'. |
| votes_trump     | Assuming everyone votes, the votes for Trump based on the value of 'trump_prob'. |
| voted_prop     | The proportion of people in this cell that voted in the last election, from the CPS voted data. |
| est_population_voted     | The estimated population that voted in the last election, based on multiplying 'proportion' and 'voted_prop'. |
| votes_adj_clinton    | The votes for Clinton, using 'est_population_voted' and 'trump_prob'. |
| votes_adj_trump     | The votes for Trump, using 'est_population_voted' and 'trump_prob'. |
| lr_prob     | Probability of Trump vote for this cell, from a simple OLS logistic regression model. |
| lr_votes_clinton     | Assuming everyone votes (again, bad assumption), the votes for Clinton based on the value of 'lr_prob'. |
| lr_votes_trump     | Assuming everyone votes, the votes for Trump based on the value of 'lr_prob'. |


# Appendix

## Pew Research Center TOU for "October 2016 Political Survey"

Pew Research hereby grants to the User a non-exclusive, revocable, limited, non-sublicensable, non-transferable license to use the Data solely for (1) research, scholarly or academic purposes, (2) the internal use of your business (e.g., not for further distribution or resale), or (3) your own personal non-commercial use. You may not reproduce, sell, rent, lease, loan, distribute or sublicense or otherwise transfer any Data, in whole or in part, to any other party, or use the Data to create any derived product for resale, lease or license.  Notwithstanding the foregoing, you may incorporate limited portions of the Data in scholarly, research or academic publications or for the purposes of news reporting, provided you acknowledge the source of the Data (with express references to the Center, as well as the complete title of the report) and include the following legend:
 
The Pew Research Center bears no responsibility for the analyses or interpretations of the data presented here.
 
THE DATA IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, ARISING BY LAW OR OTHERWISE, INCLUDING BUT NOT LIMITED TO WARRANTIES OF COMPLETENESS,  NON-INFRINGEMENT, ACCURACY, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.  THE USER ASSUMES ALL RISK ASSOCIATED WITH USE OF THE DATA AND AGREES THAT IN NO EVENT SHALL THE CENTER BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY INDIRECT, SPECIAL, INCIDENTAL, PUNITIVE OR CONSEQUENTIAL DAMAGES INCLUDING, BUT NOT LIMITED TO, DAMAGES FOR THE INABILITY TO USE EQUIPMENT OR ACCESS DATA, LOSS OF BUSINESS, LOSS OF REVENUE OR PROFITS, BUSINESS INTERRUPTIONS, LOSS OF INFORMATION OR DATA, OR OTHER FINANCIAL LOSS, ARISING OUT OF THE USE OF, OR INABILITY TO USE, THE DATA BASED ON ANY THEORY OF LIABILITY INCLUDING, BUT NOT LIMITED TO, BREACH OF CONTRACT, BREACH OF WARRANTY, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, EVEN IF USER HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
  
The Center has taken measures to ensure that the Data is devoid of information that could be used to identify individuals (e.g., names, telephone numbers, email addresses, social security numbers) who participated in or who were the subject of any research surveys or studies used to collect the Data ("Personally Identifying Information").  However, in the event that you discover any such Personally Identifying Information in the Data, you shall immediately notify the Center and refrain from using any such Personally Identifying Information.
 
This license will terminate (1) automatically without notice from the Center if you fail to comply with the provisions of this agreement, or (2) upon written notice (by e-mail, U.S. or otherwise) from the Center.  Upon termination of this agreement, you agree to destroy all copies of any Data, in whole or in part and in any and all media, in your custody and control. 
 
This agreement shall be governed by, construed and interpreted in accordance with the laws of the District of Columbia. You further agree to submit to the jurisdiction and venue of the courts of the District of Columbia for any dispute relating to this Agreement.

## IPUMS CPS usage license and citation

IPUMS CPS USAGE LICENSE

Redistribution: You will not redistribute the data without permission.
You may publish a subset of the data to meet journal requirements for accessing data related to a particular publication. Contact us for permission for any other redistribution; we will consider requests for free and commercial redistribution.

Citation: Cite the IPUMS CPS data appropriately
For information on proper citation refer to citation and use. Publications and research reports making use of IPUMS CPS should be added to our Bibliography.

IMPORTANT: These terms of use are a legally binding agreement. You can use the data only in accordance with these terms, and any other use is a violation of the agreement. Violations may result in revocation of the agreement and prohibition from using other IPUMS data. If IPUMS or our partners are harmed from your violation, you are responsible for all damages, including reasonable attorney’s fees and expenses.


CITATION AND USE OF THE IPUMS-CPS

Publications and research reports based on the IPUMS-USA database must cite it appropriately. The citation should include the following:

Sarah Flood, Miriam King, Steven Ruggles, and J. Robert Warren. Integrated Public Use Microdata Series, Current Population Survey: Version 5.0. [dataset]. Minneapolis: University of Minnesota, 2017. https://doi.org/10.18128/D030.V5.0.
For policy briefs or articles in the popular press that use the IPUMS-CPS database, we recommend that you cite the use of IPUMS data as follows:

IPUMS-CPS, University of Minnesota, www.ipums.org.

The licensing agreement for use of IPUMS-CPS data requires that users supply us with the title and full citation for any publications, research reports, or educational materials making use of the data or documentation.




