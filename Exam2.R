##########################################################################
##  ECONOMETRICS EXAM 2 - MASTER SCRIPT   (ECN 377, Exam II, Wed 11/11)
##  Built from Problem Sets 8-12, Quizzes 8-10, Days 13-21, Exam I review
##
##  HOW TO USE
##   1. Ctrl+F a few PLAIN WORDS from the question (not the math symbols):
##      "standard error", "point of means", "3.23", "biased", "log-level", "MLR3" ...
##   2. PART 1 = multiple choice / select all / true-false. The answer is right under it.
##      FLIP: = the answer if he asks the OPPOSITE version (larger/smaller, up/down ...).
##   3. PART 2 = computation. Change the INPUT lines, highlight the WHOLE block, Ctrl+Enter.
##      Every block prints EVERY related answer (labeled). Pick the one you need.
##      Every block is self-contained: it never needs another block run first.
##      "# check:" = what the block prints with the numbers already in it.
##   4. Answers print UNROUNDED. Round to the hundredths only when you type it in.
##   5. TYPE NEGATIVE NUMBERS WITH THE MINUS:  b1 <- -0.051   dx <- -3 (a FALL)
##   6. REAL DATA: always grab coefficients by NAME:  b["educ"]   (b[2] style = off-by-one risk)
##      if library(wooldridge) errors: install.packages("wooldridge")
##
##   7. Run this line once when you open R (no 1e-14 style numbers):
options(scipen = 999)
##
##  TIME RULE: one question at a time, ~2 min max, never leave a blank.
##
##  SECTIONS (Ctrl+F the section name)
##   PART 1  CONCEPT QUESTIONS (multiple choice / select all)
##   PART 2  COMPUTATION
##     SECTION 0  EXAM I REVIEW (probability tables, Var rules, sample stats, SST/SSE/SSR/R2, SLR all-in-one)
##     SECTION 1  UNITS AND LOGS
##     SECTION 2  VARIANCE OF OLS + STANDARD ERRORS (given numbers)  <- PS12 #4, #6
##     SECTION 3  MULTIPLE REGRESSION (predict, change, point of means)
##     SECTION 4  OMITTED-VARIABLE BIAS (3.23)
##     SECTION 5  REAL DATA IN R  (se by hand = PS12 #8-12 is here)
##########################################################################

##  FORMULAS (Ctrl+F the word)
##   predicted change:   delta yhat = b1*dx1 + b2*dx2 + ...      (intercept never matters)
##   log-level  log(y) on x       : %delta y = 100 * b1 * delta x
##   log-log    log(y) on log(x)  : %delta y = b1 * (%delta x)          b1 = ELASTICITY
##   level-log  y on log(x)       : delta y  = (b1/100) * (%delta x)
##   undo a log: yhat = exp(predicted log(y))
##   SST_X = sum((x - mean(x))^2) = (n - 1) * Sx^2
##   SLR:  Var(b1hat) = sigma^2 / SST_X        sd(b1hat) = sigma / sqrt(SST_X)
##   MLR:  Var(bjhat) = sigma^2 / (SST_j * (1 - R_j^2))
##   degrees of freedom df = n - K - 1   (K = number of x's, NOT counting the intercept; SLR: n - 2)
##   sigma-hat^2 = SSR / df      sigma-hat = sqrt(SSR / df)   (= "Residual standard error" in summary)
##   se(bjhat) = sigma-hat / sqrt(SST_j * (1 - R_j^2))
##   sample k times as large -> SST k times as large -> sd/se DIVIDED BY sqrt(k)  (Var divided by k)
##   3.23:  btilde1 = bhat1 + bhat2 * dtilde1     Bias(btilde1) = beta2 * delta1
##   SST = SSE + SSR    R2 = SSE/SST = 1 - SSR/SST    (SSE = EXPLAINED, SSR = RESIDUAL)


##########################################################################
##########################################################################
##  PART 1  CONCEPT QUESTIONS  (exact idea -> answer, + FLIP)
##########################################################################
##########################################################################

## ---- Exam I review ----

# Var(X + b) equals:
#   ANSWER: Var(X)   (a constant shifts, does not spread)
#   Var(aX + b) = a^2 Var(X)      sd(aX + b) = |a| sd(X)      E[aX + b] = a E[X] + b (constant DOES matter for the mean)

# Which is a population quantity (a fixed number) and which is a sample statistic (a random variable)?
#   ANSWER: mu_Y = E[Y] is a FIXED population number.  Ybar (sample mean) is a RANDOM VARIABLE (changes sample to sample).
#   FLIP: "which one is random?" -> Ybar / the estimate (bhat).  "which is fixed?" -> mu_Y / beta.

# Income in dollars -> thousands of dollars. What happens to the CORRELATION with education?
#   ANSWER: Nothing. Correlation is unitless (any positive rescaling leaves it unchanged). Same for R^2.
#   The COVARIANCE does change: Cov(aX, cY) = a*c*Cov(X, Y). (Rescale by a NEGATIVE number -> correlation flips sign.)

# In a sample where y is not all equal, every observation lies exactly on the OLS line. Then:
#   ANSWER: SSR = 0 and R^2 = 1.      FLIP (line explains nothing / slope 0): SSE = 0, R^2 = 0, SST = SSR.

