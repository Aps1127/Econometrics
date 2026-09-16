#Expectation is linear: E[aX+b] = a*E[X] + b
EX <- 5; a <- 4; b <- 1
Q8 <- a*EX + b
Q8

#E[aX+bY] = a*E[X] + b*E[Y]
EX <- 6; EY <- 8; a <- 4; b <- 2
Q9 <- a*EX + b*EY
Q9

#E[aX+bY-c] = a*E[X] + b*E[Y] - c
EX <- 3; EY <- 8; a <- 2; b <- 5; c <- 5
Q10 <- a*EX + b*EY - c
Q10

#Var(X) = E[X^2] - (E[X])^2
EX <- 5; EX2 <- 58
Q11 <- EX2 - EX^2
Q11

#Var(aX+b) = a^2 * Var(X)
VarX <- 6; a <- 2
Q12 <- a^2 * VarX
Q12

#sd(X) = sqrt(Var(X))
VarX <- 14
Q13 <- sqrt(VarX)
Q13

#If independent, Var(X+Y) = Var(X) + Var(Y)
VarX <- 6; VarY <- 6
Q14 <- VarX + VarY
Q14

#Cov(X,Y) = E[XY] - E[X]*E[Y]
EXY <- 17; EX <- 3; EY <- 2
Q15 <- EXY - EX*EY
Q15

#Cov(X,Y) = E[XY] - E[X]*E[Y] for paired values (2,2),(3,1),(1,3) each prob 1/3
x <- c(2,3,1); y <- c(2,1,3); p <- rep(1/3,3)
EX <- sum(x*p); EY <- sum(y*p); EXY <- sum(x*y*p)
Q16 <- EXY - EX*EY
Q16

#Cov(a1*X+b1, a2*Y+b2) = a1*a2*Cov(X,Y)  (b1,b2 don't matter)
CovXY <- 3; a1 <- 5; a2 <- 3
Q17 <- a1*a2*CovXY
Q17

#Cor(X,Y) = Cov(X,Y) / (sd(X)*sd(Y))
CovXY <- 0; sdX <- 2; sdY <- 2
Q18 <- CovXY / (sdX*sdY)
Q18

#Var(aX+bY) = a^2*Var(X) + b^2*Var(Y) + 2ab*Cov(X,Y)
VarX <- 2; VarY <- 3; CovXY <- -1; a <- 2; b <- 1
Q19 <- a^2*VarX + b^2*VarY + 2*a*b*CovXY
Q19

#E[Y|X=x] = average of the Y values in that subgroup
y_vals <- c(6, 0, 4, 5)
Q20 <- mean(y_vals)
Q20

#E[Y|X=x] = sum(value * probability)
y_vals <- c(5, 8, 0); probs <- c(0.2, 0.3, 0.5)
Q21 <- sum(y_vals*probs)
Q21

#E[aY+b|X=x] = a*E[Y|X=x] + b
EYcond <- 3; a <- 4; b <- 7
Q22 <- a*EYcond + b
Q22