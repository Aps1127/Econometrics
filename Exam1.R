##########################################################################
##  ECONOMETRICS EXAM 1 - MASTER SCRIPT
##  Built from Quizzes 1-6 and Problem Sets 1-7 (quiz wording used when both had it)
##
##  HOW TO USE
##   1. Ctrl+F a few PLAIN WORDS from the exam question (not the math symbols),
##      e.g. "find the OLS slope", "explained sum of squares", "UNEXPLAINED".
##   2. PART 1 = word / multiple choice questions -> answer is written right under it.
##   3. PART 2 = computation -> change the numbers on the INPUT lines, highlight the
##      block, Ctrl+Enter. The answer prints (NOT rounded - round it yourself).
##      A few blocks print several answers (slope, intercept, prediction...) - each line is labeled.
##      Every block is self-contained: it never needs anything from another block.
##      "# check:" shows the answer (rounded) for the numbers currently in the block.
##   4. Fractions can be typed straight in: B1hat <- 7/10 works.
##
##  MATH WRITTEN IN PLAIN TEXT
##   B0, B1 = beta 0, beta 1        B0hat, B1hat = beta hats (OLS estimates)
##   xbar, ybar = sample means      yhat = fitted/predicted y    uhat = residual
##   Sx^2 = sample variance         Sx = sample sd   Sxy = sample covariance
##   E[X] = expected value          E[Y | X = x] = conditional expectation
##
##  QUICK FORMULA REFERENCE (the stuff that gets mixed up)
##   SLR MODEL:  Y = B0 + B1*X + U
##     Y  = dependent variable (left side, what we explain)      X = independent / explanatory variable
##     B0 = intercept (value of E[Y|X] when X = 0)               B1 = slope (ceteris paribus change in Y per +1 X)
##     U  = error: everything OTHER than X that affects Y        E[U | X] = 0  ->  E[Y | X = x] = B0 + B1*x
##     B0, B1 = POPULATION (unknown)   B0hat, B1hat = ESTIMATES from the sample
##   OLS:   B1hat = cov(x, y) / var(x) = sum((x-xbar)(y-ybar)) / sum((x-xbar)^2)
##          B0hat = ybar - B1hat * xbar          (xbar, ybar) is always ON the line
##   FITTED / RESIDUAL:  yhat = B0hat + B1hat*x     uhat = y - yhat (actual - fitted)
##          uhat > 0 = UNDER-predicted     uhat < 0 = OVER-predicted     sum(uhat) = 0 always
##   CHANGES:  delta yhat = B1hat * delta x   (intercept never matters for a change)
##          multiple:  delta y = B1*dX1 + B2*dX2 + ...   B1 = effect of X1 holding X2 fixed
##   SUMS OF SQUARES:  SST = sum((y - ybar)^2)   SSE = EXPLAINED   SSR = sum(uhat^2) = RESIDUAL
##          SST = SSE + SSR     R^2 = SSE/SST = 1 - SSR/SST     unexplained fraction = SSR/SST = 1 - R^2
##   SAMPLE (data, divide by n-1):  Sx^2 = var(x)   Sx = sd(x)   Sxy = cov(x,y)   rho = cor(x,y) = Sxy/(Sx*Sy)
##   POPULATION (probabilities):    E[X] = sum(x*p)   E[X^2] = sum(x^2*p)   Var(X) = E[X^2] - (E[X])^2
##          Cov(X,Y) = E[XY] - E[X]E[Y]     Cor(X,Y) = Cov(X,Y) / (sd(X) sd(Y))   always between -1 and 1
##   RULES:  E[c] = c     E[aX + bY + c] = aE[X] + bE[Y] + c     Var(aX + b) = a^2 Var(X)
##          Var(aX + bY) = a^2 Var(X) + b^2 Var(Y) + 2ab Cov(X,Y)      independent -> Cov = 0
##          Cov(a1 X + b1, a2 Y + b2) = a1 a2 Cov(X,Y)     E[aY + b | X = x] = a E[Y|X=x] + b
##   PERCENTS:  percent change = 100*(new - old)/old     percentage POINTS = new - old   (4% -> 6% = 2 pts = 50%)
##   LOG MODELS (Table 2.3):
##          level-level  y on x         : +1 x  ->  y changes by B1 units
##          log-level    log(y) on x    : +1 x  ->  y changes by 100*B1 PERCENT
##          level-log    y on log(x)    : +1% x ->  y changes by B1/100 units
##          log-log      log(y) on log(x): +1% x ->  y changes by B1 PERCENT  (B1 = ELASTICITY)
##   UNITS:  Y multiplied by c -> B0hat AND B1hat both multiplied by c
##          X multiplied by c -> B1hat divided by c, B0hat unchanged        R^2 never changes
##   DATA TYPES: cross-section = many units, one time | time series = one unit, many times | panel = many units, many times
##
##  !! THIS CLASS'S NAMING (Wooldridge):  SSE = EXPLAINED   SSR = RESIDUAL !!
##     SST = SSE + SSR      R^2 = SSE/SST = 1 - SSR/SST
##
##  SECTIONS (Ctrl+F the section name)
##   PART 1  WORD QUESTIONS
##   PART 2  COMPUTATION
##     SECTION A  SUMS AND MEANS
##     SECTION B  PERCENT CHANGE AND PERCENTAGE POINTS
##     SECTION C  LINEAR EQUATIONS (predict y, change in y, slope)
##     SECTION D  SAMPLE VARIANCE / SD / COVARIANCE / CORRELATION
##     SECTION E  EXPECTED VALUE OF A RANDOM VARIABLE (coins, probabilities)
##     SECTION F  RULES FOR E, Var, Cov, Cor
##     SECTION G  JOINT PROBABILITY TABLE
##     SECTION H  CONDITIONAL EXPECTATION
##     SECTION I  OLS SLOPE / INTERCEPT / PREDICTION
##     SECTION J  FITTED VALUES, RESIDUALS, SSR, SSE, SST, R^2
##     SECTION K  REAL DATA IN R (wage1, bwght)
##     SECTION L  LOGS AND UNITS OF MEASUREMENT
##   PART 3  IN-CLASS DAY SCRIPTS (Day 2 - Day 13, solved)
##########################################################################


##########################################################################
##########################################################################
##  PART 1  WORD QUESTIONS  (exact wording -> correct answer)
##########################################################################
##########################################################################

## ---- Intro / data / causation ----

# Econometrics combines data, economics, and which of the following?
#   ANSWER: Statistics

# In economics, "ceteris paribus" means:
#   ANSWER: Holding all other factors fixed

# Ice-cream sales and drownings both rise in the summer, so they are positively correlated. What is the best explanation?
#   ANSWER: A confounding variable (summer) drives both

# True or False: a strong correlation between education and wages proves that more education causes higher wages.
#   ANSWER: False

# Which statement is correct?
#   ANSWER: Correlation means two variables move together; causation means changing one changes the other.

# What type of data is this: wages and years of education for 526 workers, all measured in 1976?
#   ANSWER: Cross-section

# What type of data is this: the U.S. unemployment rate recorded each year from 2000 to 2024?
#   ANSWER: Time series

# What type of data is this: GDP for all 50 states, recorded every year from 2015 to 2020?
#   ANSWER: Panel
#   (rule: many units at ONE time = cross-section; ONE unit over time = time series; many units over time = panel)

# True or False: we use the sample we have in order to learn about the larger population we care about.
#   ANSWER: True

# The whole group we care about, but usually cannot fully observe, is called the ______. (one word)
#   ANSWER: population

# The part of that group we actually collect data on is called the ______. (one word)
#   ANSWER: sample

# Complete the course's rule for using AI: "AI writes, you ______." (one word)
#   ANSWER: verify

