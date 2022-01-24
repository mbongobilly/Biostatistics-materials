cd "C:\Teaching UNZA\Lectureslides2016-2017"

//ACTIVITIES IN THE LECTURE

tabi 20 220\80 140, chi2 expected row

tabi 16 48\40 20, chi2 expected row col

//SMALL SAMPLE CHI-SQUARED
tabi 10 2\2 4, chi2 expected col

//USING FISHER'S EXACT TEST
tabi 10 2\2 4, expected col exact 



tabi 20 18 12\32 20 8\18 12 10, chi2 expected row 

//MATCHED STUDIES

symmi 212 144\256 707  

mcci 212 144 256 707  

//The r by c Contingency tables
tabi 20 18 12\32 20 8\18 12 10, chi2 expected row 

// TREND DATA


/*clear
set obs 583
expand age 80
gen age=1
replace age=2 in 81/581
tab age
gen tricep=1
replace tricep=2 in 81/156
tab age tricep

save trend, replace

label define age 1 "<12 yrears" 2 "12 + years"
label values age age
label define tricep 1 "Small" 2 "Intermediate" 3 "Large"
label values tricep tricep
*/

use trend, clear

*nptrend tricep, by(age)
tab age tricep, col
nptrend age, by(tricep)

signtest age = tricep

spearman age tricep

