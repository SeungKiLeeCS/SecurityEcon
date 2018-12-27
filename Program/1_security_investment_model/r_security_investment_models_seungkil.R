# # SeungKi Lee

# ##################
# # Main Functions #
# ##################

# # Expected Probability of Breach given Security level, Inherant Vulnerabilty, and beta for distribution
# # Beta defaulted to 5
# # V = Loss
# # S = current level of security
# P.breach <- function( sec, vuln, beta = 5 ) {
#     vuln * beta^(-sec)
# }

# # Expected Net Benefit
# # Vulnerability - Prob of Breach - Security Level
# # enbis will vary, not linearly, depending on sec and vuln.
# # Therefore, simply increasing security investment will not yield the most benefit.
# enbis <- function( sec, vuln, beta = 5 ) {
#     vuln - P.breach(sec, vuln, beta) - sec
# }

# # Sequence of Value
# sseq <- seq(0, 1, by = 0.01)


# #####################
# # Utility Functions #
# #####################

# get_min <- function(first, second) {
#     min(
#         c(first, second)
#     )
# }

# get_max <- function(first, second) {
#     max(
#         c(first, second)
#     )
# }

# get_enbis <- function(Vulnerability) {
#     enbis(sseq, Vulnerability, 5)
# }

# ##################################################
# # Visualizing Utility & Optimal Investment Level #
# ##################################################

# # 1st.Vulnerability = 100%
# # 2nd.Vulnerability = 85%

# # Plotting
# # Two Enbis
# plot(
#     y = get_enbis(1),
#     x = sseq,
#     type = 'l',
#     ylab = "ENBIS",
#     xlab = "Sequence"
# )

# # Lines command will plot on top of the existing plot.
# lines(
#     y = get_enbis(0.85),
#     x = sseq,
#     type = 'l',
#     lty = 2
# )

# # Second Plot
# plot(
#     y = get_enbis(1),
#     x = sseq,
#     type = 'l',
#     ylim = c(
#         get_min(get_enbis(0.85), get_enbis(1)),
#         get_max(get_enbis(0.85), get_enbis(1))
#         ),
#     ylab = "Security Level (S)",
#     xlab = "ENBIS"
# )

# lines(
#     y = get_enbis(0.85),
#     x = sseq,
#     type = 'l',
#     lty = 2
# )

# legend(
#     "topright",
#     c("v = 1", "v = 0.85"),
#     lty = 1:2
# )

# # First Order Condition

# S.foc <- function(beta = 5, vuln) {
#     log( vuln * log(beta) ) / log(beta)
# }

# abline(
#     v = S.foc(5,1),
#     lty = 1,
#     col = 'red'
# )

# abline(
#     v = S.foc(5,0.825),
#     lty = 2,
#     col= 'blue'
# )

# # Plot Values of FOC for a range of beta values while holding the vulnerability. Let v = 0.85 for different value of v.
# # There are some range of beta values where you are indefensible -> When optimal investment level is negative

# vulnerability <- 0.7

# # Create Sequence that will start from indefensible range (exp(1/v)) to a large value in beta (64)
# # Determine Security Productivity (Effficiency?) for this range
# secpro <- seq( exp(1/vulnerability), 64, length = 101)

# plot(
#     # ForEach i in secpro, given the same vulnerability
#     y = S.foc(secpro, vulnerability),
#     x = secpro,
#     type = 'l',
#     # Do not display negative
#     xlim = c(1, 64),
#     ylab = 'Optimal Investment Level',
#     xlab = 'Security Productivity BETA'
# )

# The plot with v = 0.85 has it's optimum point slightly right of the v = 1 plot.
# Also, it seems that the diminishing return is much mitigated.
# I predict that with a much lower value of v, the optimum will shift all the way to the right.

#############
# Dataframe #
#############

# #put the x and y data into a data frame for comparison
# sdf <- data.frame(secpro, S.foc(secpro, vulnerability))
# # rename the column
# names(sdf) <- c("beta","S.opt")

# # get the security productivity with the largest optimal security level
# # from sdf -> get security productivity level | S.opt == max(S.opt)
# # Logical vectors are extension of the boolean vectors created by its comparison logic
# # Effectively a `filter` function from python.
# sdf$beta[sdf$S.opt==max(sdf$S.opt)]

# # get the security productivity levels where the optimal investment is less than 25%
# sdf$beta[sdf$S.opt<=0.25]

