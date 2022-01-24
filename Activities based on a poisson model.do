*cd "G:\Files\mem2\Teaching UNZA\Lecture Slides2014"
cd "F:\Files\mem2\Teaching UNZA\Lecture Slides2014"
cd "H:\Files\mem2\Teaching UNZA\Lecture Slides2014"


clear
 input male trt baspolyps age postpolyps
 0 1 7 17 6
 0 0 77 20 67
 1 1 7 16 4
 0 0 5 18 5
 1 1 23 22 16
 0 0 35 13 31
 0 1 11 23 6
 1 0 12 34 20
 1 0 7 50 7
 1 0 318 19 347
 1 1 160 17 142
 0 1 8 23 1
 1 0 20 22 16
 1 0 11 30 20
 1 0 24 27 26
 1 1 34 23 27
 0 0 54 22 45
 1 1 16 13 10
 1 0 30 34 30
 0 1 10 23 6
 0 1 20 22 5
 1 1 12 42 8
 end
 
 list
  label var male "Dummy variable for male, 1=yes, 0=no"
  lab define male 1 "Male" 0 "Female"
  label values male male
  tab male
  label var trt "Dummy variable for active treatmen, 1=yes, 0=no"
  label define trt 0 "Placebo" 1 "Active"
  label values trt trt
  tab trt
  label var age "Age of patient in years"
  label var baspolyps "Number of polyps at baseline"
  label var postpolyps "Number of polyps after three months"

   //DESCRIPTIVE STATISTICS BY TREATMENT
   tab trt  //overall treatment
   tab male trt, col chi2 expected exact
   
   bysort trt: summ baspolyps, detail //SUMARISING BASELINE POLYPS
   hist baspolyps, normal
   ranksum baspolyps, by(trt) /*TESTING TO SEE WHETHER THEIR ANY DIFFERENCES 
   IN POLYPS AT BASELINE, NON PARAMETRIC TEST */
   
   bysort trt: summ age, detail //SUMARISING BASELINE AGE
   hist age, normal
   ranksum age, by(trt) /*TESTING TO SEE WHETHER THEIR ANY DIFFERENCES 
   IN THEIR AGE, NON PARAMETRIC TEST */
   
   bysort trt: summ postpolyps, detail //SUMARISING POLYPS AFTER 3 MONTHS
   hist postpolyps, normal
   ranksum postpolyps, by(trt) /*TESTING TO SEE WHETHER THEIR ANY DIFFERENCES 
   IN THE NUMBER OF POLYPS AFTER 3 MONTHS, NON PARAMETRIC TEST */
   
   //FITTING A POISSON WITH COUNT OUTCOME
   *glm postpolyps trt baspolyps age male, family(poisson) link(log)
   
   poisson postpolyps trt baspolyps age male

   
   //REPORTING INCIDENT RATE RATIOS
   *glm postpolyps trt baspolyps age male, family(poisson) link(log) eform
   
   poisson postpolyps trt baspolyps age male, irr



	//EXAMPLE 2
clear
input time x n
2 0 1
3 0 1
6 0 1
8 0 1
9 0 1 
10 0 1
11 0 1
13 0 1
14 0 1
16 0 1
21 0 1
22 0 1
24 0 1
26 0 1
27 0 1
7 0 2
13 0 2
15 0 2
18 0 2
23 0 2
20 0 3
24 0 4
1 1 1
5 1 1
17 1 1
18 1 1
25 1 1
18 1 2
25 1 2
4 1 3
19 1 4
end
list 

label var time "Time period after removal of primary tumour"
label var x "Size of the primary tumour, 0=tumour < 3cm, 1=tumour > 3 cm"
label var n "Number of recurrent tumours"

gen lntime=ln(time) //GENERATING AN OFFSET VARIABLE

*glm n x, family(poisson) link(log) offset(lntime) //FITTING A MODEL WITH AN OFFSET ON LOG SCALE

poisson n x, offset(lntime) //FITTING A MODEL WITH AN OFFSET ON LOG SCALE
	

glm n x, family(poisson) link(log) offset(lntime) eform //FITTING A MODEL WITH AN OFFSET ON IRR SCALE

poisson n x, offset(lntime) irr  //FITTING A MODEL WITH AN OFFSET ON IRR SCALE

//START OF CLASS FOLLOWING EXERCISE
describe 

//UNIVARIATE ANALYSIS
poisson art fem
poisson art fem, irr //incident rate ratio estimate

poisson art mar
poisson art mar, irr //incident rate ratio estimate

poisson art kid5
poisson art kid5, irr //incident rate ratio estimate

poisson art phd
poisson art phd, irr //incident rate ratio estimate

poisson art ment
poisson art ment, irr //incident rate ratio estimate

//ADJUSTED ANALYSIS

poisson art fem mar kid5 phd ment

//REMOVING PHD

poisson art fem mar kid5 ment













