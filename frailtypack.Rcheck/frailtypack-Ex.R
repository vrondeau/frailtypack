pkgname <- "frailtypack"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "frailtypack-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('frailtypack')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("Cmeasures")
### * Cmeasures

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Cmeasures
### Title: Concordance measures in shared frailty and Cox proportional
###   hazard models
### Aliases: Cmeasures CbootstrapFP cindexes.frailty cindexes.W cindexes.B
###   cindexes statFP
### Keywords: concordance

### ** Examples



## No test: 

#-- load data
data(readmission)

#-- a frailtypenal fit
fit <- frailtyPenal(Surv(time,event)~cluster(id)+dukes+
charlson+chemo,data=readmission,cross.validation=FALSE,
n.knots=10,kappa=1,hazard="Splines")

#-- a Cmeasures call
fit.Cmeasures <- Cmeasures(fit)
fit.Cmeasures.noties <- Cmeasures(fit, ties=0)
fit.Cmeasures.marginal <- Cmeasures(fit, marginal=1)
fit.Cmeasures.cindex <- Cmeasures(fit, cindex=1)

#-- a short summary
fit.Cmeasures
fit.Cmeasures.noties
fit.Cmeasures.marginal
fit.Cmeasures.cindex

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Cmeasures", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Diffepoce")
### * Diffepoce

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Diffepoce
### Title: Difference of Expected Prognostic Observed Cross-Entropy (EPOCE)
###   estimators and its 95% tracking interval between two joint models.
### Aliases: Diffepoce
### Keywords: misc

### ** Examples



## Not run: 
##D 
##D #Example for joint frailty models
##D data(readmission)
##D 
##D # first joint frailty model
##D joint1 <- frailtyPenal(Surv(t.start,t.stop,event)~ cluster(id) +
##D   dukes + charlson + sex + chemo + terminal(death),
##D   formula.terminalEvent = ~ dukes + charlson + sex + chemo ,
##D   data = readmission, n.knots = 8, kappa = c(2.11e+08,9.53e+11),
##D   recurrentAG=TRUE)
##D 
##D # second joint frailty model without dukes nor charlson as covariates
##D joint2 <- frailtyPenal(Surv(t.start,t.stop,event)~ cluster(id) +
##D   sex + chemo + terminal(death),
##D   formula.terminalEvent = ~ sex + chemo ,
##D   data = readmission, n.knots = 8, kappa = c(2.11e+08,9.53e+11),
##D   recurrentAG=TRUE)
##D 
##D temps <- c(200,500,800,1100)
##D 
##D # computation of estimators of EPOCE for the two models
##D epoce1 <- epoce(joint1,temps)
##D epoce2 <- epoce(joint2,temps)
##D 
##D # computation of the difference
##D diff <- Diffepoce(epoce1,epoce2)
##D 
##D print(diff)
##D plot(diff)
##D 
##D 
##D #Example for joint models with a biomarker
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D # first joint model for a biomarker and a terminal event
##D modLongi <- longiPenal(Surv(time0, time1, state) ~ age +
##D treatment + who.PS, tumor.size ~  year*treatment + age +
##D who.PS, colorectalSurv, data.Longi =colorectalLongi,
##D random = c("1", "year"),  id = "id", link = "Random-effects", 
##D left.censoring = -3.33, hazard = "Weibull", 
##D method.GH = "Pseudo-adaptive")
##D 
##D # second joint model for a biomarker, recurrent events and a terminal event
##D # (computation takes around 30 minutes)
##D modTriv <- model.weib.RE.gap <-trivPenal(Surv(gap.time, new.lesions) 
##D ~ cluster(id) + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive", n.nodes=7)
##D 
##D time <- c(1, 1.5, 2, 2.5)
##D 
##D # computation of estimators of EPOCE for the two models
##D epoce1 <- epoce(modLongi, time)
##D # (computation takes around 10 minutes)
##D epoce2 <- epoce(modTriv, time)
##D 
##D 
##D # computation of the difference
##D diff <- Diffepoce(epoce1, epoce2)
##D 
##D print(diff)
##D plot(diff)
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Diffepoce", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GenfrailtyPenal")
### * GenfrailtyPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GenfrailtyPenal
### Title: Fit a Shared or a Joint Frailty Generalized Survival Model
### Aliases: GenfrailtyPenal
### Keywords: models

### ** Examples

## No test: 

#############################################################################
# -----        GENERALIZED SURVIVAL MODELS (without frailties)       -----  #
#############################################################################

adult.retino = retinopathy[retinopathy$type == "adult", ]
adult.retino[adult.retino$futime >= 50, "status"] = 0
adult.retino[adult.retino$futime >= 50, "futime"] = 50

### ---  Parametric PH, AH, PO and probit models  --- ###

GenfrailtyPenal(formula=Surv(futime,status)~trt, data=adult.retino, 
hazard="parametric", family="PH")
GenfrailtyPenal(formula=Surv(futime,status)~trt, data=adult.retino, 
hazard="parametric", family="AH")
GenfrailtyPenal(formula=Surv(futime,status)~trt, data=adult.retino, 
hazard="parametric", family="PO")
GenfrailtyPenal(formula=Surv(futime,status)~trt, data=adult.retino, 
hazard="parametric", family="probit")

### ---  Semi-parametric PH and AH models  --- ###

GenfrailtyPenal(formula=Surv(futime,status)~timedep(trt), data=adult.retino, 
family="PH", hazard="Splines", n.knots=8, kappa=10^6, betaknots=1, betaorder=2)
GenfrailtyPenal(formula=Surv(futime,status)~timedep(trt), data=adult.retino, 
family="AH", hazard="Splines", n.knots=8, kappa=10^10, betaknots=1, betaorder=2)



#############################################################################
# -----          SHARED FRAILTY GENERALIZED SURVIVAL MODELS          -----  #
#############################################################################

adult.retino = retinopathy[retinopathy$type == "adult", ]
adult.retino[adult.retino$futime >= 50, "status"] = 0
adult.retino[adult.retino$futime >= 50, "futime"] = 50

### ---  Parametric PH, AH, PO and probit models  --- ###

GenfrailtyPenal(formula=Surv(futime,status)~trt+cluster(id), data=adult.retino, 
hazard="parametric", family="PH")
GenfrailtyPenal(formula=Surv(futime,status)~trt+cluster(id), data=adult.retino, 
hazard="parametric", family="AH")
GenfrailtyPenal(formula=Surv(futime,status)~trt+cluster(id), data=adult.retino, 
hazard="parametric", family="PO")
GenfrailtyPenal(formula=Surv(futime,status)~trt+cluster(id), data=adult.retino, 
hazard="parametric", family="probit")

### ---  Semi-parametric PH and AH models  --- ###

GenfrailtyPenal(formula=Surv(futime,status)~cluster(id)+timedep(trt), 
data=adult.retino, family="PH", hazard="Splines", 
n.knots=8, kappa=10^6, betaknots=1, betaorder=2)
GenfrailtyPenal(formula=Surv(futime,status)~cluster(id)+timedep(trt), 
data=adult.retino, family="AH", hazard="Splines", 
n.knots=8, kappa=10^10, betaknots=1, betaorder=2)



#############################################################################
# -----         JOINT FRAILTY GENERALIZED SURVIVAL MODELS            -----  #
#############################################################################

data("readmission") 
readmission[, 3:5] = readmission[, 3:5]/365.25

### ---  Parametric dual-PH, AH, PO and probit models  --- ###

GenfrailtyPenal(
formula=Surv(t.start,t.stop,event)~cluster(id)+terminal(death)+sex+dukes+chemo,
formula.terminalEvent=~sex+dukes+chemo, data=readmission, recurrentAG=TRUE, 
hazard="parametric", family=c("PH","PH"))
GenfrailtyPenal(
formula=Surv(t.start,t.stop,event)~cluster(id)+terminal(death)+sex+dukes+chemo,
formula.terminalEvent=~sex+dukes+chemo, data=readmission, recurrentAG=TRUE, 
hazard="parametric", family=c("AH","AH"))
GenfrailtyPenal(
formula=Surv(t.start,t.stop,event)~cluster(id)+terminal(death)+sex+dukes+chemo,
formula.terminalEvent=~sex+dukes+chemo, data=readmission, recurrentAG=TRUE, 
hazard="parametric", family=c("PO","PO"))
GenfrailtyPenal(
formula=Surv(t.start,t.stop,event)~cluster(id)+terminal(death)+sex+dukes+chemo,
formula.terminalEvent=~sex+dukes+chemo, data=readmission, recurrentAG=TRUE, 
hazard="parametric", family=c("probit","probit"))

### ---  Semi-parametric dual-PH and AH models  --- ###

GenfrailtyPenal(
formula=Surv(t.start,t.stop,event)~cluster(id)+terminal(death)+sex+dukes+timedep(chemo),
formula.terminalEvent=~sex+dukes+timedep(chemo), data=readmission, recurrentAG=TRUE, 
hazard="Splines", family=c("PH","PH"), 
n.knots=5, kappa=c(100,100), betaknots=1, betaorder=3)

## Not run: 
##D GenfrailtyPenal(
##D formula=Surv(t.start,t.stop,event)~cluster(id)+terminal(death)+sex+dukes+timedep(chemo),
##D formula.terminalEvent=~sex+dukes+timedep(chemo), data=readmission, recurrentAG=TRUE,
##D hazard="Splines", family=c("AH","AH"),
##D n.knots=5, kappa=c(600,600), betaknots=1, betaorder=3)
## End(Not run)

## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GenfrailtyPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("SurvIC")
### * SurvIC

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: SurvIC
### Title: Create a survival object for interval censoring and possibly
###   left truncated data
### Aliases: SurvIC

### ** Examples



## No test: 

data(bcos)
bcos$event <- ifelse(bcos$left!=bcos$right,1,0)

###---  Cox proportional hazard model with interval censoring ---###

cox.ic <- frailtyPenal(SurvIC(left,right,event)~treatment,
data=bcos,n.knots=8,kappa=10000)

###---  Shared model with interval censoring ---###

bcos$group <- c(rep(1:20,4),1:14)