# Four candidate lines: which is the OLS line?
#   ANSWER: among lines whose residuals SUM TO 0, pick the SMALLEST sum of squared residuals.

# A residual is negative. ->  OVER-predicted (actual < fitted).   FLIP: positive -> UNDER-predicted.

## ---- Units and functional form ----

# Every value of Y multiplied by c (e.g. thousands of dollars -> dollars, c = 1000):
#   ANSWER: b0hat AND b1hat both multiplied by c. R^2 unchanged.
#   FLIP (Y divided by c): both divided by c.

# Every value of X multiplied by c:
#   ANSWER: b1hat DIVIDED by c, b0hat unchanged, R^2 unchanged.
#   FLIP (X divided by c, e.g. percent -> decimal): b1hat MULTIPLIED by c, b0hat unchanged.

# log(y) on x (or log-log): Y measured in different units (y times c). What happens?
#   ANSWER: SLOPE DOES NOT CHANGE; only the INTERCEPT changes (new b0 = b0 + log(c)).  R^2 unchanged.
#   Same rule for a LOGGED x: rescaling x inside log() never changes its slope, only the intercept.

# Level-log: y = b0 + 20*log(adv). What does 20 mean?
#   ANSWER: a 1% rise in adv -> y rises by about 20/100 = 0.20 UNITS.
# Log-level: log(y) = b0 + 0.03*x. -> +1 x -> y rises about 3%.
# Log-log: log(rent) = b0 + 0.45*log(income). -> a 1% rise in income -> about 0.45% rise in rent (ELASTICITY).
# Level-level: +1 x -> y changes by b1 UNITS.
# In which model is the slope an elasticity?  ANSWER: log-log.
# In which model is 100*b1 the % change in y from +1 x?  ANSWER: log-level.
# In which model is b1/100 the unit change in y from a 1% rise in x?  ANSWER: level-log.
# Turn a predicted log(y) back into y:  ANSWER: exp()

## ---- Unbiasedness and variance of OLS ----

# Theorem 2.1 / unbiased means:
#   ANSWER: averaged over many random samples, b1hat equals beta1 (E[b1hat] = beta1).
#   1,000 researchers, 1,000 samples: they get DIFFERENT estimates, but their AVERAGE is close to beta1.
#   NOT: every sample gives beta1 exactly / no spread / all positive / most overestimate.

# Why prefer an unbiased estimator with a SMALLER variance?
#   ANSWER: its estimates land closer to beta1 from sample to sample, so any one estimate is more reliable.

# Var(b1hat) = sigma^2 / SST_X.  Which changes make it LARGER? (select all)
#   ANSWER: a LARGER error variance sigma^2;  a SMALLER sample;  x values BUNCHED together (smaller SST_X / smaller Sx).
#   FLIP (SMALLER): a smaller sigma^2;  a LARGER sample;  x values MORE SPREAD OUT (larger SST_X).
#   NEVER matters: the size of the true slope beta1, the intercept.

# Sample k times as large (x spread the same way):  sd(b1hat) is DIVIDED BY sqrt(k)  (not by k).  Var divided by k.
# sigma doubles:  sd(b1hat) doubles  (Var times 4).

# Every worker has exactly 12 years of educ; regress wage on educ. What goes wrong?
#   ANSWER: SLR3 fails: x has no variation, the slope cannot be computed.

# Spread of food spending around the line grows with income:
#   ANSWER: SLR5 (homoskedasticity) fails -> the variance formula sigma^2/SST_X no longer applies. OLS is STILL UNBIASED.

# Ability is in U and correlated with educ:
#   ANSWER: SLR4 / MLR4 (zero conditional mean, E[U|X] = 0) fails -> educ is ENDOGENOUS -> OLS is BIASED.

# sigma-hat = sqrt(SSR / (n - K - 1)) estimates:
#   ANSWER: sigma, the standard deviation of the ERROR U.   (NOT sd of Y, NOT R^2, NOT sd of bhat)
# Divide SSR by:  n - 2 in SLR,  n - K - 1 in MLR   (not n, not n - 1)

## ---- Multiple regression ----

# In wage = b0 + b1*educ + b2*exper, what does b1 measure?
#   ANSWER: the predicted change in wage from one more year of educ, HOLDING EXPER FIXED (ceteris paribus).
#   NOT "letting experience change too".

# After OLS (with an intercept), which are ALWAYS true? (select all)
#   TRUE:  the residuals sum to 0 / average 0
#   TRUE:  sample covariance between EACH x_j and the residuals = 0   (so sum(x * uhat) = 0)
#   TRUE:  sample covariance between the FITTED values yhat and the residuals = 0
#   TRUE:  the line passes through the point of means: ybar = b0 + b1*x1bar + b2*x2bar + ...
#   FALSE: residuals add up to SSR  |  covariance between Y ITSELF and the residuals is 0  |  every residual is 0 in large samples