## ---- R commands ----

# Which R command gives a quick snapshot (minimum, mean, maximum, and so on) of every variable in a dataset?
#   ANSWER: summary()

# True or False: in R, mean(x) gives the same result as sum(x)/length(x).
#   ANSWER: True

# In the R expression wage1$wage, what does the $ do?
#   ANSWER: Pulls the variable "wage" out of the dataset "wage1"

# Which of the following compute the mean of a numeric vector x in R? (Select all that apply.)
#   ANSWER: mean(x)  AND  sum(x) / length(x)

# In R, which set of commands describes a variable's center, spread, and shape (in that order)?
#   ANSWER: mean(), sd(), hist()

# Which R command computes the SAMPLE variance of a numeric vector x?
#   ANSWER: var(x)

# Which R command computes the correlation between numeric vectors x and y?
#   ANSWER: cor(x, y)

# True or False: in R, sd(x) gives the SAMPLE standard deviation (dividing by n - 1).
#   ANSWER: True

## ---- Coefficients / percent change ----

# For y = B0 + B1*X1 + B2*X2, the coefficient B1 is:
#   ANSWER: The effect of X1 on y, holding X2 fixed

# An interest rate rises from 4% to 6%. Which statement is correct?
#   ANSWER: A 2 percentage-point increase, which is also a 50% increase

# True or False: in y = B0 + B1*x, the intercept B0 affects the change (delta y) when x changes.
#   ANSWER: False

## ---- Variance / covariance / correlation ----

# The sample variance divides the sum of squared deviations from the mean by:
# (also: When we compute the SAMPLE variance, we divide the sum of squared deviations from the mean by:)
#   ANSWER: n - 1

# If two variables tend to rise and fall together, their sample covariance Sxy is:
#   ANSWER: Positive

# The correlation between two variables is always:
#   ANSWER: Between -1 and 1

# The correlation Cor(X, Y) always lies:
#   ANSWER: Between -1 and 1

# Compared with the covariance, the correlation is:
#   ANSWER: Unitless and always between -1 and 1

## ---- Expected value / random variables ----

# For a discrete random variable X, the expected value E[X] equals:
#   ANSWER: The sum of each value times its probability

# For a discrete random variable X, E[X^2] equals:
#   ANSWER: The sum of each SQUARED value times its probability

# The variance of a random variable X equals:
#   ANSWER: E[X^2] - (E[X])^2

# For any constant c, the expected value E[c] equals:
#   ANSWER: c

# If X and Y are independent, then Cov(X, Y) equals:
#   ANSWER: 0

# If X and Y are independent, then Var(X + Y) equals:
#   ANSWER: Var(X) + Var(Y)

# E[Y | X = x] is best described as:
#   ANSWER: The average of Y among observations with X = x

## ---- Simple linear regression model ----

# In the simple linear regression model Y = B0 + B1*X + U, the DEPENDENT variable is:
#   ANSWER: Y

# In Y = B0 + B1*X + U, the error term U represents:
#   ANSWER: Factors OTHER than X that affect Y

# In Y = B0 + B1*X + U, the slope B1 measures:
#   ANSWER: The ceteris paribus effect of X on Y (the change in Y per one-unit rise in X, holding other factors fixed)

# The zero conditional mean assumption E[U | X] = 0 says:
#   ANSWER: The average of U does not depend on X

# Under the SLR model with E[U | X] = 0, the conditional mean E[Y | X = x] equals:
#   ANSWER: B0 + B1*x

# The OLS slope estimate B1hat can be written as:
#   ANSWER: cov(x, y) / var(x)

# We must ESTIMATE B0, B1 (rather than compute them exactly) because:
#   ANSWER: They are population quantities; we observe only a sample

# In Y = (B0 + B1*X) + U, the term B0 + B1*X is:
#   ANSWER: The part of Y EXPLAINED by X (its conditional mean)

## ---- Fitted values / residuals / R^2 ----

# In OLS, the fitted value Yhat_i = B0hat + B1hat*X_i is:
#   ANSWER: The model's PREDICTION of Y at X_i

# The OLS residual Uhat_i equals:
#   ANSWER: Y_i - Yhat_i (actual minus fitted)

# A NEGATIVE residual (Uhat_i < 0) means OLS:
#   ANSWER: Over-predicted Y_i

# A POSITIVE residual (Uhat_i > 0) means OLS:
#   ANSWER: Under-predicted Y_i (actual > fitted)

# The total sum of squares decomposes as SST =
#   ANSWER: SSE + SSR

# The sum of the OLS residuals (sum of Uhat_i) is always:
#   ANSWER: 0

# R^2 is:
#   ANSWER: The fraction of the sample variation in Y explained by X

# An R^2 close to 0 means:
#   ANSWER: The OLS line explains little of the variation in Y --- common, and not necessarily a bad model

# The point (Xbar, Ybar):
#   ANSWER: Always lies on the OLS regression line


##########################################################################
##########################################################################
##  PART 2  COMPUTATION  (change INPUT numbers, run block, read last line)
##########################################################################
##########################################################################


##########################################################################
##  SECTION A  SUMS AND MEANS
##########################################################################

# The three numbers 6, 1, and 9 add up to what total?
# (also: Find the sum of x_i (i = 1 to 3) for x = (7, 9, 6).)
x <- c(6, 1, 9)                       # INPUT
sum(x)                                # check: 16

# What is the mean (average) of these four numbers: 4, 8, 6, and 2?
# (also: The sample mean is xbar = (1/n) sum x_i. Find xbar for x = (11, 3, 10).)
x <- c(4, 8, 6, 2)                    # INPUT
mean(x)                     # check: 5

# A set of 6 numbers adds up to 150. What is their mean (average)?
# (also: A set of 35 numbers sums to 83. Using xbar = (1/n) sum x_i, find the mean.)
total <- 150; n <- 6                  # INPUT
total / n                   # check: 25


##########################################################################
##  SECTION B  PERCENT CHANGE AND PERCENTAGE POINTS
##########################################################################

# Percent change is %delta x = 100 * (x_new - x_old) / x_old. Find it when x goes from 42 to 79. (round to the hundredths)
x_old <- 42; x_new <- 79              # INPUT
100 * (x_new - x_old) / x_old   # check: 88.1

# A rate goes from 3% to 10%. What is the change in percentage POINTS?
old <- 3; new <- 10                   # INPUT (just the % numbers)
new - old                             # check: 7


##########################################################################
##  SECTION C  LINEAR EQUATIONS (predict y, change in y, slope)
##########################################################################

# For y = B0 + B1*x with B0 = 9 and B1 = 4, predict y at x = 6.
B0 <- 9; B1 <- 4; x <- 6              # INPUT
B0 + B1 * x                           # check: 33

# For y = B0 + B1*x, a change gives delta y = B1 * delta x. With B0 = 3, B1 = 6, and delta x = 4, find delta y.
# (B0 does NOT matter for the change)
B1 <- 6; dx <- 4                      # INPUT
B1 * dx                               # check: 24

# For y = B0 + B1*X1 + B2*X2, delta y = B1*delta X1 + B2*delta X2.
# With B0 = 16, B1 = 2, B2 = 7, delta X1 = 1, delta X2 = -1, find delta y.
B1 <- 2; B2 <- 7; dX1 <- 1; dX2 <- -1 # INPUT
B1 * dX1 + B2 * dX2                   # check: -5

# For y = B0 + B1*X1 + B2*X2 + B3*X3, delta y = B1*delta X1 + B2*delta X2 + B3*delta X3.
# With B1 = 8, B2 = 1, B3 = 7, delta X1 = -1, delta X2 = -1, delta X3 = 2, find delta y.
B <- c(8, 1, 7)                       # INPUT B1, B2, B3
dX <- c(-1, -1, 2)                    # INPUT delta X1, delta X2, delta X3
sum(B * dX)                           # check: 5

