#### ON ABOUND ####

library(dplyr)
library(ggplot2)
library(plyr)
library(reshape2)
library(gridExtra)

load("~/R/sulfuryl_fluoride/sf_data.rda")

sf_data <- sf_data %>%
    dplyr::mutate(lbs_per_applic = lbs_chm_used / applic_cnt)

ggplot(sf_data, aes(x = applic_cnt)) +
    geom_density() +
    facet_grid(~year) +
    ggtitle("Distribution of Num. Sulfuryl Fluoride Applications by Year")

ggplot(sf_data, aes(x = lbs_per_applic)) +
    geom_density() +
    facet_grid(~year) +
    ggtitle("Distribution of Num. Sulfuryl Fluoride Applications by Year")


ggplot(sf_data %>%
       group_by(year) %>%
       dplyr::summarise(num_applications = sum(applic_cnt, na.rm = TRUE)),
       aes(x = as.factor(year), y = num_applications, fill = as.factor(year))) +
    geom_bar(stat = "identity")

sf_data %>% group_by(year) %>% dplyr::summarise(av_lbs_per_applic = mean(lbs_per_applic, na.rm = TRUE))

