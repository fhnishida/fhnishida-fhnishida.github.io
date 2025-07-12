y1 = mtcars$mpg
x1 = mtcars$hp

linregfun1 = function(a, b, sigma) {
  yhat = a + b * x
  -sum(dnorm(y, mean=yhat, sd=sigma, log=TRUE))
}

test = mle2(linregfun1, start=list(a=0, b=0, sigma=1), data=list(y=y1, x=x1))
summary(test)




# ##########################################
# Load necessary libraries
library(tidyverse)

# Define the number of bootstrap samples
nboot <- 1000

# Load data
data(mtcars)
data(gpa1, package="wooldridge")

# Define the model formula
formula <- colGPA ~ hsGPA + ACT

# Fit the initial model
fit <- lm(formula, data = gpa1)

# Extract the coefficients
coefs <- coef(fit)

# Create a matrix to store the bootstrap results
boot_coefs <- matrix(NA, nrow = nboot, ncol = length(coefs))
colnames(boot_coefs) <- names(coefs)

# Perform bootstrapping
# set.seed(123)
for (i in 1:nboot) {
  # Sample the data with replacement
  boot_data <- gpa1[sample(nrow(gpa1), replace = TRUE), ]

  # Fit the model on the bootstrapped data
  boot_fit <- lm(formula, data = boot_data)

  # Store the coefficients
  boot_coefs[i, ] <- coef(boot_fit)
}

# Calculate the standard errors for each coefficient
se_boot <- apply(boot_coefs, 2, sd)

# Print the results
se_boot


summary(lm(formula, data = gpa1))$coef
nrow(gpa1)


# (d) An advantage of (full observations) bootstrap is that it doesn't make
# specific distributional assumptions, so it can be more precise than other
# standard errors in case that the data represent the actual underlying
# distribution well. Which, if you so wish, is the assumption of bootstrap.

# (e) Bootstrap can be very unstable if the dataset is small; it can also be
# unstable if there are not enough bootstrap replicates.

# (d) An advantage of (full observations) bootstrap is that it doesn't make
# specific distributional assumptions, so it can be more precise than other
# standard errors in case that the data represent the actual underlying
# distribution well. Which, if you so wish, is the assumption of bootstrap.

# (e) Bootstrap can be very unstable if the dataset is small; it can also be
# unstable if there are not enough bootstrap replicates.
