//Data set used in analysis
use prostat9.dta, clear
//to see how the variables are names and presented
tab

 //CHECKING THE VARIABLES IN THE DATA
 describe
 // Descriptives stats 
 // the varibles in the question are; age is continuous, to summarise the data we use the summarise command
  summ age acidlevo
  tab nodoinvov xray 
  tab nodoinvov tumasize
  tab nodoinvov tumagrad
  
 
 //univariate analysis of the variables to see which variables explain the outcome better

  glm nodoinvov age, family(binomial) link(logit) eform 
   glm nodoinvov acidlevo, family(binomial) link(logit) eform //acidlevo
    glm nodoinvov xray, family(binomial) link(logit) eform
	 glm nodoinvov tumasize, family(binomial) link(logit) eform
	  glm nodoinvov tumagrad, family(binomial) link(logit) eform
	  //at univariate, only three variables were statistically signficant xray, tumasize, tumagrad and the other variables age and acidlevo were not significant

//fiting a model with all the variables

  glm nodoinvov age acidlevo xray tumasize tumagrad, family(binomial) link(logit) eform 
  //two varibles age and tumagrad were not significant,with p values greater than 0.05 
  
  
  //finding a best fit model by first removing the varibale with the highest p value
  
    glm nodoinvov age acidlevo xray tumasize, family(binomial) link(logit) eform 

//So even after removing tumagrad which had the highest p value, age is still not significant therefore we remove age

    glm nodoinvov acidlevo xray tumasize, family(binomial) link(logit) eform 
	
	// model without acidlevo
	glm nodoinvov age xray tumasize, family(binomial) link(logit) eform
	
	//	model without age
	glm nodoinvov xray tumasize, family(binomial) link(logit) eform

	//model with only xray and tumasize are statistically explaining the outcome better but may not be the best model
	
	//model without age
	  glm nodoinvov acidlevo xray tumasize tumagrad, family(binomial) link(logit) eform
	  
	  //model without age and acidlevo

	  //software led stepwise
	  //backwards
	  stepwise, pr(.2): glm nodoinvov age acidlevo xray tumasize tumagrad, family(binomial) link(logit) eform 
	  
	  //forward
	  stepwise, pe(.2): glm nodoinvov age acidlevo xray tumasize tumagrad, family(binomial) link(logit) eform 

	  
	  //qq plots normality assumption check
	  quantile age
	  quantile acidlevo
	  
	  //used qnorm
	  qnorm age
	  qnorm acidlevo
	  
	  
	  //log transform age and acidlevo, data looks skewed
	  gen lage=log(age)
	  gen lacidlevo=log(acidlevo)
	  
	  //running the whole model with log
	    glm nodoinvov lage lacidlevo xray tumasize tumagrad, family(binomial) link(logit) eform 
		
		//tumagrad has highest p value, removed and model redone without it
		  glm nodoinvov lage lacidlevo xray tumasize, family(binomial) link(logit) eform 
		  
		  //age still not good, removing age picked this mdel
		    glm nodoinvov lacidlevo xray tumasize, family(binomial) link(logit) eform 
			//all remaining values are significant
			
			//model without log tranforming acidlevo
			  glm nodoinvov acidlevo xray tumasize, family(binomial) link(logit) eform 
			  //acidlevo not good
			  // we compare the two models using the AIC and BIC
			  
	// interaction between acidlevo and tumaize
	gen tuma_acidlevo=tumasize*lacidlevo
	
	gen xray_acidlevo=xray*acidlevo
	
	
	//model with interaction
	glm nodoinvov lacidlevo xray tumasize tuma_acidlevo, family(binomial) link(logit) eform
		glm nodoinvov lacidlevo xray tumasize xray_acidlevo, family(binomial) link(logit) eform

	//interaction not good
	

	
	// best fit model is the one with xray, acidlevo and tumasize
	
	//looking at the fact that acidlevo show some skewness, the model with log acidlevo is better and statistically significant
	
		
		//likelihood ratio test
		
	//	Full model
 glm nodoinvov lage lacidlevo xray tumasize tumagrad, family(binomial) link(logit) eform
estimates store A

 //Nested model
  glm nodoinvov lacidlevo xray tumasize, family(binomial) link(logit) eform
estimates store B

lrtest A B

//ESTIMATING SENSITIVITY, SPECIFICITY, PPV, NPPV, FALSE RATES, CORRECT CLASSIFICATIONS, AND ROC
logistic nodoinvov i.xray i.tumasize lacidlevo
lstat
lroc

			




	
	



 