# MLR1 = linear in parameters (Y = b0 + b1 X1 + ... + bK XK + U)
# MLR2 = random sampling
# MLR3 = no perfect collinearity (no x is an EXACT linear function of the others; each x varies)
# MLR4 = zero conditional mean E[U | X1..XK] = 0   (fails -> endogenous, biased)
# MLR5 = homoskedasticity Var(U | X) = sigma^2
#   unbiasedness needs MLR1-MLR4.   Var formulas / Gauss-Markov need MLR1-MLR5.

# Which regressions VIOLATE MLR3 (OLS cannot estimate them)? (select all)
#   VIOLATE: total = part1 + part2 all included (total sales = online + store; totexpend = expendA + expendB)
#   VIOLATE: same variable twice in different units (sqft AND sq meters; income in $ AND in $1000s)
#   VIOLATE: more parameters than observations (3 x's on 3 obs; 5 x's on 4 obs -> need n >= K + 1... really n > K + 1)
#   VIOLATE: an x with no variation (everyone educ = 12)
#   OK:      x's highly but NOT perfectly correlated (study hours & sleep, ACT & hsGPA)
#   OK:      wage on educ alone;  wage on educ and exper where both vary
# R output for an exact linear function (totexpend): NA  (R drops it).

# Which situation makes MLR4 fail (endogenous x)?
#   ANSWER: a variable that affects Y AND is correlated with an x is left out  (or wrong functional form).
#   NOT: high-but-not-perfect correlation, small sample, units of measurement.

# Why not add every variable we can find?
#   ANSWER: adding variables can INCREASE the variance of the OLS estimates and can even violate MLR3.

# Gauss-Markov theorem:  under MLR1-MLR5, OLS is BLUE = Best Linear Unbiased Estimator.
#   "Best" = SMALLEST VARIANCE among linear unbiased estimators.  (not "unbiased", not "highest R^2")

## ---- Omitted-variable bias ----

# An omitted variable biases the slope only if it (1) affects Y (beta2 != 0) AND (2) is correlated with X1 (delta1 != 0).
# Bias(btilde1) = beta2 * delta1.   SIGN TABLE (Table 3.2, "two legs"):
#                         corr(X1,X2) > 0    corr(X1,X2) < 0
#     beta2 > 0 (raises Y)    UPWARD             DOWNWARD
#     beta2 < 0 (lowers Y)    DOWNWARD           UPWARD
#   rule: SAME signs -> UPWARD (overstates).  OPPOSITE signs -> DOWNWARD (understates / more negative).

# When is there NO omitted-variable bias? (select all)
#   ANSWER: X2 has no effect on Y (beta2 = 0)  OR  X2 uncorrelated with X1 (delta1 = 0).
#   NOT: high R^2, very large sample, X2 has big effect and is strongly correlated.

# Stories (memorize the two legs):
#   wage ~ educ, omit ability:          ability raises wage (+), ability ~ educ (+)        -> UPWARD
#   test score ~ class size, omit family income: income raises scores (+), richer = smaller classes (-) -> DOWNWARD
#   yield ~ fertilizer, omit land quality: better land raises yield (+), more fertilizer on better land (+) -> UPWARD (overstates)
#   exam ~ tutoring, omit prior ability:  ability raises scores (+), low-ability students tutor more (-)   -> DOWNWARD (understates)
#   bwght ~ cigs, omit faminc:          income raises bwght (+), smokers have lower income (-) -> DOWNWARD (more negative)
#   math10 ~ lnchprg, omit poverty:     negative slope = poverty drives both, not free lunch lowering scores
# bwght reading: simple cigs slope -0.51, multiple (holding faminc) -0.46:
#   ANSWER: -0.46 = effect of smoking HOLDING INCOME FIXED; the other -0.05 is income's effect riding along.
# What does an omitted variable do in words?  it AFFECTS Y and MOVES WITH the included X, so X gets credit for it.

## ---- Variances in multiple regression / standard errors (PS12) ----

# In se(bjhat) = sigma-hat / sqrt(SST_j (1 - R_j^2)), what is X_j?
#   ANSWER: the independent variable whose coefficient bjhat we want the standard error of.

# You want se of the EXPER coefficient in wage ~ educ + exper + tenure. Which regression gives R_j^2?
#   ANSWER: exper on the OTHER x's:  lm(exper ~ educ + tenure).   Y (wage) is NOT involved.
#   pattern: for X_j = bdrms in price ~ sqrft + bdrms + lotsize -> lm(bdrms ~ sqrft + lotsize)

# What makes Var(bjhat) LARGER? (select all)
#   ANSWER: larger sigma^2;  smaller SST_j (less variation in X_j / smaller n);  LARGER R_j^2 (X_j explained by the other x's = multicollinearity)
#   FLIP (SMALLER): smaller sigma^2; larger SST_j (more spread / bigger n); SMALLER R_j^2.
# As R_j^2 -> 1 (holding sigma-hat and SST_j fixed): se GROWS WITHOUT BOUND (multicollinearity).
#   FLIP: R_j^2 = 0 -> se = sigma-hat / sqrt(SST_j), same as the simple-regression formula.

# summary(reg) line "Residual standard error: ... on 84 degrees of freedom" matches:
#   ANSWER: sigma-hat, and its df = n - K - 1.
# summary(reg)$coefficients: rows = (Intercept), then x's IN ORDER; column 2 = "Std. Error". Intercept is ROW 1.

