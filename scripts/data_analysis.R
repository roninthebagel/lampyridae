### --- alpha diversity --- ###

# generating stats for lampyridae vs habitat
lampyridae_summary_alpha <- lampyridae_only |> 
  group_by(habitat) |> 
  summarise(mean = mean(g5_lampyridae, na.rm =T),
            sd = sd(g5_lampyridae, na.rm=T))

lampyridae_alpha_shannon <- 

### --- beta diversity --- ###

# generating stats for lampyridae vs habitat and count type
lampyridae_summary_beta <- lampyridae_complete |> 
  # stating new save data frame name and required data set
  group_by(count_type, habitat) |> 
  # stating which columns to include in analysis, and what order to appear on table
  summarise(mean = mean(g5_lampyridae, na.rm =T), 
  # stating i want to calculate means using values from g5_lampyridae column
            sd = sd(g5_lampyridae, na.rm=T)) 
  # stating i want to calculate standard deviations using values from g5_lampyridae column 

# saving summmary table
write.csv(lampyridae_summary_beta, file = "data/lampyridae_summary_beta.csv")

### --- gamma diversity --- ###

# the total diversity of the ecosystem 

# total lampyridae and total diversities
lampyridae_summary_gamma <- lampyridae_complete |> # stating new save data frame name and required data set
  group_by(count_type) |> # stating which columns to include in analysis
  summarise(mean = mean(g5_lampyridae, na.rm =T), # stating i want to calculate means using values from g5_lampyridae column 
            sd = sd(g5_lampyridae, na.rm=T)) # stating i want to calculate standard deviations using values from g5_lampyridae column 
