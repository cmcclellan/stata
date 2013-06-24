* New Jersey
* 6/21/2013 - cmk


/*

VERY IMPORTANT
finish adapting this script from the normal model

*/

* setup

version 10
clear
set memory 2g

set seed 48014
set sortseed 926841

* USER INPUT:

* path of working directory (should include subfolder called "explore")
global workingdirectory "S:\2013\Models\General_Public\NJ min wage"

* name of response data
global responsedata "minwage.dta"

* name of dependent variable
global depvar "amendment_vote"

* union membership data
global unionmembership "S:\analytic_files\NJ\nj_qtool_aflciomembers_anid.dta"


**** zzz    Change this
* enhanced analytics data (should be sorted on ANID)
global enhanalytics "S:\analytic_files\NJ\ENH3_NJ-2013-2.0.dta"

* list of variables we want to keep from union membership data
global keepunion "internationalname memtypestat union_category_col"

* enhanced analytics: list of categorical variables for exploratory analysis (that we want to keep)
global enhcategorical "ca_deceased	ca_race	ca_ethnicity	ca_religion	ca_gender	ca_partyaffiliation	ca_permanentabsenteevoter	ca_voterstatus	ca_partyregstate	cb_mailaddressisdifferent	cb_mailaddressmailable	cb_regaddressmailable	cb_badmailaddress	cb_badregaddress	cb_foreignmailaddress	cb_regaddressiswalkable	co_actvbank	co_compownr	co_contbhlt	co_contbpol	co_contbrel	co_environm	co_equitest	co_findc	co_fitness	co_golf	co_hiticket	co_homeowns	co_homewrks	co_htia	co_invest	co_loctype	co_magazine	co_mailord	co_mr_prev	co_outdgrdn	co_outdoor	co_penshhld	co_smarstat	co_veteran	co_wlthfind	co_childtype	co_actvcnsr	co_ag0_11	co_ag0_17	co_ag0_5	co_ag12_17	co_ag18_24f	co_ag18_24m	co_ag18_34f	co_ag18_34m	co_ag18_44f	co_ag25_34f	co_ag25_34m	co_ag35_44f	co_ag35_44m	co_ag35_54f	co_ag35_54m	co_ag45_54f	co_ag45_54m	co_ag50plus	co_ag55_64f	co_ag55_64m	co_ag65plus	co_childcnt	co_inetuse	co_inetuseh	co_married	co_ownrent	co_revolver	di_countyfips	di_congressionaldistrict	di_statesenatedistrict	di_statehousedistrict	di_regcounty	di_nceccodesource	es_pre1996	es_n1996p	es_n1996g	es_n1998p	es_n1998g	es_n2000p	es_n2000g	es_n2001g	es_n2002p	es_n2002g	es_n2003g	es_n2004p	es_n2004g	es_n2005g	es_n2006p	es_n2006g	es_n2007g	es_n2008p	es_n2008g	es_n2009g	es_n2010p	es_n2010g	es_n2011g	es_n2012p	es_n2012g	es_countaem	es_countearly	es_countmail	es_countprim	es_countabsentee	es_anyprimary	es_evervoted	ge_division	hh1_children	hh1_womenunder35	hh1_women35to64	hh1_women65plus	hh1_menunder35	hh1_men35to64	hh1_men65plus	hh1_unkgender	hh1_unkageandgender	hh1_white	hh1_black	hh1_asian	hh1_hispanic	hh1_otherrace	hh1_dems	hh1_reps	hh1_mix	hh1_unreg	hh1_othunk	hh1_type	hh1_hhpartisanbehave	hh1_alttype	hh2_totalpersons	hh2_children	hh2_womenunder35	hh2_women35to64	hh2_women65plus	hh2_menunder35	hh2_men35to64	hh2_men65plus	hh2_unkgender	hh2_unkage	hh2_unkageandgender	hh2_black	hh2_asian	hh2_hispanic	hh2_otherrace	hh2_dems	hh2_reps	hh2_mix	hh2_unreg	hh2_othunk	hh2_type	hh2_hhpartisanbehave	hh2_alttype	id_beststate	id_firstseenon	id_lastseenon	sd_fd_imputed	sd_isteacher	sd_isschoolsupportstaff	sd_isschooladministrator	sd_ispilot	sd_isflightattendant	sd_ismechanic	sd_iscontroltowerop	sd_isaviationemployee	sd_isfarmer	sd_isdoctor	sd_isnurse	sd_ishunter	sd_isfisher	sd_ischildcare	sy_indpartbehave	sy_workcluster	sy_densitycluster	sy_religioncluster sy_deadwood"
* Cutting cuz they suck: co_occupatf	co_occupatm	
																																																																																																																																																																																		
