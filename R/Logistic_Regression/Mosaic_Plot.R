library(dplyr)

meta <- read.delim("anemia_metadata_updated.txt") %>%
  filter(anemia != "Missing: Not collected", stunting != "Missing: Not collected")

count_table <- table(meta$anemia, meta$stunting)
row.names(count_table) <- c("Anemic", "Healthy")
colnames(count_table) <- c("Non-Stunted", "Stunted")
count_table

mosaicplot(count_table, color = c("lightcoral", "skyblue2"), 
          xlab = "Anemia Status", ylab = "Stunting Status", main = NULL)