# On a line, when x increases by 2, y increases by 33. Find the slope B1 = delta y / delta x. (round to the hundredths)
dx <- 2; dy <- 33                     # INPUT
dy / dx                     # check: 16.5


##########################################################################
##  SECTION D  SAMPLE VARIANCE / SD / COVARIANCE / CORRELATION
##  (R's var, sd, cov, cor already divide by n - 1 = SAMPLE versions)
##########################################################################

# Sample variance is Sx^2 = (1/(n-1)) sum (x_i - xbar)^2. Compute it for x = (0, 5, 7). (round to the hundredths)
# (also: Find the sample variance of x = (4, 0, 8).)
x <- c(0, 5, 7)                       # INPUT
var(x)                      # check: 13

# Sample sd is Sx = sqrt(Sx^2). Compute it for x = (9, 5, 5). (round to the hundredths)
# (also: Find the sample standard deviation of x = (5, 5, 3).)
x <- c(9, 5, 5)                       # INPUT
sd(x)                       # check: 2.31

# Sample covariance is Sxy = (1/(n-1)) sum (x_i - xbar)(y_i - ybar). Compute it for x = (2, 4, 6) and y = (5, 6, 3). (round to the hundredths)
# (also: Find the sample covariance of x = (2, 6, 1) and y = (6, 6, 0).)
# (also: Review (sample). ... find the SAMPLE covariance Sxy)
x <- c(2, 4, 6)                       # INPUT
y <- c(5, 6, 3)                       # INPUT
cov(x, y)                   # check: -2

# Find the sample correlation between x = (4, 2, 5) and y = (7, 7, 4). (round to the hundredths)
# (also: Compute the sample correlation rho = Sxy / (Sx Sy) directly from the data x = (8, 3, 4), y = (2, 2, 4). (In R: cor(x, y).)
x <- c(4, 2, 5)                       # INPUT
y <- c(7, 7, 4)                       # INPUT
cor(x, y)                   # check: -0.76

# Sample correlation is rho = Sxy / (Sx Sy). With Sxy = 4, Sx = 3, Sy = 2, find rho. (round to the hundredths)
Sxy <- 4; Sx <- 3; Sy <- 2            # INPUT
Sxy / (Sx * Sy)             # check: 0.67


##########################################################################
##  SECTION E  EXPECTED VALUE OF A RANDOM VARIABLE (coins, probabilities)
##  E[X] = sum(value * prob)     E[X^2] = sum(value^2 * prob)
##########################################################################

# A fair coin gives value 10 on heads and 9 on tails (each with probability 1/2). Find E[X]. (round to the hundredths)
# (also: A random variable X takes the values 3, 0, 0, each with probability 1/3. Find E[X].)
#   -> for the 1/3 version: vals <- c(3, 0, 0); p <- c(1/3, 1/3, 1/3)
vals <- c(10, 9)                      # INPUT values
p    <- c(1/2, 1/2)                   # INPUT probabilities
sum(vals * p)               # check: 9.5

# A fair coin gives value 0 (heads) and 2 (tails), each with probability 1/2. Find E[X^2]. (round to the hundredths)
# (also: For X taking values 7, 1, 3, each with probability 1/3, find E[X^2].)
vals <- c(0, 2)                       # INPUT
p    <- c(1/2, 1/2)                   # INPUT
sum(vals^2 * p)             # check: 2

# X equals 3 with probability 2/10 and 9 with probability (10-2)/10. Find E[X]. (round to the hundredths)
vals <- c(3, 9)                       # INPUT
p    <- c(2/10, (10-2)/10)            # INPUT
sum(vals * p)               # check: 7.8

# For the same X -- value 8 with probability 9/10, value 4 with probability (10-9)/10 -- find E[X^2]. (round to the hundredths)
vals <- c(8, 4)                       # INPUT
p    <- c(9/10, (10-9)/10)            # INPUT
sum(vals^2 * p)             # check: 59.2

# X takes values 6, 5, 6 with probabilities 0.2, 0.5, 0.3. Find E[X^2]. (round to the hundredths)
# (also: A random variable X takes values 7, 3, 8 with probabilities 0.2, 0.5, 0.3. Find E[X].  -> use the E[X] line)
vals <- c(6, 5, 6)                    # INPUT
p    <- c(0.2, 0.5, 0.3)              # INPUT
sum(vals * p)               # E[X]   (= 5.5 here)
sum(vals^2 * p)             # E[X^2] check: 30.5
sum(vals^2 * p) - sum(vals * p)^2     # Var(X) = E[X^2] - (E[X])^2   (if asked)
sqrt(sum(vals^2 * p) - sum(vals * p)^2)   # sd(X)   (if asked)


##########################################################################
##  SECTION F  RULES FOR E, Var, Cov, Cor
##########################################################################

# Given E[X] = 8, E[Y] = 1, a = 5, and b = 3, find E[aX + bY]. (round to the hundredths)
# (also: Given E[X] = 6, E[Y] = 8, a = 4, and b = 2, find E[aX + bY] = a E[X] + b E[Y].)
EX <- 8; EY <- 1; a <- 5; b <- 3      # INPUT
a * EX + b * EY             # check: 43

# Expectation is linear: E[aX + b] = a E[X] + b. Given E[X] = 5, a = 4, and b = 1, find E[aX + b]. (round to the hundredths)
EX <- 5; a <- 4; b <- 1               # INPUT
a * EX + b                  # check: 21

# Given E[X] = 3, E[Y] = 8, find E[aX + bY - c] = a E[X] + b E[Y] - c with a = 2, b = 5, c = 5. (round to the hundredths)
EX <- 3; EY <- 8; a <- 2; b <- 5; c0 <- 5   # INPUT
a * EX + b * EY - c0        # check: 41

# Given E[X] = 6 and E[X^2] = 41, find Var(X). (round to the hundredths)
# Var(X) = E[X^2] - (E[X])^2
EX <- 6; EX2 <- 41                    # INPUT
EX2 - EX^2                  # check: 5

# Given Var(X) = 2 and a = 2, find Var(aX + b) (for any constant b). (round to the hundredths)
# Var(aX + b) = a^2 Var(X)   (b drops out)
VarX <- 2; a <- 2                     # INPUT
a^2 * VarX                  # check: 8

# The standard deviation is sd(X) = sqrt(Var(X)). Given Var(X) = 14, find sd(X). (round to the hundredths)
VarX <- 14                            # INPUT
sqrt(VarX)                  # check: 3.74

# If X and Y are independent, Var(X + Y) = Var(X) + Var(Y). Given Var(X) = 6 and Var(Y) = 6, find Var(X + Y). (round to the hundredths)
VarX <- 6; VarY <- 6                  # INPUT
VarX + VarY                 # check: 12

# Given E[XY] = 9, E[X] = 2, and E[Y] = 2, find Cov(X, Y). (round to the hundredths)
# Cov(X, Y) = E[XY] - E[X] E[Y]
EXY <- 9; EX <- 2; EY <- 2            # INPUT
EXY - EX * EY               # check: 5

# X and Y take the paired values (0, 2), (2, 1), (0, 3), each pair equally likely (probability 1/3). Find Cov(X, Y). (round to the hundredths)
# NOTE: this is a POPULATION covariance (probabilities) -> do NOT use cov(), it divides by n-1
X <- c(0, 2, 0)                       # INPUT first numbers of each pair
Y <- c(2, 1, 3)                       # INPUT second numbers of each pair
p <- rep(1/3, 3)                      # INPUT probabilities
sum(X * Y * p) - sum(X * p) * sum(Y * p)   # check: -0.67

