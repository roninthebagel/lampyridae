### --- alpha diversity --- ###

# using lampyridae counts to measure abundances in each habitat

# filtering only lampyridae counts
lampyridae_only <- filter(.data = lampyridae_complete, 
                          count_type == "lampyridae")

# making a standard scatterplot to show spread of data
lampyridae_scatter_alpha <- lampyridae_only |>
  ggplot(aes(x = habitat, y = g5_lampyridae)) + 
  geom_point()
print(lampyridae_scatter_alpha)

# making a violin plot
lampyridae_violin_alpha <- lampyridae_only |> 
  ggplot(aes(x = habitat, 
             y = g5_lampyridae)) +
  geom_violin(width = 0.5) +
  labs(title = "Lampyridae")
print(lampyridae_violin_alpha)

# making a bar plot with standar error lines

# firstly have to generate statistics for the error lines
lampyridae_summary <- lampyridae_only |> 
  group_by(habitat) |> 
  summarise(mean = mean(g5_lampyridae, na.rm =T),
            sd = sd(g5_lampyridae, na.rm=T))

# making the bar plot
lampyridae_bar_alpha <- lampyridae_summary |>
  ggplot(aes(x = habitat, 
             y = mean))+
  geom_bar(stat = "identity")+
  geom_errorbar(aes(ymin = mean-sd,
                    ymax = mean+sd))
print(lampyridae_bar_alpha)

### --- beta diversity --- ###

# using lampyridae counts to measure abundances in each habitat, and comparing counts to total number of individuals across all families

# filtering out total data
totals_only <- filter(.data = lampyridae_complete, 
                      count_type == "total")

# making a violin plot to present total individual abundances

total_violin_alpha <- totals_only |> 
  ggplot(aes(x = habitat, 
             y = g5_lampyridae)) +
  geom_violin(width = 0.5) +
  labs(title = "Total")
print(total_violin_alpha)

# combined plot
combined_violin_beta <- lampyridae_complete |> 
  ggplot(aes(x = habitat, 
             y = g5_lampyridae)) +
  geom_violin(aes(colour = count_type), width = 0.5)
print(combined_violin_beta)

# alternatively, the two plots side by side

duo_plot_beta <- lampyridae_violin_alpha + total_violin_alpha
print(duo_plot_beta)