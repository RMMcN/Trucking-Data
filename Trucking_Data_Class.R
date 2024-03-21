library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(stringr)
library(farver)

rm(list = ls())
setwd("~/Trucking Data")

df_truck_0001 <- read_excel('truck data 0001.xlsx',
                       sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_0369 <- read_excel('truck data 0369.xlsx',
                            sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1226 <- read_excel('truck data 1226.xlsx',
                            sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1442 <- read_excel('truck data 1442.xlsx',
                            sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1478 <- read_excel('truck data 1478.xlsx',
                            sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1539 <- read_excel('truck data 1539.xlsx',
                            sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1769 <- read_excel('truck data 1769.xlsx',
                            sheet = 2, skip = 3, .name_repair = 'universal')
df_pay <- read_excel('Driver Pay Sheet.xlsx', .name_repair = "universal")


df <- rbind(df_truck_0001, df_truck_0369, df_truck_1226, df_truck_1442, df_truck_1478, df_truck_1539, df_truck_1769)


df_starting_pivot <- df %>%
  group_by(Truck.ID) %>%
  summarize(count = n())

df <- left_join(df, df_pay, by = c('Truck.ID'),)

df$total_miles_driven <- (df$Odometer.Ending - df$Odometer.Beginning)
df$total_salary <- df$total_miles_driven * df$labor_per_mil

df_total_salary_pivot <- df %>%
  group_by(Truck.ID, total_salary) %>%
  summarize()

ggplot(df_total_salary_pivot, aes(x = Truck.ID, y = total_salary, fill = as.factor(Truck.ID))) +
  geom_col() +
  scale_fill_manual(values = c("blue", "orange", "green", "red", "purple", "brown", "pink"))
  theme(axis.text = element_text(angle = 45, vjust =.5, hjust =1))