# Given Cov(X, Y) = -4, sd(X) = 2, and sd(Y) = 4, find Cor(X, Y). (round to the hundredths)
# Cor(X, Y) = Cov(X, Y) / (sd(X) sd(Y))
CovXY <- -4; sdX <- 2; sdY <- 4       # INPUT
CovXY / (sdX * sdY)         # check: -0.5

# A covariance property: Cov(a1 X + b1, a2 Y + b2) = a1 a2 Cov(X, Y). Given Cov(X, Y) = 3, a1 = 5, a2 = 3 (and any constants b1, b2), find Cov(a1 X + b1, a2 Y + b2).
CovXY <- 3; a1 <- 5; a2 <- 3          # INPUT
a1 * a2 * CovXY             # check: 45

# Given Var(X) = 6, Var(Y) = 2, Cov(X, Y) = 0, a = 1, and b = 1, find Var(aX + bY). (round to the hundredths)
# Var(aX + bY) = a^2 Var(X) + b^2 Var(Y) + 2ab Cov(X, Y)
# (for Var(X - Y) use a <- 1; b <- -1)
VarX <- 6; VarY <- 2; CovXY <- 0; a <- 1; b <- 1   # INPUT
a^2 * VarX + b^2 * VarY + 2 * a * b * CovXY   # check: 8


##########################################################################
##  SECTION G  JOINT PROBABILITY TABLE  (x, y, P(X=x, Y=y))
##########################################################################

# X and Y have the joint probability distribution below. Find E[X]. / Find Cov(X, Y). /
# The population regression slope is B1 = Cov(X, Y) / Var(X). Find B1. (round to the hundredths)
#   x y P(X=x, Y=y)
#   6 4 0.2
#   5 7 0.3
#   3 1 0.5
X <- c(6, 5, 3)                       # INPUT x column
Y <- c(4, 7, 1)                       # INPUT y column
p <- c(0.2, 0.3, 0.5)                 # INPUT probability column
EX  <- sum(X * p); EY <- sum(Y * p)
CovXY <- sum(X * Y * p) - EX * EY
VarX  <- sum(X^2 * p) - EX^2
EX                          # E[X]
EY                          # E[Y]
CovXY                       # Cov(X, Y)  check: 2.52
CovXY / VarX                # population slope B1 = Cov(X,Y)/Var(X)


##########################################################################
##  SECTION H  CONDITIONAL EXPECTATION
##########################################################################

# Given X = x, Y takes values 3, 2, 3 with probabilities 0.2, 0.3, 0.5. Find E[Y | X = x]. (round to the hundredths)
vals <- c(3, 2, 3)                    # INPUT
p    <- c(0.2, 0.3, 0.5)              # INPUT
sum(vals * p)               # check: 2.7

# Among the observations with X = x, the Y values are 6, 0, 4, 5. Find E[Y | X = x] (the subgroup average). (round to the hundredths)
y_sub <- c(6, 0, 4, 5)                # INPUT
mean(y_sub)                 # check: 3.75

# Conditional expectation is also linear: E[aY + b | X = x] = a E[Y | X = x] + b. Given E[Y | X = x] = 3, a = 4, b = 7, find E[aY + b | X = x].
EYx <- 3; a <- 4; b <- 7              # INPUT
a * EYx + b                 # check: 19


##########################################################################
##  SECTION I  OLS SLOPE / INTERCEPT / PREDICTION
##  B1hat = cov(x, y) / var(x)      B0hat = ybar - B1hat * xbar
##########################################################################

# Given cov(x, y) = -5 and var(x) = 4, find the OLS slope B1hat. (round to the hundredths)
covxy <- -5; varx <- 4                # INPUT
covxy / varx                # check: -1.25

# Given ybar = 12, xbar = 9, and slope B1hat = 7/10, find the OLS intercept B0hat. (round to the hundredths)
ybar <- 12; xbar <- 9; B1hat <- 7/10  # INPUT
ybar - B1hat * xbar         # check: 5.7

# For the sample x = (3, 5, 3), y = (8, 0, 9), find the OLS slope B1hat. (round to the hundredths)
# For the sample x = (8, 4, 2), y = (5, 12, 1), find the OLS intercept B0hat. (round to the hundredths)
# For the sample x = (2, 6, 8), y = (2, 2, 8), fit the OLS line and predict yhat at x = 3. (round to the hundredths)
# (all three use this one block - just change x, y, x0)
#  checks: x=(8,4,2),y=(5,12,1) -> intercept 4.5 ;  x=(2,6,8),y=(2,2,8),x0=3 -> yhat 2
x  <- c(3, 5, 3)                      # INPUT
y  <- c(8, 0, 9)                      # INPUT
x0 <- 3                               # INPUT x to predict at (only for "predict yhat")
B1hat <- cov(x, y) / var(x)
B0hat <- mean(y) - B1hat * mean(x)
B1hat                       # slope      check: -4.25
B0hat                       # intercept
B0hat + B1hat * x0          # prediction yhat at x0
# double check with lm:  coef(lm(y ~ x))
# if instead GIVEN the sums: B1hat = sum((x-xbar)(y-ybar)) / sum((x-xbar)^2)  -> just divide the two numbers

# A fitted regression line is yhat = B0hat + B1hat*x. With B0hat = 5 and B1hat = 3/10, find the predicted yhat at x = 8.
# (also: A fitted line is yhat = 3 + (6/10) x. Find the fitted value yhat at x = 8.)
B0hat <- 5; B1hat <- 3/10; x0 <- 8    # INPUT
B0hat + B1hat * x0          # check: 7.4

# A fitted line is E[colGPA | hsGPA] = 13/10 + (5/10) hsGPA. Find the expected colGPA at hsGPA = 39/10. (round to the hundredths)
B0hat <- 13/10; B1hat <- 5/10; hsGPA <- 39/10   # INPUT
B0hat + B1hat * hsGPA       # check: 3.25

# In wage = B0 + B1*educ + U the estimated slope is B1hat = 8/10. Ceteris paribus, if educ rises by 9 year(s), by how much does predicted wage change?
# (also: A fitted slope is B1hat = 9/10. Find the predicted change in y when x rises by 4.)
# (also: ... Using delta yhat = B1hat * delta x, find the predicted change in y when x rises by 2.)
B1hat <- 8/10; dx <- 9                # INPUT
B1hat * dx                  # check: 7.2


##########################################################################
##  SECTION J  FITTED VALUES, RESIDUALS, SSR, SSE, SST, R^2
##  REMEMBER: SSE = EXPLAINED, SSR = RESIDUAL (unexplained), SST = SSE + SSR
##########################################################################

# A fitted line is yhat = 1 + (2/10) x. A person has x = 16 and actual y = 8. Find the OLS residual uhat for this person. (round to the hundredths)
# uhat = y - yhat   (actual minus fitted)
B0hat <- 1; B1hat <- 2/10; x0 <- 16; y0 <- 8   # INPUT
y0 - (B0hat + B1hat * x0)   # check: 3.8

# For the fitted line yhat = 2 + (5/10) x and the three points (X_i, Y_i): (3, 8), (10, 7), (4, 1), find SSR. (round to the hundredths)
# SSR = sum (Y_i - Yhat_i)^2
B0hat <- 2; B1hat <- 5/10             # INPUT
X <- c(3, 10, 4)                      # INPUT first numbers of points
Y <- c(8, 7, 1)                       # INPUT second numbers of points
sum((Y - (B0hat + B1hat * X))^2)   # check: 29.25

# A regression has SST = 358 and SSR = 161. Find the explained sum of squares SSE. (round to the hundredths)
SST <- 358; SSR <- 161                # INPUT
SST - SSR                   # check: 197

