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


*** Now showing: Pass 3

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

local pass = 5

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

roccomp $depvar sy_partisanscore2012 $probscore if validate == 1, graph summary
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

/*
this is a ratchet way to find out which people were classified and how
you're going to have turn the output into something usable so that you can copy and paste in recodes
then you can finally find the malcontents who are being falsely classified and snoop on their specs
you need to gen obs = _n somewhere in order to get it to work. Do that after the last time that you drop people.
*/

estat list, misclassified

log close

**** This section is because we have a ton of false positive for buono support yyy

/*

gen misclassified = 0

replace misclassified = 1 if obs == 2
replace misclassified = 1 if obs == 3
replace misclassified = 1 if obs == 5
replace misclassified = 1 if obs == 15
replace misclassified = 1 if obs == 16
replace misclassified = 1 if obs == 17
replace misclassified = 1 if obs == 18
replace misclassified = 1 if obs == 20
replace misclassified = 1 if obs == 23
replace misclassified = 1 if obs == 24
replace misclassified = 1 if obs == 36
replace misclassified = 1 if obs == 39
replace misclassified = 1 if obs == 40
replace misclassified = 1 if obs == 53
replace misclassified = 1 if obs == 55
replace misclassified = 1 if obs == 57
replace misclassified = 1 if obs == 59
replace misclassified = 1 if obs == 60
replace misclassified = 1 if obs == 61
replace misclassified = 1 if obs == 62
replace misclassified = 1 if obs == 72
replace misclassified = 1 if obs == 86
replace misclassified = 1 if obs == 87
replace misclassified = 1 if obs == 94
replace misclassified = 1 if obs == 108
replace misclassified = 1 if obs == 111
replace misclassified = 1 if obs == 121
replace misclassified = 1 if obs == 125
replace misclassified = 1 if obs == 126
replace misclassified = 1 if obs == 129
replace misclassified = 1 if obs == 130
replace misclassified = 1 if obs == 135
replace misclassified = 1 if obs == 137
replace misclassified = 1 if obs == 141
replace misclassified = 1 if obs == 152
replace misclassified = 1 if obs == 153
replace misclassified = 1 if obs == 154
replace misclassified = 1 if obs == 158
replace misclassified = 1 if obs == 161
replace misclassified = 1 if obs == 166
replace misclassified = 1 if obs == 168
replace misclassified = 1 if obs == 170
replace misclassified = 1 if obs == 177
replace misclassified = 1 if obs == 181
replace misclassified = 1 if obs == 206
replace misclassified = 1 if obs == 207
replace misclassified = 1 if obs == 213
replace misclassified = 1 if obs == 228
replace misclassified = 1 if obs == 231
replace misclassified = 1 if obs == 239
replace misclassified = 1 if obs == 246
replace misclassified = 1 if obs == 247
replace misclassified = 1 if obs == 251
replace misclassified = 1 if obs == 253
replace misclassified = 1 if obs == 254
replace misclassified = 1 if obs == 255
replace misclassified = 1 if obs == 257
replace misclassified = 1 if obs == 260
replace misclassified = 1 if obs == 264
replace misclassified = 1 if obs == 265
replace misclassified = 1 if obs == 271
replace misclassified = 1 if obs == 275
replace misclassified = 1 if obs == 285
replace misclassified = 1 if obs == 286
replace misclassified = 1 if obs == 288
replace misclassified = 1 if obs == 289
replace misclassified = 1 if obs == 291
replace misclassified = 1 if obs == 296
replace misclassified = 1 if obs == 299
replace misclassified = 1 if obs == 301
replace misclassified = 1 if obs == 303
replace misclassified = 1 if obs == 309
replace misclassified = 1 if obs == 310
replace misclassified = 1 if obs == 313
replace misclassified = 1 if obs == 314
replace misclassified = 1 if obs == 315
replace misclassified = 1 if obs == 317
replace misclassified = 1 if obs == 318
replace misclassified = 1 if obs == 321
replace misclassified = 1 if obs == 327
replace misclassified = 1 if obs == 328
replace misclassified = 1 if obs == 335
replace misclassified = 1 if obs == 336
replace misclassified = 1 if obs == 338
replace misclassified = 1 if obs == 339
replace misclassified = 1 if obs == 340
replace misclassified = 1 if obs == 342
replace misclassified = 1 if obs == 346
replace misclassified = 1 if obs == 348
replace misclassified = 1 if obs == 351
replace misclassified = 1 if obs == 352
replace misclassified = 1 if obs == 357
replace misclassified = 1 if obs == 358
replace misclassified = 1 if obs == 360
replace misclassified = 1 if obs == 361
replace misclassified = 1 if obs == 370
replace misclassified = 1 if obs == 373
replace misclassified = 1 if obs == 380
replace misclassified = 1 if obs == 381
replace misclassified = 1 if obs == 385
replace misclassified = 1 if obs == 392
replace misclassified = 1 if obs == 393
replace misclassified = 1 if obs == 406
replace misclassified = 1 if obs == 415
replace misclassified = 1 if obs == 421
replace misclassified = 1 if obs == 423
replace misclassified = 1 if obs == 426
replace misclassified = 1 if obs == 429
replace misclassified = 1 if obs == 433
replace misclassified = 1 if obs == 436
replace misclassified = 1 if obs == 437
replace misclassified = 1 if obs == 438
replace misclassified = 1 if obs == 445
replace misclassified = 1 if obs == 453
replace misclassified = 1 if obs == 458
replace misclassified = 1 if obs == 471
replace misclassified = 1 if obs == 474
replace misclassified = 1 if obs == 476
replace misclassified = 1 if obs == 477
replace misclassified = 1 if obs == 484
replace misclassified = 1 if obs == 485
replace misclassified = 1 if obs == 487
replace misclassified = 1 if obs == 490
replace misclassified = 1 if obs == 491
replace misclassified = 1 if obs == 497
replace misclassified = 1 if obs == 500
replace misclassified = 1 if obs == 501
replace misclassified = 1 if obs == 504
replace misclassified = 1 if obs == 506
replace misclassified = 1 if obs == 509
replace misclassified = 1 if obs == 510
replace misclassified = 1 if obs == 511
replace misclassified = 1 if obs == 512
replace misclassified = 1 if obs == 513
replace misclassified = 1 if obs == 515
replace misclassified = 1 if obs == 518
replace misclassified = 1 if obs == 519
replace misclassified = 1 if obs == 522
replace misclassified = 1 if obs == 523
replace misclassified = 1 if obs == 529
replace misclassified = 1 if obs == 531
replace misclassified = 1 if obs == 537
replace misclassified = 1 if obs == 541
replace misclassified = 1 if obs == 542
replace misclassified = 1 if obs == 545
replace misclassified = 1 if obs == 546
replace misclassified = 1 if obs == 548
replace misclassified = 1 if obs == 554
replace misclassified = 1 if obs == 558
replace misclassified = 1 if obs == 559
replace misclassified = 1 if obs == 562
replace misclassified = 1 if obs == 567
replace misclassified = 1 if obs == 589
replace misclassified = 1 if obs == 594
replace misclassified = 1 if obs == 597
replace misclassified = 1 if obs == 598
replace misclassified = 1 if obs == 602
replace misclassified = 1 if obs == 606
replace misclassified = 1 if obs == 610
replace misclassified = 1 if obs == 616
replace misclassified = 1 if obs == 619
replace misclassified = 1 if obs == 624
replace misclassified = 1 if obs == 625
replace misclassified = 1 if obs == 628
replace misclassified = 1 if obs == 639
replace misclassified = 1 if obs == 643
replace misclassified = 1 if obs == 645
replace misclassified = 1 if obs == 648
replace misclassified = 1 if obs == 653
replace misclassified = 1 if obs == 657
replace misclassified = 1 if obs == 661
replace misclassified = 1 if obs == 667
replace misclassified = 1 if obs == 675
replace misclassified = 1 if obs == 691
replace misclassified = 1 if obs == 711
replace misclassified = 1 if obs == 718
replace misclassified = 1 if obs == 724
replace misclassified = 1 if obs == 725
replace misclassified = 1 if obs == 736
replace misclassified = 1 if obs == 744
replace misclassified = 1 if obs == 749
replace misclassified = 1 if obs == 750
replace misclassified = 1 if obs == 761
replace misclassified = 1 if obs == 766
replace misclassified = 1 if obs == 774
replace misclassified = 1 if obs == 776
replace misclassified = 1 if obs == 783
replace misclassified = 1 if obs == 785
replace misclassified = 1 if obs == 788
replace misclassified = 1 if obs == 792
replace misclassified = 1 if obs == 797
replace misclassified = 1 if obs == 798
replace misclassified = 1 if obs == 799
replace misclassified = 1 if obs == 804
replace misclassified = 1 if obs == 809
replace misclassified = 1 if obs == 810
replace misclassified = 1 if obs == 811
replace misclassified = 1 if obs == 812
replace misclassified = 1 if obs == 816
replace misclassified = 1 if obs == 823
replace misclassified = 1 if obs == 835
replace misclassified = 1 if obs == 844
replace misclassified = 1 if obs == 849
replace misclassified = 1 if obs == 862
replace misclassified = 1 if obs == 870
replace misclassified = 1 if obs == 871
replace misclassified = 1 if obs == 873
replace misclassified = 1 if obs == 875
replace misclassified = 1 if obs == 879
replace misclassified = 1 if obs == 885
replace misclassified = 1 if obs == 888
replace misclassified = 1 if obs == 889
replace misclassified = 1 if obs == 892
replace misclassified = 1 if obs == 897
replace misclassified = 1 if obs == 902
replace misclassified = 1 if obs == 904
replace misclassified = 1 if obs == 905
replace misclassified = 1 if obs == 907
replace misclassified = 1 if obs == 920
replace misclassified = 1 if obs == 924
replace misclassified = 1 if obs == 926
replace misclassified = 1 if obs == 929
replace misclassified = 1 if obs == 934
replace misclassified = 1 if obs == 938
replace misclassified = 1 if obs == 941
replace misclassified = 1 if obs == 943
replace misclassified = 1 if obs == 947
replace misclassified = 1 if obs == 952
replace misclassified = 1 if obs == 968
replace misclassified = 1 if obs == 971
replace misclassified = 1 if obs == 973
replace misclassified = 1 if obs == 980
replace misclassified = 1 if obs == 991
replace misclassified = 1 if obs == 996
replace misclassified = 1 if obs == 1000
replace misclassified = 1 if obs == 1002
replace misclassified = 1 if obs == 1005
replace misclassified = 1 if obs == 1007
replace misclassified = 1 if obs == 1014
replace misclassified = 1 if obs == 1015
replace misclassified = 1 if obs == 1016
replace misclassified = 1 if obs == 1029
replace misclassified = 1 if obs == 1036
replace misclassified = 1 if obs == 1038
replace misclassified = 1 if obs == 1041
replace misclassified = 1 if obs == 1047
replace misclassified = 1 if obs == 1049
replace misclassified = 1 if obs == 1053
replace misclassified = 1 if obs == 1054
replace misclassified = 1 if obs == 1057
replace misclassified = 1 if obs == 1060
replace misclassified = 1 if obs == 1061
replace misclassified = 1 if obs == 1072
replace misclassified = 1 if obs == 1073
replace misclassified = 1 if obs == 1080
replace misclassified = 1 if obs == 1083
replace misclassified = 1 if obs == 1084
replace misclassified = 1 if obs == 1088
replace misclassified = 1 if obs == 1090
replace misclassified = 1 if obs == 1105
replace misclassified = 1 if obs == 1106
replace misclassified = 1 if obs == 1110
replace misclassified = 1 if obs == 1116
replace misclassified = 1 if obs == 1120
replace misclassified = 1 if obs == 1121
replace misclassified = 1 if obs == 1126
replace misclassified = 1 if obs == 1130
replace misclassified = 1 if obs == 1142
replace misclassified = 1 if obs == 1145
replace misclassified = 1 if obs == 1157
replace misclassified = 1 if obs == 1159
replace misclassified = 1 if obs == 1160
replace misclassified = 1 if obs == 1161
replace misclassified = 1 if obs == 1166
replace misclassified = 1 if obs == 1167
replace misclassified = 1 if obs == 1168
replace misclassified = 1 if obs == 1171
replace misclassified = 1 if obs == 1172
replace misclassified = 1 if obs == 1181
replace misclassified = 1 if obs == 1190
replace misclassified = 1 if obs == 1192
replace misclassified = 1 if obs == 1200
replace misclassified = 1 if obs == 1204
replace misclassified = 1 if obs == 1207
replace misclassified = 1 if obs == 1211
replace misclassified = 1 if obs == 1215
replace misclassified = 1 if obs == 1217
replace misclassified = 1 if obs == 1220
replace misclassified = 1 if obs == 1221
replace misclassified = 1 if obs == 1222
replace misclassified = 1 if obs == 1224
replace misclassified = 1 if obs == 1227
replace misclassified = 1 if obs == 1228
replace misclassified = 1 if obs == 1240
replace misclassified = 1 if obs == 1251
replace misclassified = 1 if obs == 1253
replace misclassified = 1 if obs == 1258
replace misclassified = 1 if obs == 1275
replace misclassified = 1 if obs == 1287
replace misclassified = 1 if obs == 1298
replace misclassified = 1 if obs == 1299
replace misclassified = 1 if obs == 1300
replace misclassified = 1 if obs == 1307
replace misclassified = 1 if obs == 1319
replace misclassified = 1 if obs == 1326
replace misclassified = 1 if obs == 1327
replace misclassified = 1 if obs == 1329
replace misclassified = 1 if obs == 1330
replace misclassified = 1 if obs == 1347
replace misclassified = 1 if obs == 1351
replace misclassified = 1 if obs == 1354
replace misclassified = 1 if obs == 1357
replace misclassified = 1 if obs == 1358
replace misclassified = 1 if obs == 1364
replace misclassified = 1 if obs == 1371
replace misclassified = 1 if obs == 1378
replace misclassified = 1 if obs == 1380
replace misclassified = 1 if obs == 1392
replace misclassified = 1 if obs == 1406
replace misclassified = 1 if obs == 1414
replace misclassified = 1 if obs == 1421
replace misclassified = 1 if obs == 1423
replace misclassified = 1 if obs == 1424
replace misclassified = 1 if obs == 1437
replace misclassified = 1 if obs == 1451
replace misclassified = 1 if obs == 1453
replace misclassified = 1 if obs == 1457
replace misclassified = 1 if obs == 1466
replace misclassified = 1 if obs == 1467
replace misclassified = 1 if obs == 1475
replace misclassified = 1 if obs == 1484
replace misclassified = 1 if obs == 1485
replace misclassified = 1 if obs == 1487
replace misclassified = 1 if obs == 1493
replace misclassified = 1 if obs == 1506
replace misclassified = 1 if obs == 1511
replace misclassified = 1 if obs == 1523
replace misclassified = 1 if obs == 1524
replace misclassified = 1 if obs == 1525
replace misclassified = 1 if obs == 1526
replace misclassified = 1 if obs == 1529
replace misclassified = 1 if obs == 1534
replace misclassified = 1 if obs == 1537
replace misclassified = 1 if obs == 1539
replace misclassified = 1 if obs == 1542
replace misclassified = 1 if obs == 1551
replace misclassified = 1 if obs == 1552
replace misclassified = 1 if obs == 1558
replace misclassified = 1 if obs == 1559
replace misclassified = 1 if obs == 1561
replace misclassified = 1 if obs == 1564
replace misclassified = 1 if obs == 1565
replace misclassified = 1 if obs == 1566
replace misclassified = 1 if obs == 1574
replace misclassified = 1 if obs == 1575
replace misclassified = 1 if obs == 1584
replace misclassified = 1 if obs == 1588
replace misclassified = 1 if obs == 1590
replace misclassified = 1 if obs == 1593
replace misclassified = 1 if obs == 1600
replace misclassified = 1 if obs == 1604
replace misclassified = 1 if obs == 1611
replace misclassified = 1 if obs == 1619
replace misclassified = 1 if obs == 1620
replace misclassified = 1 if obs == 1621
replace misclassified = 1 if obs == 1630
replace misclassified = 1 if obs == 1631
replace misclassified = 1 if obs == 1637
replace misclassified = 1 if obs == 1641
replace misclassified = 1 if obs == 1645
replace misclassified = 1 if obs == 1647
replace misclassified = 1 if obs == 1648
replace misclassified = 1 if obs == 1649
replace misclassified = 1 if obs == 1651
replace misclassified = 1 if obs == 1652
replace misclassified = 1 if obs == 1653
replace misclassified = 1 if obs == 1655
replace misclassified = 1 if obs == 1656
replace misclassified = 1 if obs == 1658
replace misclassified = 1 if obs == 1661
replace misclassified = 1 if obs == 1664
replace misclassified = 1 if obs == 1666
replace misclassified = 1 if obs == 1669
replace misclassified = 1 if obs == 1670
replace misclassified = 1 if obs == 1672
replace misclassified = 1 if obs == 1674
replace misclassified = 1 if obs == 1683
replace misclassified = 1 if obs == 1684
replace misclassified = 1 if obs == 1689
replace misclassified = 1 if obs == 1691
replace misclassified = 1 if obs == 1702
replace misclassified = 1 if obs == 1706
replace misclassified = 1 if obs == 1723
replace misclassified = 1 if obs == 1724
replace misclassified = 1 if obs == 1733
replace misclassified = 1 if obs == 1735
replace misclassified = 1 if obs == 1736
replace misclassified = 1 if obs == 1740
replace misclassified = 1 if obs == 1744
replace misclassified = 1 if obs == 1754
replace misclassified = 1 if obs == 1761
replace misclassified = 1 if obs == 1767
replace misclassified = 1 if obs == 1768
replace misclassified = 1 if obs == 1769
replace misclassified = 1 if obs == 1771
replace misclassified = 1 if obs == 1773
replace misclassified = 1 if obs == 1775
replace misclassified = 1 if obs == 1777
replace misclassified = 1 if obs == 1778
replace misclassified = 1 if obs == 1790
replace misclassified = 1 if obs == 1792
replace misclassified = 1 if obs == 1793
replace misclassified = 1 if obs == 1794
replace misclassified = 1 if obs == 1806
replace misclassified = 1 if obs == 1810
replace misclassified = 1 if obs == 1813
replace misclassified = 1 if obs == 1815
replace misclassified = 1 if obs == 1816
replace misclassified = 1 if obs == 1828
replace misclassified = 1 if obs == 1836
replace misclassified = 1 if obs == 1840
replace misclassified = 1 if obs == 1841
replace misclassified = 1 if obs == 1844
replace misclassified = 1 if obs == 1845
replace misclassified = 1 if obs == 1849
replace misclassified = 1 if obs == 1853
replace misclassified = 1 if obs == 1854
replace misclassified = 1 if obs == 1856
replace misclassified = 1 if obs == 1859
replace misclassified = 1 if obs == 1860
replace misclassified = 1 if obs == 1863
replace misclassified = 1 if obs == 1864
replace misclassified = 1 if obs == 1869
replace misclassified = 1 if obs == 1870
replace misclassified = 1 if obs == 1871
replace misclassified = 1 if obs == 1878
replace misclassified = 1 if obs == 1885
replace misclassified = 1 if obs == 1889
replace misclassified = 1 if obs == 1890
replace misclassified = 1 if obs == 1892
replace misclassified = 1 if obs == 1894
replace misclassified = 1 if obs == 1896
replace misclassified = 1 if obs == 1899
replace misclassified = 1 if obs == 1903
replace misclassified = 1 if obs == 1905
replace misclassified = 1 if obs == 1910
replace misclassified = 1 if obs == 1914
replace misclassified = 1 if obs == 1915
replace misclassified = 1 if obs == 1918
replace misclassified = 1 if obs == 1921
replace misclassified = 1 if obs == 1922
replace misclassified = 1 if obs == 1923
replace misclassified = 1 if obs == 1927
replace misclassified = 1 if obs == 1931
replace misclassified = 1 if obs == 1941
replace misclassified = 1 if obs == 1949
replace misclassified = 1 if obs == 1954
replace misclassified = 1 if obs == 1962
replace misclassified = 1 if obs == 1963
replace misclassified = 1 if obs == 1970
replace misclassified = 1 if obs == 1973
replace misclassified = 1 if obs == 1976
replace misclassified = 1 if obs == 1980
replace misclassified = 1 if obs == 1981
replace misclassified = 1 if obs == 1982
replace misclassified = 1 if obs == 1985
replace misclassified = 1 if obs == 1986
replace misclassified = 1 if obs == 1988
replace misclassified = 1 if obs == 1993
replace misclassified = 1 if obs == 1997
replace misclassified = 1 if obs == 2001
replace misclassified = 1 if obs == 2004
replace misclassified = 1 if obs == 2006
replace misclassified = 1 if obs == 2010
replace misclassified = 1 if obs == 2015
replace misclassified = 1 if obs == 2017
replace misclassified = 1 if obs == 2019
replace misclassified = 1 if obs == 2021
replace misclassified = 1 if obs == 2022
replace misclassified = 1 if obs == 2024
replace misclassified = 1 if obs == 2033
replace misclassified = 1 if obs == 2035
replace misclassified = 1 if obs == 2036
replace misclassified = 1 if obs == 2044
replace misclassified = 1 if obs == 2051
replace misclassified = 1 if obs == 2055
replace misclassified = 1 if obs == 2058
replace misclassified = 1 if obs == 2059
replace misclassified = 1 if obs == 2069
replace misclassified = 1 if obs == 2071
replace misclassified = 1 if obs == 2072
replace misclassified = 1 if obs == 2080
replace misclassified = 1 if obs == 2089
replace misclassified = 1 if obs == 2095
replace misclassified = 1 if obs == 2097
replace misclassified = 1 if obs == 2098
replace misclassified = 1 if obs == 2100
replace misclassified = 1 if obs == 2109
replace misclassified = 1 if obs == 2116
replace misclassified = 1 if obs == 2122
replace misclassified = 1 if obs == 2123
replace misclassified = 1 if obs == 2124
replace misclassified = 1 if obs == 2132
replace misclassified = 1 if obs == 2133
replace misclassified = 1 if obs == 2143
replace misclassified = 1 if obs == 2144
replace misclassified = 1 if obs == 2147
replace misclassified = 1 if obs == 2148
replace misclassified = 1 if obs == 2149
replace misclassified = 1 if obs == 2156
replace misclassified = 1 if obs == 2158
replace misclassified = 1 if obs == 2171
replace misclassified = 1 if obs == 2185
replace misclassified = 1 if obs == 2187
replace misclassified = 1 if obs == 2196
replace misclassified = 1 if obs == 2201
replace misclassified = 1 if obs == 2212
replace misclassified = 1 if obs == 2213
replace misclassified = 1 if obs == 2218
replace misclassified = 1 if obs == 2219
replace misclassified = 1 if obs == 2220
replace misclassified = 1 if obs == 2224
replace misclassified = 1 if obs == 2229
replace misclassified = 1 if obs == 2234
replace misclassified = 1 if obs == 2243
replace misclassified = 1 if obs == 2246
replace misclassified = 1 if obs == 2247
replace misclassified = 1 if obs == 2248
replace misclassified = 1 if obs == 2260
replace misclassified = 1 if obs == 2265
replace misclassified = 1 if obs == 2266
replace misclassified = 1 if obs == 2267
replace misclassified = 1 if obs == 2270
replace misclassified = 1 if obs == 2279
replace misclassified = 1 if obs == 2288
replace misclassified = 1 if obs == 2290
replace misclassified = 1 if obs == 2291
replace misclassified = 1 if obs == 2292
replace misclassified = 1 if obs == 2296
replace misclassified = 1 if obs == 2317
replace misclassified = 1 if obs == 2319
replace misclassified = 1 if obs == 2321
replace misclassified = 1 if obs == 2322
replace misclassified = 1 if obs == 2328
replace misclassified = 1 if obs == 2340
replace misclassified = 1 if obs == 2344
replace misclassified = 1 if obs == 2346
replace misclassified = 1 if obs == 2348
replace misclassified = 1 if obs == 2356
replace misclassified = 1 if obs == 2360
replace misclassified = 1 if obs == 2363
replace misclassified = 1 if obs == 2367
replace misclassified = 1 if obs == 2377
replace misclassified = 1 if obs == 2383
replace misclassified = 1 if obs == 2391
replace misclassified = 1 if obs == 2392
replace misclassified = 1 if obs == 2393
replace misclassified = 1 if obs == 2397
replace misclassified = 1 if obs == 2399
replace misclassified = 1 if obs == 2405
replace misclassified = 1 if obs == 2409
replace misclassified = 1 if obs == 2431
replace misclassified = 1 if obs == 2436
replace misclassified = 1 if obs == 2437
replace misclassified = 1 if obs == 2447
replace misclassified = 1 if obs == 2448
replace misclassified = 1 if obs == 2449
replace misclassified = 1 if obs == 2452
replace misclassified = 1 if obs == 2455
replace misclassified = 1 if obs == 2457
replace misclassified = 1 if obs == 2465
replace misclassified = 1 if obs == 2466
replace misclassified = 1 if obs == 2469
replace misclassified = 1 if obs == 2471
replace misclassified = 1 if obs == 2475
replace misclassified = 1 if obs == 2476
replace misclassified = 1 if obs == 2479
replace misclassified = 1 if obs == 2481
replace misclassified = 1 if obs == 2491
replace misclassified = 1 if obs == 2494
replace misclassified = 1 if obs == 2500
replace misclassified = 1 if obs == 2501
replace misclassified = 1 if obs == 2509
replace misclassified = 1 if obs == 2511
replace misclassified = 1 if obs == 2514
replace misclassified = 1 if obs == 2531
replace misclassified = 1 if obs == 2534
replace misclassified = 1 if obs == 2539
replace misclassified = 1 if obs == 2541
replace misclassified = 1 if obs == 2545
replace misclassified = 1 if obs == 2553
replace misclassified = 1 if obs == 2556
replace misclassified = 1 if obs == 2559
replace misclassified = 1 if obs == 2576
replace misclassified = 1 if obs == 2590
replace misclassified = 1 if obs == 2599
replace misclassified = 1 if obs == 2604
replace misclassified = 1 if obs == 2608
replace misclassified = 1 if obs == 2613
replace misclassified = 1 if obs == 2619
replace misclassified = 1 if obs == 2632
replace misclassified = 1 if obs == 2640
replace misclassified = 1 if obs == 2645
replace misclassified = 1 if obs == 2646
replace misclassified = 1 if obs == 2649
replace misclassified = 1 if obs == 2658
replace misclassified = 1 if obs == 2660
replace misclassified = 1 if obs == 2667
replace misclassified = 1 if obs == 2672
replace misclassified = 1 if obs == 2677
replace misclassified = 1 if obs == 2678
replace misclassified = 1 if obs == 2682
replace misclassified = 1 if obs == 2686
replace misclassified = 1 if obs == 2690
replace misclassified = 1 if obs == 2691
replace misclassified = 1 if obs == 2692
replace misclassified = 1 if obs == 2700
replace misclassified = 1 if obs == 2704
replace misclassified = 1 if obs == 2708
replace misclassified = 1 if obs == 2712
replace misclassified = 1 if obs == 2714
replace misclassified = 1 if obs == 2715
replace misclassified = 1 if obs == 2726
replace misclassified = 1 if obs == 2746
replace misclassified = 1 if obs == 2747
replace misclassified = 1 if obs == 2751
replace misclassified = 1 if obs == 2756
replace misclassified = 1 if obs == 2764
replace misclassified = 1 if obs == 2768
replace misclassified = 1 if obs == 2771
replace misclassified = 1 if obs == 2772
replace misclassified = 1 if obs == 2775
replace misclassified = 1 if obs == 2777
replace misclassified = 1 if obs == 2778
replace misclassified = 1 if obs == 2779
replace misclassified = 1 if obs == 2783
replace misclassified = 1 if obs == 2785
replace misclassified = 1 if obs == 2787
replace misclassified = 1 if obs == 2791
replace misclassified = 1 if obs == 2795
replace misclassified = 1 if obs == 2797
replace misclassified = 1 if obs == 2801
replace misclassified = 1 if obs == 2802
replace misclassified = 1 if obs == 2804
replace misclassified = 1 if obs == 2809
replace misclassified = 1 if obs == 2811
replace misclassified = 1 if obs == 2813
replace misclassified = 1 if obs == 2817
replace misclassified = 1 if obs == 2819
replace misclassified = 1 if obs == 2826
replace misclassified = 1 if obs == 2827
replace misclassified = 1 if obs == 2829
replace misclassified = 1 if obs == 2837
replace misclassified = 1 if obs == 2847
replace misclassified = 1 if obs == 2850
replace misclassified = 1 if obs == 2855
replace misclassified = 1 if obs == 2858
replace misclassified = 1 if obs == 2870
replace misclassified = 1 if obs == 2875
replace misclassified = 1 if obs == 2876
replace misclassified = 1 if obs == 2882
replace misclassified = 1 if obs == 2902
replace misclassified = 1 if obs == 2903
replace misclassified = 1 if obs == 2907
replace misclassified = 1 if obs == 2908
replace misclassified = 1 if obs == 2909
replace misclassified = 1 if obs == 2917
replace misclassified = 1 if obs == 2929
replace misclassified = 1 if obs == 2937
replace misclassified = 1 if obs == 2938
replace misclassified = 1 if obs == 2940
replace misclassified = 1 if obs == 2941
replace misclassified = 1 if obs == 2942
replace misclassified = 1 if obs == 2943
replace misclassified = 1 if obs == 2948
replace misclassified = 1 if obs == 2956
replace misclassified = 1 if obs == 2957
replace misclassified = 1 if obs == 2958
replace misclassified = 1 if obs == 2962
replace misclassified = 1 if obs == 2971
replace misclassified = 1 if obs == 2973
replace misclassified = 1 if obs == 2977
replace misclassified = 1 if obs == 2984
replace misclassified = 1 if obs == 2989
replace misclassified = 1 if obs == 2992
replace misclassified = 1 if obs == 2995
replace misclassified = 1 if obs == 2996
replace misclassified = 1 if obs == 3000
replace misclassified = 1 if obs == 3002
replace misclassified = 1 if obs == 3005
replace misclassified = 1 if obs == 3010
replace misclassified = 1 if obs == 3013
replace misclassified = 1 if obs == 3016
replace misclassified = 1 if obs == 3021
replace misclassified = 1 if obs == 3036
replace misclassified = 1 if obs == 3038
replace misclassified = 1 if obs == 3042
replace misclassified = 1 if obs == 3044
replace misclassified = 1 if obs == 3047
replace misclassified = 1 if obs == 3048
replace misclassified = 1 if obs == 3053
replace misclassified = 1 if obs == 3055
replace misclassified = 1 if obs == 3060
replace misclassified = 1 if obs == 3061
replace misclassified = 1 if obs == 3063
replace misclassified = 1 if obs == 3065
replace misclassified = 1 if obs == 3066
replace misclassified = 1 if obs == 3068
replace misclassified = 1 if obs == 3070
replace misclassified = 1 if obs == 3072
replace misclassified = 1 if obs == 3074
replace misclassified = 1 if obs == 3078
replace misclassified = 1 if obs == 3080
replace misclassified = 1 if obs == 3081
replace misclassified = 1 if obs == 3083
replace misclassified = 1 if obs == 3084
replace misclassified = 1 if obs == 3085
replace misclassified = 1 if obs == 3096
replace misclassified = 1 if obs == 3098

cap drop classified

gen classified = $depvar
replace classified = 0 if $depvar == 1 & misclassified == 1
replace classified = 1 if $depvar == 0 & misclassified == 1

cap drop false_*

gen false_positive = (misclassified == 1 & $depvar == 0)
gen false_negative = (misclassified == 1 & $depvar == 1)

gen positive = ""
replace positive = "T" if classified == 1 & misclassified == 0
replace positive = "F" if classified == 1 & misclassified == 1

gen negative = ""
replace negative = "T" if classified == 0 & misclassified == 0
replace negative = "F" if classified == 0 & misclassified == 1

save model_for_r.dta, replace

preserve
keep if false_positive == 1
save false_positive_for_r.dta, replace
restore

*** testing misclassified people

tab co_findc positive, col
* false positives are richer than true positive

tab co_equitest positive, col
* flase positives are less likely to have "U" or "P". This reinforces the wealth bit. U is people with no comm data, I think that P is people with comm data but no equity data

tab disaster positive, col
* no significant difference between true and false classified

tab white positive, col
* white people are more likely to be misclassified. Add "white" to the kitchensink vars

* none of the age variables

tab di_congressionaldistrict positive, row
*cds  3, 4, 6, 7, 11

tab ca_partyaffiliation positive, col
* most of the falsies are registered Democrats

su sy_partisanscore2012 if positive == "F"
su sy_partisanscore2012 if positive == "T"
* their mean partisan score is 91. Make a variable for high partisan score whites
* make a variable for rich white democrats

tab exurban positive, col
* exurbanites

tab rural positive, col
* rural people
* make a variable for high p-score exurbanites

tab di_countyfips positive, row
* Salem, Warren, Somerset, Burlington

tab a_disaster_whites positive, col
* disaster whites more likely to be false positives

tab a_married positive, col
* married people more likely to be false positives

tab a_ever_Dem_Prim positive, col
* they are just as likely to have voted in a Democratic primary


*/








