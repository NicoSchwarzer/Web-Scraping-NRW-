##################
## Web Scraping ##
##################


# Properties of cities in NRW

library(xml2)
library(rvest)
library(rlist)
library(stringi)
library(tidyr)
library(tidyverse)
library(stringr)


## Ensuring legality
## https://www.wikipedia.com/robots.txt

## given for my purpose 



##########################

### Scraping the data


xml <- read_html("https://de.wikipedia.org/wiki/Nordrhein-Westfalen")


### Governing areas ###

df_1 <- html_text(html_nodes(xml, css = ".zebra.toptextcells td , .zebra.toptextcells th"))

df_1 <- df_1 %>%
  str_remove("\n")



n <- length(df_1)
areas <- n/5


df_1[26]


mat1 <- matrix(0, nrow = 6, ncol = 5)
mat1 <- data.frame(mat1)

for (i in 0:5) { 
  mat1[1,i+1] <- df_1[1+5*i]
  mat1[2,i+1] <- df_1[2+5*i]
  mat1[3,i+1] <- df_1[3+5*i]
  mat1[4,i+1] <- df_1[4+5*i]
  mat1[5,i+1] <- df_1[5+5*i]
  }

df_1 <- t(mat1)

df_1 <- df_1[, c(1:5)]


colnames(df_1) <- df_1[1,]

df_1 <- df_1[-1,]

head(df_1)



### largest cities ### 

## 1st table
css2 <- '.float-right:nth-child(31) tr:nth-child(4) td:nth-child(1) , .float-right:nth-child(31) tr:nth-child(6) td:nth-child(1) , .float-right:nth-child(31) tr:nth-child(5) td:nth-child(1) , .float-right:nth-child(31) td:nth-child(2) , .float-right:nth-child(31) tr:nth-child(3) td:nth-child(1) , .float-right:nth-child(31) th:nth-child(2) , .float-right:nth-child(31) tr:nth-child(2) td:nth-child(1) , .float-right:nth-child(31) th:nth-child(1)'


df_2 <- html_text(html_nodes(xml, css = css2))

df_2 <- df_2 %>%
  str_remove("\n")



mat2 <- matrix(0, nrow = 6, ncol = 2)
mat2 <- data.frame(mat2)


for (i in 0:5) { 
  mat2[i+1,1] <- df_2[1+2*i]
  mat2[i+1,2] <- df_2[2+2*i]
  }


colnames(mat2) <- mat2[1,]

df_2 <- mat2[-1,]

colnames(df_2)[2] <- "Einwohner am 31.12.2019"


df_2$`Einwohner am 31.12.2019` <- gsub("[^0-9]", "", df_2$`Einwohner am 31.12.2019`)
df_2$`Einwohner am 31.12.2019` <- as.numeric(df_2$`Einwohner am 31.12.2019`)

head(df_2)

## 2nd href links 

xp <- '//*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//tr[(((count(preceding-sibling::*) + 1) = 4) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//tr[(((count(preceding-sibling::*) + 1) = 6) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//tr[(((count(preceding-sibling::*) + 1) = 5) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 2) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//tr[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//th[(((count(preceding-sibling::*) + 1) = 2) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//tr[(((count(preceding-sibling::*) + 1) = 2) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "float-right", " " )) and (((count(preceding-sibling::*) + 1) = 31) and parent::*)]//th[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]'

links <-
  html_attr(html_nodes(xml, xpath = xp), name = "href")