# A regression has SST = 206 and SSR = 70. Find R^2. (round to the hundredths)
# R^2 = 1 - SSR/SST
SST <- 206; SSR <- 70                 # INPUT
1 - SSR / SST               # check: 0.66

# A regression has SSE = 87 and SST = 294. Find R^2. (round to the hundredths)
# R^2 = SSE/SST
SSE <- 87; SST <- 294                 # INPUT
SSE / SST                   # check: 0.3

# A regression has SST = 338 and SSR = 155. What fraction of the variation in Y is UNEXPLAINED? (round to the hundredths)
# unexplained fraction = SSR/SST  (= 1 - R^2)
SST <- 338; SSR <- 155                # INPUT
SSR / SST                   # check: 0.46

# A regression has SST = 317 and R^2 = 58/100. Find SSR. (round to the hundredths)
# SSR = SST * (1 - R^2)
SST <- 317; R2 <- 58/100              # INPUT
SST * (1 - R2)              # check: 133.14
#   if instead asked for SSE: SST * R2


##########################################################################
##  SECTION K  REAL DATA IN R (wage1, bwght)
##  every block below loads what it needs, so you can run any one alone
##  (if library(wooldridge) errors: install.packages("wooldridge") )
##########################################################################

# How many workers are in the wage1 sample? (Hint: nrow(wage1))
nrow(wage1)                           # check: 526

# What is the sample mean of hourly wage, wage1$wage? (Hint: mean()) (round to the hundredths)
library(wooldridge); data("wage1"); data("bwght")
mean(wage1$wage)            # check: 5.9

# What is the sample standard deviation of years of education, wage1$educ? (Hint: sd()) (round to the hundredths)
library(wooldridge); data("wage1"); data("bwght")
sd(wage1$educ)              # check: 2.77
# other quick stats if asked: var(wage1$educ), summary(wage1$wage), cor(wage1$wage, wage1$educ)

# Run the OLS regression of wage on educ: reg <- lm(wage ~ educ, data = wage1). Save the slope as b1 <- reg$coefficients[2]. What is the OLS slope B1hat?
library(wooldridge); data("wage1"); reg <- lm(wage ~ educ, data = wage1)
b1 <- reg$coefficients[2]
b1                          # check: 0.54

# Save the intercept of the regression as b0 <- reg$coefficients[1]. What is the OLS intercept B0hat? (It can be negative.)
library(wooldridge); data("wage1"); reg <- lm(wage ~ educ, data = wage1)
b0 <- reg$coefficients[1]
b0                          # check: -0.9

# Using your saved b0 and b1, what is the predicted hourly wage (wage hat) for a worker with 14 years of education?
library(wooldridge); data("wage1"); reg <- lm(wage ~ educ, data = wage1)
b0 <- reg$coefficients[1]; b1 <- reg$coefficients[2]
educ0 <- 14                           # INPUT years of education
b0 + b1 * educ0             # check (14 yrs): 6.67

# Using your saved b1, by how much does the predicted hourly wage change when education rises by 2 years? Use delta wagehat = B1hat * delta educ.
library(wooldridge); data("wage1"); reg <- lm(wage ~ educ, data = wage1)
b1 <- reg$coefficients[2]
d_educ <- 2                           # INPUT
b1 * d_educ                 # check: 1.08

# What is the sum of squared residuals SSR for the regression of wage on educ? Save it with SSR <- sum(reg$residuals^2), then type SSR to see it.
library(wooldridge); data("wage1"); reg <- lm(wage ~ educ, data = wage1)
SSR <- sum(reg$residuals^2)
SSR                         # check: 5980.68

# What is R^2 for the regression of wage on educ? Use R^2 = 1 - SSR/SST, with SSR from above and SST <- sum((wage1$wage - mean(wage1$wage))^2). Check your answer with summary(reg)$r.squared.
library(wooldridge); data("wage1"); reg <- lm(wage ~ educ, data = wage1)
SSR <- sum(reg$residuals^2)
SST <- sum((wage1$wage - mean(wage1$wage))^2)
1 - SSR / SST               # check: 0.16
summary(reg)$r.squared      # same thing
#   SSE (explained) if asked: SST - SSR

# Now use bwght: bwght is birth weight in ounces, cigs is cigarettes per day. Run reg2 <- lm(bwght ~ cigs, data = bwght).
# By how many ounces does predicted birth weight change when the mother smokes 5 more cigarettes per day?
library(wooldridge); data("bwght")
reg2 <- lm(bwght ~ cigs, data = bwght)
d_cigs <- 5                           # INPUT
reg2$coefficients[2] * d_cigs   # check: -2.57
#   slope / intercept of reg2 if asked: coef(reg2)

## TEMPLATE - any other regression "y on x" from a wooldridge dataset:
##   regX <- lm(YVAR ~ XVAR, data = DATASET)
##   coef(regX)                 # intercept, slope
##   summary(regX)$r.squared    # R^2
##   sum(regX$residuals^2)      # SSR


##########################################################################
##  SECTION L  LOGS AND UNITS OF MEASUREMENT  (from Day 12-13)
##########################################################################

# log-level model: log(wage)-hat = 0.58 + 0.08*educ. Percent change in wage from +1 year (or +4 years) of school?
# percent change in y = 100 * B1hat * (change in x)
B1hat <- 0.08; dx <- 1                # INPUT (dx = years added)
100 * B1hat * dx                      # check: 8  (dx = 4 -> 32)

# log-log model: log(salary) on log(sales), slope 0.257. If sales rise by 10%, salary rises by what percent?
# slope = ELASTICITY: percent change in y = B1hat * (percent change in x)
B1hat <- 0.257; pct_x <- 10           # INPUT
B1hat * pct_x                         # check: 2.57

# level-log model: y on log(x). If x rises by 1%, y changes by how many units?
B1hat <- 5; pct_x <- 1                # INPUT
B1hat / 100 * pct_x                   # check: 0.05

# Units: salary in $1000s regressed on roe gives 963.19 and 18.50. Salary in DOLLARS (Y x 1000)?
# Y times c -> BOTH B0hat and B1hat times c
B0hat <- 963.19; B1hat <- 18.50; c_y <- 1000   # INPUT
c(B0hat * c_y, B1hat * c_y)           # check: 963190, 18500

# Units: roe as a DECIMAL (X x 1/100)?
# X times c -> B1hat divided by c, B0hat unchanged   (R^2 unchanged in every case)
B0hat <- 963.19; B1hat <- 18.50; c_x <- 1/100  # INPUT
c(B0hat, B1hat / c_x)                 # check: 963.19, 1850

# Real data log regressions (from Day 13):
library(wooldridge); data("wage1"); data("ceosal1")
lm(log(wage) ~ educ, data = wage1)$coefficients            # 0.584, 0.083  (~8.3% per year of educ)
lm(log(salary) ~ log(sales), data = ceosal1)$coefficients  # 4.822, 0.257  (elasticity)


##########################################################################
##########################################################################
##  PART 3  IN-CLASS DAY SCRIPTS (Day 2 - Day 13, blanks filled in)
##  Original comments kept. Blanks are filled; lines I added end in  # <- filled
##  "## NOTE (Claude):" = something I changed or fixed.
##########################################################################
##########################################################################


## =======================================================================
## DAY 2  |  first R session: the mean, real data, a first line.
## =======================================================================

## (1) The mean, from our own numbers  -- we fill this in together
## step 1: put our class poll numbers in a vector -- use c()
poll <- c(3, 5, 2, 8)                                   # <- filled
## NOTE (Claude): the real class poll numbers weren't in the file, so these are placeholders.
## step 2: add them all up -- use sum()
sum(poll)                                               # <- filled
## step 3: how many are there? (n) -- use length()
length(poll)                                            # <- filled
## step 4: the mean = sum / length ... or just mean()
sum(poll) / length(poll); mean(poll)                    # <- filled

