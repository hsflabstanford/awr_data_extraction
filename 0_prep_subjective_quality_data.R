
data.dir = "~/Dropbox/Personal computer/Independent studies/2019/AWR (animal welfare review meat consumption)/Data extraction"

library(dplyr)
library(tidyverse)

setwd(data.dir)
setwd("Dual review of quality")
d3 = read_xlsx("subjective_data_reconciled.xlsx")


d3 = d3 %>% separate( `Exchangeability (DR/JN/MM/reconciled)`,
                      c("exch.DR", "exch.JN", "exch.MM", "qual.exch"),
                      sep = "/" ) %>% 
  separate( `Avoidance of differential social desirability bias and demand characteristics  (DR/JN/MM/reconciled)`,
            c("sdb.DR", "sdb.JN", "sdb.MM", "qual.sdb"),
            sep = "/" ) %>%
  separate( `External generalizability  (DR/JN/MM/reconciled)`,
            c("gen.DR", "gen.JN", "gen.MM", "qual.gen"),
            sep = "/" )

# recode missing data
d3[ d3 == "nd" ] = NA
# ~~ this one is temporary only
d3[ d3 == "?" ] = NA

# for some reason, reads in years in an absurd format (e.g., "2018.0" as a string)
library(tidyverse)
d3$Year = str_remove(d3$Year, "[.]0")

# clean up format
d3$qual.sdb = tolower(d3$qual.sdb)
d3$qual.exch = tolower(d3$qual.exch)
d3$qual.gen = tolower(d3$qual.gen)

# make merger variable
d3$authoryear = paste( d3$`First author last name`, d3$Year, sep = " " )

# save dataset
setwd(data.dir)
setwd("Dual review of quality")
write.csv(d3, "subjective_data_full_prepped.csv", row.names = FALSE)


