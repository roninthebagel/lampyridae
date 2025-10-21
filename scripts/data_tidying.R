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
# 42 duplicated rows

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

# checking for missing data
lampyridae_no_dupes |>
  # Filter rows where g5_lampyridae is NA
  filter(is.na(g5_lampyridae)) |> 
  # Group by project_sample_id and habitat
  group_by(project_sample_id, habitat) |>                 
  summarise(n_missing = n())    

# checking for missing data
lampyridae_no_dupes |>
  # Filter rows where culmen length is NA
  filter(is.na(habitat)) |> 
  # Group by species, sex and island
  group_by(g5_lampyridae) |>                 
  summarise(n_missing = n())    

# there is no missing data, but missing data recorded as N/A

# removing rows where habitat column contains N/A values
lampyridae_complete <- subset(lampyridae_no_dupes, habitat !='N/A' )