* enhanced analytics: list of continuous variables for exploratory analysis (that we want to keep)																																																																																																																																																																																		
global enhscale "ca_age	ca_monthssinceaddrchg	cn_agemedad	cn_ahp65up	cn_e_asian	cn_e_black	cn_e_hisp	cn_hhchild	cn_hhmarcpl	cn_hhsglhhc	cn_huoopct	cn_ih_0_25k	cn_ih_50kup	cn_ih200kup	cn_inhh_med	cn_ipoverty		cn_rv_0_80k	cn_rv300kup	cn_rvmedoo	cn_scolgrad	cn_wo_bluc	cn_wo_whtc	cn_womgtpro	cn_wunemp	co_doc	co_dusize	co_find	co_homeage	co_lor	co_pic	co_ppi	co_wlthfindb	es_pctofelecs	es_votesperyear	es_genrate	es_primrate	hh1_totalpersons	hh1_totalhh2s	hh1_ageavg	hh1_agedev	hh1_unkage	hh1_votescore	hh2_diff	hh2_ageavg	hh2_agedev	hh2_white	hh2_votescore	re_totrt	re_mainrt	re_evanrt	re_cathrt	re_orthrt	re_otherrt	re_jewrt	re_islamrt	re_adjrate	sd_popchange00_08	sd_whitechange00_08	sd_hispchange00_08	sd_agechange00_08	sd_mortgagepastdueany	sd_mortgagepastdue30	sd_mortgagepastdue60	sd_mortgagepastdue90	sd_inforeclosure	sd_reowned	sd_subprimerate	sd_ownerocc	sy_partisanscore	sy_costofliving	sy_marriagescore	sy_voteprop2008	sy_educscore	sy_partisanraw	sy_turnoutraw	sy_huntermodel	sy_gunscore		sy_voteprop2010	sy_partisanraw2010	sy_partisanscore2010	ac_pctwhite	ac_pctblack	ac_pctindianalaskan	ac_pctasian	ac_pcthawaiianpacific	ac_pctotherrace	ac_pcthispaniclatino	ac_pctsingleparents	ac_pctnonfamily5plus	ac_pctmarriedwithkidsunder6	ac_pctsingleparentkidsunder6	ac_pctmarriedmen	ac_pctunmarriedwomen	ac_pctnonenglishspkrs	ac_pctnoncitizenforeignborn	ac_pctdrivealonetowork	ac_pctpublictranstowork	ac_pctbicyclewalktowork	ac_pctworkathome	ac_pcthourpluscommute	ac_pctalternativeworkschedule	ac_pctcarpool3plus	ac_pctenrolledcollegeplus	ac_pctwomeningradschool	ac_pctgraduatedegree	ac_pctarmedforces	ac_pctveterans	ac_pct1975to1990vets	ac_pctwomenworkingfulltime	ac_pctselfemployedincome	ac_pctinvestmentincome	ac_pctpublicassistance	ac_pctretirementincome	ac_pctmarriedcouplenotpoverty	ac_pctunmarriedpartnerhhs	ac_pctsamesexpartnerhhs	ac_pctwomen35plusunmarried	ac_pctarabancestry	ac_pcteuropeborn	ac_pctasianborn	ac_pctafricanborn	ac_pctoceaniaborn	ac_pctamericasborn	ac_pctmen25plusnohs	ac_pctwomen25plusnohs	ac_mediannonfamilyhhincome	ac_pctforeignbornnotinpoverty	ac_totaloccupiedhousingunits	ac_pctownoccupiedwhiteonly	ac_avgsizeownerhousing	ac_avgsizerenterhousing	ac_marriedcouplehomeowners	ac_marriedcouplerenters	ac_roomsperperson	ac_pctownermultiunit	ac_pctrenterdetached	ac_pctrenterattached	ac_pctrentermultiunit	ac_pcthomebuiltbefore1950	ac_medianyearofconstruction	ac_pctnovehicle	ac_pct50pctincomeforrent	ac_pctrentmobilehome	ac_pctownersincomeover150k sy_partisanscore2012 ac_pctmortgagelessthan500	*military* ac_pctincome100krent1250plus	ac_pcthhsincomelessthan25k	ac_pcthhsincome200kplus	ac_pctmenwithincomeloss	ac_pctwomen2kto12k	ac_pcthhsvalueover500k	ac_pcthhsnomortgage	ac_medianhhincome sy_ideologymodel"
* Cutting cuz you never use them:  ca_monthsbetweenregdates	ca_monthstoearliestreg	ca_monthstoreg	cn_a0005phh	cn_hs3pup	cn_rcmpioom	cn_syrsavg	cn_v2hh	co_bbc2004	co_dbiinh	er_bush00	er_bush04	er_dem04minus00	er_gore00	er_kerry04	er_nader00	er_nader04	er_nader04minus00	er_rep04minus00	er_obama08	er_other08	ac_ctypopestimate ac_pctusingwoodandcoal	ac_pctusingsolarpower	
																																																																																																																																																																						
* enhanced analytics: id variables
global enhid "state_name di_township	cb_mailaddresstype cb_regaddresstype di_uniqueprecinctcode	di_colgeo	di_codelevel	di_nceccode	ge_fips	ge_regaddresszip	ge_region	id_anhhid1	id_anhhid2	id_combkey	id_earliestregdate	id_regdate"

* user created: list of categorical variables for exploratory analysis yyy. The zzzz is there so that you are forced to come back and fix it
global catexplore "disaster mail_disaster reg_disaster dem rep urban rural exurban suburban"



/* we don't have this below the county level
* user created: list of continuous variables for exploratory analysis
global scaleexplore "demperfpct	obama12	obama08	kerry04	gore00	menendez12	lautenberg08	menendez06	corzine09	corzine05 dpp_minus_corzine09"
*/


* name of final score
global probscore "support_amendment"

*USER INPUT: assemble response dataset (combine survey datasets, define a DV)

clear
cd "S:\2013\models\general_public\NJ min wage"
insheet using "NJ_min_wage_20130427_toanid-export.txt", clear

generate amendment_vote = .
replace amendment_vote = 1 if  col2_amendment_vote == "Yes"
replace amendment_vote = 0 if  col2_amendment_vote == "No"

tab  col2_amendment_vote amendment_vote , m

quantiles sy_partisanscore2012, gen(test_ps) n(5)
bysort amendment_vote : tab test_ps , su(sy_partisanscore2012)
bysort test_ps: su sy_partisanscore2012

keep anid amendment_vote
duplicates drop anid, force
sort anid
save minwage.dta, replace






clear
cd "$workingdirectory"


* load response file, set universe

use $responsedata
drop if missing($depvar)

* REMINDER: CHECK YOUR COUNT TO MAKE SURE YOU HAVE APPROPRIATE # OF CASES
count

* REMINDER: MANUALLY CHECK MERGES FOR ANY ISSUES WITH DUPLICATES, ETC

duplicates drop anid, force 
count

* USER INPUT: merge in custom fields
 



* merge in union membership data
sort anid
merge anid using "$unionmembership", sort nokeep keep("$keepunion")
tab _merge
drop _merge



* merge in enhanced analytics data
sort anid
merge anid using "$enhanalytics", nokeep keep("$enhcategorical" "$enhscale" "$enhid")
tab _merge, m
drop _merge




