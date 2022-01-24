
//ASSINGMENT Solutions 
//Summary statistics 
Summarize age acidlevo
tab xray
tab tumasize
tab tumagrad
tab nodoinvov

//Univariate Analysis 
glm nodoinvov age, family(binomial) link(logit) eform
glm nodoinvov acidlevo, family(binomial) link(logit) eform
glm nodoinvov xray, family(binomial) link(logit) eform
glm nodoinvov tumasize, family(binomial) link(logit) eform
glm nodoinvov tumagrad, family(binomial) link(logit) eform

glm nodoinvov xray tumasize tumagrad acidlevo age, family(binomial) link(logit) eform

stepwise, pe(0.3): glm nodoinvov xray tumasize tumagrad acidlevo age, family(binomial) link(logit) eform

stepwise, pr(0.2): glm nodoinvov xray tumasize tumagrad acidlevo age, family(binomial) link(logit) eform

 