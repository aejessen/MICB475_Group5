library(tidyverse)

# Assuming working dir in another folder next to the anemia folder
filepath <- "../anemia/anemia_metadata.txt"


# Two columns, 
# stunting : "Normal" or "Stunted"
# anemia : "normal" or "anemic"

# Final Values:
# "non-stunted_healthy", "non-stunted_anemic", "stunted_healthy", "stunted_anemic"
metadata_new <- read.delim(file= filepath) |>
      mutate(disease_state = 
                  ifelse((stunting == "Normal"),
                         ifelse((anemia == "normal"),
                               "non-stunted_healthy",
                               ifelse((anemia == "anemic"),
                                    "non-stunted_anemic",
                                    NA)),
                        ifelse((stunting == "Stunted"),
                              ifelse((anemia == "normal"),
                                    "stunted_healthy",
                                    ifelse((anemia == "anemic"),
                                          "stunted_anemic",
                                          NA)),
                              NA)))


# Writes a new .txt file to folder
write.table(metadata_new, "../anemia/anemia_metadata_updated.txt", 
            append = FALSE, 
            sep = "\t", 
            dec = ".",
            row.names = FALSE, 
            col.names = TRUE,
            quote = FALSE)