/* zzz there is no ncec code for NJ. Bummer
rename di_nceccode nceccode

sort nceccode
merge nceccode using "S:\2012\Models\General_Public\VA\NCEC_Data_VA.dta", nokeep
tab _merge
drop _merge



* USER INPUT: load in custom data sets

foreach var of varlist  demperfpct	obama12	obama08	kerry04	gore00	menendez12	lautenberg08	menendez06	corzine09	corzine05 {
replace `var' = 0 if missing(`var')
}
*/



*** zzz bring in the county election info.
sort di_countyfips
merge di_countyfips using "S:\2013\models\general_public\NJ\county_perf.dta", nokeep
tab _merge
drop _merge

*** zzz bring in FEMA zips

split ge_regaddresszip, p("-")
drop ge_regaddresszip  ge_regaddresszip2
rename ge_regaddresszip1 reg_zip5


/*
split ge_mailaddresszip, p("-")
drop ge_mailaddresszip  ge_mailaddresszip2
rename ge_mailaddresszip1 mail_zip5
*/


sort reg_zip5
merge reg_zip5 using "S:\2013\models\general_public\NJ\fema_reg_zip.dta", nokeep
tab _merge
gen reg_disaster = 0
replace reg_disaster = 1 if _merge == 3
drop _merge

/*
sort mail_zip5
merge mail_zip5 using "S:\2013\models\general_public\NJ\fema_mail_zip.dta", nokeep
gen mail_disaster = 0
replace mail_disaster = 1 if _merge == 3
drop _merge
*/

gen disaster = 0
replace disaster = 1 if reg_disaster == 1


* merge in religion, fiscal policy and obama scores
sort anid
merge anid using "S:\analytic_files\NJ\catalist models\afl_models_nj.dta", nokeep
tab _merge
drop _merge


* USER INPUT: custom recodes

generate unionmember = 0
replace unionmember = 1 if missing(memtypestat)==0



gen region_shore = 0
gen region_nyc =0
gen region_philly =0
gen region_west = 0

replace region_shore = 1 if di_countyfips == "001"
replace region_nyc = 1 if di_countyfips == "003"
replace region_philly = 1 if di_countyfips == "005"
replace region_philly = 1 if di_countyfips == "007"
replace region_shore = 1 if di_countyfips == "009"
replace region_shore = 1 if di_countyfips == "011"
replace region_nyc = 1 if di_countyfips == "013"
replace region_philly = 1 if di_countyfips == "015"
replace region_nyc = 1 if di_countyfips == "017"
replace region_west = 1 if di_countyfips == "019"
replace region_west = 1 if di_countyfips == "021"
replace region_nyc = 1 if di_countyfips == "023"
replace region_shore = 1 if di_countyfips == "025"
replace region_nyc = 1 if di_countyfips == "027"
replace region_shore = 1 if di_countyfips == "029"
replace region_nyc = 1 if di_countyfips == "031"
replace region_philly = 1 if di_countyfips == "033"
replace region_nyc = 1 if di_countyfips == "035"
replace region_west = 1 if di_countyfips == "037"
replace region_nyc = 1 if di_countyfips == "039"
replace region_west = 1 if di_countyfips == "041"

gen buono_seat = (di_statesenatedistrict == 18)




gen cd_01 = di_congressionaldistrict == 1

/*
gen corzine_christie = 0
replace corzine_christie = 1 if corzinevote == 1 & $depvar == 0

gen obama_christie = 0
replace obama_christie = 1 if pres_vote == 1 & $depvar == 0
*/

* standard recodes

gen whiteMale = ((ca_race == "C" | ca_race == "J") & ca_gender == "M")
gen whiteFemale = ((ca_race == "C" | ca_race == "J") & ca_gender == "F")
gen blackMale = (ca_race == "B" & ca_gender == "M")
gen blackFemale = (ca_race == "B" & ca_gender == "F")
gen hispanicMale = (ca_race == "H" & ca_gender == "M")
gen hispanicFemale = (ca_race == "H" & ca_gender == "F")
gen DemInHH = hh1_dems >= 1
gen RepInHH = hh1_reps >= 1
gen DemandRepHH = hh1_hhpartisanbehave == "DR"
gen OthersHH = hh1_hhpartisanbehave == "O" | hh1_hhpartisanbehave == "DO" | hh1_hhpartisanbehave == "RO"
gen DemOnlyHH = hh1_hhpartisanbehave == "D" 
gen RepOnlyHH = hh1_hhpartisanbehave == "R"
gen Oneormorechild = hh1_children >= 1
gen Twoormorechild = hh1_children > 1
gen Threeormorepersons = hh1_totalpersons > 2
gen OnlypersoninHH = hh1_totalpersons == 1
gen IndOnlyHH = hh1_hhpartisanbehave == "O"

gen military = 0
replace military = 1 if ce_pctcareermilitary >= .2
replace military = 1 if cb_regaddresstype == "M"
replace military = 1 if cb_mailaddresstype == "M"