sha.ic <- frailtyPenal(SurvIC(left,right,event)~cluster(group)+
treatment,data=bcos,n.knots=8,kappa=10000)

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("SurvIC", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("additivePenal")
### * additivePenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: additivePenal
### Title: Fit an Additive Frailty model using a semiparametric penalized
###   likelihood estimation or a parametric estimation
### Aliases: additivePenal
### Keywords: file

### ** Examples



## No test: 

###--- Additive model with 1 covariate ---###

data(dataAdditive)

modAdd <- additivePenal(Surv(t1,t2,event)~cluster(group)+
var1+slope(var1),correlation=TRUE,data=dataAdditive,
n.knots=8,kappa=10000)

#-- Var1 is boolean as a treatment variable

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("additivePenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("cluster")
### * cluster

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: cluster
### Title: Identify clusters
### Aliases: cluster
### Keywords: misc

### ** Examples



## No test: 

data(readmission)
modSha <- frailtyPenal(Surv(time,event)~as.factor(dukes)+cluster(id),
n.knots=10,kappa=10000,data=readmission,hazard="Splines")

print(modSha)

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("cluster", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("epoce")
### * epoce

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: epoce
### Title: Estimators of the Expected Prognostic Observed Cross-Entropy
###   (EPOCE) for evaluating predictive accuracy of joint models.
### Aliases: epoce
### Keywords: misc

### ** Examples



## Not run: 
##D 
##D ########################################
##D #### EPOCE on a joint frailty model ####
##D ########################################
##D 
##D data(readmission)
##D 
##D modJoint.gap <- frailtyPenal(Surv(t.start,t.stop,event)~ cluster(id) +
##D   dukes + charlson + sex + chemo + terminal(death),
##D   formula.terminalEvent = ~ dukes + charlson + sex + chemo ,
##D   data = readmission, n.knots = 8, kappa =c(2.11e+08,9.53e+11),
##D   recurrentAG=TRUE)
##D 
##D # computation on the same dataset
##D temps <- c(200,500,800,1100)
##D epoce <- epoce(modJoint.gap,temps)
##D 
##D print(epoce)
##D plot(epoce,type = "cvpol")
##D 
##D # computation on a new dataset
##D # here a sample of readmission with the first 50 subjects
##D s <- readmission[1:100,]
##D epoce <- epoce(modJoint.gap,temps,newdata=s)
##D 
##D print(epoce)
##D plot(epoce,type = "mpol")
##D 
##D #################################################
##D #### EPOCE on a joint  model for a biomarker ####
##D #########   and a terminal event  ###############
##D #################################################
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D modLongi <- longiPenal(Surv(time0, time1, state) ~ age +
##D treatment + who.PS, tumor.size ~  year*treatment + age +
##D who.PS, colorectalSurv, data.Longi =colorectalLongi,
##D random = c("1", "year"),  id = "id", link = "Random-effects", 
##D left.censoring = -3.33, hazard = "Weibull", 
##D method.GH = "Pseudo-adaptive")
##D 
##D # computation on the same dataset
##D time <- c(1, 1.5, 2, 2.5)
##D epoce <- epoce(modLongi,time)
##D 
##D print(epoce)
##D plot(epoce, type = "cvpol")
##D 
##D # computation on a new dataset
##D # here a sample of colorectal data with the first 50 subjects
##D s <-  subset(colorectal, new.lesions == 0 & id%in%1:50)
##D s.Longi <- subset(colorectalLongi, id%in%1:50)
##D epoce <- epoce(modLongi, time, newdata = s, newdata.Longi = s.Longi)
##D 
##D print(epoce)
##D plot(epoce, type = "mpol")
##D 
##D 
##D ###################################################
##D #### EPOCE on a joint model for a biomarker, ######
##D #### recurrent events and a terminal event   ######
##D ###################################################
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Linear model for the biomarker
##D # (computation takes around 30 minutes)
##D model.trivPenalNL <-trivPenal(Surv(gap.time, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive", n.nodes=7)
##D 
##D # computation on the same dataset
##D time <- c(1, 1.5, 2, 2.5)
##D 
##D # (computation takes around 10 minutes)
##D epoce <- epoce(model.trivPenalNL,time)
##D print(epoce)
##D plot(epoce, type = "cvpol")
##D 
##D # computation on a new dataset
##D # here a sample of colorectal data with the first 100 subjects
##D s <-  subset(colorectal,  id%in%1:100)
##D s.Longi <- subset(colorectalLongi, id%in%1:100)
##D # (computation takes around 10 minutes)
##D epoce <- epoce(model.trivPenalNL, time, newdata = s, newdata.Longi = s.Longi)
##D 
##D print(epoce)
##D plot(epoce, type = "mpol")
##D 
##D 
##D 
##D # Non-linear model for the biomarker
##D 
##D # No information on dose - creation of a dummy variable 
##D colorectalLongi$dose <- 1
##D 
##D # (computation can take around 40 minutes)
##D model.trivPenalNL <- trivPenalNL(Surv(time0, time1, new.lesions) ~ cluster(id) + age + treatment
##D  + terminal(state), formula.terminalEvent =~ age + treatment, biomarker = "tumor.size",
##D  formula.KG ~ 1, formula.KD ~ treatment, dose = "dose", time.biomarker = "year", 
##D  data = colorectal, data.Longi =colorectalLongi, random = c("y0", "KG"), id = "id", 
##D  init.B = c(-0.22, -0.16, -0.35, -0.19, 0.04, -0.41, 0.23), init.Alpha = 1.86,
##D  init.Eta = c(0.5, 0.57, 0.5, 2.34), init.Biomarker = c(1.24, 0.81, 1.07, -1.53),
##D  recurrentAG = TRUE, n.knots = 5, kappa = c(0.01, 2), method.GH = "Pseudo-adaptive")
##D 
##D # computation on the same dataset
##D time <- c(1, 1.5, 2, 2.5)
##D 
##D epoce <- epoce(model.trivPenalNL, time)
##D 
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("epoce", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("frailtyCmprsk")
### * frailtyCmprsk

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: frailtyCmprsk
### Title: Fit a Weibull Competing Risks Model with Optional Shared Frailty
### Aliases: frailtyCmprsk

### ** Examples

## No test: 


data(CPRSKbmtcrr)

##-- Weibull competing risks model with 
##   group frailty shared between transitions --##

ModCmprsk_Group <- frailtyCmprsk(
  formulas = list(
    Surv(observed_time, Status, type = "mstate") ~ cluster(group) + Sex,
    ~ Sex
  ),
  data        = CPRSKbmtcrr,
  print.info  = FALSE,
  maxit       = 100
)

##-- Weibull competing risks model with subject-specific 
##   frailty shared between transitions --##

ModCmprsk_Subject <- frailtyCmprsk(
  formulas = list(
    Surv(observed_time, Status, type = "mstate") ~ cluster(id) + Sex,
    ~ Sex
  ),
  data        = CPRSKbmtcrr,
  print.info  = FALSE,
  maxit       = 100
)

##--- Simple Weibull competing risks model with left truncation ---##

ModCmprsk_LeftTrunc <- frailtyCmprsk(
  formulas = list(
    Surv(Age, observed_time, Status, type = "mstate") ~ Source,
    ~ Sex
  ),
  data       = CPRSKbmtcrr,
  print.info = FALSE
)

##--- Simple Weibull competing risks model with a factor and 
##    no covariates for the first competing event (left truncation) ---##

ModCmprsk_Factor_LeftTrunc <- frailtyCmprsk(
  formulas = list(
    Surv(Age, observed_time, Status, type = "mstate") ~ Source,
    ~ factor(Phase)
  ),
  data       = CPRSKbmtcrr,
  print.info = FALSE
)  
## End(No test)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("frailtyCmprsk", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("frailtyDesign")
### * frailtyDesign

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: frailtyDesign
### Title: Sample Size calculation and Power Analysis using Gamma-Frailty
###   Models
### Aliases: frailtyDesign SFM.power SFM.ssize NFM.power NFM.ssize
###   JFM.power JFM.ssize GJFM.power GJFM.ssize
### Keywords: methods power

### ** Examples

## No test: 
# Example 1 (SFM): a total of 400 patients (1:1 randomization scheme),
# with a fixed number of 3 recurrent events per patient. Gamma-frailty
# variance of 0.5. Expected hazard ratio of 0.7, time-to-death are uniformly
# distributed, with a mean time to death of (3+10)/2=6.5 years. Each subject is
# followed-up for a maximum of 6 years, with a median time-to-event of 1.5 years.
# Patients are recruited over a 0.5-year period.
SFM.power(
  Groups = 400, ni = 3, ni.type = "max",
  FUP = 6, Acc.Dur = 0.5, median.H0 = 1.5,
  beta.HA = log(0.7), theta = 0.5,
  cens.par = c(3, 10), cens.type = "Unif",
  data.type = "rec_event"
) # power ~ 90%


# Example 2 (NFM): same parameters as above, but we now assume that we have
# 40 hospitals, 10 subjects per hospital (10 × 40 = 400 subjects in total)
# and 3 recurrent events per subject.
NFM.power(
  Groups = 40, ni = 10, ni.type = "max", kij = 3, kij.type = "max",
  FUP = 6, Acc.Dur = 0.5, median.H0 = 1.5,
  beta.HA = log(0.7), theta = 0.5,
  cens.par = c(3, 10), cens.type = "Unif",
  data.type = "rec_event1"
) # power ~ 83%


# Example 3 (NFM): we aim to compute the required sample size to achieve
# 80% power for detecting a hazard ratio of 0.75 in a neurological study,
# where migraine episodes experienced by subjects are classified into three
# severity subtypes (mild, moderate, severe). For each subject, we anticipate
# a mean number of 2 migraine episodes per severity subtype, with a median
# time-to-event of 6 months. The study duration includes a 1-year accrual period
# followed by a 5-year total follow-up. All subjects will be followed until
# the end of the study.
NFM.ssize(
  power = 0.80, ni = 3, ni.type = "max", kij = 2, kij.type = "pois",
  FUP = 5, Acc.Dur = 1, FUP.type = "uptoend", median.H0 = 0.5,
  beta.HA = log(0.75), data.type = "rec_event2"
) # sample size ~ 363 patients

# Example 4 (JFM): power estimation, testing a treatment effect on recurrent
# events only. We assume a uniformly distributed number of recurrent events,
# ranging from 1 to 6 recurrent events per subject. The allocation ratio
# experimental:control is 2:1, and the follow-up is 10 weeks.
# The expected hazard ratio is 0.70 for recurrent event and 0.90 for the
# terminal event. We have chosen 0.5 as the variance of the frailties.
JFM.power(
  Npts = 400, ni = c(1, 6), ni.type = "unif",
  FUP = 10, FUP.type = "fixed", ratio = 2,
  betaTest.type = "betaRtest", betaR.HA = log(.70), betaD.HA = log(.90),
  theta = .5
) # power ~ 76%


# Example 5 (JFM): sample size calculation, to assess the treatment effect on
# both recurrent and terminal events. We want to achieve an 80% power.
# We anticipate a maximum of 5 recurrent events, over a 6-year period and a
# 0.5-year accrual period. We assume that the gamma-frailty variance is 0.5.
# For the control group, we expect a 2-year and a 5-year median time-to-event
# for recurrent events and terminal events, respectively. We consider a 30%
# and 20% risk reduction for recurrent events and terminal event, respectively.
JFM.ssize(
  power = 0.80, ni = 9,
  FUP = 6, Acc.Dur = 1.5, medianR.H0 = 2, medianD.H0 = 5,
  betaTest.type = "joint", betaR.HA = log(.70), betaD.HA = log(.80), theta = .5
) # sample size ~ 445 patients / ~ approx 


# Example 6: Sample size calculation for GJFM
# Same as above, but with two random effects (with two Gamma-frailty variances
# theta and eta). To ensure sample size estimation stability, we use 10000
# Monte-Carlo samples.
GJFM.ssize(
  power = 0.80, ni = 5,
  FUP = 6, Acc.Dur = 0.5, medianR.H0 = 2, medianD.H0 = 5,
  betaR.HA = log(0.70), betaD.HA = log(0.80), theta = 0.5, eta = 0.75,
  samples.mc = 1e5
) # sample size ~ 705 patients / ~ approx 4 min.


# Example 7:
# --------------------------------------------------
# Post-hoc power analysis for a Joint Frailty Model
# --------------------------------------------------
# See original article by Gonzalez et al. (2005)
data(readmission)
modJFM <- frailtyPenal(
  Surv(time, event) ~ cluster(id) + as.factor(chemo) + terminal(death),
  formula.terminalEvent = ~ as.factor(chemo), data = readmission,
  hazard = "Weibull"
)

# Test both recurrent and death events
# # - Let us assume an underlying Poisson distribution for ni.type. The
# # empirical mean of the number of recurrent events per patients is: ni = 1.136476.
# # - For the null hypothesis, let us consider betaR.H0 = betaD.H0 = 0. For the
# # alternative hypothesis, we use the estimated parameters for betaD.HA and
# # betaR.HA.
# # - "Patients were actively followed up until June 2002" -> the follow-up
# # type is "UpToEnd".
# # - "The study took place in the Hospital de Bellvitge, [...] between
# # January 1996 and December 1998" -> the accrual time is approximately 3 years
# # - We can assume that the study duration is approximately 6 years

ni <- 1.136476
ni.type <- "Pois"
Acc.Dur <- 3 * 365.25 # time unit = days
FUP <- 6 * 365.25     # same as above
betaR.HA <- as.numeric(modJFM$coef[1]) # else "Named numeric"
betaD.HA <- as.numeric(modJFM$coef[2]) # same as above
med <- modJFM$scale.weib * log(2)^(1 / modJFM$shape.weib)
medianR.H0 <- med[1]
medianD.H0 <- med[2]
shapeR.W <- modJFM$shape[1]
shapeD.W <- modJFM$shape[2]
theta <- modJFM$theta
alpha <- modJFM$alpha
Npts <- length(unique(readmission[, "id"])) # 403 patients
nTreated <- length(unique(readmission[readmission$chemo == "Treated", "id"])) #217 treated patients
ratio <- nTreated / (Npts - nTreated)

JFM.power(
  Npts = Npts, ni = ni, ni.type = ni.type,
  Acc.Dur = Acc.Dur, FUP = FUP, medianR.H0 = medianR.H0, medianD.H0 = medianD.H0,
  betaTest.type = "joint", betaR.HA = betaR.HA, betaD.HA = betaD.HA,
  shapeR.W = shapeR.W, shapeD.W = shapeD.W, theta = theta, alpha = alpha,
  ratio = ratio
) # power ~ 92%

# --------------------------------------------------
# Required sample size under the same setting
# --------------------------------------------------
# Here, let us consider that readmission is a “pilot study” with 403 patients,
# from which we estimate parameters. Under this scenario, let us compute the
# needed sample size, but to achieve an 80% power.

JFM.ssize(
  power = 0.80, ni = ni, ni.type = ni.type,
  Acc.Dur = Acc.Dur, FUP = FUP, medianR.H0 = medianR.H0, medianD.H0 = medianD.H0,
  betaTest.type = "joint", betaR.HA = betaR.HA, betaD.HA = betaD.HA,
  shapeR.W = shapeR.W, shapeD.W = shapeD.W, theta = theta, alpha = alpha,
  ratio = ratio
) # 289 patients needed under the same settings vs. 403
## End(No test)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("frailtyDesign", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("frailtyIllnessDeath")
### * frailtyIllnessDeath

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: frailtyIllnessDeath
### Title: Fit a Weibull Illness-Death Model with Optional Shared Frailty
### Aliases: frailtyIllnessDeath

### ** Examples

## No test: 
 
data(readmission2)

##-- Fitting models --##

#-- Semi-Markovian Weibull Illness-Death model with 
#   group frailty shared between transitions --#

ModIllnessDeath_SemiMarkov_Group <- frailtyIllnessDeath(
  formula = Surv(observed_disease_time, disease_status) ~ cluster(group) + sex,
  formula.terminalEvent = Surv(observed_death_time, death_status) ~ sex,
  data        = readmission2,
  model       = "Semi-Markov",
  print.info  = FALSE,
  maxit       = 100
)

#-- Markovian Weibull Illness-Death model with subject-specific 
#   frailty shared between transitions --#

ModIllnessDeath_Markov_Subject <- frailtyIllnessDeath(
  formula = Surv(observed_disease_time, disease_status) ~ cluster(id) + sex,
  formula.terminalEvent = Surv(observed_death_time, death_status) ~ sex,
  data        = readmission2,
  model       = "Markov",
  print.info  = FALSE,
  maxit       = 100
)

#--- Semi-Markovian Weibull Illness-Death model with a factor and 
#    no covariates for the non-terminal event ---#

ModIllnessDeath_SemiMarkov_NoCov_Factor <- frailtyIllnessDeath(
  formula = Surv(observed_disease_time, disease_status) ~ 1,
  formula.terminalEvent = Surv(observed_death_time, death_status) ~ factor(dukes),
  data        = readmission2,
  model       = "Semi-Markov",
  print.info  = FALSE,
  maxit       = 100
)

#--- Semi-Markovian Weibull Illness-Death model with left truncation ---#

data(Paq810)

ModIllnessDeath_SemiMarkov_LeftTrunc <- frailtyIllnessDeath(
  formula = Surv(e, r, dementia) ~ gender + certif,
  formula.terminalEvent = Surv(t, death) ~ certif,
  data        = Paq810,
  model       = "Semi-Markov",
  print.info  = FALSE,
  maxit       = 100
)

#--- Markovian Weibull Illness-Death model with left truncation ---#

ModIllnessDeath_Markov_LeftTrunc <- frailtyIllnessDeath(
  formula = Surv(e, r, dementia) ~ gender + certif,
  formula.terminalEvent = Surv(t, death) ~ certif,
  data        = Paq810,
  model       = "Markov",
  print.info  = FALSE,
  maxit       = 100
) 
## End(No test)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("frailtyIllnessDeath", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("frailtyPenal")
### * frailtyPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: frailtyPenal
### Title: Fit a Shared, Joint or Nested Frailty model
### Aliases: frailtyPenal waldtest factor.names timedep.names
### Keywords: models

### ** Examples

## No test: 

### ---  COX proportional hazard model (SHARED without frailties) ---###
### ---  estimated with penalized likelihood ---###

data(kidney)
frailtyPenal(Surv(time, status) ~ sex + age,
  n.knots = 12, kappa = 10000, data = kidney
)

### ---  Shared Frailty model  ---###

frailtyPenal(Surv(time, status) ~ cluster(id) + sex + age,
  n.knots = 12, kappa = 10000, data = kidney
)

#-- with an initialisation of regression coefficients

frailtyPenal(Surv(time, status) ~ cluster(id) + sex + age,
  n.knots = 12, kappa = 10000, data = kidney, init.B = c(-1.44, 0)
)

#-- with truncated data

data(dataNested)

frailtyPenal(Surv(t1, t2, event) ~ cluster(group),
  data = dataNested, n.knots = 10, kappa = 10000,
  cross.validation = TRUE, recurrentAG = FALSE
)

#-- stratified analysis

data(readmission)
frailtyPenal(Surv(time, event) ~ cluster(id) + dukes + strata(sex),
  n.knots = 10, kappa = c(10000, 10000), data = readmission
)

#-- recurrentAG=TRUE

frailtyPenal(Surv(t.start, t.stop, event) ~ cluster(id) + sex + dukes +
  charlson, data = readmission, n.knots = 6, kappa = 1e5, recurrentAG = TRUE)

#-- cross.validation=TRUE

frailtyPenal(
  Surv(t.start, t.stop, event) ~ cluster(id) + sex + dukes +
    charlson,
  data = readmission, n.knots = 6, kappa = 5000, recurrentAG = TRUE,
  cross.validation = TRUE
)

#-- log-normal distribution

frailtyPenal(
  Surv(t.start, t.stop, event) ~ cluster(id) + sex + dukes +
    charlson,
  data = readmission, n.knots = 6, kappa = 5000, recurrentAG = TRUE,
  RandDist = "LogN"
)

### --- Joint Frailty model (recurrent and terminal events) ---###

data(readmission)
#-- Gap-time
modJoint.gap <- frailtyPenal(
  Surv(time, event) ~ cluster(id) + sex + dukes + charlson +
    terminal(death),
  formula.terminalEvent = ~ sex + dukes + charlson,
  data = readmission, n.knots = 14, kappa = c(9.55e+9, 1.41e+12),
  recurrentAG = FALSE
)

#-- Calendar time
modJoint.calendar <- frailtyPenal(
  Surv(t.start, t.stop, event) ~ cluster(id) +
    sex + dukes + charlson + terminal(death),
  formula.terminalEvent = ~ sex
  + dukes + charlson, data = readmission, n.knots = 10, kappa = c(9.55e9, 1.41e12),
  recurrentAG = TRUE
)

#-- without alpha parameter
modJoint.gap <- frailtyPenal(
  Surv(time, event) ~ cluster(id) + sex + dukes + charlson +
    terminal(death),
  formula.terminalEvent = ~ sex + dukes + charlson,
  data = readmission, n.knots = 10, kappa = c(9.55e9, 1.41e12),
  recurrentAG = FALSE, Alpha = "None"
)

#-- log-normal distribution

modJoint.log <- frailtyPenal(
  Surv(t.start, t.stop, event) ~ cluster(id) + sex
    + dukes + charlson + terminal(death),
  formula.terminalEvent = ~ sex
  + dukes + charlson, data = readmission, n.knots = 10, kappa = c(9.55e9, 1.41e12),
  recurrentAG = TRUE, RandDist = "LogN"
)

### --- Joint frailty model for NCC data ---###
data(dataNCC)
modJoint.ncc <- frailtyPenal(
  Surv(t.start, t.stop, event) ~ cluster(id) + cov1
    + cov2 + terminal(death) + wts(ncc.wts),
  formula.terminalEvent = ~ cov1 + cov2,
  data = dataNCC, n.knots = 8, kappa = c(1.6e+10, 5.0e+03), recurrentAG = TRUE, RandDist = "LogN"
)


### --- Joint Frailty model for clustered data ---###

#-- here is generated cluster (5 clusters)
readmission <- transform(readmission, group = id %% 5 + 1)

#-- exclusion all recurrent events --#
#--  to obtain framework of semi-competing risks --#
readmission2 <- subset(readmission, (t.start == 0 & event == 1) | event == 0)

joi.clus.gap <- frailtyPenal(
  Surv(time, event) ~ cluster(group) +
    num.id(id) + dukes + charlson + sex + chemo + terminal(death),
  formula.terminalEvent = ~ dukes + charlson + sex + chemo,
  data = readmission2, recurrentAG = FALSE, n.knots = 8,
  kappa = c(1.e+10, 1.e+10), Alpha = "None"
)


### --- General Joint model (recurrent and terminal events)
### --- with 2 covariates ---###

data(readmission)
modJoint.general <- frailtyPenal(
  Surv(time, event) ~ cluster(id) + dukes +
    charlson + sex + chemo + terminal(death),
  formula.terminalEvent = ~ dukes + charlson + sex + chemo,
  data = readmission, jointGeneral = TRUE, n.knots = 8,
  kappa = c(2.11e+08, 9.53e+11)
)


### --- Nested Frailty model ---###

##***** WARNING *****##
# Data should be ordered according to cluster and subcluster

data(dataNested)
modClu <- frailtyPenal(
  Surv(t1, t2, event) ~ cluster(group) +
    subcluster(subgroup) + cov1 + cov2,
  data = dataNested,
  n.knots = 8, kappa = 50000
)

modClu.str <- frailtyPenal(
  Surv(t1, t2, event) ~ cluster(group) +
    subcluster(subgroup) + cov1 + strata(cov2),
  data = dataNested,
  n.knots = 8, kappa = c(50000, 50000)
)
## End(No test)
## Not run: 
##D ### --- Joint Nested Frailty model ---###
##D 
##D #-- here is generated cluster (30 clusters)
##D readmissionNested <- transform(readmission, group = id %% 30 + 1)
##D 
##D modJointNested_Splines <- frailtyPenal(
##D   formula = Surv(t.start, t.stop, event)
##D   ~ subcluster(id) + cluster(group) + dukes + terminal(death),
##D   formula.terminalEvent = ~dukes, data = readmissionNested, recurrentAG = TRUE,
##D   n.knots = 8, kappa = c(9.55e+9, 1.41e+12), initialize = TRUE
##D )
##D 
##D modJointNested_Weib <- frailtyPenal(
##D   Surv(t.start, t.stop, event) ~ subcluster(id)
##D     + cluster(group) + dukes + terminal(death),
##D   formula.terminalEvent = ~dukes,
##D   hazard = ("Weibull"), data = readmissionNested, recurrentAG = TRUE, initialize = FALSE
##D )
##D 
##D JoiNesGapSpline <- frailtyPenal(
##D   formula = Surv(time, event)
##D   ~ subcluster(id) + cluster(group) + dukes + terminal(death),
##D   formula.terminalEvent = ~dukes, data = readmissionNested,
##D   recurrentAG = FALSE, n.knots = 8, kappa = c(9.55e+9, 1.41e+12),
##D   initialize = TRUE, init.Alpha = 1.091, Ksi = "None"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("frailtyPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("frailtypack-package")
### * frailtypack-package

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: frailtypack-package
### Title: General Frailty models: shared, joint and nested frailty models
###   with prediction; Evaluation of Failure-Time Surrogate Endpoints
### Aliases: frailtypack-package
### Keywords: package

### ** Examples



## Not run: 
##D 
##D ###--- Additive model with 1 covariate ---###
##D 
##D data(dataAdditive)
##D modAdd <- additivePenal(Surv(t1,t2,event)~
##D cluster(group)+var1+slope(var1),
##D correlation=TRUE,data=dataAdditive,
##D n.knots=8,kappa=10000,hazard="Splines")
##D 
##D ###--- Joint model (recurrent and terminal events) with 2 covariates ---###
##D 
##D data(readmission)
##D modJoint.gap <- frailtyPenal(Surv(time,event)~
##D cluster(id)+sex+dukes+charlson+terminal(death),
##D formula.terminalEvent=~sex+dukes+charlson,
##D data=readmission,n.knots=10,kappa=c(100,100),
##D recurrentAG=FALSE,hazard="Splines")
##D 
##D ###--- General Joint model (recurrent and terminal events) with 2 covariates ---###
##D data(readmission)
##D modJoint.general <- frailtyPenal(Surv(time,event) ~ cluster(id) + dukes +
##D charlson + sex + chemo + terminal(death),
##D formula.terminalEvent = ~ dukes + charlson + sex + chemo,
##D data = readmission, jointGeneral = TRUE, n.knots = 8,
##D kappa = c(2.11e+08, 9.53e+11))
##D 
##D ###--- Nested model (or hierarchical model) with 2 covariates ---###
##D 
##D data(dataNested)
##D modClu <- frailtyPenal(Surv(t1,t2,event)~
##D cluster(group)+subcluster(subgroup)+cov1+cov2,
##D data=dataNested,n.knots=8,kappa=50000,hazard="Splines")
##D 
##D ###--- Joint Nested Frailty model ---###
##D 
##D #-- here is generated cluster (30 clusters)
##D readmissionNested <- transform(readmission,group=id%%30+1)
##D 
##D modJointNested_Splines <- frailtyPenal(formula = Surv(t.start, t.stop, event) 
##D ~ subcluster(id) + cluster(group) + dukes + terminal(death), 
##D formula.terminalEvent = ~dukes, data = readmissionNested, recurrentAG = TRUE, 
##D n.knots = 8, kappa = c(9.55e+9, 1.41e+12), initialize = TRUE)
##D 
##D modJointNested_Weib <- frailtyPenal(Surv(t.start,t.stop,event)~subcluster(id)
##D +cluster(group)+dukes+ terminal(death),formula.terminalEvent=~dukes, 
##D hazard = ('Weibull'), data=readmissionNested,recurrentAG=TRUE, initialize = FALSE)
##D 
##D JoiNes-GapSpline <- frailtyPenal(formula = Surv(time, event) 
##D ~ subcluster(id) + cluster(group) + dukes + terminal(death), 
##D formula.terminalEvent = ~dukes, data = readmissionNested, recurrentAG = FALSE, 
##D n.knots = 8, kappa = c(9.55e+9, 1.41e+12), initialize = TRUE,
##D init.Alpha = 1.091, Ksi = "None")
##D 
##D ###--- Semiparametric Shared model ---###
##D 
##D data(readmission)
##D sha.sp <- frailtyPenal(Surv(t.start,t.stop,event)~
##D sex+dukes+charlson+cluster(id),data=readmission,
##D n.knots=6,kappa=5000,recurrentAG=TRUE,
##D cross.validation=TRUE,hazard="Splines")
##D 
##D ###--- Parametric Shared model ---###
##D 
##D data(readmission)
##D sha.p <- frailtyPenal(Surv(t.start,t.stop,event)~
##D cluster(id)+sex+dukes+charlson,
##D data=readmission,recurrentAG=TRUE,
##D hazard="Piecewise-per",nb.int=6)
##D 
##D ###--- Joint model for longitudinal ---###
##D ###--- data and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D model.weib.RE <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS 
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS ,
##D colorectalSurv,	data.Longi = colorectalLongi, 
##D random = c("1", "year"), id = "id", link = "Random-effects", 
##D left.censoring = -3.33, hazard = "Weibull")
##D 
##D ###--- Trivariate joint model for longitudinal ---###
##D ###--- data, recurrent and terminal events ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # (computation takes around 40 minutes)
##D 
##D model.spli.RE.cal <-trivPenal(Surv(time0, time1, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS +  terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal, 
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = TRUE,
##D n.knots = 6, kappa=c(0.01, 2), method.GH="Pseudo-adaptive",
##D n.nodes=7, init.B = c(-0.07, -0.13, -0.16, -0.17, 0.42, #recurrent events covariates
##D -0.23, -0.1, -0.09, -0.12, 0.8, -0.23, #terminal event covariates
##D 3.02, -0.30, 0.05, -0.63, -0.02, -0.29, 0.11, 0.74)) #biomarker covariates
##D 
##D 
##D ##---Surrogacy evaluation based on ganerated data with a combination 
##D ##of Monte Carlo and classical Gaussian Hermite integration.
##D ## (Computation takes around 5 minutes)
##D 
##D # Generation of data to use 
##D data.sim <- jointSurrSimul(n.obs=600, n.trial = 30,cens.adm=549.24, 
##D          alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1, sigma.s = 0.7, 
##D          sigma.t = 0.7, rsqrt = 0.8, betas = -1.25, betat = -1.25, 
##D          full.data = 0, random.generator = 1, seed = 0, nb.reject.data = 0)
##D 
##D # Joint surrogate model estimation
##D joint.surro.sim.MCGH <- jointSurroPenal(data = data.sim, int.method = 2, 
##D                    nb.mc = 300, nb.gh = 20)
##D 
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("frailtypack-package", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("hazard")
### * hazard

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: hazard
### Title: Hazard function.
### Aliases: hazard

### ** Examples



## Not run: 
##D 
##D #-- a fit Shared
##D data(readmission)
##D fit.shared <- frailtyPenal(Surv(time,event)~dukes+cluster(id)+
##D strata(sex),n.knots=10,kappa=c(10000,10000),data=readmission)
##D 
##D #-- calling survival
##D hazard(20,fit.shared)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("hazard", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointRecCompet")
### * jointRecCompet

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointRecCompet
### Title: Competing Joint Frailty Model: A single type of recurrent event
###   and two terminal events.
### Aliases: jointRecCompet

### ** Examples

## No test: 
set.seed(1)
data=simulatejointRecCompet(n=500,
		par0=c(shapeR = 1.5, scaleR = 10, 
		shapeM = 1.75, scaleM = 16, shapeD = 1.75, scaleD = 16, sigma = 0.5, 
		alphaM = 1, alphaD = 1, betaR = -0.5, betaM = -0.5, betaD = 0) )
mod <-jointRecCompet(formula = Surv(tstart, tstop, event)~cluster(id)+treatment+
                    terminal(terminal1)+terminal2(terminal2),
                    formula.terminalEvent = ~treatment,
                    formula.terminalEvent2 = ~treatment,
                    data = data,
                    recurrentAG = TRUE,
                    initialize = TRUE,
					   n.knots=7,
					   crossVal=TRUE,
                    hazard = "Splines",
                    maxit = 350)

#This example uses an extract of 500 patients of the REDUCE trial
data(reduce)
mod_reduce <-jointRecCompet(formula = Surv(t.start,t.stop, del)~cluster(id)+
					   treatment+terminal(death)+terminal2(discharge),
                    formula.terminalEvent = ~treatment,
                    formula.terminalEvent2 = ~treatment,
                    data = reduce,
                    initialize = TRUE,
                    recurrentAG = TRUE,
                    hazard = "Weibull",
                    constraint.frailty = "exponential",
                    maxit = 350)
print(mod_reduce)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointRecCompet", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointSurrCopSimul")
### * jointSurrCopSimul

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointSurrCopSimul
### Title: Generate survival times for two endpoints using the joint
###   frailty-copula model for surrogacy
### Aliases: jointSurrCopSimul

### ** Examples


## No test: 
# dataset with 2 covariates and fixed censorship
data.sim <- jointSurrCopSimul(n.obs=600, n.trial = 30, prop.cens = 0, cens.adm=549, 
            alpha = 1.5, gamma = 2.5, sigma.s = 0.7, sigma.t = 0.7, 
            cor = 0.8, betas = c(-1.25, 0.5), betat = c(-1.25, 0.5), 
            full.data = 0, random.generator = 1,ver = 2, covar.names = "trt", 
            nb.reject.data = 0, thetacopule = 6, filter.surr = c(1,1), 
            filter.true = c(1,1), seed = 0)
            
#dataset with 2 covariates and random censorship

data.sim2 <- jointSurrCopSimul(n.obs=600, n.trial = 30, prop.cens = 0.75, 
            cens.adm = 549, alpha = 1.5, gamma = 2.5, sigma.s = 0.7, 
            sigma.t = 0.7, cor = 0.8, betas = c(-1.25, 0.5), 
            betat = c(-1.25, 0.5), full.data = 0, random.generator = 1,
            ver = 2, covar.names = "trt", nb.reject.data = 0, thetacopule = 6, 
            filter.surr = c(1,1), filter.true = c(1,1), seed = 0)
            
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointSurrCopSimul", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointSurrSimul")
### * jointSurrSimul

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointSurrSimul
### Title: Generate survival times for two endpoints using the joint
###   frailty surrogate model
### Aliases: jointSurrSimul

### ** Examples


## No test: 
data.sim <- jointSurrSimul(n.obs=600, n.trial = 30,cens.adm=549.24, 
            alpha = 1.5, theta = 3.5, gamma = 2.5, sigma.s = 0.7, 
            zeta = 1, sigma.t = 0.7, cor = 0.8, betas = -1.25, 
            betat = -1.25, full.data = 0, random.generator = 1, 
            seed = 0, nb.reject.data = 0, pfs = 0)
## End(No test)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointSurrSimul", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointSurroCopPenal")
### * jointSurroCopPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointSurroCopPenal
### Title: Fit the one-step Joint frailty-copula model for evaluating a
###   canditate surrogate endpoint
### Aliases: jointSurroCopPenal

### ** Examples


## Not run: 
##D # Data from the advanced ovarian cancer randomized clinical trials.
##D data(dataOvarian)
##D joint.surro.Gumbel <- jointSurroCopPenal(data = dataOvarian, int.method = 0,
##D       n.knots = 8, maxit = 50, kappa.use = 4, nb.mc = 1000, typecopula = 2,
##D       print.iter = FALSE, scale = 1/365)
##D 
##D print(joint.surro.Gumbel)
##D 
##D joint.surro.Clayton <- jointSurroCopPenal(data = dataOvarian, int.method = 0,
##D       n.knots = 8, maxit = 50, kappa.use = 4, nb.mc = 1000, typecopula = 1,
##D       print.iter = FALSE, scale = 1/365)
##D 
##D print(joint.surro.Clayton)
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointSurroCopPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointSurroPenal")
### * jointSurroPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointSurroPenal
### Title: Fit the one-step Joint surrogate model for evaluating a
###   canditate surrogate endpoint
### Aliases: jointSurroPenal

### ** Examples


## Not run: 
##D # Generation of data to use
##D data.sim <- jointSurrSimul(n.obs=600, n.trial = 30,cens.adm=549.24,
##D          alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1, sigma.s = 0.7,
##D          sigma.t = 0.7, cor = 0.8, betas = -1.25, betat = -1.25,
##D          full.data = 0, random.generator = 1, seed = 0, nb.reject.data = 0)
##D 
##D 
##D #Surrogacy evaluation based on generated data with a combination of Monte Carlo
##D #and classical Gaussian Hermite integration.*
##D # (Computation takes around 5 minutes)
##D 
##D joint.surro.sim.MCGH <- jointSurroPenal(data = data.sim, int.method = 2,
##D                    nb.mc = 300, nb.gh = 20)
##D 
##D #Surrogacy evaluation based on generated data with a combination of Monte Carlo
##D # and Pseudo-adaptive Gaussian Hermite integration.
##D # (Computation takes around 4 minutes)
##D 
##D joint.surro.sim.MCPGH <- jointSurroPenal(data = data.sim, int.method = 2,
##D                    nb.mc = 300, nb.gh = 20, adaptatif = 1)
##D 
##D # Results
##D summary(joint.surro.sim.MCGH)
##D summary(joint.surro.sim.MCPGH)
##D 
##D # Data from the advanced ovarian cancer randomized clinical trials.
##D # Joint surrogate model with \eqn{\zeta} fixed to 1, 8 nodes spline
##D # and the rescaled survival time.
##D 
##D data(dataOvarian)
##D # (Computation takes around 20 minutes)
##D 
##D joint.surro.ovar <- jointSurroPenal(data = dataOvarian, n.knots = 8,
##D                 init.kappa = c(2000,1000), indicator.alpha = 0, nb.mc = 200,
##D                 scale = 1/365)
##D # results
##D summary(joint.surro.ovar)
##D 
##D print(joint.surro.ovar)
##D 
##D 
##D # Mediation analysis on the adjuvant chemotherapy
##D # dataset where the surrogate is a time-to-relapse and the final endpoint is death.
##D # 4 knots are used to estimate the two baseline hazard functions.
##D # The function g(s) is estimated using cubic b-splines with 1 interior
##D # knot ('g.nkots=1'). The function \eqn{PTE(t)} is computed at 100 time points
##D # using 10.000 Monte Carlo simulations for integration over the random effects.
##D # To reduce computation time in the provided example only one fifth of the
##D # the original dataset is used and the confidence bands for the function
##D # \eqn{PTE(t)} are not computed as well as the power parameters associated with
##D # the random effects. Full example is commented thereafter.
##D 
##D # We first need to change the variable "statusS" which in the dataset
##D # encodes the indicator of a disease free survival event to an indicator
##D # of a time to relapse event (i.e., resurgence of cancer or
##D # onset of a second cancer) that excludes death as a composite event.
##D # Thus, the patients whose variables "timeS" and "timeT" are equal
##D # and whose variable "statusS" is equal to 1 will have
##D # "statuS" be set to 0. We do this because composite endpoint may not
##D # be appropriate in the setting of mediation analysis.
##D 
##D data(gastadj)
##D gastadj$timeS<-gastadj$timeS/365
##D gastadj$timeT<-gastadj$timeT/365
##D #here changing "statusS" to corresponds to a time to relapse event
##D gastadj[gastadj$timeS==gastadj$timeT & gastadj$statusS==1,c("statusS")]<-0
##D 
##D # select 20% of the original dataset
##D set.seed(1)
##D n<-nrow(gastadj)
##D subset<-gastadj[sort(sample(1:nrow(gastadj),round(n*0.2),replace = FALSE)),]
##D 
##D # Mediation model ('mediation=TRUE'). Computation takes around 17 minutes
##D mod.gast<-jointSurroPenal(subset,n.knots = 4,indicator.zeta = 0,
##D                          indicator.alpha = 0,mediation=TRUE,g.nknots=1,
##D                          pte.ntimes=30,pte.nmc=10000,pte.boot=FALSE)
##D 
##D summary(mod.gast)
##D plot(mod.gast)
##D 
##D # Example on the full dataset, including estimation of the power parameters
##D # mod.gast2<-jointSurroPenal(gastadj,n.knots = 4,mediation=TRUE,g.nknots=1,
##D #                            pte.ntimes=30,pte.nmc=10000,pte.boot=TRUE,
##D #                            pte.nboot=2000,pte.boot.nmc=10000)
##D 
##D # results
##D # plot(mod.gast2)
##D # summary(mod.gast2)
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointSurroPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointSurroPenalSimul")
### * jointSurroPenalSimul

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointSurroPenalSimul
### Title: Simulation studies based on the one-step Joint surrogate models
###   for the evaluation of a canditate surrogate endpoint
### Aliases: jointSurroPenalSimul

### ** Examples


## Not run: 
##D # Surrogacy model evaluation performance study based on 10 generated data
##D # (Computation takes around 20 minutes using a processor including 40
##D # cores and a read only memory of 378 Go)
##D # To realize a simulation study on 100 samples or more (as required), use
##D # nb.dataset = 100
##D 
##D ### joint frailty model
##D joint.simul <- jointSurroPenalSimul(nb.dataset = 10, nbSubSimul= 600,
##D                    ntrialSimul = 30, LIMparam = 0.001, LIMlogl = 0.001,
##D                    LIMderiv = 0.001, nb.mc = 200, nb.gh = 20,
##D                    nb.gh2 = 32, true.init.val = 1, print.iter = FALSE, pfs = 0)
##D 
##D # results
##D summary(joint.simul, d = 3, R2boot = 1) # bootstrap
##D summary(joint.simul, d = 3, R2boot = 0) # Delta-method
##D 
##D ### joint frailty copula model
##D 
##D joint.simul.cop.clay <- jointSurroPenalSimul(nb.dataset = 10, nbSubSimul= 600,
##D                    ntrialSimul = 30, nb.mc = 1000, type.joint.estim = 3,
##D                    typecopula = 1, type.joint.simul = 3, theta.copula = 3,
##D                    time.cens = 349, true.init.val = 1, R2 = 0.81, maxit = 40,
##D                    print.iter = FALSE)
##D 
##D summary(joint.simul.cop.clay)
##D 
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointSurroPenalSimul", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("jointSurroTKendall")
### * jointSurroTKendall

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: jointSurroTKendall
### Title: Kendall's tau estimation using numerical integration methods
### Aliases: jointSurroTKendall

### ** Examples

Ktau1 <- jointSurroTKendall(theta = 3.5, gamma = 2.5, nb.gh = 32)
Ktau2 <- jointSurroTKendall(theta = 1, gamma = 0.8, alpha = 1, zeta = 1, 
         nb.gh = 32)

###---Kendall's \eqn{\tau} from a joint surrogate model ---###

## Not run: 
##D data.sim <-jointSurrSimul(n.obs=400, n.trial = 20,cens.adm=549, 
##D           alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1, 
##D           sigma.s = 0.7, sigma.t = 0.7,cor = 0.8, betas = -1.25, 
##D           betat = -1.25, full.data = 0, random.generator = 1, 
##D           seed = 0, nb.reject.data = 0)
##D           
##D 
##D ###---Estimation---###
##D joint.surrogate <- jointSurroPenal(data = data.sim, nb.mc = 300, 
##D                    nb.gh = 20, indicator.alpha = 1, n.knots = 6)
##D                    
##D  Ktau3 <- jointSurroTKendall(joint.surrogate)
##D  Ktau4 <- jointSurroTKendall(joint.surrogate,nb.MC.kendall = 4000,
##D           seed = 1)
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("jointSurroTKendall", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("longiPenal")
### * longiPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: longiPenal
### Title: Fit a Joint Model for Longitudinal Data and a Terminal Event
### Aliases: longiPenal
### Keywords: models

### ** Examples



## Not run: 
##D 
##D ###--- Joint model for longitudinal data and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D # We recommend fitting first a mixed model on the longitudinal data and
##D # a survival model on the terminal event and use these estimations as
##D # initial values for the joint model.
##D # Mixed model with lme:
##D mlongi <- nlme::lme(tumor.size ~ year * treatment + age + who.PS, 
##D                     data = colorectalLongi, random = ~1 + year | id)
##D # Survival model with frailtyPenal:
##D msurv <- frailtyPenal(Surv(time1, state) ~ age + treatment + who.PS + prev.resection,
##D                       data = colorectalSurv, n.knots = 7, kappa = 2)
##D msurv.weib <- frailtyPenal(Surv(time1, state) ~ age + treatment + who.PS + prev.resection,
##D                            data = colorectalSurv, hazard = "Weibull")
##D 
##D 
##D # Joint model with
##D # Baseline hazard function approximated with splines
##D # Random effects as the link function
##D model.spli.RE <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS ,
##D data=colorectalSurv,	data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Random-effects", left.censoring = -3.33,
##D n.knots = 7, kappa = 2, init.longi = mlongi, init.surv = msurv, init.Eta = c(0, 0))
##D 
##D # Joint model with
##D # Weibull baseline hazard function
##D # Current level of the biomarker as the link function
##D model.weib.CL <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS , timevar="year",
##D data=colorectalSurv, data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Current-level", left.censoring = -3.33, hazard = "Weibull",
##D init.longi = mlongi, init.surv = msurv.weib, init.Eta = 0)
##D 
##D # Joint model with user specified initial values
##D initL <- list(fixed = c(3, -0.3, -0.1, 0.2, -0.4, 0.2, 1, -0.6),
##D               random = matrix(c(2, -0.4, -0.4, 0.8), 2, 2),
##D               sigma = 1)
##D initS <- list(hazard = c(1.2, 1.5),
##D               fixed = c(-0.2, 0, 0.1, -0.2, 0.5, -0.3))
##D 
##D model.weib.CL.2 <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS , timevar="year",
##D data=colorectalSurv, data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Current-level", left.censoring = -3.33, hazard = "Weibull",
##D init.longi = initL, init.surv = initS, init.Eta = 0.3)
##D 
##D ###--- Two-part Joint model for semicontinuous
##D #      longitudinal data and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D # Box-cox back transformation (lambda=0.3) and apply logarithm (with a 1 unit shift)
##D colorectalLongi$Yo <- (colorectalLongi$tumor.size*0.3+1)^(1/0.3)
##D colorectalLongi$Y <- log(colorectalLongi$Y+1) # log transformation with shift=1
##D 
##D # Conditional two-part joint model - random-effects association structure (~15min)
##D 
##D CTPJM_re <-longiPenal(Surv(time1, state)~age + treatment +
##D who.PS+ prev.resection, Y~year*treatment, formula.Binary=Y~year*treatment,
##D data = colorectalSurv, data.Longi = colorectalLongi, random = c("1"),
##D random.Binary=c("1"), id = "id", link ="Random-effects", left.censoring = F,
##D n.knots = 7, kappa = 2, hazard="Splines-per")
##D 
##D print(CTPJM_re)
##D 
##D # Conditional two-part joint model - current-level association structure (~15min)
##D # Simulated dataset (github.com/DenisRustand/TPJM_sim)
##D data(longDat)
##D data(survDat)
##D tte <- frailtyPenal(Surv(deathTimes, d)~trt,n.knots=5,kappa=0, data=survDat,
##D cross.validation = T)
##D kap <- round(tte$kappa,2);kap # smoothing parameter
##D   CTPJM_cl <- longiPenal(Surv(deathTimes, d)~trt, Y~timej*trtY,
##D   data=survDat, data.Longi = longDat,
##D   random = c("1","timej"), formula.Binary=Y~timej*trtY,
##D   random.Binary=c("1"), timevar="timej", id = "id",
##D   link = "Current-level", n.knots = 5, kappa = kap,
##D   hazard="Splines-per", method.GH="Monte-carlo",
##D   n.nodes=500)
##D 
##D   print(CTPJM_cl)
##D 
##D 
##D # Marginal two-part joint model - random-effects association structure (~10min)
##D longDat$Yex <- exp(longDat$Y)-1
##D MTPJM_re <- longiPenal(Surv(deathTimes, d)~trt, Yex~timej*trtY,
##D                   data=survDat, data.Longi = longDat,MTP=T,GLMlog = T,
##D                   random = c("1"), formula.Binary=Y~timej*trtY,
##D                   random.Binary=c("1"), timevar="timej", id = "id",
##D                   link = "Random-effects", n.knots = 5, kappa = kap,
##D                   hazard="Splines-per", method.GH="Monte-carlo",
##D                   n.nodes=500)
##D 
##D print(MTPJM_re)
##D 
##D # Marginal two-part joint model - current-level association structure (~45min)
##D  MTPJM_cl <- longiPenal(Surv(deathTimes, d)~trt, Yex~timej*trtY,
##D                   data=survDat, data.Longi = longDat,MTP=T,GLMlog = T,
##D                   random = c("1","timej"), formula.Binary=Y~timej*trtY,
##D                   random.Binary=c("1"), timevar="timej", id = "id",
##D                   link = "Current-level", n.knots = 5, kappa = kap,
##D                   hazard="Splines-per", method.GH="Monte-carlo",
##D                   n.nodes=500)
##D 
##D print(MTPJM_cl)
##D 
##D ###--- Mediation analysis  
##D #Takes ~ 10 minutes to run
##D data(colorectal)
##D data(colorectalLongi)
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D colorectalSurv$treatment<-sapply(colorectalSurv$treatment,function(t) ifelse(t=="S",1,0))
##D colorectalLongi$treatment<-sapply(colorectalLongi$treatment,function(t) ifelse(t=="S",1,0))
##D 
##D longi.col <- nlme::lme(tumor.size ~ age+year*treatment,
##D                        random = ~1 + year | id,
##D                        data = colorectalLongi)
##D surv.col <- frailtyPenal(Surv(time1, state) ~ age + treatment ,
##D                          n.knots = 7, kappa = 2,
##D                          data = colorectalSurv)
##D 
##D mod.col <- longiPenal(Surv(time1, state) ~ age+treatment,
##D             tumor.size ~ age+year*treatment,
##D             data=colorectalSurv, data.Longi = colorectalLongi, random = c("1", "year"),
##D             id = "id", link = "Current-level",timevar="year",method.GH = "Pseudo-adaptive",
##D             mediation = TRUE,med.trt = colorectalSurv$treatment,
##D             med.center = NULL,med.nmc = 50,n.knots = 7, kappa = 2,
##D             pte.ntimes = 30,pte.boot = T,pte.nmc = 1000,pte.nboot = 1000,
##D             init.longi = longi.col, init.surv = surv.col)
##D 
##D print(mod.col)
##D plot(mod.col,plot.mediation='All')
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("longiPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("loocv")
### * loocv

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: loocv
### Title: The trials leave-one-out crossvalidation for the one-step Joint
###   surrogate model for evaluating a canditate surrogate endpoint.
### Aliases: loocv
### Keywords: loocv prediction surrogate

### ** Examples



## Not run: 
##D # Generation of data to use 
##D  data.sim <- jointSurrSimul(n.obs=300, n.trial = 10,cens.adm=549.24,
##D              alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1, sigma.s = 0.7,
##D              sigma.t = 0.7, cor = 0.8, betas = -1.25, betat = -1.25,
##D              full.data = 0, random.generator = 1, seed = 0,
##D              nb.reject.data = 0)
##D 
##D ###--- Joint surrogate model ---###
##D  
##D joint.surro.sim.MCGH <- jointSurroPenal(data = data.sim, int.method = 2,
##D                         nb.mc = 300, nb.gh = 20, print.iter = F)
##D 
##D # Example of loocv taking into accountn ony trial 2 trials (1 and 3)
##D dloocv <- loocv(joint.surro.sim.MCGH, unusedtrial = c(2,4:10))
##D dloocv$result
##D dloocv$loocv.summary
##D 
##D # In order to summarize all the estimated models during the loocv proccess:
##D dloocv$different.models
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("loocv", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("multivPenal")
### * multivPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: multivPenal
### Title: Fit a multivariate frailty model for two types of recurrent
###   events and a terminal event.
### Aliases: multivPenal transfo.table for multivariate frailty model
### Keywords: methods models multiv

### ** Examples



## No test: 

###--- Multivariate Frailty model ---###

data(dataMultiv)

# (computation takes around 60 minutes)
modMultiv.spli <- multivPenal(Surv(TIMEGAP,INDICREC)~cluster(PATIENT)+v1+v2+
             event2(INDICMETA)+terminal(INDICDEATH),formula.Event2=~v1+v2+v3,
             formula.terminalEvent=~v1,data=dataMultiv,n.knots=c(8,8,8),
             kappa=c(1,1,1),initialize=FALSE)

print(modMultiv.spli)

modMultiv.weib <- multivPenal(Surv(TIMEGAP,INDICREC)~cluster(PATIENT)+v1+v2+
             event2(INDICMETA)+terminal(INDICDEATH),formula.Event2=~v1+v2+v3,
             formula.terminalEvent=~v1,data=dataMultiv,hazard="Weibull")

print(modMultiv.weib)

modMultiv.cpm <- multivPenal(Surv(TIMEGAP,INDICREC)~cluster(PATIENT)+v1+v2+
             event2(INDICMETA)+terminal(INDICDEATH),formula.Event2=~v1+v2+v3,
             formula.terminalEvent=~v1,data=dataMultiv,hazard="Piecewise-per",
             nb.int=c(6,6,6))

print(modMultiv.cpm)

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("multivPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("num.id")
### * num.id

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: num.id
### Title: Identify individuals in Joint model for clustered data
### Aliases: num.id
### Keywords: misc

### ** Examples



## No test: 

data(readmission)
#-- here is generated cluster (5 clusters)
readmission <- transform(readmission,group=id%%5+1)

#-- exclusion all recurrent events --#
#--  to obtain framework of semi-competing risks --#
readmission2 <- subset(readmission, (t.start == 0 & event == 1) | event == 0)

joi.clus.gap <- frailtyPenal(Surv(time,event)~cluster(group)+
num.id(id)+dukes+charlson+sex+chemo+terminal(death),
formula.terminalEvent=~dukes+charlson+sex+chemo,
data=readmission2,recurrentAG=FALSE, n.knots=8,
kappa=c(1.e+10,1.e+10) ,Alpha="None")

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("num.id", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.additivePenal")
### * plot.additivePenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.additivePenal
### Title: Plot Method for an Additive frailty model.
### Aliases: plot.additivePenal lines.additivePenal
### Keywords: methods

### ** Examples



## No test: 

data(dataAdditive)

modAdd <- additivePenal(Surv(t1,t2,event)~cluster(group)+var1+slope(var1),
correlation=TRUE,data=dataAdditive,n.knots=8,kappa=862,hazard="Splines")

#-- 'var1' is boolean as a treatment variable

plot(modAdd)

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.additivePenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.frailtyCmprsk")
### * plot.frailtyCmprsk

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.frailtyCmprsk
### Title: Plot Method for a Weibull competing risks model with optional
###   shared frailty between transitions.
### Aliases: plot.frailtyCmprsk
### Keywords: file

### ** Examples

## No test: 

    ###--- Simple Weibull competing risks model ---###

    data(CPRSKbmtcrr)

    ModCmprsk_NoCov_Factor <- frailtyCmprsk(
      formulas = list(
        Surv(observed_time, Status, type = "mstate") ~ D,
        ~ 1
      ),
      data = CPRSKbmtcrr,
      print.info = FALSE,
      maxit = 100
    )

    plot(ModCmprsk_NoCov_Factor)

    #-- No confidence bands
    plot(ModCmprsk_NoCov_Factor, conf.bands = FALSE)

## End(No test)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.frailtyCmprsk", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.frailtyIllnessDeath")
### * plot.frailtyIllnessDeath

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.frailtyIllnessDeath
### Title: Plot Method for a Weibull Illness-Death model with optional
###   shared frailty between transitions.
### Aliases: plot.frailtyIllnessDeath
### Keywords: file

### ** Examples



  ## No test: 

    ###--- Semi-Markovian Weibull Illness-Death model with left truncation ---###

    data(Paq810)

    ModIllnessDeath_SemiMarkov_LeftTrunc <- frailtyIllnessDeath(
      formula = Surv(e, r, dementia) ~ gender + certif,
      formula.terminalEvent = Surv(t, death) ~ gender + certif,
      data = Paq810,
      print.info = FALSE,
      maxit = 100
    )

    plot(ModIllnessDeath_SemiMarkov_LeftTrunc)

    #-- No confidence bands
    plot(ModIllnessDeath_SemiMarkov_LeftTrunc, conf.bands = FALSE)

  
## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.frailtyIllnessDeath", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.frailtyPenal")
### * plot.frailtyPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.frailtyPenal
### Title: Plot Method for a Shared frailty model.
### Aliases: plot.frailtyPenal lines.frailtyPenal
### Keywords: file

### ** Examples



## Not run: 
##D 
##D data(readmission)
##D 
##D ###--- Shared frailty model ---###
##D 
##D modSha <- frailtyPenal(Surv(time,event)~as.factor(dukes)+cluster(id),
##D n.knots=10,kappa=10000,data=readmission,hazard="Splines")
##D 
##D plot(modSha,type="Survival",conf=FALSE)
##D 
##D ###--- Cox proportional hazard model ---###
##D 
##D modCox <- frailtyPenal(Surv(time,event)~as.factor(dukes),n.knots=10,
##D kappa=10000,data=readmission,hazard="Splines")
##D 
##D plot(modCox)
##D 
##D #-- no confidence bands
##D plot(modSha,conf.bands=FALSE)
##D plot(modCox,conf.bands=FALSE)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.frailtyPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.jointNestedPenal")
### * plot.jointNestedPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.jointNestedPenal
### Title: Plot method for a joint nested frailty model.
### Aliases: plot.jointNestedPenal lines.jointNestedPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D #-- here is generated cluster (30 clusters)
##D readmissionNested <- transform(readmission,group=id%%30+1)
##D 
##D # Baseline hazard function approximated with splines with calendar-timescale
##D 
##D model.spli.AG <- frailtyPenal(formula = Surv(t.start, t.stop, event) 
##D ~ subcluster(id) + cluster(group) + dukes + terminal(death), 
##D formula.terminalEvent = ~dukes, data = readmissionNested, recurrentAG = TRUE,
##D  n.knots = 8, kappa = c(9.55e+9, 1.41e+12),initialize = TRUE)
##D 
##D # Plot the estimated baseline hazard function with the confidence intervals
##D plot(model.spli.AG)	
##D 
##D # Plot the estimated baseline hazard function with the confidence intervals
##D plot(model.spli.RE, type = "Survival")
##D 	
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.jointNestedPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.jointPenal")
### * plot.jointPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.jointPenal
### Title: Plot Method for a Joint frailty model.
### Aliases: plot.jointPenal lines.jointPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D data(readmission)
##D 
##D #-- Gap-time
##D modJoint.gap <- frailtyPenal(Surv(time,event)~cluster(id)+sex+dukes+
##D charlson+terminal(death),formula.terminalEvent=~sex+dukes+charlson,
##D data=readmission,n.knots=14,kappa=c(100,100))
##D 
##D #-- It takes around 1 minute to converge --#
##D 
##D plot(modJoint.gap,type.plot="Haz",event="recurrent",conf.bands=TRUE)
##D plot(modJoint.gap,type.plot="Haz",event="terminal",conf.bands=TRUE)
##D plot(modJoint.gap,type.plot="Haz",event="both",conf.bands=TRUE)
##D 
##D plot(modJoint.gap,type.plot="Su",event="recurrent",conf.bands=TRUE)
##D plot(modJoint.gap,type.plot="Su",event="terminal",conf.bands=TRUE)
##D plot(modJoint.gap,type.plot="Su",event="both",conf.bands=TRUE)
##D 
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.jointPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.jointSurroPenal")
### * plot.jointSurroPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.jointSurroPenal
### Title: Plot Method for the one-step Joint surrogate model for the
###   evaluation of a canditate surrogate endpoint.
### Aliases: plot.jointSurroPenal lines.jointSurroPenal
### Keywords: surrogate

### ** Examples



## Not run: 
##D 
##D 
##D ###--- Joint surrogate model ---###
##D ###---evaluation of surrogate endpoints---###
##D 
##D data(dataOvarian)
##D joint.surro.ovar <- jointSurroPenal(data = dataOvarian, n.knots = 8, 
##D                 init.kappa = c(2000,1000), indicator.alpha = 0, 
##D                 nb.mc = 200, scale = 1/365)
##D 
##D # Baseline Hazards fonctions for both the surrogate endpoint 
##D # and the true endpoint
##D plot(joint.surro.ovar,endpoint = 2,type.plot = "Haz", conf.bands = T)   
##D 
##D # Baseline survival fonctions for both the surrogate endpoint 
##D # and the true endpoint
##D plot(joint.surro.ovar,endpoint = 2,type.plot = "Su", conf.bands = T)  
##D              
##D 
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.jointSurroPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.jointSurroPenalloocv")
### * plot.jointSurroPenalloocv

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.jointSurroPenalloocv
### Title: Plot of trials leave-one-out crossvalidation Outputs from the
###   one-step Joint surrogate model for evaluating a canditate surrogate
###   endpoint.
### Aliases: plot.jointSurroPenalloocv
### Keywords: loocv plot prediction surrogate

### ** Examples



## Not run: 
##D # Generation of data to use 
##D  data.sim <- jointSurrSimul(n.obs=300, n.trial = 10,cens.adm=549.24,
##D              alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1, sigma.s = 0.7,
##D              sigma.t = 0.7, cor = 0.8, betas = -1.25, betat = -1.25,
##D              full.data = 0, random.generator = 1, seed = 0,
##D              nb.reject.data = 0)
##D 
##D ###--- Joint surrogate model ---###
##D  
##D joint.surro.sim.MCGH <- jointSurroPenal(data = data.sim, int.method = 2,
##D                         nb.mc = 300, nb.gh = 20, print.iter = T)
##D         
##D # Example of loocv taking into accountn ony trial 2 trials (1 and 3)
##D dloocv <- loocv(joint.surro.sim.MCGH, unusedtrial = c(2,4:10))
##D 
##D plot(x = dloocv, xleg = "topright", bty = "n")
##D 
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.jointSurroPenalloocv", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.longiPenal")
### * plot.longiPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.longiPenal
### Title: Plot Method for a joint model for longitudinal data and a
###   terminal event.
### Aliases: plot.longiPenal lines.longiPenal
### Keywords: file

### ** Examples



## Not run: 
##D ###--- Joint model for longitudinal data and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D # Baseline hazard function approximated with splines
##D # Random effects as the link function
##D 
##D model.spli.RE <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS 
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS ,
##D colorectalSurv,	data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Random-effects", left.censoring = -3.33, 
##D n.knots = 7, kappa = 2)
##D pdf(file = "/home/agareb1/etudiants/al10/newpack/test/plot_longi.pdf")
##D 
##D # Plot the estimated baseline hazard function with the confidence intervals
##D plot(model.spli.RE)	
##D 
##D # Plot the estimated baseline hazard function with the confidence intervals
##D plot(model.spli.RE, type = "Survival")	
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.longiPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.nestedPenal")
### * plot.nestedPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.nestedPenal
### Title: Plot Method for a Nested frailty model.
### Aliases: plot.nestedPenal lines.nestedPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D data(dataNested)
##D modNested <- frailtyPenal(Surv(t1,t2,event)~cluster(group)+
##D subcluster(subgroup)+cov1+cov2,data=dataNested,n.knots=8,
##D kappa=50000,hazard="Splines")
##D 
##D plot(modNested,conf.bands=FALSE)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.nestedPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.trivPenal")
### * plot.trivPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.trivPenal
### Title: Plot Method for a trivariate joint model for longitudinal data,
###   recurrent events and a terminal event.
### Aliases: plot.trivPenal lines.trivPenal
### Keywords: methods

### ** Examples


## Not run: 
##D ###--- Trivariate joint model for longitudinal data, ---###
##D ###--- recurrent events and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Weibull baseline hazard function
##D # Random effects as the link function, Gap timescale
##D # (computation takes around 30 minutes)
##D model.weib.RE.gap <-trivPenal(Surv(gap.time, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive", n.nodes = 7)
##D 
##D plot(model.weib.RE.gap)
##D plot(model.weib.RE.gap, type = "survival")
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.trivPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.trivPenalNL")
### * plot.trivPenalNL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.trivPenalNL
### Title: Plot Method for a Non-Linear Trivariate Joint Model for
###   Recurrent Events and a Terminal Event with a Biomarker Described with
###   an ODE.
### Aliases: plot.trivPenalNL lines.trivPenalNL
### Keywords: methods

### ** Examples


## Not run: 
##D ###--- Trivariate joint model for longitudinal data, ---###
##D ###--- recurrent events and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Weibull baseline hazard function
##D # Random effects as the link function, Gap timescale
##D # (computation takes around 30 minutes)
##D model.weib.RE.gap <-trivPenal(Surv(gap.time, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive", n.nodes = 7)
##D 
##D plot(model.weib.RE.gap)
##D plot(model.weib.RE.gap, type = "survival")
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.trivPenalNL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotTreatPredJointSurro")
### * plotTreatPredJointSurro

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotTreatPredJointSurro
### Title: Plot of the prediction of the treatment effect on the true
###   endpoint and the STE
### Aliases: plotTreatPredJointSurro
### Keywords: prediction surrogate

### ** Examples


## Not run: 
##D 
##D 
##D ###--- Joint surrogate model ---###
##D ###---evaluation of surrogate endpoints---###
##D 
##D data(dataOvarian)
##D joint.surro.ovar <- jointSurroPenal(data = dataOvarian, n.knots = 8, 
##D                 init.kappa = c(2000,1000), indicator.alpha = 0, 
##D                 nb.mc = 200, scale = 1/365)
##D 
##D ## "HR"
##D plotTreatPredJointSurro(joint.surro.ovar, from = 0, to = 4, 
##D                 type = "HR", lty = 2, leg.y = 13)
##D                 
##D ## or without acceptance area for betaS:
##D plotTreatPredJointSurro(joint.surro.ovar, from = 0, to = 4, 
##D                 type = "HR", lty = 2, leg.y = 13, 
##D                 add.accept.area.betaS = FALSE)
##D              
##D ## "log HR"
##D plotTreatPredJointSurro(joint.surro.ovar, from = -2, to = 2, 
##D                 type = "Coef", lty = 2, leg.y = 3.5)
##D                 
##D ### For a value of ste greater than 0 (HR > 1), which induces deleterious
##D ### treatment effet, argument "pred.int.use" can be set to "lw"  
##D 
##D plotTreatPredJointSurro(joint.surro.ovar, from = 0, to = 2, 
##D                 type = "HR", lty = 2, leg.y = 4,
##D                 pred.int.use = "lw")
##D 
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotTreatPredJointSurro", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("predict.jointSurroPenal")
### * predict.jointSurroPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: predict.jointSurroPenal
### Title: S3method predict for the one-step Joint surrogate models for the
###   evaluation of a canditate surrogate endpoint.
### Aliases: predict.jointSurroPenal
### Keywords: prediction surrogate

### ** Examples



## Not run: 
##D 
##D 
##D ###--- Joint surrogate model ---###
##D ###---evaluation of surrogate endpoints---###
##D 
##D data(dataOvarian)
##D joint.surro.ovar <- jointSurroPenal(data = dataOvarian, n.knots = 8, 
##D                 init.kappa = c(2000,1000), indicator.alpha = 0, 
##D                 nb.mc = 200, scale = 1/365)
##D 
##D # prediction of the treatment effects on the true endpoint in each trial of 
##D # the dataOvarian dataset
##D predict(joint.surro.ovar)
##D 
##D # prediction of the treatment effect on the true endpoint from an observed 
##D # treatment effect on the surrogate endpoint in a given trial
##D 
##D # in log HR
##D predict(joint.surro.ovar, betaS.obs = -0.797, betaT.obs = -1.018)
##D predict(joint.surro.ovar, type = "Coef", betaS.obs = -1, leg.y = 0, leg.x = 0.3, to = 2.3)
##D predict(joint.surro.ovar, type = "Coef", leg.y = 3.5, add.accept.area.betaS = F, to = 2.3)
##D 
##D # in HR
##D predict(joint.surro.ovar, betaS.obs = exp(-0.797), betaT.obs = exp(-1.018))
##D predict(joint.surro.ovar, type = "HR", betaS.obs = log(0.65), leg.y = 5, to = 2.3)
##D predict(joint.surro.ovar, type = "HR", leg.y = 5, add.accept.area.betaS = F, to = 2.3)
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("predict.jointSurroPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("prediction")
### * prediction

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: prediction
### Title: Prediction probabilities for Cox proportional hazard, Shared,
###   Joint frailty models, Joint models for longitudinal data and a
###   terminal event and Trivariate joint model for longitudinal data,
###   recurrent events and a terminal event (linear and non-linear).
### Aliases: prediction
### Keywords: misc

### ** Examples



## Not run: 
##D 
##D #####################################################
##D #### prediction on a COX or SHARED frailty model ####
##D #####################################################
##D 
##D data(readmission)
##D #-- here is a generated cluster (31 clusters of 13 subjects)
##D readmission <- transform(readmission,group=id%%31+1)
##D 
##D #-- we compute predictions of death
##D #-- we extract last row of each subject for the time of death
##D readmission <- aggregate(readmission,by=list(readmission$id),
##D                          FUN=function(x){x[length(x)]})[,-1]
##D 
##D ##-- predictions on a Cox proportional hazard model --##
##D cox <- frailtyPenal(Surv(t.stop,death)~sex+dukes,
##D n.knots=10,kappa=10000,data=readmission)
##D 
##D #-- construction of the data frame for predictions
##D datapred <- data.frame(sex=0,dukes=0)
##D datapred$sex <- as.factor(datapred$sex)
##D levels(datapred$sex)<- c(1,2)
##D datapred$dukes <- as.factor(datapred$dukes)
##D levels(datapred$dukes)<- c(1,2,3)
##D datapred[1,] <- c(1,2) # man, dukes 2
##D datapred[2,] <- c(2,3) # woman, dukes 3
##D 
##D #-- prediction of death for two patients between 100 and 100+w,
##D #-- with w in (50,100,...,1900)
##D pred.cox <- prediction(cox,datapred,t=100,window=seq(50,1900,50))
##D plot(pred.cox)
##D 
##D #-- prediction of death for two patients between t and t+400,
##D #-- with t in (100,150,...,1500)
##D pred.cox2 <- prediction(cox,datapred,t=seq(100,1500,50),window=400)
##D plot(pred.cox2)
##D 
##D ##-- predictions on a shared frailty model for clustered data --##
##D sha <- frailtyPenal(Surv(t.stop,death)~cluster(group)+sex+dukes,
##D n.knots=10,kappa=10000,data=readmission)
##D 
##D #-- marginal prediction
##D # a group must be specified but it does not influence the results 
##D # in the marginal predictions setting
##D datapred$group[1:2] <- 1
##D pred.sha.marg <- prediction(sha,datapred,t=100,window=seq(50,1900,50))
##D plot(pred.sha.marg)
##D 
##D #-- conditional prediction, given a specific cluster (group=5)
##D datapred$group[1:2] <- 5
##D pred.sha.cond <- prediction(sha,datapred,t=100,window=seq(50,1900,50),
##D                             conditional = TRUE)
##D plot(pred.sha.cond)
##D 
##D ##-- marginal prediction of a recurrent event, on a shared frailty model
##D data(readmission)
##D 
##D datapred <- data.frame(t.stop=0,event=0,id=0,sex=0,dukes=0)
##D datapred$sex <- as.factor(datapred$sex)
##D levels(datapred$sex)<- c(1,2)
##D datapred$dukes <- as.factor(datapred$dukes)
##D levels(datapred$dukes)<- c(1,2,3)
##D 
##D datapred[1,] <- c(100,1,1,1,2) #man, dukes 2, 3 recurrent events
##D datapred[2,] <- c(200,1,1,1,2) 
##D datapred[3,] <- c(300,1,1,1,2) 
##D datapred[4,] <- c(350,0,2,1,2) #man, dukes 2  0 recurrent event
##D 
##D #-- Shared frailty model with gamma distribution
##D sha <- frailtyPenal(Surv(t.stop,event)~cluster(id)+sex+dukes,n.knots=10,
##D kappa=10000,data=readmission)
##D pred.sha.rec.marg <- prediction(sha,datapred,t=200,window=seq(50,1900,50),
##D event='Recurrent',MC.sample=100)
##D 
##D plot(pred.sha.rec.marg,conf.bands=TRUE)
##D 
##D ##-- conditional prediction of a recurrent event, on a shared frailty model
##D pred.sha.rec.cond <- prediction(sha,datapred,t=200,window=seq(50,1900,50),
##D event='Recurrent',conditional = TRUE,MC.sample=100)
##D 
##D plot(pred.sha.rec.cond,conf.bands=TRUE)
##D #####################################################
##D ######## prediction on a JOINT frailty model ########
##D #####################################################
##D 
##D data(readmission)
##D 
##D ##-- predictions of death on a joint model --##
##D joi <- frailtyPenal(Surv(t.start,t.stop,event)~cluster(id)
##D +sex+dukes+terminal(death),formula.terminalEvent=~sex
##D +dukes,data=readmission,n.knots=10,kappa=c(100,100),recurrentAG=TRUE)
##D 
##D #-- construction of the data frame for predictions
##D datapredj <- data.frame(t.stop=0,event=0,id=0,sex=0,dukes=0)
##D datapredj$sex <- as.factor(datapredj$sex)
##D levels(datapredj$sex) <- c(1,2)
##D datapredj$dukes <- as.factor(datapredj$dukes)
##D levels(datapredj$dukes) <- c(1,2,3)
##D datapredj[1,] <- c(100,1,1,1,2)
##D datapredj[2,] <- c(200,1,1,1,2)
##D datapredj[3,] <- c(300,1,1,1,2)
##D datapredj[4,] <- c(400,1,1,1,2)
##D datapredj[5,] <- c(380,1,2,1,2)
##D 
##D #-- prediction of death between 100 and 100+500 given relapses
##D pred.joint0 <- prediction(joi,datapredj,t=100,window=500,event = "Terminal")
##D print(pred.joint0)
##D 
##D #-- prediction of death between 100 and 100+w given relapses 
##D # (with confidence intervals)
##D pred.joint <- prediction(joi,datapredj,t=100,window=seq(50,1500,50),
##D event = "Terminal",MC.sample=100)
##D plot(pred.joint,conf.bands=TRUE)
##D # each y-value of the plot corresponds to the prediction between [100,x]
##D 
##D #-- prediction of death between t and t+500 given relapses
##D pred.joint2 <- prediction(joi,datapredj,t=seq(100,1000,50),
##D window=500,event = "Terminal")
##D plot(pred.joint2)
##D # each y-value of the plot corresponds to the prediction between [x,x+500], 
##D #or in the next 500
##D 
##D #-- prediction of relapse between 100 and 100+w given relapses 
##D # (with confidence intervals)
##D pred.joint <- prediction(joi,datapredj,t=100,window=seq(50,1500,50),
##D event = "Recurrent",MC.sample=100)
##D plot(pred.joint,conf.bands=TRUE)
##D # each y-value of the plot corresponds to the prediction between [100,x]
##D 
##D #-- prediction of relapse and death between 100 and 100+w given relapses 
##D # (with confidence intervals)
##D pred.joint <- prediction(joi,datapredj,t=100,window=seq(50,1500,50),
##D event = "Both",MC.sample=100)
##D plot(pred.joint,conf.bands=TRUE)
##D # each y-value of the plot corresponds to the prediction between [100,x]
##D 
##D #############################################################################
##D ### prediction on a JOINT model for longitudinal data and a terminal event ####
##D #############################################################################
##D 
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D #-- construction of the data-frame for predictions
##D #-- biomarker observations
##D datapredj_longi <- data.frame(id = 0, year = 0, tumor.size = 0, treatment = 0,
##D  age = 0, who.PS = 0, prev.resection = 0)
##D datapredj_longi$treatment <- as.factor(datapredj_longi$treatment)
##D levels(datapredj_longi$treatment) <- 1:2
##D datapredj_longi$age <- as.factor(datapredj_longi$age)
##D levels(datapredj_longi$age) <- 1:3
##D datapredj_longi$who.PS <- as.factor(datapredj_longi$who.PS)
##D levels(datapredj_longi$who.PS) <- 1:3
##D datapredj_longi$prev.resection <- as.factor(datapredj_longi$prev.resection)
##D levels(datapredj_longi$prev.resection) <- 1:2
##D 
##D # patient 1: increasing tumor size
##D datapredj_longi[1,] <- c(1, 0,1.2 ,2,1,1,1)
##D datapredj_longi[2,] <- c(1,0.3,1.4,2,1,1,1)
##D datapredj_longi[3,] <- c(1,0.6,1.9,2,1,1,1)
##D datapredj_longi[4,] <- c(1,0.9,2.5,2,1,1,1)
##D datapredj_longi[5,] <- c(1,1.5,3.9,2,1,1,1)
##D 
##D # patient 2: decreasing tumor size
##D datapredj_longi[6,] <- c(2, 0,1.2 ,2,1,1,1)
##D datapredj_longi[7,] <- c(2,0.3,0.7,2,1,1,1)
##D datapredj_longi[8,] <- c(2,0.5,0.3,2,1,1,1)
##D datapredj_longi[9,] <- c(2,0.7,0.1,2,1,1,1)
##D datapredj_longi[10,] <- c(2,0.9,0.1,2,1,1,1)
##D 
##D #-- terminal event
##D datapredj <- data.frame(id = 0, treatment = 0, age = 0, who.PS = 0,
##D prev.resection = 0)
##D datapredj$treatment <- as.factor(datapredj$treatment)
##D levels(datapredj$treatment) <- 1:2
##D datapredj$age <- as.factor(datapredj$age)
##D levels(datapredj$age) <- 1:3
##D datapredj$who.PS <- as.factor(datapredj$who.PS)
##D datapredj$prev.resection <- as.factor(datapredj$prev.resection)
##D levels(datapredj$prev.resection) <- 1:2
##D levels(datapredj$who.PS) <- 1:3
##D datapredj[1,] <- c(1,2,1,1,1)
##D datapredj[2,] <- c(2,2,1,1,1)
##D 
##D model.spli.CL <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS , 
##D colorectalSurv, data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Current-level", left.censoring = -3.33, n.knots = 6, 
##D kappa = 1)
##D 
##D #-- prediction of death between 1 year and 1+2 given history of the biomarker
##D pred.jointLongi0 <- prediction(model.spli.CL, datapredj, datapredj_longi,
##D t = 1, window = 2)
##D print(pred.jointLongi0)
##D 
##D #-- prediction of death between 1 year and 1+w given history of the biomarker
##D pred.jointLongi <- prediction(model.spli.CL, datapredj, datapredj_longi,
##D t = 1, window = seq(0.5, 2.5, 0.2), MC.sample = 100)
##D plot(pred.jointLongi, conf.bands = TRUE)
##D # each y-value of the plot corresponds to the prediction between [1,x]
##D 
##D #-- prediction of death between t and t+0.5 given history of the biomarker
##D pred.jointLongi2 <- prediction(model.spli.CL, datapredj, datapredj_longi,
##D t = seq(1, 2.5, 0.5), window = 0.5, MC.sample = 100)
##D plot(pred.jointLongi2, conf.bands = TRUE)
##D # each y-value of the plot corresponds to the prediction between [x,x+0.5], 
##D #or in the next 0.5
##D 
##D #############################################################################
##D ##### marginal prediction on a JOINT NESTED model for a terminal event ######
##D #############################################################################
##D #*--Warning! You can compute this prediction method with ONLY ONE family 
##D #*--by dataset of prediction. 
##D #*--Please make sure your data frame contains a column for individuals AND a 
##D #*--column for the reference number of the family chosen.
##D 
##D data(readmission)
##D readmissionNested <- transform(readmission,group=id%%30+1)
##D 
##D #-- construction of the data frame for predictions : 
##D #-- family 5 was selected for the prediction
##D 
##D DataPred <- readmissionNested[which(readmissionNested$group==5),]
##D 
##D #-- Fitting the model
##D modJointNested_Splines <- 
##D frailtyPenal(formula = Surv(t.start, t.stop, event)~subcluster(id)+ 
##D cluster(group) + dukes + terminal(death),formula.terminalEvent
##D =~dukes, data = readmissionNested, recurrentAG = TRUE,n.knots = 8, 
##D kappa = c(9.55e+9, 1.41e+12), initialize = TRUE)
##D 
##D #-- Compute prediction over the individuals 274 and 4 of the family 5
##D predRead <- prediction(modJointNested_Splines, data=DataPred,t=500,
##D window=seq(100,1500,200), conditional=FALSE, individual = c(274, 4))
##D 
##D 
##D #########################################################################
##D ##### prediction on TRIVARIATE JOINT model (linear and non-linear) ######
##D #########################################################################
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D #-- construction of the data frame for predictions
##D #-- history of recurrences and terminal event
##D datapredj <- data.frame(time0 = 0, time1 = 0, new.lesions = 0, id = 0, 
##D treatment = 0, age = 0, who.PS = 0, prev.resection =0)
##D datapredj$treatment <- as.factor(datapredj$treatment)
##D levels(datapredj$treatment) <- 1:2
##D datapredj$age <- as.factor(datapredj$age)
##D levels(datapredj$age) <- 1:3
##D datapredj$who.PS <- as.factor(datapredj$who.PS)
##D levels(datapredj$who.PS) <- 1:3
##D datapredj$prev.resection <- as.factor(datapredj$prev.resection)
##D levels(datapredj$prev.resection) <- 1:2
##D 
##D datapredj[1,] <- c(0,0.4,1,1,2,1,1,1)
##D datapredj[2,] <- c(0.4,1.2,1,1,2,1,1,1)
##D datapredj[3,] <- c(0,0.5,1,2,2,1,1,1)
##D 
##D # Linear trivariate joint model
##D # (computation takes around 40 minutes)
##D model.trivPenal <-trivPenal(Surv(time0, time1, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS +  terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal, 
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = TRUE,
##D n.knots = 6, kappa=c(0.01, 2), method.GH="Pseudo-adaptive",
##D n.nodes=7, init.B = c(-0.07, -0.13, -0.16, -0.17, 0.42, #recurrent events covarates
##D -0.23, -0.1, -0.09, -0.12, 0.8, -0.23, #terminal event covariates
##D 3.02, -0.30, 0.05, -0.63, -0.02, -0.29, 0.11, 0.74)) #biomarker covariates
##D 
##D #-- prediction of death between 1 year and 1+2
##D pred.jointTri0 <- prediction(model.trivPenal, datapredj, 
##D datapredj_longi, t = 1, window = 2)
##D print(pred.jointTri0)
##D 
##D #-- prediction of death between 1 year and 1+w
##D pred.jointTri <- prediction(model.trivPenal, datapredj, 
##D datapredj_longi, t = 1, window = seq(0.5, 2.5, 0.2), MC.sample = 100)
##D plot(pred.jointTri, conf.bands = TRUE)
##D 
##D #-- prediction of death between t and t+0.5
##D pred.jointTri2 <- prediction(model.trivPenal, datapredj, 
##D datapredj_longi, t = seq(1, 2.5, 0.5), window = 0.5, MC.sample = 100)
##D plot(pred.jointTri2, conf.bands = TRUE)
##D 
##D 
##D ###############################
##D 
##D # No information on dose - creation of a dummy variable 
##D colorectalLongi$dose <- 1
##D 
##D # (computation can take around 40 minutes)
##D model.trivPenalNL <- trivPenalNL(Surv(time0, time1, new.lesions) ~ cluster(id) + age + treatment
##D  + terminal(state), formula.terminalEvent =~ age + treatment, biomarker = "tumor.size",
##D  formula.KG ~ 1, formula.KD ~ treatment, dose = "dose", time.biomarker = "year", 
##D  data = colorectal, data.Longi =colorectalLongi, random = c("y0", "KG"), id = "id", 
##D  init.B = c(-0.22, -0.16, -0.35, -0.19, 0.04, -0.41, 0.23), init.Alpha = 1.86,
##D  init.Eta = c(0.5, 0.57, 0.5, 2.34), init.Biomarker = c(1.24, 0.81, 1.07, -1.53),
##D  recurrentAG = TRUE, n.knots = 5, kappa = c(0.01, 2), method.GH = "Pseudo-adaptive")
##D 
##D #-- prediction of death between 1 year and 1+2
##D pred.jointTriNL0 <- prediction(model.trivPenalNL, datapredj, 
##D datapredj_longi, t = 1, window = 2)
##D print(pred.jointTriNL0)
##D 
##D #-- prediction of death between 1 year and 1+w 
##D pred.jointTriNL <- prediction(model.trivPenalNL, datapredj, 
##D datapredj_longi, t = 1, window = seq(0.5, 2.5, 0.2), MC.sample = 100)
##D plot(pred.jointTriNL, conf.bands = TRUE)
##D 
##D #-- prediction of death between t and t+0.5
##D pred.jointTriNL2 <- prediction(model.trivPenalNL, datapredj, 
##D datapredj_longi, t = seq(2, 3, 0.2), window = 0.5, MC.sample = 100)
##D plot(pred.jointTriNL2, conf.bands = TRUE)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("prediction", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("print.frailtyDesign")
### * print.frailtyDesign

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: print.frailtyDesign
### Title: Print a short table of a 'frailtyDesign' result.
### Aliases: print.frailtyDesign
### Keywords: methods

### ** Examples

est.ex <- SFM.power(
  Groups = 400, ni = 3, ni.type = "max", FUP = 6, Acc.Dur = 0.5, median.H0 = 1.5,
  beta.HA = log(0.7), theta = 0.5, cens.par = c(3, 10), cens.type = "Unif", data.type = "rec_event"
)

print(est.ex)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("print.frailtyDesign", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("print.jointSurroPenal")
### * print.jointSurroPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: print.jointSurroPenal
### Title: Summary of the random effects parameters, the fixed treatment
###   effects, and the surrogacy evaluation criteria estimated from a joint
###   surrogate model
### Aliases: print.jointSurroPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D ###---Data generation---###
##D data.sim <-jointSurrSimul(n.obs=400, n.trial = 20,cens.adm=549, 
##D           alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1, 
##D           sigma.s = 0.7, sigma.t = 0.7, cor = 0.8, betas = -1.25, 
##D           betat = -1.25, full.data = 0, random.generator = 1, 
##D           seed = 0, nb.reject.data = 0)
##D 
##D ###---Estimation---###
##D joint.surrogate <- jointSurroPenal(data = data.sim, nb.mc = 300, 
##D                    nb.gh = 20, indicator.alpha = 1, n.knots = 6)
##D                             
##D print(joint.surrogate)
##D 
##D # or
##D joint.surrogate
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("print.jointSurroPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("runShiny")
### * runShiny

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: runShiny
### Title: Shiny application for modelisation and prediction of frailty
###   models
### Aliases: runShiny

### ** Examples

## Not run: 
##D 
##D runShiny()
##D 
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("runShiny", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("slope")
### * slope

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: slope
### Title: Identify variable associated with the random slope
### Aliases: slope
### Keywords: misc

### ** Examples



## No test: 

data(dataAdditive)

##-- Additive with one covariate --##

modAdd1cov <- additivePenal(Surv(t1,t2,event)~cluster(group)+var1+
slope(var1),data=dataAdditive,n.knots=8,kappa=10000,hazard="Splines")

##-- Additive with two covariates --##

set.seed(1234)
dataAdditive$var2 <- rbinom(nrow(dataAdditive),1,0.5)

modAdd2cov <- additivePenal(Surv(t1,t2,event)~cluster(group)+var1+
var2+slope(var1),data=dataAdditive,n.knots=8,kappa=10000,
hazard="Splines")

##-- Additive with 2 covariates and stratification --##

dataAdditive$var2 <- rbinom(nrow(dataAdditive),1,0.5)

modAddstrat <- additivePenal(Surv(t1,t2,event)~cluster(group)+
strata(var2)+var1+slope(var1),data=dataAdditive,n.knots=8,
kappa=c(10000,10000),hazard="Splines")

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("slope", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ste")
### * ste

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ste
### Title: Surrogate threshold effect for the one-step Joint surrogate
###   model for the evaluation of a canditate surrogate endpoint.
### Aliases: ste
### Keywords: Surrogate effect prediction ste surrogate threshold

### ** Examples



## No test: 


###--- Joint surrogate model ---###
###---evaluation of surrogate endpoints---###

data(dataOvarian)
joint.surro.ovar <- jointSurroPenal(data = dataOvarian, n.knots = 8, 
                init.kappa = c(2000,1000), indicator.alpha = 0, 
                nb.mc = 200, scale = 1/365)

# ======STE=====
# Assuming errors on the estimates
ste(joint.surro.ovar, var.used = "error.estim")
# Assuming no errors on the estimates
ste(joint.surro.ovar, var.used = "No.error", pred.int.use = "up")

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ste", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("subcluster")
### * subcluster

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: subcluster
### Title: Identify subclusters
### Aliases: subcluster
### Keywords: misc

### ** Examples



## Not run: 
##D 
##D data(dataNested)
##D modClu <- frailtyPenal(Surv(t1,t2,event)~cluster(group)+
##D subcluster(subgroup)+cov1+cov2,data=dataNested,
##D n.knots=8,kappa=c(50000,50000),hazard="Splines")
##D 
##D print(modClu)
##D 
##D #-- here is generated cluster (30 clusters)
##D readmissionNested <- transform(readmission,group=id%%30+1)
##D 
##D modJointNested_Splines <- frailtyPenal(formula = Surv(t.start, t.stop, event)
##D 	~ subcluster(id) + cluster(group) + dukes + 
##D 	terminal(death), formula.terminalEvent = ~dukes, 
##D 	data = readmissionNested, recurrentAG = TRUE, n.knots = 8, 
##D 	kappa = c(9.55e+9, 1.41e+12), initialize = TRUE)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("subcluster", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.additivePenal")
### * summary.additivePenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.additivePenal
### Title: summary of parameter estimates of an additive frailty model
### Aliases: summary.additivePenal print.summary.additivePenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D data(dataAdditive)
##D 
##D modAdd <- additivePenal(Surv(t1,t2,event)~cluster(group)+var1+slope(var1),
##D correlation=TRUE,data=dataAdditive,n.knots=8,kappa=862,hazard="Splines")
##D 
##D #- 'var1' is boolean as a treatment variable.
##D 
##D summary(modAdd)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.additivePenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.frailtyCmprsk")
### * summary.frailtyCmprsk

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.frailtyCmprsk
### Title: summary of parameter estimates of a Weibull competing risks
###   model with (or without) shared frailty between transitions.
### Aliases: summary.frailtyCmprsk print.summary.frailtyCmprsk
### Keywords: methods

### ** Examples


  ## No test: 

    ###--- Simple Weibull competing risks model ---###

    ###--- Weibull competing risks model with shared frailty between transitions ---###

    data(CPRSKbmtcrr)

    ##--- Simple Weibull competing risks model with left truncation ---##

    modCmprskFrailty <- frailtyCmprsk(
      formulas = list(
        Surv(Age, observed_time, Status, type = "mstate") ~ Sex,
        ~ Sex
      ),
      data = CPRSKbmtcrr,
      print.info = FALSE,
      maxit = 100
    )

    #-- Confidence interval at 95% level (default)

    summary(modCmprskFrailty)

    #-- Confidence interval at 99% level

    summary(modCmprskFrailty, level = 0.99) 
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.frailtyCmprsk", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.frailtyDesign")
### * summary.frailtyDesign

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.frailtyDesign
### Title: Summarize a 'frailtyDesign' object.
### Aliases: summary.frailtyDesign
### Keywords: methods

### ** Examples

est.ex <- SFM.power(
  Groups = 400, ni = 3, ni.type = "max", FUP = 6, Acc.Dur = 0.5, median.H0 = 1.5,
  beta.HA = log(0.7), theta = 0.5, cens.par = c(3, 10), cens.type = "Unif", data.type = "rec_event"
)

summary(est.ex)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.frailtyDesign", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.frailtyIllnessDeath")
### * summary.frailtyIllnessDeath

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.frailtyIllnessDeath
### Title: Summary of parameter estimates of a Weibull Illness-Death model
###   with (or without) shared frailty between transitions.
### Aliases: summary.frailtyIllnessDeath print.summary.frailtyIllnessDeath
### Keywords: methods

### ** Examples


  ## No test: 



    ###--- Semi-Markovian Weibull Illness-Death model with left truncation ---###

    data(Paq810)

    ModIllnessDeath_LeftTrunc <- frailtyIllnessDeath(formula = Surv(e,r,dementia) ~ gender+certif,
    formula.terminalEvent = Surv(t,death) ~ gender+certif  ,
    data=Paq810, print.info = FALSE, maxit=100)

    #-- confidence interval at 95% level (default)

    summary(ModIllnessDeath_LeftTrunc)

    #-- confidence interval at 99% level

    summary(ModIllnessDeath_LeftTrunc,level=0.99)

  
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.frailtyIllnessDeath", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.frailtyPenal")
### * summary.frailtyPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.frailtyPenal
### Title: summary of parameter estimates of a shared frailty model
### Aliases: summary.frailtyPenal print.summary.frailtyPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D data(kidney)
##D 
##D ##-- Shared frailty model --##
##D 
##D modSha <- frailtyPenal(Surv(time,status)~age+sex+cluster(id),
##D n.knots=8,kappa=10000,data=kidney,hazard="Splines")
##D 
##D ##-- Cox proportional hazard model --##
##D 
##D modCox <- frailtyPenal(Surv(time,status)~age+sex,
##D n.knots=8,kappa=10000,data=kidney,hazard="Splines")
##D 
##D #-- confidence interval at 95% level (default)
##D 
##D summary(modSha)
##D summary(modCox)
##D 
##D #-- confidence interval at 99% level
##D 
##D summary(modSha,level=0.99)
##D summary(modCox,level=0.99)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.frailtyPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.jointNestedPenal")
### * summary.jointNestedPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.jointNestedPenal
### Title: summary of parameter estimates of a joint nested frailty model
### Aliases: summary.jointNestedPenal print.summary.jointNestedPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D #-- here is generated cluster (30 clusters)
##D readmissionNested <- transform(readmission,group=id%%30+1)
##D 
##D # Baseline hazard function approximated with splines with calendar-timescale
##D 
##D model.spli.AG <- frailtyPenal(formula = Surv(t.start, t.stop, event)
##D  ~ subcluster(id) + cluster(group) + dukes + terminal(death), 
##D  formula.terminalEvent = ~dukes, data = readmissionNested, 
##D  recurrentAG = TRUE, n.knots = 8, kappa = c(9.55e+9, 1.41e+12),
##D  initialize = TRUE)
##D 
##D summary(model.spli.AG)
##D 
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.jointNestedPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.jointPenal")
### * summary.jointPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.jointPenal
### Title: summary of parameter estimates of a joint frailty model
### Aliases: summary.jointPenal print.summary.jointPenal
### Keywords: methods

### ** Examples

## Not run: 
##D 
##D data(readmission)
##D 
##D #-- gap-time
##D modJoint.gap <- frailtyPenal(
##D   Surv(time, event) ~ cluster(id) + sex + dukes +
##D     charlson + terminal(death),
##D   formula.terminalEvent = ~ sex + dukes + charlson,
##D   data = readmission, n.knots = 14, kappa = c(9.55e+9, 1.41e+12)
##D )
##D 
##D #-- calendar time
##D modJoint.calendar <- frailtyPenal(
##D   Surv(t.start, t.stop, event) ~ cluster(id) +
##D     sex + dukes + charlson + terminal(death),
##D   formula.terminalEvent = ~ sex + dukes + charlson,
##D   data = readmission, n.knots = 10, kappa = c(9.55e+9, 1.41e+12), recurrentAG = TRUE
##D )
##D 
##D #-- It takes around 1 minute to converge
##D 
##D summary(modJoint.gap)
##D summary(modJoint.calendar)
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.jointPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.jointSurroPenal")
### * summary.jointSurroPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.jointSurroPenal
### Title: Short summary of the surrogacy evaluation criteria estimated
###   from a joint surrogate model
### Aliases: summary.jointSurroPenal
### Keywords: methods

### ** Examples


## Not run: 
##D 
##D ###---Data generation---###
##D data.sim <-jointSurrSimul(n.obs=400, n.trial = 20,cens.adm=549,
##D           alpha = 1.5, theta = 3.5, gamma = 2.5, zeta = 1,
##D           sigma.s = 0.7, sigma.t = 0.7, cor = 0.8, betas = -1.25,
##D           betat = -1.25, full.data = 0, random.generator = 1,
##D           seed = 0, nb.reject.data = 0)
##D 
##D ###---Estimation---###
##D joint.surrogate <- jointSurroPenal(data = data.sim, nb.mc = 300,
##D                    nb.gh = 20, indicator.alpha = 1, n.knots = 6)
##D 
##D summary(joint.surrogate)
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.jointSurroPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.jointSurroPenalSimul")
### * summary.jointSurroPenalSimul

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.jointSurroPenalSimul
### Title: Short summary of the simulation studies based on a joint
###   surrogate model
### Aliases: summary.jointSurroPenalSimul
###   print.summary.jointSurroPenalSimul
### Keywords: methods

### ** Examples


# Studies simulation
## Not run: 
##D # (Computation takes around 45 minutes using a processor including 40
##D # cores and a read only memory of 378 Go)
##D joint.simul <- jointSurroPenalSimul(nb.dataset = 10, nbSubSimul=600, 
##D                    ntrialSimul=30, LIMparam = 0.001, LIMlogl = 0.001, 
##D                    LIMderiv = 0.001, nb.mc = 200, nb.gh = 20, 
##D                    nb.gh2 = 32, true.init.val = 1, print.iter=F)
##D 
##D # results
##D summary(joint.simul, d = 3, R2boot = 1) # bootstrap
##D summary(joint.simul, d = 3, R2boot = 0) # Delta-method
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.jointSurroPenalSimul", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.longiPenal")
### * summary.longiPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.longiPenal
### Title: Short summary of fixed covariates estimates of a joint model for
###   longitudinal data and a terminal event.
### Aliases: summary.longiPenal print.summary.longiPenal
### Keywords: methods

### ** Examples



## Not run: 
##D ###--- Joint model for longitudinal data and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D # Baseline hazard function approximated with splines
##D # Random effects as the link function
##D 
##D model.spli.RE <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS 
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS ,
##D colorectalSurv,	data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Random-effects", left.censoring = -3.33, 
##D n.knots = 7, kappa = 2)
##D 
##D # Weibull baseline hazard function
##D # Current level of the biomarker as the link function
##D 
##D model.weib.CL <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS , 
##D colorectalSurv, data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Current-level", left.censoring = -3.33, hazard = "Weibull")
##D 	
##D summary(model.spli.RE)
##D summary(model.weib.CL)
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.longiPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.nestedPenal")
### * summary.nestedPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.nestedPenal
### Title: summary of regression coefficient estimates of a nested frailty
###   model
### Aliases: summary.nestedPenal print.summary.nestedPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D data(dataNested)
##D 
##D modNested <- frailtyPenal(Surv(t1,t2,event)~cluster(group)+
##D subcluster(subgroup)+cov1+cov2,data=dataNested,
##D n.knots=8,kappa=c(50000,50000),hazard="Splines")
##D 
##D #- It takes 90 minutes to converge (depends on processor)
##D 
##D summary(modNested)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.nestedPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.trivPenal")
### * summary.trivPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.trivPenal
### Title: Short summary of fixed covariates estimates of a joint model for
###   longitudinal data, recurrent events and a terminal event
### Aliases: summary.trivPenal print.summary.trivPenal
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D ###--- Trivariate joint model for longitudinal data, ---###
##D ###--- recurrent events and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Weibull baseline hazard function
##D # Random effects as the link function, Gap timescale
##D # (computation takes around 30 minutes)
##D model.weib.RE.gap <-trivPenal(Surv(gap.time, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive", n.nodes = 7)
##D 
##D summary(model.weib.RE.gap)
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.trivPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.trivPenalNL")
### * summary.trivPenalNL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.trivPenalNL
### Title: Short summary of fixed covariates estimates of a non-linear
###   trivariate joint model for longitudinal data, recurrent events and a
###   terminal event
### Aliases: summary.trivPenalNL print.summary.trivPenalNL
### Keywords: methods

### ** Examples



## Not run: 
##D 
##D ###--- Trivariate joint model for longitudinal data, ---###
##D ###--- recurrent events and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Weibull baseline hazard function
##D # Random effects as the link function, Gap timescale
##D # (computation takes around 30 minutes)
##D model.weib.RE.gap <-trivPenal(Surv(gap.time, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive", n.nodes = 7)
##D 
##D summary(model.weib.RE.gap)
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.trivPenalNL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("survival")
### * survival

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: survival
### Title: Survival function
### Aliases: survival

### ** Examples



## Not run: 
##D 
##D #-- a fit Shared
##D data(readmission)
##D 
##D fit.shared <- frailtyPenal(Surv(time,event)~dukes+cluster(id)+
##D strata(sex),n.knots=10,kappa=c(10000,10000),data=readmission)
##D 
##D #-- calling survival
##D survival(20,fit.shared)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("survival", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("timedep")
### * timedep

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: timedep
### Title: Identify time-varying effects
### Aliases: timedep
### Keywords: misc

### ** Examples



## No test: 

data(readmission)

###--- Shared Frailty model with time-varying effect ---###

sha.time <- frailtyPenal(Surv(time,event)~cluster(id)+dukes+charlson+
timedep(sex)+chemo,data=readmission,n.knots=8,kappa=1,
betaknots=3,betaorder=3)

#-- print results of the fit and the associated curves for the
#-- time-dependent effects
print(sha.time)

###--- Joint Frailty model with time-varying effect ---###

joi.time <- frailtyPenal(Surv(time,event)~cluster(id)+timedep(sex)+
chemo+terminal(death),formula.terminalEvent=~timedep(sex)+chemo,
data=readmission,n.knots=8,kappa=c(1,1),betaknots=3,betaorder=3)

print(joi.time)

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("timedep", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("trivPenal")
### * trivPenal

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: trivPenal
### Title: Fit a Trivariate Joint Model for Longitudinal Data, Recurrent
###   Events and a Terminal Event
### Aliases: trivPenal
### Keywords: models

### ** Examples



## Not run: 
##D 
##D ###--- Trivariate joint model for longitudinal data, ---###
##D ###--- recurrent events and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # Parameter initialisation for covariates - longitudinal and terminal part
##D 
##D # Survival data preparation - only terminal events 
##D colorectalSurv <- subset(colorectal, new.lesions == 0)
##D 
##D initial.longi <- longiPenal(Surv(time1, state) ~ age + treatment + who.PS 
##D + prev.resection, tumor.size ~  year * treatment + age + who.PS ,
##D colorectalSurv,	data.Longi = colorectalLongi, random = c("1", "year"),
##D id = "id", link = "Random-effects", left.censoring = -3.33, 
##D n.knots = 6, kappa = 2, method.GH="Pseudo-adaptive",
##D  maxit=40, n.nodes=7)
##D 
##D 
##D # Parameter initialisation for covariates - recurrent part
##D initial.frailty <- frailtyPenal(Surv(time0, time1, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS, data = colorectal,
##D recurrentAG = TRUE, RandDist = "LogN", n.knots = 6, kappa =2)
##D 
##D 
##D # Baseline hazard function approximated with splines
##D # Random effects as the link function, Calendar timescale
##D # (computation takes around 40 minutes)
##D 
##D model.spli.RE.cal <-trivPenal(Surv(time0, time1, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS +  terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal, 
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = TRUE,
##D n.knots = 6, kappa=c(0.01, 2), method.GH="Standard", n.nodes = 7,
##D init.B = c(-0.07, -0.13, -0.16, -0.17, 0.42, #recurrent events covariates
##D -0.16, -0.14, -0.14, 0.08, 0.86, -0.24, #terminal event covariates
##D 2.93, -0.28, -0.13, 0.17, -0.41, 0.23, 0.97, -0.61)) #biomarker covariates
##D 
##D 
##D 
##D # Weibull baseline hazard function
##D # Random effects as the link function, Gap timescale
##D # (computation takes around 30 minutes)
##D model.weib.RE.gap <-trivPenal(Surv(gap.time, new.lesions) ~ cluster(id)
##D + age + treatment + who.PS + prev.resection + terminal(state),
##D formula.terminalEvent =~ age + treatment + who.PS + prev.resection, 
##D tumor.size ~ year * treatment + age + who.PS, data = colorectal,
##D data.Longi = colorectalLongi, random = c("1", "year"), id = "id", 
##D link = "Random-effects", left.censoring = -3.33, recurrentAG = FALSE,
##D hazard = "Weibull", method.GH="Pseudo-adaptive",n.nodes=7)
##D 
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("trivPenal", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("trivPenalNL")
### * trivPenalNL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: trivPenalNL
### Title: Fit a Non-Linear Trivariate Joint Model for Recurrent Events and
###   a Terminal Event with a Biomarker Described with an ODE Population
###   Model
### Aliases: trivPenalNL
### Keywords: models

### ** Examples



## Not run: 
##D 
##D ###--- Non-linear trivariate joint model for longitudinal data, ---###
##D ###--- recurrent events and a terminal event ---###
##D 
##D data(colorectal)
##D data(colorectalLongi)
##D 
##D # No information on dose - creation of a dummy variable 
##D colorectalLongi$dose <- 1
##D 
##D 
##D # Parameters initialisation - estimation of a simplified model
##D # with two random effects (a frailty term and a random effect 
##D # related to biomarker growth (KG))
##D initial.model <- trivPenalNL(Surv(time0, time1, new.lesions) ~ cluster(id)
##D  + age + treatment + terminal(state), formula.terminalEvent =~ age + treatment, 
##D  biomarker = "tumor.size", formula.KG ~ 1, formula.KD ~ treatment, dose = "dose",
##D  time.biomarker = "year", data = colorectal, data.Longi =colorectalLongi, 
##D  random = "KG", id = "id", recurrentAG = TRUE, n.knots = 5, kappa = c(0.01, 2),
##D  method.GH = "Pseudo-adaptive")
##D 
##D 
##D # Trivariate joint model with initial values for parameters
##D # (computation takes around 40 minutes)
##D 
##D model <- trivPenalNL(Surv(time0, time1, new.lesions) ~ cluster(id) + age + treatment
##D  + terminal(state), formula.terminalEvent =~ age + treatment, biomarker = "tumor.size",
##D  formula.KG ~ 1, formula.KD ~ treatment, dose = "dose", time.biomarker = "year", 
##D  data = colorectal, data.Longi =colorectalLongi, random = c("y0", "KG"), id = "id", 
##D  init.B = c(-0.22, -0.16, -0.35, -0.19, 0.04, -0.41, 0.23), init.Alpha = 1.86,
##D  init.Eta = c(0.5, 0.57, 0.5, 2.34), init.Biomarker = c(1.24, 0.81, 1.07, -1.53),
##D  recurrentAG = TRUE, n.knots = 5, kappa = c(0.01, 2), method.GH = "Pseudo-adaptive")
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("trivPenalNL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("wts")
### * wts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: wts
### Title: Identify weights
### Aliases: wts
### Keywords: misc

### ** Examples



## No test: 

data(dataNCC)
modJoint.ncc <- frailtyPenal(Surv(t.start,t.stop,event)~cluster(id)+cov1
+cov2+terminal(death)+wts(ncc.wts), formula.terminalEvent=~cov1+cov2,
data=dataNCC,n.knots=8,kappa=c(1.6e+10, 5.0e+03),recurrentAG=TRUE, RandDist="LogN") 



print(modJoint.ncc)

## End(No test)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("wts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
