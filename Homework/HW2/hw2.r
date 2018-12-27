ebis <- function(p0, l, ps) {
  p0*l - ps*l;
}

#ENBIS = Bernouilli assumption
enbis <- function(p0, l, ps, s) { 
  ebis(p0, l, ps)-s;
}

# making rosi 
rosi <- function(p0, l, ps, s) {
	enbis(p0, l, ps, s)/(s);
}	

#Net Present Value, fixed for legibility
npv <- function(r, c0, ct, ALE0, ALEs, tmax=10) {
  ebi <- (ALE0-ALEs-ct)
  depr <- (1+r)^(1:tmax)
  -c0+sum(ebi/depr)
}

# Optimal c

C.opt <- function(beta, v, lambda=1) {
  (beta * v * lambda)^(1/(beta+1)) - 1
}

vseq <- seq(0, 1, by = 0.01)

# Get C.opt
get_copt <- function(b) {
    C.opt(beta=b, v = vseq, 1)
}

# Plotting
# Two Enbis
plot(
    y = get_copt(2),
    x = vseq,
    type = 'l',
    ylab = "Optimal Investment (c*)",
    xlab = "Vulnerability (v)"
)

# Lines command will plot on top of the existing plot.
lines(
    y = get_copt(3),
    x = vseq,
    type = 'l',
    lty = 2
)

lseq = seq(100, 100000, 100)
# 20 mil
P.breakeven <- function(C.911, C.door = 20, reduc) {
  (C.door/C.911) + reduc
}

get_pbe <- function(risk.reduction) {
  P.breakeven(C.911 = lseq, C.door=20, reduc = risk.reduction)
}

plot(
    y = get_pbe(0.1),
    x = lseq,
    type = 'l',
    ylab = "Breakeven Probability (p0)",
    xlab = "Expected Loss in Millions"
)