# # get the optimal investment levels and corresponding productivities for breach productivities >30
# # Do you mean security productivity beta?
# # Why comma? -> no need to specify the column with `$`, but just need to use comma to indicate `all values` of the df.
# sdf[sdf$beta > 30,]

# # calculate the enbis for the optimal investment level and beta, add as a column to the data frame
# # Adding a column to df is like adding a member data to a struct.
# # df$new_col_name <- operation to create the column
# sdf$enbis <- enbis(sdf$S.opt, 1, sdf$beta)

# # Confirm it prints with 3 columns
# sdf


######################
#Homework 2 Work Code#
######################

# C.opt <- function(beta, v, lambda=100) {
#   (beta * v * lambda)^(1/(beta+1)) - 1
# }

# vseq <- seq(0, 1, by = 0.01)

# # Get C.opt
# get_copt <- function(b) {
#     C.opt(beta=b, v = vseq)
# }

# # Plotting
# # Two Enbis
# plot(
#     y = get_copt(2),
#     x = vseq,
#     type = 'l',
#         ylim = c(
#         0.65,
#         get_max(get_copt(2), get_copt(3))
#         ),
#     ylab = "Optimal Investment (c*)",
#     xlab = "Vulnerability (v)"
# )

# # Lines command will plot on top of the existing plot.
# lines(
#     y = get_copt(3),
#     x = vseq,
#     type = 'l',
#     lty = 2
# )

# legend(
#     "topleft",
#     c("beta = 2", "beta = 3"),
#     lty = 1:2
# )


# enb.b1 = enbis(sec = 4.848, vuln = 1, beta = 2)
# enb.b2 = enbis(sec = 3.162, vuln = 1, beta = 3)

# paste(enb.b1)
# paste(enb.b2)

# ia <- seq(0, 1, 0.1)
# ib <- c(0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.9, 0.9, 0.9, 1, 1)

# rocb <- stepfun(1:10, ib, f=0)
# plot(rocb, ylim=c(0, 1.0), ylab="1-beta", xlab="alpha", xaxt="n", main="Discrete ROC Curve")
# axis(1, at=c(0,1,2,3,4,5,6,7,8,9,10), labels=c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0))

# # Plot in millions, increase by 1 milion
# lseq = seq(100, 100000, 1)

# # probability of breakeven point as a function of loss value = C.911, cost C.door = 40milion, and risk reduction reduc
# P.breakeven <- function(C.911, C.door = 40, reduc) {
#   (C.door/C.911) + reduc
# }

# get_pbe <- function(risk.reduction) {
#   P.breakeven(C.911 = lseq, C.door=20, reduc = risk.reduction)
# }

# plot(
#     y = get_pbe(0.25),
#     x = lseq,
#     type = 'l',
#     log = "y",
#     lty = 1,
#     xaxt="n",
#     ylab = "Breakeven Probability (p0)",
#     xlab = "Expected Loss in Millions",
#     main = "Breakeven Probability for Range of Loss",
#     sub = "Loss Range $100M : $100B",
#     ylim=c(0.1, 0.6)
# )

# axis(
#     1, 
#     at=c(0e+00, 2e+04, 4e+04, 6e+04, 8e+04, 1e+05), 
#     labels=expression(0, 2%*%10^4, 4%*%10^4, 6%*%10^4, 8%*%10^4, 1%*%10^5) 
# )

# # plot(
# #     y = get_pbe(0.25),
# #     x = lseq,
# #     type = 'l',
# #     log = "xy",
# #     lty = 1,
# #     xaxt="n",
# #     ylab = "Breakeven Probability (p0)",
# #     xlab = "Expected Loss in Millions",
# #     main = "Breakeven Probability for Range of Loss",
# #     sub = "Loss Range $100M : $100B",
# #     ylim=c(0.1, 0.6)
# # )

# # axis(
# #     1, 
# #     at=c(1e+02, 5e+02, 1e+03, 5e+03, 1e+04, 5e+04, 5e+05 ), 
# #     labels=expression(100, 500, 1000, 5000, 10000, 50000, 500000) 
# # )

# lines(
#     y = get_pbe(0.4),
#     x = lseq,
#     type = 'l',
#     log = "y",
#     lty = 3
# )

# lines(
#     y = get_pbe(0.1),
#     x = lseq,
#     type = 'l',
#     log = "y",
#     lty = 5
# )

# legend(
#     "topright",
#     c("Reduction = 0.1", "Reduction = 0.25", "Reduction = 0.4"),
#     lty = c(5,1,3)
# )
