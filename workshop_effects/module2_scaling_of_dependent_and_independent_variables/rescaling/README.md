# Rescaling data

If there are multiple predictor variables with different scales then the predictor variable with the larger scale has a tendency to dominate the model. For example if you have one varialble with a scale from 0-1 and another from 0-Millions then the one with the larger range will dominate. To reduce this bias, introduce scaling. 

Example with gestation data using births.csv

# gestation_days

gestation_days = gestation * 7

# bwt_pnds

Birth weight in pounds ; bwt_pnds = bwt/16

