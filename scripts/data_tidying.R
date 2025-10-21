# reading csv file
lampyridae <- read.csv("data/lampyridae_counts.csv")

### --- looking at descriptive data --- ###

# looking at the data structure
glimpse(lampyridae)

# generating key initial summary statistics for each variable
# also includes frequencies for character variables to quickly understand data distribution
summary(lampyridae)

# per column summaries
# includes data types, missing data, and statistics
skimr::skim(lampyridae)

