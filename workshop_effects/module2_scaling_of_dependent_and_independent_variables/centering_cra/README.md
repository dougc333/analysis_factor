# Centering Data for effect sizes

Using the NLSY dataset, an uncentered regression says the 5933(rounded) intercept is the average physical health score for somebody with no education, no children, no depression symptoms and a zero mental health score. This person doesn't exist in the data so this isn't a meaningful intercept.

After centering, the model says the intercept 5110 is the average physical health score for someone with a HS diploma, no children, with an average level of depression and an average mental health score. And the data backs up this claim.

## Debugging Notes

remove type module from package.json to get npx ts-node hello.ts to work
npx tsx convertCSV_to_JSON.ts

## Reference

https://programs.theanalysisfactor.com/workshops-home/workshops/irc-2/scaling/
