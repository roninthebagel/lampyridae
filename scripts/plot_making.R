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

# saving lampyridae scatter plot
ggsave("figures/lampyridae_scatter_alpha.pdf", 
       plot = lampyridae_scatter_alpha, 
       width = 25,
       height = 15, 
       units = "cm", 
       device = "pdf") 

# making a violin plot
lampyridae_violin_alpha <- lampyridae_only |> # stating new plot name and required dataset
  ggplot(aes(x = habitat, # stating which column to include for x axis
             y = g5_lampyridae)) + # stating which column to include for y axis
  geom_violin(width = 0.5) + # stating what plot to use (violin), as well as width of plotted "violins"
  labs(title = "Lampyridae", # adding plot title
       x = "Habitat", # specifying x axis title
       y = "Number of Individuals", # specifying y axis title
       caption = "The number of individals of the Lampyridae Family found across different habitats") + # adding a plot caption
  scale_x_discrete(labels = c("Deciduous forest","Highly disturbed 
                              tropical dry forest", "Moderately disturbed 
                              tropical dry forest", "Preserved 
                              tropical dry forest")) + # modifying x axis labels (mainly to fit on multiple lines)
  theme_bw() + # making theme black and white (changes background and plot colours)
  theme(panel.border = element_rect(color="black"), # making primary plot border colour black
        axis.text = element_text(size = 10, angle = 45, hjust = 1), # resizing, adjusting angle, and moving axis labels
        axis.title = element_text(size = 15), # resizing axis title
        plot.caption = element_text(hjust = 0)) # resizing plot caption
print(lampyridae_violin_alpha) # printing plot into plots area

# saving lampyridae violin plot
ggsave("figures/lampyridae_violin_alpha.pdf", 
       plot = lampyridae_violin_alpha, 
       width = 25,
       height = 15, 
       units = "cm", 
       device = "pdf") 

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

# saving lampyridae bar plot
ggsave("figures/lampyridae_summary_bar_alpha.pdf", 
       plot = lampyridae_bar_alpha, 
       width = 25,
       height = 15, 
       units = "cm", 
       device = "pdf") 

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

# saving lampyridae scatter plot
ggsave("figures/total_violin_alpha.pdf", 
       plot = total_violin_alpha, 
       width = 25,
       height = 15, 
       units = "cm", 
       device = "pdf") 

# combined plot
combined_violin_beta <- lampyridae_complete |> # stating new plot name and required dataset
  ggplot(aes(x = habitat, # stating which column to include for x axis
             y = g5_lampyridae)) + # stating which column to include for y axis
  geom_violin(aes(colour = count_type), width = 1) + # stating what plot to use (violin), as well as width of plotted "violins"
  labs(title = "Lampyridae VS All Found Individuals", # adding plot title
       x = "Habitat", # specifying x axis title
       y = "Number of Individuals", # specifying y axis title
       caption = "The number of individals of the Lampyridae Family against the total number of individuals of all Coleoptera families, found across different habitats") + # adding a plot caption
  scale_x_discrete(labels = c("Deciduous forest","Highly disturbed
                              tropical dry forest", "Moderately disturbed
                              tropical dry forest", "Preserved
                              tropical dry forest")) + # modifying x axis labels (mainly to fit on multiple lines)
  scale_color_manual(name = "Family Count", labels = c("Lampyridae", "All Families"), values = c("cornflowerblue", "coral")) +
  theme_bw() + # making theme black and white (changes background and plot colours)
  theme(panel.border = element_rect(color="black"), # making primary plot border colour black
        axis.text = element_text(size = 10, angle = 45, hjust = 1), # resizing, adjusting angle, and moving axis labels
        axis.title = element_text(size = 15, vjust = -5), # resizing axis title
        legend.text = element_text(size = 10), # resizing legend text
        legend.title = element_text(size = 15), # resizing legend title
        plot.caption = element_text(hjust = 1)) # resizing plot caption
print(combined_violin_beta) # printing plot into plots area

# saving lampyridae scatter plot
ggsave("figures/combined_violin_beta.pdf", 
       plot = combined_violin_beta, 
       width = 25,
       height = 15, 
       units = "cm", 
       device = "pdf") 

# alternatively, the two plots side by side

duo_plot_beta <- lampyridae_violin_alpha + total_violin_alpha
print(duo_plot_beta)

# saving lampyridae scatter plot
ggsave("figures/duo_plot_beta.pdf", 
       plot = duo_plot_beta, 
       width = 25,
       height = 15, 
       units = "cm", 
       device = "pdf") 
