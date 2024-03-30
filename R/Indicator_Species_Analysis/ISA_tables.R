install.packages("data.table")
install.packages("formattable")
install.packages("tidyr")

library(tidyverse)
library(data.table)
library(dplyr)
library(formattable)
library(tidyr)

#Make a nicer table for species visualization
species_tbl <- read.table(file = "R/NEW_ISA_species_tbl.txt", header = TRUE) %>%
  rename("Anemic_only" = "s.non.stunted_anemic",
        "Healthy" = "s.non.stunted_healthy",
        "Anemic_and_Stunted" = "s.stunted_anemic",
        "Stunted_only" = "s.stunted_healthy")
species_tbl

formattable(species_tbl)

formattable(species_tbl, 
            align =c("l","c","c","c","c", "c", "c", "c", "c","c","c", "c", "c", "c","r"), 
            list(`ASV` = formatter(
              "span", style = ~ style(color = "grey",font.weight = "bold")) 
            ))

#Make a nicer table for genus visualization 
genus_tbl <- read.table(file = "R/NEW_ISA_genus_tbl.txt", header = TRUE) %>%
  rename("Anemic_only" = "s.non.stunted_anemic",
         "Healthy" = "s.non.stunted_healthy",
         "Anemic_and_Stunted" = "s.stunted_anemic",
         "Stunted_only" = "s.stunted_healthy")
genus_tbl

formattable(genus_tbl)

formattable(genus_tbl, 
            align =c("l","c","c","c","c", "c", "c", "c", "c","c","c", "c", "c", "c","r"), 
            list(`ASV` = formatter(
              "span", style = ~ style(color = "grey",font.weight = "bold")) 
            ))
