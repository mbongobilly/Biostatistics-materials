
cd  "G:\Files\mem2\Teaching UNZA\Lecture Slides2014"

  *use cyst, clear 
 
 lab var sub "Subject number"
 lab var age "Age in years"
 lab var sex "sex, 0=male, 1=female"
 lab var height "height in metres"
 lab var weight "Weight in kg"
 lab var bmp "Body max (weight/height^2) as a percentage of the age specific median in normal people"
 lab var fev1 "Force expiratory volume in 1 minute"
 lab var rv "Residual volume"
 lab var frc "Functional residual capacity"
 lab var tlc "Total lung capacity"
 lab var pemax "maximal static expiratory pressure (cm H2O)"
 
 *save cyst, replace
use "G:\Files\mem2\Teaching UNZA\UNZA LECTURE NOTES 2013\cyst11.dta", clear


 use cyst, clear 
 use cyst11, clear
 
 de
 
 //UNIVARIATE ANALYSIS
 regress pemax age
 regress pemax sex
 regress pemax height
 regress pemax weight
 regress pemax bmp
 regress pemax fev1
 regress pemax rv
 regress pemax frc
 regress pemax tlc
 
 regress pemax age height we //MULTIPLE REGRESSION WITH ONLY SIGNIFICANT VARIABLE
ight fev1 frc 
 
 //FITTING THE MODEL WITHOUT WEIGHT
  regress pemax age height fev1 frc
  regress pemax age fev1 frc
  regress pemax age fev1 
  
  //FORWARD STEPWISE REGRESSION
  stepwise, pe(.2): regress pemax age sex height weight bmp fev1 rv frc tlc
  
  //BACKWARD STEPWISE REGRESSION
   stepwise, pr(.2): regress pemax age sex height weight bmp fev1 rv frc tlc
   
   //EXAMPLE 2
   use lbw1, clear
   use "G:\Files\mem2\Teaching UNZA\Lecture Slides2014\lbw1.dta", clear
   *use lbw1, clear
   describe
   
   regress bwt age lwt smoke
   
   lincom _cons+smoke+120*lwt+30*age
   
   adjust age=30 lwt=120, by(smoke) se ci
   
   margins, at(age=30 lwt=120 smoke=1)
   margins, at(age=30 lwt=120 smoke=0)
   
   *testparm smoke
   
   tab1 race, generate(race)
   ssc desc groups
   net install groups //only if stata is connected to internet
   groups race*
   list race race1 race2 race3
   
   regress bwt smoke race?
   
   regress bwt smoke race2 race3   //making white mothers reference group
   regress bwt smoke race2 race1  //making other mothers reference group
   
   xi: regress bwt i.smoke i.race
   
   list smoke race _Ismoke_1 _Irace_2 _Irace_3
   describe
   
   char race[omit] 2
   xi: regress bwt i.smoke i.race
   
   char race[omit]  //this restores the default reference category being the lowest insted of 2
   quietly xi: regress bwt i.smoke i.race
   testparm _Irace*
   
   quietly xi: regress bwt i.smoke i.race
   predict pbwt if e(sample)
   predict resid if e(sample), residual
   table smoke, by(race) c(mean bwt mean pbwt mean resid) format(%8.0f)
   
   //FITTING AN INTERACTION MODEL
   
   xi: regress bwt i.smoke*i.race

   groups smoke race _I*, sepby(smoke) show(f) abbrev(13) nolabel
   
   quietly xi: regress bwt i.smoke*i.race
   predict pbwt2 if e(sample)
   predict resid2 if e(sample), residual
   table smoke, by(race) c(mean bwt mean pbwt2 mean resid2) format(%8.0f)

   
   
   
   
   
  use "G:\Files\mem2\Teaching UNZA\UNZA LECTURE NOTES 2013\cyst11.dta", clear


 use cyst, clear 
 use cyst11, clear
 
 de
 
 //UNIVARIATE ANALYSIS
 regress pemax age
 regress pemax sex

  //MULTIPLE REGRESSION WITH ONLY SIGNIFICANT VARIABLE
regress pemax age height weight fev1 frc 
 
  
  
  
     use "G:\Files\mem2\Teaching UNZA\Lecture Slides2014\lbw1.dta", clear
   *use lbw1, clear
   describe
   
   regress bwt age lwt smoke
  
  
  
  
  *testparm smoke
   
   tab1 race, generate(race)
   group race*
  
   list race race1 race2 race3
   
   regress bwt smoke race?
   
  
  
  
  
  
  

use "aE:MSC UNZA INTRO BIOSTATISTICS\nesthesia11. dta", clear


 use anesthesia, clear 
 use anesthesia11, clear
 
 de
 
 //UNIVARIATE ANALYSIS
 regress depression trauma
 regress depression durat

 
 //MULTIPLE REGRESSION WITH ONLY SIGNIFICANT VARIABLE
 regress depression trauma durat
 