# Missing data: Y has NAs, X_j does not; you compute SST_j from all rows of X_j. What happens?
#   ANSWER: your hand se can differ from summary(reg), because SST_j uses rows the regression dropped.
#   Compute every piece on the same rows the regression used (Section 5 blocks use model.frame(reg) = done for you).


##########################################################################
##########################################################################
##  PART 2  COMPUTATION
##########################################################################
##########################################################################


##########################################################################
##  SECTION 0  EXAM I REVIEW
##########################################################################

# ONE RANDOM VARIABLE from a probability list: E[X], E[X^2], Var(X), sd(X), and E / Var / sd of aX + b
# (X takes values ... with probabilities ...;  "find the standard deviation of 2X - 4")
vals <- c(12, 27, 43)                  # INPUT values
p    <- c(0.5, 0.3, 0.2)               # INPUT probabilities (equally likely 3 values: rep(1/3, 3))
a <- 2; b <- 3                         # INPUT for aX + b  (2X - 4 -> a <- 2; b <- -4)
EX <- sum(vals * p); EX2 <- sum(vals^2 * p); VarX <- EX2 - EX^2
c(EX = EX, EX2 = EX2, VarX = VarX, sdX = sqrt(VarX),
  E_aXb = a * EX + b, Var_aXb = a^2 * VarX, sd_aXb = abs(a) * sqrt(VarX))
# check: EX 22.7, E_aXb 48.4   (same block = conditional E[2Y + 3 | X = x])

# GIVEN MOMENTS (no table): E[X] and E[X^2] (or Var(X)) -> Var, sd of aX + b
# ("E[X] = 1 and E[X^2] = 21. Find the standard deviation of 2X - 4.")
EX <- 1; EX2 <- 21                     # INPUT  (if Var(X) is given instead: VarX <- 20 and skip EX2)
a <- 2; b <- -4                        # INPUT
VarX <- EX2 - EX^2
c(VarX = VarX, sdX = sqrt(VarX), E_aXb = a * EX + b, Var_aXb = a^2 * VarX, sd_aXb = abs(a) * sqrt(VarX))
# check: sd_aXb 8.94   (b NEVER matters for Var/sd)

# Var(aX + bY) = a^2 Var(X) + b^2 Var(Y) + 2ab Cov(X,Y);  also Cov(cX + d, eY + f) = c*e*Cov(X,Y);  Cor
# ("Var(X) = 8, Var(Y) = 8, Cov = -5.7. Find Var(3X - 2Y).")
VarX <- 8; VarY <- 8; CovXY <- -5.7    # INPUT
a <- 3; b <- -2                        # INPUT (X - Y -> a <- 1; b <- -1)
c(Var_aXbY = a^2 * VarX + b^2 * VarY + 2 * a * b * CovXY,
  Cov_aX_bY = a * b * CovXY, Cor = CovXY / sqrt(VarX * VarY))
# check: Var_aXbY 172.4

# JOINT PROBABILITY TABLE: E, Var, sd, Cov, Cor, population slope
X <- c(1, 5, 7, 8)                     # INPUT x column
Y <- c(3, 9, 2, 2)                     # INPUT y column
p <- c(0.1, 0.4, 0.3, 0.2)             # INPUT probability column
EX <- sum(X * p); EY <- sum(Y * p)
VarX <- sum(X^2 * p) - EX^2; VarY <- sum(Y^2 * p) - EY^2
CovXY <- sum(X * Y * p) - EX * EY
c(EX = EX, EY = EY, VarX = VarX, VarY = VarY, sdX = sqrt(VarX), sdY = sqrt(VarY),
  EXY = sum(X * Y * p), CovXY = CovXY, CorXY = CovXY / sqrt(VarX * VarY), slope_B1 = CovXY / VarX)
# check: CorXY -0.41   (do NOT use cor() here - it ignores the probabilities)

# SAMPLE STATS of a list of numbers: mean, sd, var, SST
# ("A vector of 16 numbers has first element 44, and each of the remaining elements equals 10" -> x <- c(44, rep(10, 15)))
x <- c(44, rep(10, 15))                # INPUT
c(n = length(x), sum = sum(x), mean = mean(x), var = var(x), sd = sd(x), SST = sum((x - mean(x))^2))
# check: mean 12.13

# SST / SSE / SSR / R^2 SOLVER - type numbers for the TWO you are given, NA for the rest
# (also: n and the sample variance of y -> SST = (n - 1) * Sy^2)
SST <- NA; SSE <- 75; SSR <- NA; R2 <- 0.33      # INPUT any two (R2 as a decimal: 33% -> 0.33)
n <- NA; Sy2 <- NA                               # INPUT only if given n and the sample variance of y (n = 40, Sy^2 = 21)
if (!is.na(n) && !is.na(Sy2)) SST <- (n - 1) * Sy2
if (is.na(SST)) { if (!is.na(SSE) && !is.na(SSR)) SST <- SSE + SSR else
                  if (!is.na(SSE) && !is.na(R2))  SST <- SSE / R2 else
                  if (!is.na(SSR) && !is.na(R2))  SST <- SSR / (1 - R2) }
