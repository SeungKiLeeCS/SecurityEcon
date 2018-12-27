# Finding Optimal Filter Configuration

# Given -< cost of false neg, cost of false pos, prob of malware >-
C.beta <- 100
C.alpha <- 100

pseq = seq(0, 1, 0.01)

P.malware <- pseq

# Config A
A.alpha <- 0.2
A.beta <- 0.5

# Config B
B.alpha <- 0.6
B.beta <- 0.1

# Compute expected Cost for both config

C.Config <- function(alpha, beta, p = P.malware, cost_a = C.alpha, cost_b = C.beta) {
    ((p * beta * cost_b)) + ((1-p) * alpha * cost_a)
}

C.Conf.A <- C.Config(A.alpha, A.beta)
C.Conf.B <- C.Config(B.alpha, B.beta)

# paste("Config A | Config B")
# paste(C.Conf.A, C.Conf.B)
ifelse (C.Conf.A < C.Conf.B, paste(C.Conf.A), paste("Config B Prefered from here"))

# paste(C.Conf.A)
# paste(C.Conf.B)

# if (C.Conf.A > C.Conf.B) {
#     paste("Config B is Cheaper with $", C.Conf.B, "< $", C.Conf.A)
# } else if (C.Conf.A == C.Conf.B) {
#     paste("Choose Whatever. They are the same for $", C.Conf.A)
# } else {
#     paste("Config A is Cheaper with $", C.Conf.A, "< $", C.Conf.B)
# }


# Continuous ROC Curves

# Calculate Slope
m.roc.c <- function(p, a, b) {
    ((1-p)*a) / p*b
}