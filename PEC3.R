library(tidyverse)

BCG_strain <- read_delim("task_2-BCG_strain_per_country-1Nov2020.csv", ",")
COVID <- read_delim("task_2-COVID-19-death_cases_per_country_after_fifth_death-till_22_September_2020.csv", 
                    ",")

COVID_BGC <- left_join(BCG_strain, COVID, by = "country_name")

plot(COVID_BGC$`BCG Atlas: Which year was vaccination introduced?`, COVID_BGC$deaths_per_million_150_days_after_fifth_death)

plot(COVID_BGC$`mandatory_bcg_strain_2015-2020` == "None", COVID_BGC$deaths_per_million_150_days_after_fifth_death)


ggplot(COVID_BGC, aes(country_name,as.numeric(deaths_per_million_150_days_after_fifth_death)))+
  geom_col()+theme(axis.text.x = element_blank())+
  facet_grid(~`mandatory_bcg_strain_1950-1960`)

model <- lm(as.numeric(COVID_BGC$`BCG Atlas: Which year was vaccination introduced?`) ~ as.numeric(COVID_BGC$deaths_per_million_150_days_after_fifth_death))

summary(model)
