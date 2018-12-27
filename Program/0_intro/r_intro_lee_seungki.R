# SeungKi Lee

# Arithmatics and assignment = & <- does the same thing
a = 3-4
a <- -1

# Define function with name <- function(param) { operation } syntax
square <- function(x) {
  x^2
}

# Application
abs_val <- function(x) {
  if (x<0) {
    sqrt(x^2)
  } else {
    x
  }
}

# Vectors
1:10
# can multiply the whole vector with num * vector
5*1:10

# can assign vector to a var and map operations to elements
b<-5:10
b+3

# concat -> c()
# cannot perform certain operations on multiple types
# you can store multiple types into a single Datastructure
d<-c(3, 4, 7, "apple")
d*4

# Now operation can be applied
d<-c(3, 4, 7)
d*4

e<-1:3
# adding vectors -> add nth index of each vector. Two Vectors must be of the same length.
d+e

#ENBIS = Bernouilli assumption
enbis <- function(p0, l, ps, s) { 
  p0*l-ps*l-s;
}

enbis(.001, 100, .00001, .08)

# making rosi 
rosi <- function(p0, l, ps, s) {
	enbis(p0, l, ps, s)/(s);
}	

rosi(0.001, 100, 0.00001, 0.08)

losses <- seq(25, 5000, length=500)

# syntax explanation from ?function
?seq

# vector can go as param
enbis(p0=.1, losses, ps=.01, s=75)

loss.vary <- enbis(p0=.1, losses, ps=.01, s=75)
loss.vary2 <- enbis(p0=.05, losses, ps=.01, s=75)

plot(x=losses,
     y=loss.vary,
     type='l',
     xlab='Loss',
     ylab='ENBIS',
     main='ENBIS for antivirus as losses vary',
     cex=2)

#lines() can add to and ONLY add to existing plots.
lines(x=losses, y=loss.vary2, col='red')
# break even
abline(h=0, lty='dashed', col='gray')
legend("topleft", legend=c("p0=.10","p0=.05"), col=c('black', 'red'), lty="solid")

 
costs <- seq(50, 250, length=100)
costs.vary1 <- rosi(p0=0.1, ps=0.01, l=2000, s=costs)
costs.vary2 <- rosi(p0=0.1, ps=0.01, l=1000, s=costs)

# copy pasta but this time add ylim parameter
plot(x=costs,
     y=costs.vary1,
     type='l',
     xlab='Cost of antivirus',
     ylab='ROSI',
     main='ROSI for antivirus with varying costs',
     cex=2,
     ylim = c(
       min(costs.vary1, costs.vary2), 
       max(costs.vary1, costs.vary2))
    )

lines(x=costs, y=costs.vary2, col=2)
abline(h=0, col='gray', lty="dashed")
legend("topright",legend=c("$2K loss", "$1K loss"), col=c("black", "red"), lty="solid")
      
#Net Present Value, fixed for legibility
npv <- function(r, c0, ct, ALE0, ALEs, tmax=10) {
  a <- (ALE0-ALEs-ct)
  b <- (1+r)^(1:tmax)
  -c0+sum(a/b)
}

# If the return is 5% calculate  DLP
npv(r=.05, c0=15, ct=1, ALE0=5, ALEs=2)

# Same for User Training, also do not have to specify the param as long as it is in order
npv(.05, 6, 3, 5, 1)

# calculate IRR for DLP
# solve for R
irr_dlp <- uniroot(
  npv,
  interval=c(.01,.25),
  c0=15,
  ct=1,
  ALE0=5,
  ALEs=2
  )$root

# Same for user training, also can be formated differently
irr_tr <- uniroot( npv, c(.01,.25), 6, 3, 5, 1 )$root