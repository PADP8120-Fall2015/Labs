
## What about a census?

Let's say we are studying the 50 states. Do these assumptions make sense in that case?


## "empirical" and "structural" relationships

Imagine that the true data generating process is
$$income = \beta_0 + \beta_1 educ + \beta_2 height + \epsilon$$

If we estimate
$$income = \beta_0 + \beta_1' educ + \epsilon$$
  
  What is relationship between $\beta_1'$ and $\beta$? Do we care?

##

Algebra from Fox shows:
$$\beta_1' = \beta_1 + bias$$
  where
$$bias = \beta_2 \frac{\sigma_{12}}{\sigma_1^2}$$
  
  If you want to estimate the parameter in the data generating process, you need to know the data generating process.

## measurement error on outcome and predictors

- random measurement error in $X$ biases $\beta_1$ toward 0
- random measurement error in $Y$ does not introduce bias in coefficients (goes into $\epsilon$)


# Outliers and Diagnostics

## What is an outlier? 

<div class="columns-2">
  ![outliers](http://marcoghislanzoni.com/blog/wp-content/uploads/2013/10/outliers_gladwell.jpg)

**Outlier** is a general term to describe a data point that doesn't follow the
pattern set by the bulk of the data, when one takes into account the model.
</div>

Calling a point an outlier is vague. 
* Outliers can be the result of spurious or real processes.
* Outliers can have varying degrees of influence.
* Outliers can conform to the regression relationship (i.e being marginally outlying in X or Y, but not outlying given the regression relationship).


## Outlier Example One

```{r, echo=FALSE, warning=FALSE, message=FALSE}
# this chunk sets the chunk options for the whole document
require(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)
```

```{r, echo=FALSE}
library(openintro)
COL <- c('#55000088','#225588')
set.seed(238)
n <- c(50, 25, 78, 55, 70, 150)
m <- c(12, -4, 7, -19, 0, 40)
xr <- list(0.3, c(2), 1.42, runif(4,1.45,1.55), 5.78, -0.6)
yr <- list(-4, c(-8), 19, c(-17,-20,-21,-19), 12, -23.2)
i <- 1
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)
```


## Outlier Example Two

```{r, echo=FALSE}
i <- 2
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)
```


## Outlier Example Three

```{r, echo=FALSE}
i <- 3
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)
```


## Outlier Example Four

```{r, echo=FALSE}
i <- 5
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)
```


## Outlier Example Four

```{r, echo=FALSE}
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x[1:70], y[1:70], col = COL[2], lCol = COL[1], lwd = 3, xlim = range(x), ylim = range(y))
```


## Outliers, leverage, influence

**Outliers** are points that don't fit the trend in the rest of the data.

**High leverage points** have the potential to have an unusually large influence 
on the fitted model.

**Influential points** are high leverage points that cause a very different
line to be fit than would be with that point removed.



## The linear model
* Specified as $Y_i =  \sum_{k=1}^p X_{ik} \beta_j + \epsilon_{i}$
* We'll also assume here that $\epsilon_i \stackrel{iid}{\sim} N(0, \sigma^2)$
  * Define the residuals as
$e_i = Y_i -  \hat Y_i =  Y_i - \sum_{k=1}^p X_{ik} \hat \beta_j$
  * Our estimate of residual variation is $\hat \sigma^2 = \frac{\sum_{i=1}^n e_i^2}{n-p}$, the $n-p$ so that $E[\hat \sigma^2] = \sigma^2$
  
  ```{r, fig.height = 5, fig.width = 5}
data(swiss); par(mfrow = c(2, 2))
fit <- lm(Fertility ~ . , data = swiss); plot(fit)
```


## Influential, high leverage and outlying points
```{r, fig.height = 5, fig.width=5, echo = FALSE, results='hide'}
n <- 100; x <- rnorm(n); y <- x + rnorm(n, sd = .3)
plot(c(-3, 6), c(-3, 6), type = "n", frame = FALSE, xlab = "X", ylab = "Y")
abline(lm(y ~ x), lwd = 2)
points(x, y, cex = 2, bg = "lightblue", col = "black", pch = 21)
points(0, 0, cex = 2, bg = "darkorange", col = "black", pch = 21)
points(0, 5, cex = 2, bg = "darkorange", col = "black", pch = 21)
points(5, 5, cex = 2, bg = "darkorange", col = "black", pch = 21)
points(5, 0, cex = 2, bg = "darkorange", col = "black", pch = 21)
```

* Upper left hand point has low leverage, low influence, outlies in a way not conforming to the regression relationship.
* Lower left hand point has low leverage, low influence and is not to be an outlier in any sense.
* Upper right hand point has high leverage, but chooses not to extert it and thus would have low actual influence by conforming to the regresison relationship of the other points.
* Lower right hand point has high leverage and would exert it if it were included in the fit.

## Example of high leverage, high influence

We can data on the surface temperature and light intensity of 47 stars in the
star cluster CYG OB1, near Cygnus.

```{r, echo=FALSE}
library(faraway)
data(star)
par(mar=c(4,4,2,1), las=1, mgp=c(2.5,0.7,0), cex.lab = 1.25, cex.axis = 1.25)
plot(light ~ temp, data = star, pch=19, col=COL[2], xlab = "log(temp)", ylab = "log(light intensity)")
```


## Example of high leverage, high influence

We can data on the surface temperature and light intensity of 47 stars in the
star cluster CYG OB1, near Cygnus.

```{r, echo=FALSE}
par(mar=c(4,4,2,1), las=1, mgp=c(2.5,0.7,0), cex.lab = 1.25, cex.axis = 1.25)
plot(light ~ temp, data = star, pch=19, col=COL[2], xlab = "log(temp)", ylab = "log(light intensity)")
abline(lm(light~temp, data = star), col = "darkgreen", lwd = 3, lty = 2)
legend("top", inset = 0.05, "w/ outliers", lty = 2, lwd = 2, col = "darkgreen")
```


## Example of high leverage, high influence

We can data on the surface temperature and light intensity of 47 stars in the
star cluster CYG OB1, near Cygnus.

```{r, echo=FALSE}
par(mar=c(4,4,2,1), las=1, mgp=c(2.5,0.7,0), cex.lab = 1.25, cex.axis = 1.25)
plot(light ~ temp, data = star, pch=19, col=COL[2], xlab = "log(temp)", ylab = "log(light intensity)")
abline(lm(light~temp, data = star), col = "darkgreen", lwd = 3, lty = 2)
abline(lm(light[temp>4]~temp[temp>4], data = star), col = COL[1], lwd = 3)
legend("top", inset = 0.05, c("w/ outliers","w/o outliers"), lty = c(2,1), lwd = c(2,3), col = c("darkgreen",COL[1]))
```


## Example of high leverage, low influence

```{r, echo=FALSE}
set.seed(12)
i <- 2
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
y <- y - mean(y)
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)
```


## Quantifying leverage: $h_{ii}$ {.build}

We need a metric for the leverage of $x_i$ that incorporates

1. The distance $x_i$ is away from the bulk of the $x$'s.
2. The extent to which the fitted regression line is attracted by the given point.

\[ h_{ii} = \frac{1}{n} + \frac{(x_i - \bar{x})^2}{\sum_{j = 1}^n(x_j - \bar{x})^2} \]


## $h_{ii}$ values

```{r, echo=FALSE, fig.height=6, fig.width=7, fig.align='center'}
m1 <- lm(y ~ x)
plot(x, y, col = COL[2], pch = 16)
abline(m1, col = COL[1], lwd = 3)
h <- lm.influence(lm(y ~ x))$hat
for(i in c(1, 16, 25, 26)) {
text(x[i], y[i] + .3, round(h[i], 2))
}
```


## What is "high" leverage?

**Rule of Thumb**: in simple regression, a point has "high leverage" if
$h_{ii} > 4/n$.

```{r, fig.height=3.5, echo=1:2}
m1 <- lm(y ~ x)
h <- lm.influence(lm(y ~ x))$hat
hist(h)
abline(v = 4/length(y), col = "red")
```


## From leverage to influence

**Leverage** measures the weight given to each point in determining the regression
line.

**Influence** measures how different the regression line would be without a given
point.

```{r, echo=FALSE, fig.height=4, }
i <- 5
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mfrow = c(1, 2))
plot(x, y, col = COL[2], pch = 16)
abline(lm(y ~ x), col = COL[1], lwd = 3)
x2 <- x[1:70]
y2 <- y[1:70]
plot(x2, y2, col = COL[2], pch = 16, xlim = range(x), ylim = range(y))
abline(lm(y2 ~ x2), col = COL[1], lwd = 3)
```

## Influence measures
* Do `?influence.measures` to see the full suite of influence measures in stats. The measures include
* `rstandard` - standardized residuals, residuals divided by their standard deviations)
* `rstudent` - standardized residuals, residuals divided by their standard deviations, where the ith data point was deleted in the calculation of the standard deviation for the residual to follow a t distribution
* `hatvalues` - measures of leverage
* `dffits` - change in the predicted response when the $i^{th}$ point is deleted in fitting the model.
* `dfbetas` - change in individual coefficients when the $i^{th}$ point is deleted in fitting the model.
* `cooks.distance` - overall change in teh coefficients when the $i^{th}$ point is deleted.
* `resid` - returns the ordinary residuals
* `resid(fit) / (1 - hatvalues(fit))` where `fit` is the linear model fit returns the PRESS residuals, i.e. the leave one out cross validation residuals - the difference in the response and the predicted response at data point $i$, where it was not included in the model fitting.


