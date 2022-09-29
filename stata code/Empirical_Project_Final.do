//clear
//log using empiricalProject, text replace
*IMPORTING DATASET AND SET PANEL DATA
//import delimited "...", encoding(UTF-8) 
encode state, gen(state1)
label variable state "State Code"
label variable year "Election Year"
label variable vp "Democratic Share"
label variable i "Incumbent Party"
label variable dper "Incumbent President Running Again"
label variable dper "Incumbent Party President Running Again"
label variable dur "Consecutive Terms"
label variable g "GDPC Growth Rate"
label variable p "GDPD Absolute Growth Rate"
label variable z "Year Count G>3.2%"
label variable state1 "State"
xtset state1 year, yearly
drop if year == 1976
*EXPLORING PANEL DATASET
xtline vp, overlay
xtline g, overlay
xtline p, overlay
*EXPLORING FIXED EFFECTS: HETEROGENEITY ACROSS STATES
bysort state1: egen vp_mean=mean(vp)
twoway scatter vp state1, msymbol(circle_hollow) || connected vp_mean state1, msymbol(diamond)
*MULTIPLE REGRESSION
sort state1 year
generate g_i=g*i
generate p_i=p*i
generate z_i=z*i
label var g_i "Original Equation G"
label var p_i "Original Equation P"
label var z_i "Original Equation Z"
regress vp dper dur i g_i p_i z_i
estimates store ols
predict vp_ols
label variable vp_ols "Fitted Values OLS Regression"
rvfplot, yline(0) // Check for heteroskedasticity --> It is not
estat hettest // Additional test for heteroskedasticity --> False. Model is well-defined
twoway scatter vp vp_ols, mlabel(state1) || lfitci vp vp_ols, clstyle(p2) //plotting multiple regression
*FIXED EFFECTS USING LEAST SQUARE DUMMY VARIABLE MODEL (LSDV)
xi: regress vp dper dur i g_i p_i z_i i.state1
estimates store ols_fe
estimates table ols ols_fe, star stats(N)
predict vp_fe
label variable vp_fe "Fitted Values of vp using FE model"
rvfplot, yline(0)
predict residuals_fe, residuals
histogram residuals_fe, kdensity normal
separate vp, by(state1)
separate vp_fe, by(state1)
twoway scatter vp vp_fe, mlabel(state1) || lfitci vp vp_fe, clstyle(p2) //plotting fixed effects multiple regression
*CHECK JOINT SIGNFICANCE OF ECONOMIC VARIABLES WITH F-TESTS
correlate dper dur i g_i p_i z_i
*unrestricted regression
reg vp dper dur i g_i p_i z_i i.state1
*restricted regression
reg vp dper dur i i.state1
*F-TEST
di (1.45571096 - 1.29493679) / 3
di  1.29493679 / (453)
di .05359139/.00285858
di invFtail(3, 453, 0.05) // if it is smaller than model approved
di Ftail(3, 453, 18.747556) // if p value is < 0.5 than model approved
testparm i.state1 // poolability test
*reject null hypothesis. State-Fixed Effect Model Approved!
*ASSIGN STATE TO PARTY
generate assigned_party = "Republican"
label variable assigned_party "Assigned State based on vphat_fixed"
replace assigned_party = "Democratic" if vp_fe > .5
*ASSIGN ELECTORAL VOTES TO STATES AND PREDICT ELECTIONS
generate electoral_votes = 9
label variable electoral_votes "Electoral votes allocation based on 2010 census"
replace electoral_votes = 3 if state == "AK"
replace electoral_votes = 3 if state == "ND"
replace electoral_votes = 3 if state == "SD"
replace electoral_votes = 3 if state == "MT"
replace electoral_votes = 3 if state == "DE"
replace electoral_votes = 3 if state == "DC"
replace electoral_votes = 3 if state == "VT"
replace electoral_votes = 3 if state == "WY"
replace electoral_votes = 4 if state == "HI"
replace electoral_votes = 4 if state == "ID"
replace electoral_votes = 4 if state == "ME"
replace electoral_votes = 4 if state == "NH"
replace electoral_votes = 4 if state == "RI"
replace electoral_votes = 5 if state == "NE"
replace electoral_votes = 5 if state == "NM"
replace electoral_votes = 5 if state == "WV"
replace electoral_votes = 6 if state == "AR"
replace electoral_votes = 6 if state == "IA"
replace electoral_votes = 6 if state == "KS"
replace electoral_votes = 6 if state == "MS"
replace electoral_votes = 6 if state == "NV"
replace electoral_votes = 6 if state == "UT"
replace electoral_votes = 7 if state == "CT"
replace electoral_votes = 7 if state == "OK"
replace electoral_votes = 7 if state == "OR"
replace electoral_votes = 8 if state == "KY"
replace electoral_votes = 8 if state == "LA"
replace electoral_votes = 10 if state == "MD"
replace electoral_votes = 10 if state == "MN"
replace electoral_votes = 10 if state == "MO"
replace electoral_votes = 10 if state == "WI"
replace electoral_votes = 11 if state == "AZ"
replace electoral_votes = 11 if state == "IN"
replace electoral_votes = 11 if state == "MA"
replace electoral_votes = 11 if state == "TN"
replace electoral_votes = 12 if state == "WA"
replace electoral_votes = 13 if state == "VA"
replace electoral_votes = 14 if state == "NJ"
replace electoral_votes = 15 if state == "NC"
replace electoral_votes = 16 if state == "GA"
replace electoral_votes = 16 if state == "MI"
replace electoral_votes = 18 if state == "OH"
replace electoral_votes = 20 if state == "IL"
replace electoral_votes = 20 if state == "PA"
replace electoral_votes = 29 if state == "FL"
replace electoral_votes = 29 if state == "NY"
replace electoral_votes = 38 if state == "TX"
replace electoral_votes = 55 if state == "CA"
generate total_electoral_votes = electoral_votes if assigned_party == "Democratic"
label variable total_electoral_votes "Electoral Votes for Democratic by year"
separate  total_electoral_votes, by(year)
*use function total () to compute the total electoral_votes Democratic gained in that year
*if the total is greater than 270 the party won, otherwise lost
*MERGE DATASET WITH ADDITIONAL VARIABLES
*Data-->Combine Datasets-->Merge Two Datasets
*Add additional squared variable that might be significant and run global macros to ease the code writing
label variable ug "Unemployment Growth Rate"
label variable gender_m "Gender Male Share"
generate p_i2 = p_i^2
generate ug2 = ug^2
generate gender_m2 = gender_m^2
label variable p_i2 "Squared p_i"
label variable ug2 "Squared ug"
label variable gender_m2 "Squared gender_m2"
global X_original p_i z_i dper dur i
global X_additional ug gender_m p_i2 ug2 gender_m2
global X_effects _Istate1_2-_Istate1_51
*USE LASSO POST-SELECTION TO SELECT MEANINGFUL VARIABLES
lasso linear vp (g_i $X_effects) $X_original $X_additional, selection(adaptive) //exclusion of g_i and fixed effects from lasso penalty using adaptive selection
ereturn list
lassocoef
reg `e(post_sel_vars)' // regress y on variables selected by the lasso
predict vp_ps
predict residuals_ps, residuals
histogram residuals_ps, kdensity normal
estimates store lasso_ps
*DOUBLE SELECTION LASSO
lasso linear vp ($X_effects) $X_original $X_additional, selection(adaptive)
local Xy = "`e(allvars_sel)'"
lasso linear g_i ($X_effects) $X_original $X_additional, selection(adaptive)
local Xd = "`e(allvars_sel)'"
reg vp g_i `Xy' `Xd'
predict vp_ds
predict residuals_ds, residuals
histogram residuals_ds, kdensity normal
estimates store lasso_ds
*MODEL COMPARISON
estout ols ols_fe lasso_ps lasso_ds
lassogof ols ols_fe lasso_ps lasso_ds
Log close


