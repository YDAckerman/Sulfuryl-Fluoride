## file to load data for Mike's sulfuryl-fluoride question:

#### ON abound ####
### load libraries
library(RPostgreSQL)
library(DBI)
library(dplyr)
library(plyr)
library(foreach)
library(lubridate)

## connect to the database
con <- src_postgres(dbname="california",
                  host="ziram.lawr.ucdavis.edu",
                   user="jonathan"
                   ## ,options="-c search_path=bee"
                    )

sf_code <- tbl(con, dplyr::sql("SELECT chemname, chem_code FROM pur.chemical WHERE chemname = 'SULFURYL FLUORIDE'"))
sf_code <- collect(sf_code)

sql <- paste0("SELECT year, county_cd, applic_cnt, lbs_chm_used FROM pur.udc WHERE chem_code = ", sf_code$chem_code, " AND site_code = 10 AND (year = 2013 OR year = 2012 OR year = 2011)")

sf_data <- tbl(con, dplyr::sql(sql))
sf_data <- collect(sf_data)

save(sf_data, file = "~/R/sulfuryl_fluoride/sf_data.rda")