gen syreligB = (sy_religioncluster == "B")
gen syreligE = (sy_religioncluster == "E")
gen syreligF = (sy_religioncluster == "F")
gen syreligG = (sy_religioncluster == "G")
gen syreligJ = (sy_religioncluster == "J")
gen syreligK = (sy_religioncluster == "K")
gen male = (ca_gender == "M")
gen female = (ca_gender == "F")
gen under35 = (ca_age <= 35)
gen between36and50 = (ca_age > 35 & ca_age <= 50)
gen between50and64 = (ca_age > 50 & ca_age < 65)
gen over65 = (ca_age >= 65)
gen youngMen = male*under35
gen middleMen = male*between36and50
gen oldMen = male*between50and64
gen seniorMen = male*over65
gen youngWomen = female*under35
gen middleWomen = female*between36and50
gen oldWomen = female*between50and64
gen seniorWomen = female*over65
gen white = (ca_race == "C" | ca_race == "J")
gen black = (ca_race == "B")
gen hispanic = (ca_race == "H")
gen other = (ca_race != "C" & ca_race != "J" & ca_race != "B" & ca_race != "H")
gen youngBlack = black*under35
gen middleBlack = black*between36and50
gen oldBlack = black*between50and64
gen seniorBlack = black*over65
gen youngHispanic = hispanic*under35
gen middleHispanic = hispanic*between36and50
gen oldHispanic = hispanic*between50and64
gen seniorHispanic = hispanic*over65
gen youngWhite = white*under35
gen middleWhite = white*between36and50
gen oldWhite = white*between50and64
gen seniorWhite = white*over65
gen youngBlackMen = black*under35*male
gen middleBlackMen = black*between36and50*male
gen oldBlackMen = black*between50and64*male
gen seniorBlackMen = black*over65*male
gen youngHispanicMen = hispanic*under35*male
gen middleHispanicMen = hispanic*between36and50*male
gen oldHispanicMen = hispanic*between50and64*male
gen seniorHispanicMen = hispanic*over65*male
gen youngWhiteMen = white*under35*male
gen middleWhiteMen = white*between36and50*male
gen oldWhiteMen = white*between50and64*male
gen seniorWhiteMen = white*over65*male
gen youngBlackWomen = black*under35*female
gen middleBlackWomen = black*between36and50*female
gen oldBlackWomen = black*between50and64*female
gen seniorBlackWomen = black*over65*female
gen youngHispanicWomen = hispanic*under35*female
gen middleHispanicWomen = hispanic*between36and50*female
gen oldHispanicWomen = hispanic*between50and64*female
gen seniorHispanicWomen = hispanic*over65*female
gen youngWhiteWomen = white*under35*female
gen middleWhiteWomen = white*between36and50*female
gen oldWhiteWomen = white*between50and64*female
gen seniorWhiteWomen = white*over65*female
gen votedprim = es_anyprimary == "Y"
gen evervoted = es_evervoted == "Y"
gen high_catholic = re_cathrt <= 250
gen high_evan = re_evanrt <= 250
gen high_mainlne = re_mainrt <= 250
gen high_adherence = re_adjrate <= 750
gen high_hisp_growth = sd_hispchange00_08 >= 1.5
gen white_high_hisp_growth = high_hisp_growth == 1 & white == 1
gen dem_imputed = sy_indpartbehave == "D"
gen rep_imputed = sy_indpartbehave == "R"
gen ind_imputed = sy_indpartbehave == "O"
gen tix_splitter_imputed = sy_indpartbehave == "M"
gen dem = ca_partyaffiliation == "DEM"
gen rep = ca_partyaffiliation == "REP"
gen ind = ca_partyaffiliation == "LIB" | ca_partyaffiliation == "NPA" | ca_partyaffiliation == "OTH" | ca_partyaffiliation == "UNK"
gen dem_rep_sum = (hh1_dems - hh1_reps)


***special interactions 
gen womenwithchildren=Oneormorechild * female
gen womenwithchildren_modeled = (female == 1 & (Oneormorechild == 1 | (co_ag0_17 >= 5 & co_ag0_17 != .)))

/*
gen educscorewomen= sy_educscore * female
gen educscorechildren=sy_educscore * Oneormorechild
gen educscorewomenchildren= female* Oneormorechild *sy_educscore
*/




foreach var of varlist sy_partisanscore2012 sy_partisanscore2010 sy_partisanraw sy_partisanraw2010   sy_costofliving sy_marriagescore sy_educscore sy_huntermodel sy_gunscore {

gen `var'_mid=`var'
su `var' 
if (`r(max)'> 5) {  
recode `var'_mid (min/32=0)(32.10/66=1)(66/max=0)
}

else {
recode `var'_mid (min/.320=0)(.321/.66=1)(.66/max=0)
}
su `var' if `var'_mid==1
}



foreach var of varlist  sy_partisanscore2012 sy_partisanscore2010 sy_partisanscore sy_costofliving sy_marriagescore sy_educscore sy_huntermodel sy_gunscore {

gen `var'_low=`var'
su `var' 
if (`r(max)'> 5) {  
recode `var'_low (min/32=1)(32.10/66=0)(66/max=0)
}

else {
recode `var'_low (min/.320=1)(.321/.66=0)(.66/max=0)
}
su `var' if `var'_low==1
}



foreach var of varlist  sy_partisanscore2012 sy_partisanscore2010 sy_partisanscore sy_costofliving sy_marriagescore sy_educscore sy_huntermodel sy_gunscore {

gen `var'_high=`var'
su `var' 
if (`r(max)'> 5) {  
recode `var'_high (min/32=0)(32.10/66=0)(66/max=1)
}

else {
recode `var'_high (min/.320=0)(.321/.66=0)(.66/max=1)
}
su `var' if `var'_high==1
}


foreach var of varlist *_low *_mid *_high {
replace `var' = 0 if missing(`var')
}


gen age_18_39=.
replace age_18_39=0 if ca_age!=.
replace age_18_39=1 if ca_age>17 & ca_age<40


gen age_40_49=.
replace age_40_49=0 if ca_age!=.
replace age_40_49=1 if ca_age>39 & ca_age<50


gen age_50_64=.
replace age_50_64=0 if ca_age!=.
replace age_50_64=1 if ca_age>49 & ca_age<65

gen age_65_plus=.
replace age_65_plus=1 if ca_age>64 
replace age_65_plus=. if ca_age==.
replace age_65_plus=0 if age_65_plus==.


/*
foreach var of varlist  age_18_39 age_40_49 age_50_64 age_65_plus{
gen marriagescore_`var'_fe=sy_marriagescore * `var' * female
}
*/

* gen partisan_dem_primary=primary_voter * sy_partisanscore2012


recode ac_pctenrolledcollegeplus .2/max=1 else=0, gen(collegetown)

gen SY_DENSITYCLUSTER_col=sy_densitycluster
replace SY_DENSITYCLUSTER_col = "0" if SY_DENSITYCLUSTER_col == "Z"
destring SY_DENSITYCLUSTER_col, replace
recode SY_DENSITYCLUSTER_col 1/4=1 5/6=2 7=3 8=2 9/11=4
label define SY_DENSITYCLUSTER_col 1"Urban" 2"Suburban" 3"Exurban" 4"Rural" 
label values SY_DENSITYCLUSTER_col SY_DENSITYCLUSTER_col

