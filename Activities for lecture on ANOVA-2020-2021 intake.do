cd "G:\Files\mem2\Teaching UNZA\Lecture Slides2014"

clear 
input folate str3 grp 
243 I
251 I
275 I
291 I
347 I
354 I
380 I
392 I
206 II
210 II
226 II
249 II
255 II
273 II
285 II
295 II
309 II
241 III
258 III
270 III
293 III
328 III
end

label var folate "Red cell folate level"
label var grp "Treatment group"
encode grp, gen(grpnum)
twoway scatter folate grpnum, ytitle("Red cell folate (mu g/L)") ///
xlabel(1 "Group I" 2 "Group II" 3 "Group III")  //investingating the distribution

oneway folate grp, tabulate means standard //overall one way ANOVA

mean folate, over(grpnum) //obtaining confidence intervals for the values

oneway folate grp, bonferroni  
oneway folate grp, bonferroni  tabulate means standard //pairwise comparison taking account of multiple testing.
oneway folate grp,  scheffe  tabulate means standard  //another multiple testing command.

//ENTERING DATA FOR PRACTICAL, ANOVA

clear 
input years trtgrp 
15 1
17 1
18 1
20 1
20 1
20 1
30 1
37 1
43 1
48 1
60 1
100 1
100 1
8 2
10 2
15 2
20 2
22 2
24 2
25 2
26 2
27 2
29 2
30 2
30 2
35 2
35 2
39 2
40 2
40 2
40 2
40 2
40 2
40 2
45 2
45 2
45 2
50 2
51 2
52 2
55 2
58 2
60 2
60 2
60 2
60 2
60 2
60 2
60 2
60 2
60 2
66 2
66 2
67 2
68 2
68 2
70 2
70 2
70 2
75 2
75 2
75 2
75 2
76 2
80 2
80 2
80 2
80 2
80 2
80 2
80 2
84 2
84 2
84 2
90 2
90 2
90 2
90 2
95 2
96 2
98 2
98 2
99 2
100 2
100 2
100 2
100 2
100 2
100 2
105 2
110 2
110 2
120 2
120 2
123 2
125 2
125 2
126 2
130 2
130 2
132 2
132 2
142 2
157 2
180 2
8 3
15 3
25 3
25 3
25 3
26 3
30 3
34 3
35 3
36 3
40 3
45 3
45 3
45 3
45 3
48 3
48 3
49 3
52 3
60 3
60 3
60 3
64 3
64 3
70 3
70 3
70 3
70 3
75 3
75 3
76 3
80 3
80 3
82 3
86 3
87 3
90 3
90 3
90 3
90 3
90 3
95 3
100 3
102 3
105 3
105 3
105 3
111 3
113 3
120 3
120 3
125 3
125 3
129 3
130 3
133 3
135 3
140 3
154 3
end

label var years "Pack years"
label var trtgrp "Treatment group"
label define trt 1 "NTP" 2 "B" 3 "BNTP"
label values trtgrp trt
tab trt

//save packyears, replace

//EXPLORING DISTRIBTION USING A BOXPLOT
graph box years, over(trtgrp)

//We have no reason to doubt the normality assumptions

*graph save Graph "G:\Files\mem2\Teaching UNZA\Lecture Slides2014\fig1anova.gph"

oneway years trtgrp, tabulate means standard

//The results suggests that we have strong (p-value=0.004) evidence of a difference in means

oneway years trtgrp, tabulate means standard bonferroni

/*In the results above, we see significant differences in the number of pack years for  
the pairwise comparisons of: B VS NTP (B group greater by 33.3 pack years, p-value=0.005), BNTP VS NTP group
(BNTP greater 35.6 years on average, p-value=0.003), and no evidece of a difference between BNTP VS B 
group, p-value=1.000. */  

//EXAMPLE ON REPEATED MEASURES-ANOVA

clear
input subject t0 t30 t60 t120 wmean wsd 
1 96 92 86 92 91.5 4.1
2 110 106 108 114 109.5 3.4
3 89 86 85 83 85.75 2.5
4 95 78 78 83 83.5 8.0
5 128 124 118 118 122.0 4.9
6 100 98 100 94 98.0 2.8
7 72 68 67 71 69.5 2.4
8 79 75 74 74 75.5 2.4
9 100 106 104 102 103.0 2.6
end

label var subject "Individual in the study"
labe var t0 "Heart rate at baseline"
label var t30 "Heart rate at 30 minutes"
label var t60 "Heart rate at 60 minutes"
label var t120 "Heart rate at 120 minutes"
label var wmean "Within subject mean"
labe var wsd "Within subject sd"

//Reshaping from wide to long
reshape long t, i(subject) j(timepoint)
rename t hrate
label var timepoint "Time point in minutes"
label var hrate "Heart rate"

*save longrate, replace 
use longrate, clear

