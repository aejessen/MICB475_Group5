library(tidyverse)
library(broom)
library(grid)
library(checkmate) 
library(abind)
library(forestplot)
# Turn the stunting variable into 1's and 0's, where 1 is associated with the 
# event happening (Normal = 0, Stunted = 1)

metadata <- read.delim(file = "QIIME2/anemia/anemia_metadata_updated.txt")

metadata01 <- metadata %>%
  select(anemia, stunting)

metadata01 <- metadata01 %>%
  mutate(stunting = ifelse(stunting == "Normal",0,1))

# Turn the column containing the independent variable into a factor and assign 
# the reference
metadata01$anemia <- relevel(factor(metadata01$anemia), ref = "normal")
# Create the logistic regression model (e.g., here, have included biological sex 
# and age_diagnosis as potential confounding variables here.)
model <- glm(stunting ~ anemia, family = binomial, data = metadata01)
#Clean the logistic regression model into a version we can easily interpret
model <- tidy(model, conf.int = T, exp = T)
model

# How to interpret the output and present the data:
## Look at the row which contains the dataset name followed by the input of the 
## independent factor that was NOT the reference (e.g., here, it would be 
## datasetpresent)
## The estimate represents the odds ratio (i.e., an estimate of 2 means that 
## individuals with compound A present have a 2 times higher likelihood (or 
## higher odds) of having renal disease compared to those who don't have it present).
## The data should be organized into a table containing a column for the 
## "Adjusted OR (95% CI) and "P-value". Alternatively, it can be presented as a 
## forest plot. 