xi i.SY_DENSITYCLUSTER_col
rename _ISY_DENSIT_2 suburban
rename _ISY_DENSIT_3 exurban
rename _ISY_DENSIT_4 rural
gen urban=( SY_DENSITYCLUSTER_col==1 )

foreach var of varlist suburban exurban rural urban {
replace `var' = 0 if missing(`var')
}




* exploratory analysis (crosstabs, lowess, correlations)

* A cut version of enhanced analytics files for the exploratory analysis. this is because I dropped the zip variables above and don't want that shit in my exanal
global enhscale "ca_age	ca_monthsbetweenregdates	ca_monthssinceaddrchg	ca_monthstoearliestreg	ca_monthstoreg	cn_a0005phh	cn_agemedad	cn_ahp65up	cn_e_asian	cn_e_black	cn_e_hisp	cn_hhchild	cn_hhmarcpl	cn_hhsglhhc	cn_hs3pup	cn_huoopct	cn_ih_0_25k	cn_ih_50kup	cn_ih200kup	cn_inhh_med	cn_ipoverty	cn_rcmpioom	cn_rv_0_80k	cn_rv300kup	cn_rvmedoo	cn_scolgrad	cn_syrsavg	cn_v2hh	cn_wo_bluc	cn_wo_whtc	cn_womgtpro	cn_wunemp	co_bbc2004	co_dbiinh	co_doc	co_dusize	co_find	co_homeage	co_lor	co_pic	co_ppi	co_wlthfindb	er_bush00	er_bush04	er_dem04minus00	er_gore00	er_kerry04	er_nader00	er_nader04	er_nader04minus00	er_rep04minus00	er_obama08	er_other08	es_pctofelecs	es_votesperyear	es_genrate	es_primrate	hh1_totalpersons	hh1_totalhh2s	hh1_ageavg	hh1_agedev	hh1_unkage	hh1_votescore	hh2_diff	hh2_ageavg	hh2_agedev	hh2_white	hh2_votescore	re_totrt	re_mainrt	re_evanrt	re_cathrt	re_orthrt	re_otherrt	re_jewrt	re_islamrt	re_adjrate	sd_popchange00_08	sd_whitechange00_08	sd_hispchange00_08	sd_agechange00_08	sd_mortgagepastdueany	sd_mortgagepastdue30	sd_mortgagepastdue60	sd_mortgagepastdue90	sd_inforeclosure	sd_reowned	sd_subprimerate	sd_ownerocc	sy_partisanscore	sy_costofliving	sy_marriagescore	sy_voteprop2008	sy_educscore	sy_partisanraw		sy_huntermodel	sy_gunscore		sy_voteprop2010	sy_partisanraw2010	sy_partisanscore2010	ac_pctwhite	ac_pctblack	ac_pctindianalaskan	ac_pctasian	ac_pcthawaiianpacific	ac_pctotherrace	ac_pcthispaniclatino	ac_pctsingleparents	ac_pctnonfamily5plus	ac_pctmarriedwithkidsunder6	ac_pctsingleparentkidsunder6	ac_pctmarriedmen	ac_pctunmarriedwomen	ac_pctnonenglishspkrs	ac_pctnoncitizenforeignborn	ac_pctdrivealonetowork	ac_pctpublictranstowork	ac_pctbicyclewalktowork	ac_pctworkathome	ac_pcthourpluscommute	ac_pctalternativeworkschedule	ac_pctcarpool3plus	ac_pctenrolledcollegeplus	ac_pctwomeningradschool	ac_pctgraduatedegree	ac_pctarmedforces	ac_pctveterans	ac_pct1975to1990vets	ac_pctwomenworkingfulltime	ac_pctselfemployedincome	ac_pctinvestmentincome	ac_pctpublicassistance	ac_pctretirementincome	ac_pctmarriedcouplenotpoverty	ac_pctunmarriedpartnerhhs	ac_pctsamesexpartnerhhs	ac_pctwomen35plusunmarried	ac_pctarabancestry	ac_pcteuropeborn	ac_pctasianborn	ac_pctafricanborn	ac_pctoceaniaborn	ac_pctamericasborn	ac_pctmen25plusnohs	ac_pctwomen25plusnohs	ac_mediannonfamilyhhincome	ac_pctforeignbornnotinpoverty	ac_totaloccupiedhousingunits	ac_pctownoccupiedwhiteonly	ac_avgsizeownerhousing	ac_avgsizerenterhousing	ac_marriedcouplehomeowners	ac_marriedcouplerenters	ac_roomsperperson	ac_pctownermultiunit	ac_pctrenterdetached	ac_pctrenterattached	ac_pctrentermultiunit	ac_pcthomebuiltbefore1950	ac_medianyearofconstruction	ac_pctnovehicle	ac_pct50pctincomeforrent	ac_pctrentmobilehome	ac_pctownersincomeover150k sy_partisanscore2012 	ac_pctmortgagelessthan500	*military* ac_pctusingwoodandcoal	ac_pctusingsolarpower	ac_pctincome100krent1250plus	ac_pcthhsincomelessthan25k	ac_pcthhsincome200kplus	ac_pctmenwithincomeloss	ac_pctwomen2kto12k	ac_pcthhsvalueover500k	ac_pcthhsnomortgage	ac_medianhhincome	ac_ctypopestimate"
*Cut for lack of observations: cn_popurban	sy_turnoutraw



set more off
capture log close
log using "explore\examine_pass1.txt", replace text
foreach var of varlist $enhcategorical $catexplore internationalname memtypestat union_category_col whiteMale-collegetown {
tab `var' , summarize($depvar) missing

capture noisily xi: regress $depvar i.`var'

} 
log close

foreach var of varlist $enhscale $scaleexplore {
lowess $depvar `var', logit
graph export "explore\lowess_`var'.png", replace
}

log using "explore\correlations.txt", replace text
foreach var of varlist $enhscale $catexplore $scaleexplore  whiteMale-collegetown {
corr $depvar `var' 
if abs(r(rho)) >= 0.08 { 
sum `var'
if r(sd) != 0{
display "`var'"
local IndependentVariables =  "`IndependentVariables'" + " " + "`var'"
}
}
}

