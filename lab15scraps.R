
The data set below was scraped from a real estate website that lists homes for
sale.  All of the homes are in Los Angeles and we have recorded various
characteristics on each one.

```{r}
LA <- read.csv("http://andrewpbray.github.io/data/LA.csv")
```

Your task is to build a model to predict the price of a home using only its
square footage.  You're encouraged to use the flowchart on page 103 to guide you.

1. What is the equation for your final model?

2. How would you interpret the coefficient for square footage (the slope)?

3. Do you have any reservations about using this model?

4. Let's say I give you $1 million to break into the business of buying and 
selling homes.  How could you build a business strategy around this model?
That is, what homes would you choose to buy and what price would you try to 
re-sell them at?