## (2) Real data: dataset$variable
## R convention: dataset$variable picks ONE variable (column) out of a dataset --
##   e.g. wage1$wage = the "wage" column of wage1, wage1$educ = the "educ" column.
library(wooldridge); data("wage1")   # 526 workers, 1976
summary(wage1)                        # snapshot of every variable
mean(wage1$wage)                      # center
sd(wage1$wage)                        # spread
hist(wage1$wage)                      # shape
cor(wage1$educ, wage1$wage)           # do they move together? (not causation!)

## ================= PROBLEMS (your turn) =========================
mean_wage <- mean(wage1$wage)         # (a) the mean wage   # <- filled  (5.90)
## (b) Is wage1 cross-section, time-series, or panel?   ANSWER (comment): cross-section (526 workers, all in 1976)


## =======================================================================
## DAY 3  |  ceteris paribus + percentages.
## =======================================================================

## --- Example A.2:  quantity = 120 - 9.8*price + 0.03*income ---
## the two slopes:
b1 <- -9.8        # slope on price    (hint: -9.8)
b2 <- 0.03        # slope on income   (hint:  0.03)
## price up $1, income held fixed  ->  change in quantity?
b1*1 + b2*0                           # -9.8
## price DOWN $2 and income UP $300  ->  change in quantity?
b1*(-2) + b2*300                      # <- filled  (28.6)

## --- Percentages ---
## turn the proportion 0.250 into a percent:
0.250 * 100                           # <- filled  (25)
## percent change when x goes 54 -> 57:
(57 - 54) / 54 * 100                  ##KEEP FOR EXAM   # <- filled  (5.56)
xnew = 38
xold = 52
(xnew-xold)/xold*100                  # -26.92
## percentage-POINT change 54 -> 57 (just the difference):
57 - 54                               # <- filled  (3)

## ================= PROBLEMS (your turn) =========================
pct_chg <- (25-20)/20*100             # (a) percent change from $20 to $25   # <- filled  (25)
## (b) interest rate 3% -> 5%: percentage-POINT change = 2 ; percent change = 66.67   (comment)


## =======================================================================
## DAY 4  |  variance, sd, covariance, correlation.  (all SAMPLE calculations)
## =======================================================================

## --- Sample variance & sd ---
## put a few numbers in a vector called x
x <- c(2,1,3)
## find its mean
x_bar = mean(x)
## by hand: subtract the mean from each value, square, add up, divide by n - 1
sum((x - x_bar)^2)/(length(x)-1)
## check it with the built-in variance function
var(x)
## the sd is the square root of the variance
sqrt(var(x))
sd(x)
## --- Sample covariance ---
## put two paired variables (same length) in vectors x and y
gta = c(7,0,8)
miles = c(1,1,4)
## by hand: subtract each mean, multiply the pairs, add up, divide by n - 1
sum((gta-mean(gta))*(miles-mean(miles)))/(length(gta)-1)
## check it with the built-in covariance function
cov(gta, miles)

## --- Sample correlation ---
## the correlation is the covariance divided by (sd of x  times  sd of y)
cov(gta, miles)/(sd(gta)*sd(miles))
## check it with the built-in correlation function
cor(gta, miles)

## --- Nonlinear: log & exp (allow non-constant, curved relationships) ---
## make a range of positive x-values (call it x)
x <- seq(0.5, 5, by = 0.1)            # <- filled
## plot log(x): it flattens out (diminishing).  then plot exp(x): it grows fast.
plot(x, log(x), type = "l")           # <- filled
plot(x, exp(x), type = "l")           # <- filled
## check that exp undoes log, and log undoes exp (pick any positive number):
exp(log(3))                           # <- filled  (3)
log(exp(3))                           # <- filled  (3)

## remember: var, sd, cov, cor are all SAMPLE quantities -- our best guesses at the population's.


## =======================================================================
## DAY 5  |  nonlinear functions (log/exp) + random variables & expectation.
## =======================================================================

## --- Nonlinear functions: log & exp  (self-contained demo -- run it and explore!) ---
u <- seq(0.5, 5, by = 0.1)      # a range of positive values
plot(u, log(u), type = "l")     # log: diminishing (flattens out)
plot(u, exp(u), type = "l")     # exp: grows ever faster
exp(log(3))                     # log then exp -> back to 3
log(exp(3))                     # exp then log -> back to 3

## --- Expected value:  E[X] = sum of  value * probability ---
## a random variable's values and their probabilities (must sum to 1)
x <- 1:6        # the values -- a colon makes a sequence, e.g. 1:6 for a die
p <- rep(1/6, 6)        # the probabilities -- rep() repeats a value, e.g. rep(1/6, 6)
## E[X] is a weighted average: sum of  x * p
sum(x*p)                        # 3.5
## E[X^2] weights the SQUARED values: sum of  x^2 * p
sum(x^2*p)                      # 15.17


## =======================================================================
## DAY 6  |  Expectation properties, variance, covariance, correlation
## One idea powers all of today:  weight each value by its probability, then add.
##      E[g(X)] = sum( g(x) * p )
## =======================================================================

## ===== 1. Properties of expectation:  E[aX + bY] = a*E[X] + b*E[Y] =====
## Example: suppose E[X] = 2 and E[Y] = 3.  Find E[4X + 5Y - 3].
EX <- 2
EY <- 3
4*EX + 5*EY - 3                 # E[4X + 5Y - 3]   # <- filled  (20)

## ===== 2. Variance & standard deviation:  Var(X) = E[X^2] - E[X]^2 =====
## A coin in {0, 1}, each face with probability 1/2.
x <- c(0,1)         # the values           -- the two faces
p <- c(1/2,1/2)     # their probabilities   -- must sum to 1
EX  <- sum(x*p)     # E[X]                  -- weight & add:  sum(x * p)
EX2 <- sum(x^2*p)   # E[X^2]                -- same idea, weight x^2
VarX <- EX2-EX^2    # Var(X) = E[X^2] - E[X]^2      (0.25)
sdX  <- sqrt(VarX)  # sd(X)                 -- square root of the variance   (0.5)

## ===== 3. Covariance:  Cov(X,Y) = E[XY] - E[X]*E[Y] =====
## Two INDEPENDENT coin flips.  The four (x, y) pairs, each with probability 1/4:
xj <- c(0,0,1,1)       # x across pairs (0,0) (0,1) (1,0) (1,1)
yj <- c(0,1,0,1)       # y across those same pairs
pj <- rep(1/4,4)       # probability of each pair
EXY <- sum(xj*yj*pj)   # E[XY]                 -- same idea, weight xj*yj
EX = sum(xj*pj)
EY = sum(yj*pj)
CovXY <- EXY-EX*EY     # Cov = E[XY] - E[X]*E[Y]    -- independent, so expect 0

## ===== 4. Correlation:  Cor(X,Y) = Cov(X,Y) / ( sd(X) * sd(Y) ) =====
## Unitless; always between -1 and 1.   (Remember: correlation is NOT causation.)
CovXY / (0.5 * 0.5)    # Cor(X, Y)  -- here sd(X) = sd(Y) = 0.5   # <- filled  (0)

## ================= YOUR TURN =========================
## X takes values 1, 2, 3 with probabilities 0.2, 0.5, 0.3.
x <- c(1, 2, 3); p <- c(0.2, 0.5, 0.3)   # <- filled
EX   <- sum(x*p)       # (a) E[X]       # <- filled  (2.1)
EX2  <- sum(x^2*p)     # (b) E[X^2]     # <- filled  (4.9)
VarX <- EX2 - EX^2     # (c) Var(X) = E[X^2] - E[X]^2   # <- filled  (0.49)
c(EX, EX2, VarX)