display "`IndependentVariables'"
display wordcount("`IndependentVariables'")

log close
*/



* split into training and validation samples ("responseuniverse" flag becomes useful once you start scoring)

generate responseuniverse = 1 if missing($depvar)==0
generate rand = uniform() if responseuniverse==1
generate validate = 0 if responseuniverse==1
replace validate = 1 if rand < .2 & responseuniverse==1
drop rand
tab validate

** USER INPUT: make new vars   yyy

cap drop sy_partisanscore2012_bin5
gen sy_partisanscore2012_bin5 =.
replace sy_partisanscore2012_bin5 = 1 if sy_partisanscore2012 <= 20
replace sy_partisanscore2012_bin5 = 2 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 <=40
replace sy_partisanscore2012_bin5 = 3 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 <=60
replace sy_partisanscore2012_bin5 = 4 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 <=80
replace sy_partisanscore2012_bin5 = 5 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 

gen g2010r = (es_n2010p == "R")
gen g2008r = (es_n2008p == "R")
gen g2004r = (es_n2004p == "R")

gen hi_pscore_whites = (sy_partisanscore2012 >=70 & sy_partisanscore2012 != .)
gen white_dems = (ca_partyaffiliation == "DEM" & white == 1)
gen white_dems_100kplus = (white == 1 & ca_partyaffiliation == "DEM" & co_find >= 100000 & co_find != .)
gen white_dems_150kplus = (white == 1 & ca_partyaffiliation == "DEM" & co_find >= 150000 & co_find != .)
gen white_dems_70kplus = (white == 1 & ca_partyaffiliation == "DEM" & co_find >= 70000 & co_find != .)

gen uneducated_white_men = (male == 1 & sy_educscore <= .5 & white == 1)
gen uneducated_white_women = (female == 1 & sy_educscore <= .5 & white == 1)


/*
gen white_catholics_NJm = (white == 1 & white_catholic_model>= 17 & white_catholic_model!= .)
gen white_catholics_NJh = (white == 1 & white_catholic_model>= 20 & white_catholic_model!= .)

gen white_catholic_men_NJm = (white_catholics_NJm * male)
gen white_catholic_women_NJm = (white_catholics_NJm * female)
gen white_catholic_men_NJh = (white_catholics_NJh * male)
gen white_catholic_women_NJh = (white_catholics_NJh * female)
*/

gen Dem_Women = (dem * female)
gen Dem_Men = (dem * male)

gen hi_pscore_white_women = (hi_pscore_whites * female)
gen hi_pscore_white_men = (hi_pscore_whites * male)


**** fiscal policy correlates very, very strongly with both partisan score and obama support. Only 166 people with obamasupport scores of 50+ have sy_partisanscore2012 scores of 50-
**** not going to get anything out of it

/*
bank cards and comp owning seem to just be measuring wealth.
Equity is wonky, all over the place and non-sequential. Income better?
*/

cap drop a_*