## How do I use all of these things?
* Understand what diagnostic tools are trying to accomplish and use them judiciously.
* Not all of the measures have meaningful absolute scales. You can look at them relative to the values across the data.
* They probe your data in different ways to diagnose different problems. 
* Patterns in your residual plots generally indicate some poor aspect of model fit. These can include:
* Heteroskedasticity (non constant variance).
* Missing model terms.
* Temporal patterns (plot residuals versus collection order).
* Residual QQ plots investigate normality of the errors.
* Leverage measures (hat values) can be useful for diagnosing data entry errors.
* Influence measures get to the bottom line, 'how does deleting or including this point impact a particular aspect of the model'.

## Case 1
```{r, fig.height=5, fig.width=5, echo=FALSE}
x <- c(10, rnorm(n)); y <- c(10, c(rnorm(n)))
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
abline(lm(y ~ x))            
```

* The point `c(10, 10)` has created a strong regression relationship where there shouldn't be one.

## Showing a couple of the diagnostic values
```{r}
fit <- lm(y ~ x)
round(dfbetas(fit)[1 : 10, 2], 3)
round(hatvalues(fit)[1 : 10], 3)
```

## Case 2
```{r, fig.height=5, fig.width=5, echo=FALSE}
x <- rnorm(n); y <- x + rnorm(n, sd = .3)
x <- c(5, x); y <- c(5, y)
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
fit2 <- lm(y ~ x)
abline(fit2)            
```


