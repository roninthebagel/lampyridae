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

### --- cleaning column names --- ###

# checking the data column names
colnames(lampyridae)
# column names inconsistent
# mix of capital letters and punctuation

# cleaning column names
lampyridae_clean_names <- janitor::clean_names(lampyridae)

# checking new column names
colnames(lampyridae_clean_names)
# names now standardised

### --- checking for typos --- ###

# prints each unique character string in the data 
# only needs to be checked in required categorical variable columns
# checking habitat column
lampyridae_clean_names |>  
  distinct(habitat)
# no typos under habitat column
# but there are missing values highlighted by this command

# checking lampyridae count column
lampyridae_clean_names |>  
  distinct(g5_lampyridae)
# no typos under count column
# but there are missing values highlighted by this command

