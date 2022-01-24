*cd "G:\Files\mem2\Teaching UNZA\Lecture Slides2014"
cd "C:\Teaching UNZA\Lectureslides2017-2018\Data"

clear
use lifespan, clear
browse

//4.1 Analysis using stata
bysort diet: summarize lifespan 
bysort diet: summarize lifespan, detail 
graph box lifespan, by(diet) note("Box plots" "showing the distribution of values")
hist lifespan, normal by(diet) 
//NORMAL PLOTS
qnorm lifespan if diet==1, saving(q1, replace) title(For restricted diet)
qnorm lifespan if diet==2, saving(q2, replace) title(For Ad libitum diet)
graph combine q1.gph q2.gph

//ANALYSIS USING THE TWO VERSIONS OF T-TEST
ttest lifespan, by(diet)
ttest lifespan, by(diet) unequal

//NON-PARAMETRICK TEST
ranksum lifespan, by(diet)

//EXAMPLE 2
use therapy, clear
 
help ttest
ttest wt1=wt2

gen diff=wt1-wt2
ttest diff==0

/*
scatter wt2 wt1 || lfit wt2 wt1, ///
  title(Plot showing tracking and fitted line) ///
   ytitle(Weight after therapy (pounds))   
 pwcorr wt1 wt2, sig
 
 */
 
  //EXAMPLE 3 ON CATEGORICAL DATA
 
 tabi 16 48\40 20, chi2 expected cell row col
 
  tabi 10 2\2 4, chi2 expected col
  tabi 10 2\2 4, chi2 expected col exact
  
  //EXAMPLE 4 ON MATCHED CATEGORICAL DATA
  symmi 212 144\256 707  
  
  mcci 212 144 256 707
  