if (is.na(SSE)) SSE <- if (!is.na(R2)) R2 * SST else SST - SSR
SSR <- SST - SSE; R2 <- SSE / SST
c(SST = SST, SSE_explained = SSE, SSR_residual = SSR, R2 = R2, R2_percent = 100 * R2, unexplained = SSR / SST)
# check: SSR 152.27   (n = 40, Sy2 = 21 -> SST 819)

# SLR ALL-IN-ONE from a small sample x, y: slope, intercept, prediction, every residual, SSR, SST, R^2, sigma-hat, se
# ("For the sample x = ..., y = ..., find the OLS slope / residual of the 3rd observation / sum of x_i * uhat_i ...")
x  <- c(1, 2, 3, 4, 9)                 # INPUT
y  <- c(9, 7, 8, 10, 4)                # INPUT
i  <- 3                                # INPUT which observation's residual / fitted value
x0 <- 5                                # INPUT x to predict at
B1 <- cov(x, y) / var(x); B0 <- mean(y) - B1 * mean(x)
yhat <- B0 + B1 * x; uhat <- y - yhat; n <- length(x)
SSR <- sum(uhat^2); SST <- sum((y - mean(y))^2); SSTx <- sum((x - mean(x))^2)
c(slope_B1 = B1, intercept_B0 = B0, pred_at_x0 = B0 + B1 * x0, fitted_i = yhat[i], resid_i = uhat[i],
  SSR = SSR, SSE = SST - SSR, SST = SST, R2 = 1 - SSR / SST, sum_x_uhat = round(sum(x * uhat), 8),
  SST_x = SSTx, sigma_hat = sqrt(SSR / (n - 2)), se_B1 = sqrt(SSR / (n - 2)) / sqrt(SSTx))
uhat                                   # all residuals in order
# check: resid_i -0.04   (x = (1,2,4,9,10), y = (1,1,10,5,9) -> slope 0.64)   sum_x_uhat is ALWAYS 0 (e-15 = 0)

# OLS PROPERTIES - point of means and the missing residual
# ("intercept 1, slope 1.7, mean of x is 5 -> mean of y?")  /  ("residuals 2.2, -1.7, 1.1, 1.3 and one more -> fifth?")
b0 <- 1; B <- c(1.7)                   # INPUT intercept, slopes (MLR: B <- c(b1, b2, ...))
xbar <- c(5)                           # INPUT means of the x's in the same order
c(ybar = b0 + sum(B * xbar))           # check: 9.5
resids <- c(2.2, -1.7, 1.1, 1.3)       # INPUT the residuals you know
c(missing_residual = -sum(resids))     # check: -2.9   (residuals always sum to 0)


##########################################################################
##  SECTION 1  UNITS AND LOGS
##########################################################################

# RESCALING - level-level (y on x). Y times cy and/or X times cx. (divide by 10 -> c = 1/10)
# ("slope is 0.34; every value of x is divided by 10 -> new slope?")
b0 <- 2; b1 <- 0.34                    # INPUT original
cy <- 1                                # INPUT what Y is multiplied by (thousands -> dollars: 1000; dollars -> thousands: 1/1000)
cx <- 1/10                             # INPUT what X is multiplied by (percent -> decimal: 1/100)
c(new_b0 = b0 * cy, new_b1 = b1 * cy / cx)
# check: new_b1 3.4      R^2 never changes

# RESCALING with LOGS - slope on a logged variable NEVER changes, only the intercept
b0 <- 3.55; b1 <- 0.25                 # INPUT original
cy <- 1000                             # INPUT Y multiplied by (only matters if Y is logged)
cx <- 1                                # INPUT X multiplied by (only matters if X is logged)
c(logy_on_x__new_b0 = b0 + log(cy),                   # log-level: slope same
  logy_on_logx__new_b0 = b0 + log(cy) - b1 * log(cx), # log-log: slope same
  y_on_logx__new_b0 = b0 * cy - b1 * cy * log(cx),    # level-log: intercept and slope both x cy if Y rescaled
  y_on_logx__new_b1 = b1 * cy)
# check: logy_on_x__new_b0 10.46   (log(1000) = 6.91)

# LOG-LEVEL (works for SLR or MLR): % change in y = 100 * (b1*dx1 + b2*dx2 + ...)
# ("log(y) = 1.8 - 0.051 x1 + 0.035 x2. x1 rises by 3 and x2 rises by 2 -> % change?")
B  <- c(-0.051, 0.035)                 # INPUT slopes WITH their signs
dX <- c(3, 2)                          # INPUT changes (a FALL is negative)
c(pct_change_y = 100 * sum(B * dX), exact_pct = 100 * (exp(sum(B * dX)) - 1))
# check: -8.3   (use pct_change_y; the "exact" one is only if he asks for the exact %)
# tenure measured in MONTHS, one more YEAR: dX <- 12  (slope 0.0032 -> 3.84)

# LOG-LOG: % change in y = b1 * (% change in x)       (b1 = elasticity)
b1 <- 0.97; pct_x <- -19               # INPUT (a FALL of 19% -> -19)
c(pct_change_y = b1 * pct_x)           # check: -18.43