## =======================================================================
## DAY 7  |  Correlation, conditional expectation & conditional variance
## =======================================================================

library(wooldridge); data("wage1")

## ===== 1. Population correlation from a probability table =====
## X, Y are correlated 0/1 coin flips.  Joint probabilities of the four (x, y) pairs:
xj <- c(0, 0, 1, 1)          # x for pairs (0,0) (0,1) (1,0) (1,1)
yj <- c(0, 1, 0, 1)          # y for those same pairs
pj <- c(0.4, 0.1, 0.1, 0.4)  # they tend to AGREE -> expect a positive relationship
EX  <- sum(xj*pj)            # E[X]   = sum(xj * pj)
EY  <- sum(yj*pj)            # E[Y]   = sum(yj * pj)
EXY <- sum(xj*yj*pj)         # E[XY]  = sum(xj * yj * pj)
Cov <- EXY-EX*EY             # Cov(X,Y) = E[XY] - E[X]*E[Y]
EX2 <- sum(xj^2*pj)
EY2 <- sum(yj^2*pj)
VarX = EX2-EX^2
VarY = EY2-EY^2
## sd of a 0/1 variable: sd = sqrt(E[X^2] - E[X]^2), and X^2 = X here so E[X^2] = E[X]
sdX <- sqrt(VarX)            # sqrt(EX - EX^2)
sdY <- sqrt(VarY)            # sqrt(EY - EY^2)
Cor <- Cov/(sdX*sdY)         # Cor = Cov / (sdX * sdY)   -- should come out to 0.6
Cor

## ===== 2. Conditional expectation:  E[Y | X = x] = average of Y within the X = x subgroup =====
## Build it in STEPS.  Goal: the average wage among people with exactly 12 years of educ.
is12 <- wage1$educ == 12     # a BOOLEAN vector, TRUE for each person with educ == 12
w12  <- wage1$wage[is12]     # put the Boolean in [ ] to SELECT those people's wages
mean(w12)                    # E[wage | educ = 12] = the average of those wages   # <- filled
## Now educ == 16 (college), the same idea in one line:
mean(wage1$wage[wage1$educ == 16])           # E[wage | educ = 16]
## The conditional mean RISES with education.

## Special case  E[X | X] = X: condition on X and there's nothing left to average.
mean(wage1$educ[is12])       # E[educ | educ = 12]  -> exactly 12   # <- filled

## ===== 3. Conditional variance:  Var(Y | X = x) = spread of Y within the X = x subgroup =====
var(w12)                                     # Var(wage | educ = 12)   # <- filled
var(wage1$wage[wage1$educ == 16])            # Var(wage | educ = 16)   # <- filled
## Which subgroup's wages are more spread out?  (income "fans out" at higher education) -> educ = 16

## ================= YOUR TURN =========================
## (a) E[wage | educ = 14]  (Boolean -> select -> mean, like section 2):
mean(wage1$wage[wage1$educ == 14])           # <- filled
## (b) We saw average wage RISES with education.  Does that PROVE school raises pay?
##     Name one confounder (comment).  ANSWER: No. Ability (or family background) raises both educ and wage.

## ================= OPTIONAL DEMO (run it and look -- nothing to fill in) =================
##   * the DOT (center of each hump)   = E[wage | educ]    -- conditional EXPECTATION
##   * the BAR (+/- 1 sd about the dot) = sd(wage | educ)  -- conditional spread (variance)
plot(wage1$educ, wage1$wage, pch = 16, col = "grey70",
     xlab = "education (years)", ylab = "wage",
     main = "Conditional distribution of wage given education")
show_group <- function(ed, col) {
  w <- wage1$wage[wage1$educ == ed]      # wages within this education subgroup
  d <- density(w)                        # kernel density estimate of that subgroup
  m <- mean(w); s <- sd(w)               # conditional mean and standard deviation
  lines(ed + d$y / max(d$y) * 2.5, d$x, col = col, lwd = 2)     # density drawn sideways at x = ed
  arrows(ed, m - s, ed, m + s, angle = 90, code = 3,
         length = 0.05, col = col, lwd = 2)                     # bar = mean +/- 1 sd (spread)
  points(ed, m, pch = 19, col = col, cex = 1.4)                 # dot = E[wage | educ = ed]
}
show_group(12, "blue")                   # HS diploma
show_group(16, "red")                    # college degree
legend("topleft", c("educ = 12 (HS)", "educ = 16 (college)"),
       col = c("blue", "red"), lwd = 2, bty = "n")


## =======================================================================
## DAY 8  |  The SLR model & E[Y|X]
## Model:  Y = b0 + b1*X + U,  so  E[Y|X] = b0 + b1*X  (a straight line).
## =======================================================================

## ---- Demo: colGPA as a FUNCTION of hsGPA  (illustrates R functions) ----
## Notes:  E[colGPA | hsGPA] = 1.5 + 0.5*hsGPA
b0 <- 1.5                      # intercept
b1 <- 0.5                      # slope
colgpa <- function(hsgpa) {    # define colGPA as a function of hsGPA
  b0 + b1*hsgpa                # the line:  b0 + b1*hsgpa
}
colgpa(3.6)                    # predicted colGPA at hsGPA = 3.6   (-> 3.3)
## NOTE (Claude): your file had colgpa(3.1) (= 3.05) but the comment says 3.6 -> 3.3; set it back to 3.6.
colgpa(3.6) - colgpa(2.6)      # change in colGPA from hsGPA 2.6 to 3.6   # <- filled  (0.5)
hsGPA <- seq(2, 4, by = 0.1)   # a range of hsGPA values
plot(hsGPA, colgpa(hsGPA), type = "l",
     xlab = "hsGPA", ylab = "E[colGPA | hsGPA]")   # plot the line

## ================= PROBLEMS (your turn) =========================
pred_30 <- b0 + b1*3.0         # (a) expected colGPA at hsGPA = 3.0   # <- filled  (3)
## (b) In one sentence (comment): what does E[U | X] = 0 say?
##     ANSWER: The average of the unobserved factors U does not depend on X.
## (c) In one sentence (comment): why might it fail for wage = b0 + b1*educ + U?
##     ANSWER: Ability is in U and is correlated with educ, so the average of U changes with educ.


## =======================================================================
## DAY 9  |  Deriving the OLS estimates
## beta1-hat = cov(x,y)/var(x),  beta0-hat = ybar - beta1*xbar.
## =======================================================================

## ---- Demo: estimate the wage-education line, by hand ----
library(wooldridge); data("wage1")
x <- wage1$educ     # X = education
y <- wage1$wage     # Y = wage
b1 <- cov(x, y) / var(x)            # slope      -- the derived formula:  cov(x, y) / var(x)
b0 <- mean(y) - mean(x) * b1        # intercept  -- mean(y) - b1 * mean(x)
c(b0 = b0, b1 = b1) # the fitted line  (should be about -0.90 and 0.54)
## ================= YOUR TURN =========================
## Tiny dataset:  x = (1, 2, 3),  y = (2, 2, 5)
x <- c(1, 2, 3)
y <- c(2, 2, 5)
b1    <- cov(x, y) / var(x)         # (a) slope        # <- filled  (1.5)
b0    <- mean(y) - b1 * mean(x)     # (b) intercept    # <- filled  (0)
pred4 <- b0 + b1 * 4                # (c) predicted y at x = 4   # <- filled  (6)
c(b1, b0, pred4)


