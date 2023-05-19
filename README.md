![](https://github.com/FilippoGuardassoni/usa_elections/blob/main/img/headerheader.jpg)

# Analyzing and Predicting US Elections

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/pragyy/datascience-readme-template?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/FilippoGuardassoni/spotify_hitsong)
![GitHub pull requests](https://img.shields.io/github/issues-pr/FilippoGuardassoni/spotify_hitsong)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![contributors](https://img.shields.io/github/contributors/FilippoGuardassoni/spotify_hitsong) 
![codesize](https://img.shields.io/github/languages/code-size/FilippoGuardassoni/spotify_hitsong)

# Project Overview

In this paper, we analyzed US presidential elections focusing on economic and incumbency variables. We used the equations in Fair’s research (2009) as the base of our analyses. The equations are updated incorporating new data available as of December 2020, additional variables are introduced, and different model approaches are compared in order to use a reliable method to predict US elections as well as to make inferences about economic and political issues. Double-Selection Lasso is individuated as the best model approach among selected others for its reduced errors characteristic. Lastly, its capacity to provide uniform causal inferences increases the statistical power of our analysis.


# Installation and Setup

## Codes and Resources Used
- Stata

# Data
The data is collected from U.S. Government websites

## Source Data & Data Acquisition
Every dataset was gathered from official sources of the US government and other reliable affiliates. Having this in mind, we must say that Fair uses quarterly data that is annualized to compute the coefficient as well as he considered the US as a whole country. In our analysis, we consider each state of the US separately (since we are studying presidential elections, we treated Washington D.C as separated country like in the electoral system). This approach didn’t allow us to deal with quarterly data since it was available only for a small part of the considered period. Furthermore, datasets such as unemployment rate and demographics started to be collected stately only from recent years as well. Subsequently, the data was re-modeled using panel data layout as this allowed us to detect more information more accurately (i.e., more degrees of freedom, more variability and more statistical effects). After merging the datasets from different years and removing superfluous variables, we computed the original equation estimators DPER, DUR, I, G, P and Z, but using different time criteria (quarters were\ interpreted as years, i.e., 15 quarters is equal to 4 years). Having imported the dataset of the original variables, a closer assessment can be executed to search for insights before the analysis.


# Project structure
```bash
├── dataset
│   ├── Economics
│   |   ├── emp-unemployment.xls
│   |   ├── emp-unemployment.xlsm
│   |   ├── emp-unemployment.xlsx
│   ├── GDP
│   |   ├── Nominal GDP
│   |   |   ├── Annual
│   |   |   |   ├── Nominal  GDP 1997-2000.csv
│   |   |   |   ├── Nominal GDP 2001-2004.csv
│   |   |   |   ├── Nominal GDP 2010-2014.csv
│   |   |   |   ├── Nominal GPD 2005-2009.csv
│   |   |   |   ├── Nominal GPD 2015-2019.csv
│   |   |   ├── Quarters
│   |   |   |   ├── Quarterly Nominal GDP 2005-2007.csv
│   |   |   |   ├── Quarterly Nominal GDP 2008-2010.csv
│   |   |   |   ├── Quarterly Nominal GDP 2011-2013.csv
│   |   |   |   ├── Quarterly Nominal GDP 2014-2016.csv
│   |   |   |   ├── Quarterly Nominal GDP 2017-2020.csv
│   |   ├── Real GDP
│   |   |   ├── Annual
│   |   |   |   ├── Real GDP 1976-1996.csv
│   |   |   |   ├── Real GDP 1997-2000.csv
│   |   |   |   ├── Real GDP 2001-2005.csv
│   |   |   |   ├── Real GDP 2006-2010.csv
│   |   |   |   ├── Real GDP 2011-2015.csv
│   |   |   |   ├── Real GDP 2016-2019.csv
│   |   |   ├── Quarters
│   |   |   |   ├── Quarterly Real GDP 2005-2007.csv
│   |   |   |   ├── Quarterly Real GDP 2008-2010.csv
│   |   |   |   ├── Quarterly Real GDP 2011-2013.csv
│   |   |   |   ├── Quarterly Real GDP 2014-2016.csv
│   |   |   |   ├── Quarterly Real GDP 2017-2020.csv
│   |   ├── GDP Dataset from orginal paper.txt
│   ├── US Population
│   ├── Vote by US State/dataverse_files
│   ├── Additional Variables.csv
│   ├── electoral votes 1980-2016.csv
│   ├── variables.csv
├── report
│   ├── uk_house _market_report.pdf
├── img
│   ├── headerheader.jpg      
├── LICENSE
└── README.md
```

# Results and evaluation & Future work

Our model is very limited and there are empirical challenges that need to be addressed. First, the limitations concerning the data are multiple. For example, the data is just not available because it wasn’t collected, and this is a problem also regarding the merge of the datasets as they start from different years. Ideally, we should have simulated the missing data through other techniques or restricted the considered period. Also, the criteria to estimate Vp implies that we would know in advance the economic output of the country for the year of the election. This can be redefined finding a relevant interval to predict the elections with useful anticipation. Another important point is the splitting of the data. For a much more reliable model selection, we should have split the dataset into two samples, training and validation. Unfortunately, the splitting of a panel data should be made with the use of a cut-off value which is significant for the data we are analyzing. In our case, this value could have been the 2008 economic crisis. But again, this would have required a separate more detailed study. At this point, we could have applied the difference-in-difference statistical technique which would have allowed us to compare a treatment group with the control group. We could have computed the effects of the independent variable on the dependent variable but without the time effects. The other main factor is the variables we considered as we might want to investigate more (also with the help of other studies) what influences elections both from an economic and a social-psychological perspective. This is because we can’t actually know all the variables useful to forecast the elections, but we can select more variables from different reasonings. 

![image](https://github.com/FilippoGuardassoni/usa_elections/assets/85356795/d28328df-3388-4bae-bea1-386afc25925c)


# Acknowledgments/References
See report/song_hit_prediction.pdf for references.

# License
For this github repository, the License used is [MIT License](https://opensource.org/license/mit/).
