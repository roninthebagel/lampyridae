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
# but there are missing values highlighted by this command as represented by #N/A


# checking lampyridae count column
lampyridae_clean_names |>  
  distinct(g5_lampyridae)
# no typos under count column
# but there are missing values highlighted by this command as represented by #N/A

# missing values will not be highlighted becaused of this character, need to remove the #


### --- checking for duplications --- ###

# check for duplicates across whole dataset
# rows in the data
lampyridae_clean_names |> 
  duplicated() |>  
  sum() 
# 30 duplicated rows

# inspecting the duplicated rows
lampyridae_clean_names |>
  dplyr::group_by(dplyr::across(everything())) |>
  dplyr::filter(dplyr::n() > 1) |>
  dplyr::ungroup() |> view()
# all the duplicated rows are completely empty rows - can be removed

# removing duplicated rows
lampyridae_no_dupes <- lampyridae_clean_names |> 
  distinct()

### --- handling missing data --- ###

# firstly removing rows where habitat column contains N/A values
lampyridae_complete <- subset(lampyridae_no_dupes, habitat !='N/A' )
# usually with data frames with high amounts of missing data, imputing the missing values with the mean would be the best option. but in this case it was a major categorical variable with missing data, so removing the rows was my only option

# checking for missing data
lampyridae_complete |>
  # Filter rows where g5_lampyridae is NA
  filter(is.na(g5_lampyridae)) |> 
  # Group by project_sample_id and habitat
  group_by(project_sample_id, habitat) |>                 
  summarise(n_missing = n())    
# 14 missing
# ~ 2% of data missing - can remove rows

# removing rows with missing data
lampyridae_end <- lampyridae_complete |> 
  drop_na(project_sample_id, habitat, g5_lampyridae, total_individuals)

# saving new dataset
write.csv(lampyridae_end, file = "data/lampyridae_tidy.csv")