## Looking at some of the diagnostics
```{r, echo = TRUE}
round(dfbetas(fit2)[1 : 10, 2], 3)
round(hatvalues(fit2)[1 : 10], 3)
```


## Example described by Stefanski TAS 2007 Vol 61.
```{r, fig.height=4, fig.width=4}
## Don't everyone hit this server at once.  Read the paper first.
dat <- read.table('http://www4.stat.ncsu.edu/~stefanski/NSF_Supported/Hidden_Images/orly_owl_files/orly_owl_Lin_4p_5_flat.txt', header = FALSE)
pairs(dat)
```

## Got our P-values, should we bother to do a residual plot?
```{r}
summary(lm(V1 ~ . -1, data = dat))$coef
```


## Residual plot
### P-values significant, O RLY?
```{r, fig.height=4, fig.width=4, echo = TRUE}
fit <- lm(V1 ~ . - 1, data = dat); plot(predict(fit), resid(fit), pch = '.')
```

## Back to the Swiss data
```{r, fig.height = 5, fig.width = 5, echo=FALSE}
data(swiss); par(mfrow = c(2, 2))
fit <- lm(Fertility ~ . , data = swiss); plot(fit)
```


## 

compare and contrast outliers, leverage, and influence. 

## { .build }

Influence = Leverage x Discrepancy

<img src="images/fox_applied_2008_fig11_1.png" width=500>
  
  <div class="cite">
  From [Fox (2008)](http://socserv.socsci.mcmaster.ca/jfox/Books/Applied-Regression-2E/index.html) Chapter 11 
</div>
  
  ##  { .build }
  
  Use the words influence, leverage, and discrepancy to describe what is happening in this image.

<img src="images/jackman_outlier.png" width=300>
  
  South Africa has high leverage because it is far from the other data and it is discrepent from the rest of the data.  Therefore, South Africa has a huge influence on the regression coefficient.

<div class="cite">
  From [Healy and Moody (2014)](http://kieranhealy.org/files/papers/data-visualization.pdf) from [Jackman (1980)](http://www.jstor.org/stable/pdf/2095134.pdf?acceptTC=true) 
</div>
  
  ## 
  
  Use the words influence, leverage, and discrepancy to describe what is happening in this image.

<img src="images/fox_applied_2008_fig11_2.png" width=500>
  
  <div class="cite">
  From [Fox (2008)](http://socserv.socsci.mcmaster.ca/jfox/Books/Applied-Regression-2E/index.html) Chapter 11 
</div>
  
  