*gen a_nonChristian_name = (ca_religion == "H" | ca_religion == "M" | ca_religion == "J" | ca_religion == "B" | ca_religion == "S")
*gen a_noComm_data = (co_actvbank == "U")
*gen a_has_bankcard = (co_actvbank == "Y") /* I'm a little worried that this (and equity) are just proxies for wealth - shouldwe be using them at all? */
*gen a_compowner = (co_compown == "Y")
*gen a_equity_200kplus = (co_equitest == "M" | co_equitest == "N" | co_equitest == "O")
*gen a_equity_90kplus = (co_equitest == "M" | co_equitest == "N" | co_equitest == "O" | co_equitest == "J" | co_equitest == "K" | co_equitest == "L")
*gen a_income_25kless = (co_findc == "A" | co_findc == "B" | co_findc == "C" | co_findc == "D")
*gen a_income_70kless = (co_findc == "A" | co_findc == "B" | co_findc == "C" | co_findc == "D" | co_findc == "E" | co_findc == "F" | co_findc == "G" | co_findc == "H" | co_findc == "I" | co_findc == "J" | co_findc == "K" | co_findc == "L")
*gen a_income_500kmore = (co_findc == "T")
*gen a_part40plus_dShore = (partisan40plus * disaster * region_shore)
*gen a_part60_80_dNYC = (partisan60_80 * disaster * region_nyc)
*gen a_disaster_whites = (white * disaster)
*gen a_high_pscore_disaster_whites = (a_disaster_whites == 1 & sy_partisanscore2012 >= 70 & sy_partisanscore2012 != .)
*gen a_high_pscore_whites = (sy_partisanscore2012 >= 70 & sy_partisanscore <= 100 & white == 1)
*gen a_golfer = (co_golf == "Y")
*gen a_fitness = (co_fitness == "Y")
*gen a_diy = (co_homewrks == "Y")
*gen a_hitech = (co_htia == "Y")
*gen a_investor = (co_invest == "Y") 		/* This is mostly just getting very wealthy peple */
*gen a_multi_dweller = (co_loctype == "M")
*gen a_single_family = (co_loctype == "S")
*gen a_magsub = (co_magazine == "Y")
*gen a_gardener = (co_outdgrdn == "Y")
*gen a_outdoorsy = (co_outdoor == "Y")
*gen a_single = (co_smarstat == "S")
*gen a_married = (co_smarstat == "M")
*gen a_marriedukn = (co_smarstat == "U")
*gen a_single_hh1 = (hh1_totalpersons == 1)
*gen a_worth_400mplus = (co_wlthfind == "A" | co_wlthfind == "B" | co_wlthfind == "C" | co_wlthfind == "D" | co_wlthfind == "E" | co_wlthfind == "F" | co_wlthfind == "G" )
*gen a_worth_100mless = (co_wlthfind == "N" | co_wlthfind == "O" | co_wlthfind == "P" | co_wlthfind == "Q" | co_wlthfind == "R" | co_wlthfind == "S" | co_wlthfind == "T")
*gen a_worth_20mless = (co_wlthfind == "R" | co_wlthfind == "S" | co_wlthfind == "T")
*gen a_no_credit_cards = (co_actvcnsr == 0)
*gen a_unlikely_int_user = (co_inetuse >= 8 &  co_inetuse <= 10)
*gen a_unlikely_heavy_int_user = (co_inetuseh  == 9 | co_inetuseh == 10)
*gen a_likely_renter = (co_ownrent == 0 | co_ownrent == 1 | co_ownrent == 2 | co_ownrent ==3 | co_ownrent == 4 | co_ownrent == 5)
*gen a_likely_revolver = (co_revolver == 0 | co_revolver == 1 | co_revolver == 2)
*gen a_Union_county = (di_countyfips == "039")
*gen a_GOP_primary_sum = g2010r + g2008r + g2004r
*gen a_freq_Prim = (es_countprim == 4)
*gen a_voted08_no9 = ((es_n2008g == "A" | es_n2008g == "Y") & (es_n2009g == "N"))
*gen a_voted08_no10 = ((es_n2008g == "A" | es_n2008g == "Y") & (es_n2010g == "N"))
* gen a_many_middle_women = (hh1_women35to64 >=2 & hh1_women35to64 <=7)
*gen a_1_35to64_manhh1 = (hh1_men35to64 == 1)
*gen a_1_senior_manhh1 = (hh1_men65plus == 1)
*gen a_1_man35plus_hh1 = (hh1_men65plus == 1 | hh1_men35to64 == 1)
*gen a_nowhitesinhh1 = (hh1_white == 0)
*gen a_mixed_hh1 = (hh1_totalpersons != hh1_white & hh1_totalpersons != hh1_black & hh1_totalpersons != hh1_asian & hh1_totalpersons != hh1_hispanic & hh1_totalpersons != hh1_otherrace)
*gen a_white_in_mixed_hh1 = (white * a_mixed_hh1)
*gen a_no_whites_in_hh1 = (hh1_white == 0)
*gen a_whitefamilies = (hh1_white >= 2 & hh1_white != . & white_only_hh1 == 1)
*gen a_hh1_ss = (hh1_type == "SS")
*gen a_single_ladies = (women == 1 & hh1_menunder == 0 & hh1_men35to == 0 & hh1_men65plus == 0)
*gen a_gen_group_hh1s = (hh1_type == "GR" | hh1_type == "GN")
*gen a_alt_mfp = (hh1_alttype == "MFP")
*gen a_family_plus = (a_gen_group_hh1s ==1 | a_alt_mfp == 1)
*gen a_married_children = (hh2_type == "MC")
gen a_mfsln = (hh2_alttype == "MFLSN")
*gen a_2012_registrants = (id_firstseenon == "2012-05-21" | id_firstseenon == "2012-07-23" | id_firstseenon == "2012-08-02" | id_firstseenon == "2012-08-28" | id_firstseenon == "2012-10-16")
*gen a_whiteCollar = (sy_workcluster == "13")
*gen a_traditionalFamiles = (sy_workcluster == "7")


cap drop obama12_minus_gore00 medianHHIncome_100kunder hh1_totalpeople_low pastdue60_squared low_income_GOP
gen obama12_minus_gore00 = (obama12 - gore00)
gen medianHHIncome_100kunder = (ac_medianhhincome <= 100000 & ac_medianhhincome != .)
gen hh1_totalpeople_low = (hh1_totalpersons <= 2 & hh1_totalpersons != .)
gen pastdue60_squared = (sd_mortgagepastdue60^2)
gen low_income_GOP = (ca_partyaffiliation == "REP" & co_find <= 25000 & co_find != .)

gen likely_homeowner = (co_ownrent == 9 | co_ownrent == 8 | co_ownrent == 7)

/*
gen a_ever_Dem_Prim = 0
foreach var of varlist  es_n1996p es_n1998p es_n2000p es_n2002p es_n2004p es_n2006p es_n2008p es_n2010p {
replace a_ever_Dem_Prim = 1 if `var' == "DEM"
replace a_ever_Dem_Prim = 1 if `var' == "D"
}


gen a_ever_Rep_Prim = 0
foreach var of varlist  es_n1996p es_n1998p es_n2000p es_n2002p es_n2004p es_n2006p es_n2008p es_n2010p {
replace a_ever_Rep_Prim = 1 if `var' == "REP"
replace a_ever_Rep_Prim = 1 if `var' == "R"
}
*/

cap rename a_hh1_ss hh1_ss
cap rename a_gen_group_hh1s gen_group_hh1s
cap rename a_1_man35plus_hh1 _1_man35plus_hh1

cap rename a_white_only_hh1 white_only_hh1
cap rename a_no_whites_in_hh1 no_whites_in_hh1
*rename a_voted08_no9 voted08_no9
*rename a_voted08_no10 voted08_no10


*** yyy this renames variables made above that are needed for other variables in the production so they don't show up


/*
use male not female
don't use the imputed party affiliation
*/


foreach var of varlist a_* {
replace `var' = 0 if missing(`var')
}

drop if missing(fiscalpolicy)

cap drop obs
gen obs = _n


*** Now showing: Pass 6

* USER INPUT: macro for list of variables in regressions. fill out these based on theory and your exploratory analysis
* two categories: stuff motivated by theory, and "kitchen sink" informed by exploratory analysis.
* "kitchen sink" has a lower p value threshhold than theory vars
global theoryvars "fiscalpolicy"
stepwise, pr(.01): logit $depvar $theoryvars
*** getting rid of:


