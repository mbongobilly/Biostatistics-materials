
 cd "C:\Teaching UNZA\Lectureslides2016-2017"
 
 *save heroin, replace
 *saveold heroin11, replace
 
 use heroin, clear
 *use heroin11, clear
 
 de
 
 //SETTING DATA TO BE SURVIVAL ANALYSIS FORMAT
 stset time, failure(status)
 
 hist time, normal
 
 //LOOKING AT THE SUMMARY OF DATA
 
 stsum
 display 0.0015656*365.25   //incident rate in years approx 0.57.2 per year
 
 //OVERALL SURVIVAL ESTIMATE USING LIFE-TABLE APPROACH
 
 ltable time status, interval(30)
 
 ltable time status, interval(30) graph

 
 //LIFE TABLE COMPARING SURVIVAL IN PRISONS TIME INTERVAL OF 30
 
 ltable time status, by(prison) interval(30)
 ltable time status, by(prison) interval(30) graph 
 
 //LIFE TABLE COMPARING SURVIVAL IN IN CLINICS TIME INTERVAL OF 30

 ltable time status, by(clinic) interval(30)
 ltable time status, by(clinic) interval(30) graph title(Different clinics)

 
 //SETTING DATA TO BE SURVIVAL ANALYSIS FORMAT
 stset time, failure(status)
 
 //MEDIAN SURVIVAL TIME WITH CONFIDENCE INTERVALS
 stci
 
 //MEDIAN SURVIVAL TIMES GY GROUPS
 stci, by(prison)
 stci, by(clinic)
 
 
  //KAPLAN-MEIER ESTIMATOR FOR SURVIVAL FUNCTIONS OF DIFFERENT CLINICS
 sts graph
 
 sts graph, by(prison)
 
 //KAPLAN-MEIER ESTIMATOR FOR SURVIVAL FUNCTIONS OF DIFFERENT CLINICS
 sts graph, by(clinic)
 
 
 //LOG-RANK TEST
 sts test prison
 
 //WILCOXON TEST
 sts test prison, wilcoxon
 
 //LOG-RANK TEST
 sts test clinic
 
 //WILCOXON TEST
 sts test clinic, wilcoxon
 
//INVESTIGATING THE EFFECTS OF DOSE, CLINIC AND PRISON ON HAZARD
 //ASSUMING PROPORTIONAL
 stcox dose 
 stcox prison
 xi: stcox i.clinic
 
 xi: stcox dose prison i.clinic
 
 stcurve, survival   //ESTIMATING THE SURVIVAL FUNCTION FROM THE COX MODEL
 
 
 //INVESTIGATING FOR PROPORTIONAL ASSUMPTIONS
 
 stphplot, adjust(dose prison clinic) by(prison) xlabel(1/7)
 stphplot, adjust(dose prison clinic) by(clinic) xlabel(1/7)
 
 
 //INVESTIGATING THE EFFECTS OF DOSE AND PRISON ON SURVIVAL
 //ALLOWING FOR TWO CLINICS TO BE NON PROPORTIONAL
 
 stcox dose prison, strata(clinic)
 xi: stcox dose i.clinic, strata(prison)

 