# LEVEL-LOG: change in y (UNITS) = (b1 / 100) * (% change in x)
b1 <- 34.1; pct_x <- 18                # INPUT
c(unit_change_y = b1 / 100 * pct_x)    # check: 6.14

# PREDICT y FROM A LOG MODEL: yhat = exp(predicted log(y))
# (logged x's: put log(value) in xs, e.g. sales of 5000 -> log(5000))
b0 <- 0.284; B <- c(0.092, 0.0041, 0.022)   # INPUT intercept and slopes
xs <- c(12, 10, 3)                           # INPUT the x values (same order)
c(pred_log_y = b0 + sum(B * xs), pred_y = exp(b0 + sum(B * xs)))
# check: pred_y about 4.46 (real data: use Section 5 so nothing is rounded)


##########################################################################
##  SECTION 2  VARIANCE OF OLS + STANDARD ERRORS (given numbers)
##  EXAM: ~5 questions follow PS12 #2, 4, 6, 9, 12  (this section = #4, #6; Section 5 = #9, #12)
##########################################################################

# STANDARD ERROR MASTER BLOCK  (SLR or MLR)  - fill what you are GIVEN, NA for the rest
#   gives: df, sigma-hat^2, sigma-hat, SST_j, Var(bjhat), sd / se(bjhat)
#   sigma side: give SSR (with n, K)  OR  sigma-hat  OR  sigma-hat^2  OR  the TRUE sigma / sigma^2
#   SST side:   give SST_j  OR  n and Sx (sd)  OR  n and Sx2 (variance)  OR  the x values
#   SLR -> K <- 1 and R2j <- 0
n     <- NA                           # INPUT number of observations (needed for SSR or Sx routes)
K     <- NA                           # INPUT number of x's (NOT the intercept). SLR = 1
SSR   <- NA                           # INPUT or NA
sig   <- 6.2                          # INPUT sigma-hat (or the true sigma) or NA
sig2  <- NA                           # INPUT sigma-hat^2 (or true sigma^2) or NA
SSTj  <- 360                          # INPUT SST_j or NA
Sx    <- NA                           # INPUT sample SD of X_j or NA        (needs n)
Sx2   <- NA                           # INPUT sample VARIANCE of X_j or NA  (needs n)
xvals <- NA                           # INPUT the x values c(...) or NA
R2j   <- 0.66                         # INPUT R_j^2 (SLR: 0)
df <- n - K - 1
if (is.na(sig2)) sig2 <- if (!is.na(sig)) sig^2 else SSR / df
if (is.na(SSTj)) SSTj <- if (!is.na(Sx)) (n - 1) * Sx^2 else if (!is.na(Sx2)) (n - 1) * Sx2 else sum((xvals - mean(xvals))^2)
Var_bj <- sig2 / (SSTj * (1 - R2j))
c(df = df, sigma_hat2 = sig2, sigma_hat = sqrt(sig2), SSTj = SSTj, Var_bj = Var_bj, se_bj = sqrt(Var_bj))
# check: se_bj 0.56 (PS12 #6)
#   PS12 #4: n <- 48; K <- 3; SSR <- 1595; sig <- NA -> sigma_hat 6.02   (ignore se_bj if you only need sigma-hat)
#   PS12 #5: n <- 149; Sx <- 3.2; SSTj <- NA -> SSTj 1515.52
#   SLR from SSR: n <- 30; K <- 1; SSR <- 190; sig <- NA; Sx <- ...; R2j <- 0

# SAMPLE k TIMES AS LARGE / sigma CHANGES  (sd_new = sd_old * (sigma_new/sigma_old) / sqrt(k))
sd_old <- 0.45                        # INPUT current sd(b1hat) or se
k <- 3                                # INPUT sample k times as large (same size: 1)
sigma_ratio <- 1                      # INPUT sigma_new / sigma_old (sigma doubles: 2)
c(sd_new = sd_old * sigma_ratio / sqrt(k), Var_new = (sd_old * sigma_ratio / sqrt(k))^2)
# check: 0.26


##########################################################################
##  SECTION 3  MULTIPLE REGRESSION (given numbers)
##########################################################################

# PREDICT and PREDICTED CHANGE (level-level)  (for log-level use Section 1)
# ("yhat = 4 + 2.1 x1 - 0.7 x2. Predicted y at x1 = 10, x2 = 5?"  /  "x1 rises by 4 and x2 rises by 2?")
b0 <- 4; B <- c(2.1, -0.7)            # INPUT intercept, slopes WITH signs
xs <- c(10, 5)                        # INPUT x values for the prediction
dX <- c(4, 2)                         # INPUT changes (a fall is negative, unchanged = 0)
c(prediction = b0 + sum(B * xs), change = sum(B * dX))
# check: prediction 21.5, change 7   (intercept never matters for a change)

# POINT OF MEANS: ybar = b0 + b1*x1bar + b2*x2bar   (solve for ybar, or for b0 if ybar given)
b0 <- 2; B <- c(0.5, -1.2)            # INPUT
xbar <- c(12, 3.1)                    # INPUT
ybar_given <- NA                      # INPUT only if solving for b0
c(ybar = b0 + sum(B * xbar), b0_if_ybar_given = ybar_given - sum(B * xbar))
# check: ybar 4.28