anova hrate subject timepoint, repeated(timepoint)



predict res, residual //Obtaining residuals
qnorm res
hist res, normal

rvfplot   //residual vs fitted values, no obvious patterns

rvpplot timepoint, yline(0) //residuals with time plot, no obvious patterns
rvpplot subject, yline(0)
//EXAMPLE 2 ON TWO-WAY ANOVA

clear 
input headache trtgrp scores
1 1 5.7
1 1 5.63
1 1 4.83
1 1 3.40
1 1 15.20
1 1 1.40
1 1 4.03
1 1 6.94
1 1 0.88
1 1 2.00
1 1 1.56
1 2 2.80
1 2 2.20
1 2 1.20
1 2 1.20
1 2 0.43
1 2 1.78
1 2 11.50
1 2 0.64
1 2 0.95
1 2 0.58
1 2 0.83
2 1 2.70
2 1 4.65
2 1 5.25
2 1 8.78
2 1 3.13
2 1 3.27
2 1 7.54
2 1 5.12
2 1 2.31
2 1 1.36
2 1 1.11
2 2 2.10
2 2 1.42
2 2 4.98
2 2 3.36
2 2 2.44
2 2 3.20
2 2 1.71 
2 2 1.24
2 2 1.24
2 2 2.00
2 2 4.01
end
label var headache "Headache type"
label var trtgrp "Treatment group"
label define trt 1 "Active" 2 "Placebo"
label values trtgrp trt
tab trtgrp
label var scores "Scores of unpleasant volume"

label define head 1 "Migraine" 2 "Tension"
label values headache head

bysort trtgrp: summ scores
bysort headache: summ scores

bysort trtgrp: summ scores if headache==1
bysort trtgrp: summ scores if headache==2

graph box scores, over(trtgrp) over(headache)

//TRANSFORMING THE DATA TO REDUCE SKEWNESS
gen lgscores=log(scores)

label var lgscores "Natural log transformed scores"

//BOXPLOT AFTER TRANSFORMING THE DATA
graph box lgscores, over(trtgrp) over(headache)

*save headache, replace

anova lgscores trtgrp headache
//INVESTIGATING INTERACTION EFFECT
anova lgscores trtgrp headache trtgrp#headache

oneway lgscores trtgrp, tabulate mean standard 
oneway lgscores headache, tabulate mean standard

ttest lgscores, by(trtgrp) 

//PRACTICAL ACTIVITIES ON ANOVA

clear 
input forcenewt agegrp
193.6 1
137.5 1
122.0 1
145.4 1
117.0 1
105.4 1
99.9 1
74.0 1
74.4 1
112.8 1
125.4 2
126.5 2
115.9 2
98.8 2
94.3 2
99.9 2
83.3 2
72.8 2
83.5 2
59.0 3
87.2 3
84.4 3
78.1 3
51.9 3
57.1 3
54.7 3
78.6 3
53.7 3
96.0 3
end
label var forcenewt "Force in newtons"
label var agegrp "Age group"

label define age 1 "Young" 2 "Middle-age" 3 "Elderly"
label values agegrp age

//(a)
hist forcenewt, by(agegrp) normal //Not easy to see here because of sample size
graph box forcenewt, over(agegrp) title("Figure 1." "Exploring normality assumptions")

//(d)
oneway forcenewt agegrp, tabulate means standard

//(f)
oneway forcenewt agegrp, tabulate means standard bonferroni

//ENTERING DATA FOR PRACTICAL ON REPEATED MEASURES-ANOVA, QUN 2

clear
input patient t0 t1 t2 t3 
1 249 108 93 59
2 1095 593 600 861
3 83 27 32 61
4 569 363 342 312
5 368 141 167 180
6 326 134 144 158
7 324 126 312 260
8 95 41 63 71
9 413 365 282 321
10 332 293 525 455
end

label var patient "Individual patient in the study"
labe var t0 "Number of ticks at baseline"
label var t1 "Number of ticks when gum was being chewed"
label var t2 "Number of ticks after chewing gum 0-30mins"
label var t3 "Number of ticks after chewing gum 30-60mins"


//Reshaping from wide to long
reshape long t, i(patient) j(timepoint)
rename t numticks
label var timepoint "Time point repeated"
label var numticks "Number of ticks observed at different timepoints"

* saveold "C:\Teaching UNZA\Lectureslides2016-2017\longticks.dta", version(12)
//(saving in Stata 12 format, which can be read by Stata 11 or 12)
//file C:\Teaching UNZA\Lectureslides2016-2017\longticks.dta saved


use longticks, clear

anova numticks patient timepoint, repeated(timepoint)

rvfplot   //residual vs fitted values, no obvious patterns

rvpplot timepoint, yline(0) //residuals with time plot, no obvious patterns
rvpplot patient, yline(0)
predict res, residual //Obtaining residuals
qnorm res
hist res, normal










 