## =======================================================================
## DAY 10  |  lm(), fitted values, residuals
## lm() is the shortcut for the OLS line we derived by hand on Day 9.
## =======================================================================

library(wooldridge); data("wage1")

## ---- Fit the regression:  wage on educ ----
reg <- lm(wage ~ educ, data = wage1)   # fit the OLS line:  lm(wage ~ educ, data = wage1)
reg$coefficients     # look: the two estimates  (-0.90 and 0.54, same as Day 9)

## ---- Pull the coefficients out of reg ----
b0 <- reg$coefficients[1]         # intercept:  reg$coefficients[1]
b1 <- reg$coefficients[2]         # slope:      reg$coefficients[2]

## ---- Fitted values (predictions) and residuals (misses) ----
yhat <- reg$fitted.values       # fitted values:  reg$fitted.values   (yhat = b0 + b1*educ)
uhat <- reg$residuals           # residuals:      reg$residuals        (uhat = wage - yhat)
SSR  <- sum(uhat^2)             # sum of squared residuals:  sum(uhat^2)

## ================= YOUR TURN =========================
## Estimated line:  wage-hat = -0.90 + 0.54*educ.   A person: educ = 12, actual wage = 9.0
b0 <- -0.90
b1 <- 0.54
yhat <- b0 + b1*12              # (a) fitted value at educ = 12      # <- filled  (5.58)
uhat <- 9.0 - yhat              # (b) residual = actual - fitted     # <- filled  (3.42)
c(yhat, uhat)
## (c) Over- or under-predicted? (comment)  ANSWER: UNDER-predicted (residual is positive, actual > fitted)


## =======================================================================
## DAY 11  |  OLS properties 1-3;  SST = SSE + SSR, R^2
## =======================================================================

library(wooldridge); data("ceosal1")

## Example 2.3
# dependent variable always on left
reg = lm(salary ~ roe, data = ceosal1)
b0 = reg$coefficients[1]
b1 = reg$coefficients[2]
b0 + b1 * -15   # prediction at roe = -15
b1 * -5         # predicted change when roe falls by 5
data("wage1")
reg <- lm(wage ~ educ, data = wage1)
resids = reg$residuals

## ---- OLS properties 1-3  (hold on ANY sample) ----
sum(resids)                   # 1) the residuals sum to 0   (~ 0)
cov(resids, wage1$educ)       # 2) x & residuals are uncorrelated  (~ 0)
b0 = reg$coefficients[1]
b1 = reg$coefficients[2]      # 3) (xbar, ybar) is ON the line
b0 + b1 * mean(wage1$educ)    #    these two match
mean(wage1$wage)
## ---- SST = SSE + SSR, and R^2   (bwght ~ cigs) ----
data("bwght")
reg2 <- lm(bwght ~ cigs, data = bwght)               # regress bwght on cigs   # <- filled
SST <- sum((bwght$bwght - mean(bwght$bwght))^2)      # total variation         # <- filled
SSR <- sum(reg2$residuals^2)                         # unexplained             # <- filled
SSE <- SST - SSR                                     # explained               # <- filled
R2  <- SSE / SST                                     # R^2 (~ 0.02: low is normal)   # <- filled
R2

## ================= YOUR TURN =========================
## A regression has SST = 200 and SSR = 150.
SST0 <- 200
SSR0 <- 150
SSE0 <- SST0 - SSR0             # (a) explained sum of squares   # <- filled  (50)
R20  <- SSE0 / SST0             # (b) R^2                        # <- filled  (0.25)


## =======================================================================
## DAY 12  |  R^2;  units of measurement
## =======================================================================

library(wooldridge)

## ---- SST = SSE + SSR, and R^2   (bwght ~ cigs) ----
data("bwght")
reg2 <- lm(bwght ~ cigs, data = bwght)   # regress bwght on cigs
summary(reg2)
n = nrow(bwght)
SST <- (n-1) * var(bwght$bwght)          # total variation (same as sum of squared deviations)
SSR <- (n-1) * var(reg2$residuals)       # unexplained (works because residuals average 0)
SSE <- SST - SSR                         # explained   # <- filled
## NOTE (Claude): your line was "SSE <- (n-1) *" with nothing after it, which would error. Fixed to SST - SSR.
R2  <- SSE / SST                         # R^2 (~ 0.02)   # <- filled
R2

## ---- Units of measurement   (Example 2.3: salary on roe, salary in $1000s) ----
data("ceosal1")
reg3 <- lm(salary ~ roe, data = ceosal1)               # (963.19 and 18.50)   # <- filled
ceosal1$salarydol <- 1000 * ceosal1$salary             # salary in DOLLARS     # <- filled
lm(salarydol ~ roe, data = ceosal1)$coefficients       # both x 1000           # <- filled
ceosal1$roedec <- ceosal1$roe / 100                    # roe as a DECIMAL      # <- filled
lm(salary ~ roedec, data = ceosal1)$coefficients       # slope x 100, intercept same   # <- filled
summary(reg3)$r.squared                                # R^2 same for all three        # <- filled

## ================= PROBLEMS (your turn) =========================
## A regression has SST = 200 and SSR = 150.
SST0 <- 200
SSR0 <- 150
SSE0 <- SST0 - SSR0             # (a) explained sum of squares          # <- filled  (50)
R20  <- SSE0 / SST0             # (b) R^2                               # <- filled  (0.25)
unex <- SSR0 / SST0             # (c) fraction of the variation UNEXPLAINED   # <- filled  (0.75)


## =======================================================================
## DAY 13  |  Units of measurement;  logs & functional form
## Logs: wrap a variable in log() inside the formula; read the slope with Table 2.3.
## =======================================================================

library(wooldridge)

## ---- Units of measurement   (Example 2.3: salary on roe, salary in $1000s) ----
data("ceosal1")
reg3 <- lm(salary ~ roe, data = ceosal1)        # regress salary on roe   (963.19 and 18.50)
ceosal1$salarydol <- ceosal1$salary * 1000      # salary in DOLLARS:  Y x 1000
reg4 <- lm(salarydol ~ roe, data = ceosal1)     # both estimates x 1000
ceosal1$roedec <- ceosal1$roe / 100             # roe as a DECIMAL:   X x 1/100
reg5 <- lm(salary ~ roedec, data = ceosal1)     # slope x 100, intercept unchanged
reg3
reg4
reg5
## NOTE (Claude): your file printed reg5 before it was created (error). Moved the prints below it.
summary(reg3)$r.squared                         # R^2 -- same for all three regressions

## ---- Demo: log-level (Example 2.10) ----
## What you're learning: log(y) on x  ->  slope is a PERCENT change in y.
data("wage1")
reg <- lm(log(wage) ~ educ, data = wage1)
reg$coefficients                                # 0.584, 0.083 (~8.3% per year)
b0 <- reg$coefficients[1]
b1 <- reg$coefficients[2]   #KNOW FOR EXAM HAVE SOMEHWERE TO COPY THEN REPASTE
b1*100*4                    # percent change in wage from +4 years of educ (~33%)

## ---- Demo: log-log / constant elasticity (Example 2.11) ----
## What you're learning: log(y) on log(x)  ->  slope is an ELASTICITY.
lm(log(salary) ~ log(sales), data = ceosal1)$coefficients   # 4.822, 0.257

## ================= PROBLEMS (your turn) =========================
## log-level model:  log(wage)-hat = 0.58 + 0.08*educ
b1 <- 0.08
pct_1yr <- 100*b1           # (a) % change in wage from +1 year of school   # <- filled  (8)
pct_4yr <- 100*b1*4         # (b) % change from +4 years                    # <- filled  (32)
c(pct_1yr, pct_4yr)
## (c) In a log-log model, the slope is called a(n) ELASTICITY  (comment)

## END OF SCRIPT