##########################################################################
##  SECTION 4  OMITTED-VARIABLE BIAS   3.23:  btilde1 = bhat1 + bhat2 * dtilde1
##  btilde1 = SIMPLE regression slope (X2 left out)   bhat1, bhat2 = MULTIPLE regression slopes
##  dtilde1 = slope from regressing the OMITTED X2 on the included X1
##########################################################################

# 3.23 SOLVER - give any THREE, NA for the one you want
bt1 <- 1.31                           # INPUT simple-regression slope (btilde1) or NA
bh1 <- NA                             # INPUT multiple-regression slope on X1 (bhat1) or NA
bh2 <- -0.35                          # INPUT multiple-regression slope on X2 (bhat2) or NA
dt1 <- 0.81                           # INPUT slope of X2 on X1 (dtilde1) or NA
if (is.na(bt1)) bt1 <- bh1 + bh2 * dt1
if (is.na(bh1)) bh1 <- bt1 - bh2 * dt1
if (is.na(bh2)) bh2 <- (bt1 - bh1) / dt1
if (is.na(dt1)) dt1 <- (bt1 - bh1) / bh2
c(btilde1_simple = bt1, bhat1_multiple = bh1, bhat2 = bh2, dtilde1 = dt1, bias_term = bh2 * dt1)
if (bh2 * dt1 > 0) "simple slope is ABOVE the multiple one: biased UPWARD" else "simple slope is BELOW: biased DOWNWARD (more negative)"
# check: bhat1_multiple 1.59

# BIAS FROM THE POPULATION: Bias = beta2 * delta1  (negative = downward)
beta2 <- -0.9; delta1 <- 1.25         # INPUT
c(bias = beta2 * delta1)              # check: -1.13 (rounded)

# DIRECTION ONLY (word problem): sign of each leg, +1 or -1
leg1 <- +1                            # INPUT does the omitted var RAISE Y (+1) or LOWER Y (-1)?
leg2 <- -1                            # INPUT is it POSITIVELY (+1) or NEGATIVELY (-1) correlated with the included X?
if (leg1 * leg2 > 0) "UPWARD bias (overstates)" else "DOWNWARD bias (understates / more negative)"


##########################################################################
##  SECTION 5  REAL DATA IN R
##  every block loads what it needs.  Coefficients by NAME: b["educ"], never b[2].
##########################################################################

# OPTIONAL QUICK LOOK - run once, then look(reg) prints everything about any regression
look <- function(reg) {
  s <- summary(reg); d <- model.frame(reg); y <- d[[1]]
  SSR <- sum(resid(reg)^2); SST <- sum((y - mean(y))^2)
  print(round(s$coefficients[, 1:2], 4))       # Estimate and Std. Error for every coefficient, by name
  c(n = nrow(d), K = length(coef(reg)) - 1, df = reg$df.residual, R2 = s$r.squared, R2_pct = 100 * s$r.squared,
    SSR = SSR, SSE = SST - SSR, SST = SST, sigma_hat = s$sigma)
}

# DATASET BASICS: n, mean, sd, var, correlation, mean within a group
library(wooldridge)
nrow(ceosal1)                                  # how many observations   check: 209
mean(ceosal1$roe); sd(ceosal1$roe); var(ceosal1$roe)
cor(ceosal1$salary, ceosal1$roe)               # check: 0.11
mean(wage1$wage[wage1$female == 1])            # mean WITHIN a group (women)
mean(wage1$wage[wage1$female == 0])            # (men)
mean(wage1$wage[wage1$educ == 12])             # E[wage | educ = 12]
sum((wage1$educ - mean(wage1$educ))^2)         # SST of a variable    check: 4025.43

# REGRESSION (level-level, SLR or MLR): coefficients, prediction, change, R^2, SSR, residual of row i
library(wooldridge)
reg <- lm(wage ~ educ + exper + tenure, data = wage1)            # INPUT y ~ x1 + x2 + ...
b <- coef(reg); b
new <- data.frame(educ = 16, exper = 5, tenure = 2)              # INPUT x values for a prediction
d_exper <- 10                                                    # INPUT change in one variable
i <- 2                                                           # INPUT row number
c(prediction = predict(reg, new),
  change = b["exper"] * d_exper,                                 # <- EDIT the NAME to the variable that changes
  R2 = summary(reg)$r.squared, R2_pct = 100 * summary(reg)$r.squared,
  SSR = sum(resid(reg)^2), resid_row_i = resid(reg)[i], fitted_row_i = fitted(reg)[i],
  sigma_hat = summary(reg)$sigma)
# check: prediction 7.16, change 0.22 (exper!)    two changes at once: b["educ"]*1 + b["tenure"]*2
#   wage ~ tenure: slope 0.18, predict(tenure = 10) 6.76, R2_pct 12.03, resid row 2 -2.11
#   SSE (explained) = SST - SSR:  SST <- sum((wage1$wage - mean(wage1$wage))^2)

