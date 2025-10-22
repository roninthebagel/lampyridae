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
  group_by(habitat, count_type) |> 
  summarise(mean = mean(g5_lampyridae, na.rm =T),
            sd = sd(g5_lampyridae, na.rm=T))

### --- gamma diversity --- ###

# the total diversity of the ecosystem 

# total lampyridae and total diversities
lampyridae_summary_gamma <- lampyridae_complete |> 
  group_by(count_type) |> 
  summarise(mean = mean(g5_lampyridae, na.rm =T),
            sd = sd(g5_lampyridae, na.rm=T))
