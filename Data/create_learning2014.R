# Pinky Dutta
date()
## Data wrangling exercise for Regression and Modelling

# read data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Structure of the data
str(lrn14)

# Dimension of the data
dim(lrn14)

# The data is in the form of R's data.frame, with 183 rows as observations and 60 columns as variables

# import dplyr library
library(dplyr)

# pick deep related questions, find their mean and assign them to a new column "deep"
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# pick surface related questions, find their mean and assign them to a new column "surf"
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# pick strategic learning related questions, find their mean and assign them to a new column "stra"
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# only select the required columns from the whole lrn14 data
col_sel <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points", "genderN")

## select the 'col_sel' to create a new dataset
learning2014 <- select(lrn14, one_of(col_sel))

learning2014 <- filter(learning2014, Points > 0)
# select rows where Points is greater than zero

#check for dimension of the data. Expected 166 observations and 7 variables
dim(learning2014)

# Setting up working directory of R session into IODS project folder
setwd("~/Workspace/r-studio-projects/IODS-project")

# using csv" format would append a serial number column at the beginning of the data marked with variable $x,
# hence, decided to use table format
write.table(learning2014, "./Data/learning2020.table", append=FALSE)

# verify if we are able to read the file back
lrn2020 <- read.table("./Data/learning2020.table", header=TRUE)
str(lrn2020) # expected 166 obs of 7 vars