# LOG-LEVEL REAL DATA: % change and predicted y in DOLLARS (exp)
library(wooldridge)
reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1)       # INPUT
b <- coef(reg); b
new <- data.frame(educ = 16, exper = 5, tenure = 1)              # INPUT
c(pct_change = 100 * (b["educ"] * 1 + b["tenure"] * 2),          # <- EDIT names and changes
  pred_log_y = predict(reg, new), pred_y = exp(predict(reg, new)))
# check: pct_change 13.62, pred_y 6.05
#   ceosal1 log(salary) ~ roe, roe +4: 100 * b["roe"] * 4 -> 5.55

# LOG-LOG / LEVEL-LOG REAL DATA  (logged x keeps its name "log(sales)" -> b["log(sales)"])
library(wooldridge)
reg <- lm(log(salary) ~ log(sales) + roe, data = ceosal1)        # INPUT
b <- coef(reg); b
new <- data.frame(sales = 5000, roe = 15)                        # INPUT raw values (predict() logs them for you)
c(pct_from_10pct_sales = b["log(sales)"] * 10,                   # log-log: elasticity * % change
  pct_from_roe_plus10 = 100 * b["roe"] * 10,                     # log-level part
  pred_salary = exp(predict(reg, new)))
# check: pct_from_roe_plus10 17.87, pred_salary 1067.66
#   level-log: reg <- lm(salary ~ log(sales), data = ceosal1); b["log(sales)"] / 100 * 10 -> 26.29
#   log-log:   reg <- lm(log(bwght) ~ log(faminc), data = bwght); b["log(faminc)"] * 15 -> 0.31

# UNITS IN DATA: rescale a variable and rerun
library(wooldridge)
reg  <- lm(salary ~ sales, data = ceosal1)                        # INPUT
reg2 <- lm(I(salary * 1000) ~ sales, data = ceosal1)              # INPUT (y in dollars; x in decimal: I(roe / 100))
rbind(original = coef(reg), rescaled = coef(reg2))
# check: rescaled slope 15.47

# OMITTED-VARIABLE BIAS IN DATA: simple, multiple, delta, check 3.23
library(wooldridge)
simple   <- lm(price ~ bdrms, data = hprice1)                     # INPUT y ~ X1
multiple <- lm(price ~ bdrms + sqrft, data = hprice1)             # INPUT y ~ X1 + X2
aux      <- lm(sqrft ~ bdrms, data = hprice1)                     # INPUT X2 ~ X1  (omitted on included)
c(btilde1_simple = coef(simple)["bdrms"], bhat1_multiple = coef(multiple)["bdrms"],
  bhat2 = coef(multiple)["sqrft"], dtilde1 = coef(aux)["bdrms"],
  bhat2_x_dtilde1 = coef(multiple)["sqrft"] * coef(aux)["bdrms"],
  simple_minus_multiple = coef(simple)["bdrms"] - coef(multiple)["bdrms"])
# check: bhat2_x_dtilde1 46.83 (= simple_minus_multiple)
#   wage1: lm(wage ~ educ), lm(wage ~ educ + exper), lm(exper ~ educ) -> -0.10
#   bwght: lm(bwght ~ cigs), lm(bwght ~ cigs + faminc), lm(faminc ~ cigs) -> -0.05

# STANDARD ERROR BY HAND (PS12 #8-12) - df, sigma-hat, SST_j, R_j^2, se, checked against summary
library(wooldridge)
reg <- lm(price ~ sqrft + bdrms + lotsize, data = hprice1)        # INPUT the full regression
xj  <- "bdrms"                                                    # INPUT the variable you want the se of (in quotes)
d <- model.frame(reg)                                             # only the rows the regression used
n <- nrow(d); K <- length(coef(reg)) - 1; df <- n - K - 1
SSR <- sum(resid(reg)^2); sig <- sqrt(SSR / df)
SSTj <- sum((d[[xj]] - mean(d[[xj]]))^2)
others <- setdiff(names(d)[-1], xj)
R2j <- if (length(others) == 0) 0 else summary(lm(reformulate(paste0("`", others, "`"), paste0("`", xj, "`")), data = d))$r.squared
se_hand <- sig / sqrt(SSTj * (1 - R2j))
c(n = n, K = K, df = df, SSR = SSR, sigma_hat = sig, SSTj = SSTj, R2j = R2j, Var_bj = se_hand^2,
  se_by_hand = se_hand, se_summary = summary(reg)$coefficients[xj, "Std. Error"])
# check: df 84, sigma_hat 59.83, SSTj 61.59, R2j 0.28, se 9.01
#   R_j^2 regression it used = xj on the OTHER x's (e.g. lm(bdrms ~ sqrft + lotsize)); Y not involved
#   SLR works too: reg <- lm(salary ~ roe, data = ceosal1); xj <- "roe" -> se 11.12
#   wage ~ educ: sigma_hat 3.38

# PERFECT COLLINEARITY (MLR3) - R reports NA for the dropped variable
library(wooldridge)
v <- vote1; v$totexpend <- v$expendA + v$expendB
coef(lm(voteA ~ expendA + expendB + totexpend, data = v))         # totexpend = NA

## END OF SCRIPT