/*
rename a_voted08_no10 voted_08_no10
rename a_voted08_no9 voted_08_no9

*** new variables based on R analysis:
obamasupport obamasup64plus obamasup85plus obamasup64_85 obamasup14minus r_counties r_ethno_split r_ethno_counties r_ethno_Notcounties r_ethno_obasup64plus r_ethno_obasup85plus  r_ethno_counties_oba64plus r_ethno_counties_oba64minus r_ethno_Notcounties_oba64plus r_ethno_Notcounties_oba64minus r_ethno_counties_oba85plus r_ethno_counties_oba85minus r_ethno_counties_oba64_84 r_ethno_Notcounties_oba85plus r_ethno_Notcounties_oba85minus r_ethno_Notcounties_oba64_85 r_equit_hisupsplit r_equit_sup64plus_y r_equit_sup64minus_Y r_equit_sup64plus_n r_equit_sup64minue_n r_equit_sup85plus_y r_equit_sup85minus_y r_equit_sup85plus_n r_equit_sup85minus_n r_equit_sup64_85_y r_equit_sup64_85_n
*/



* "Kitchen Sink Vars"
global kitchensinkvars "a_* cn_inhh_med	whiteMale sy_costofl~g sd_mortgagepastdueany"
** non- a_* that you're dropping for being in lockterm: 	
** non- a_*s that you're dropping for colinearity:   
** a_*s that you're dropping for colinearity: 
** a_*s that you're dropping cuz you don't like them:

cap rename a_single_hh1 single_hh1



* misschk what goes into regression



misschk $theoryvars 
misschk $kitchensinkvars 

foreach var of varlist $kitchensinkvars {
capture drop avg
egen avg = mean(`var')
replace `var' = avg if missing(`var')
}
drop avg

*drop

local pass = 6

cap log close
log using "Coeff_Validation_pass`pass'.txt", replace text
* regression
stepwise, pr(0.02) lockterm1:logit $depvar ($theoryvars) $kitchensinkvars if validate==0


capture drop $probscore
cap drop val_
predict $probscore

* validation

discrim lda $probscore if validate==1, group ($depvar)
*classification $probscore if validate==1



quantiles $probscore if validate==1, gen(val_) n(5)

tab val_ $depvar, row

rocfit $depvar $probscore if validate==1, cont(10)
rocplot
graph export "roccurve_pass`pass'.png", replace

lowess $depvar $probscore if validate==1, ylabel(0(.2)1, grid) xlabel(0(.2)1, grid) addplot(function y = x, legend(off))
graph export "lowess_pass`pass'.png", replace

roccomp $depvar sy_partisanscore2012 fiscalpolicy $probscore if validate == 1, graph summary
graph export "roccomp_pass`pass'.png", replace


** Lift

*label define bins 1 "0-30" 2 "30-70" 3 "70-100" 

foreach var of varlist $probscore {
capture drop `var'_bin
gen `var'_bin = .
replace `var'_bin = 1 if `var'<= .30
replace `var'_bin = 2 if `var' >.30 & `var' <= .70
replace `var'_bin = 3 if `var' > .70
label values `var'_bin bins 
}

foreach var of varlist sy_partisanscore2012{
capture drop `var'_bin
gen `var'_bin = .
replace `var'_bin = 1 if `var'<= 30
replace `var'_bin = 2 if `var' >30 & `var' <= 70
replace `var'_bin = 3 if `var' > 70
replace `var'_bin = . if missing(`var')
label values `var'_bin bins
}

cap drop support_bin5
gen support_bin5 = .
replace support_bin5 = 1 if $probscore <=.2
replace support_bin5 = 2 if missing(support_bin5) & $probscore <=.4
replace support_bin5 = 3 if missing(support_bin5) & $probscore <=.6
replace support_bin5 = 4 if missing(support_bin5) & $probscore <=.8
replace support_bin5 = 5 if missing(support_bin5) & $probscore <=1

cap drop sy_partisanscore2012_bin5
gen sy_partisanscore2012_bin5 =.
replace sy_partisanscore2012_bin5 = 1 if sy_partisanscore2012 <= 20
replace sy_partisanscore2012_bin5 = 2 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 <=40
replace sy_partisanscore2012_bin5 = 3 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 <=60
replace sy_partisanscore2012_bin5 = 4 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 <=80
replace sy_partisanscore2012_bin5 = 5 if missing(sy_partisanscore2012_bin5) & sy_partisanscore2012 

tab support_amendment_bin sy_partisanscore2012_bin if validate == 1, row

tab sy_partisanscore2012_bin5 $depvar if validate == 1, row

tab support_bin5 $depvar if validate == 1, row

log close

cap log close
log using "classifications.txt", replace text


discrim lda $probscore if validate==1, group ($depvar)

save model, replace




******** Scoring *********

global forscoring "sy_partisanscore2012 ca_race ca_gender cn_inhh_med sy_costofliving sd_mortgagepastdueany"

clear
cd "$workingdirectory"

set mem 10g
use model
keep anid $depvar state responseuniverse validate
sort anid
merge anid using "$enhanalytics", keep($forscoring)
tab _merge
drop _merge

sort anid
merge anid using "S:\analytic_files\NJ\catalist models\afl_models_nj.dta", nokeep
tab _merge
drop _merge

gen a_whiteMale = ((ca_race == "C" | ca_race == "J") & ca_gender == "M")


foreach var of varlist a_* {
replace `var' = 0 if missing(`var')
}

* select variables that went into your model

global kitchensinkvars "fiscalpolicy cn_inhh_med sy_costofliving sd_mortgagepastdueany a_whiteMale"


* misschk what goes into regression
misschk $kitchensinkvars

foreach var of varlist $kitchensinkvars {
capture drop avg
egen avg = mean(`var')
replace `var' = avg if missing(`var')
}

* regression 
logit $depvar $kitchensinkvars if validate==0

predict $probscore

inspect $probscore
gen support = round($probscore*100)
drop $probscore
rename support $probscore


foreach var of varlist $probscore sy_partisanscore2012{
capture drop `var'_bin
gen `var'_bin = .
replace `var'_bin = 1 if `var'<= 30
replace `var'_bin = 2 if `var' >30 & `var' <= 70
replace `var'_bin = 3 if `var' > 70
replace `var'_bin = . if missing(`var')
label values `var'_bin bins
}

tab support_amendment_bin  sy_partisanscore2012_bin, row


format anid %20.0g
keep anid state $probscore 
save NJ_Minimum_Wage_Support.dta, replace
outsheet using NJ_Min_Wage_Support.txt, replace