save model, replace




******** Scoring *********

global forscoring "es_n2006p	sy_workcluster	es_n2004p	hh1_dems	es_n2010p	sy_indpartbehave 	co_revolver"

clear
cd "$workingdirectory"

set mem 8g
use model
keep anid $depvar state responseuniverse validate
sort anid
merge anid using "$enhanalytics", keep($forscoring)
tab _merge
drop _merge

sort anid
merge anid using "S:\analytic_files\va\RR_AFL_VA.dta", nokeep
tab _merge
drop _merge

gen a_demfamily = 1 if hh1_dems >= 2
gen a_rev_mid = 1 if co_revolver == 4 |co_revolver == 5 | co_revolver ==7
gen a_voted10pR= (es_n2010p == "R")
gen a_Voted06pD= (es_n2006p == "D")
gen a_IndDem= (sy_indpartbehave == "D")
gen a_Voted04pD = (es_n2004p == "D")
gen a_work7 = (sy_workcluster == "7")

foreach var of varlist a_* {
replace `var' = 0 if missing(`var')
}

* select variables that went into your model
global kitchensinkvars "partisa~2012	a_Voted06pD	a_work7	a_Voted04pD	a_demfamily	a_voted10pR	a_IndDem	a_rev_mid"

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

tab support_kaine_bin  sy_partisanscore2012_bin, row


format anid %20.0g
keep anid state $probscore 
save General_Support_Scores_VA.dta, replace
outsheet using Gen_Support_VA.txt, replace




