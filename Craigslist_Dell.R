library(polite)
library(magrittr)
library(dplyr)
library(rvest)
library(readr)



Craigslist <- function(url){

  session = bow(url, user_agent =  "Linkedin Post | Webscrapping Tutorial")
  Description_items <- scrape(session) %>% html_nodes("#search-results") %>% html_elements(".result-heading") %>% html_text2()
  Description_items <- as.data.frame(Description_items)
  Prices <- scrape(session) %>% html_nodes("#search-results") %>% html_elements(".result-meta")%>% html_text2()
  Prices <- as.data.frame(Prices)
  Links <- scrape(session) %>% html_nodes(".rows") %>% html_elements("a") %>% html_attr("href") %>% unique()
  Links <- as.data.frame(Links) %>% slice(1,3:121)
  Comprehensive_list <- cbind(Description_items, Prices, Links )
  Comprehensive_list$Prices <- gsub("pic hide this posting restore restore this posting", "", Comprehensive_list$Prices)
  Comprehensive_list$Prices <- gsub("hide this posting restore restore this posting", "", Comprehensive_list$Prices)
  names(Comprehensive_list)[2] <- "Prices & their locations"
  Comprehensive_list <- Comprehensive_list %>% select(c(1:3))
  write_csv2(Comprehensive_list, file = "Comprehensive_list.csv", col_names = T, append = T)
  #write.xlsx(Comprehensive_list, append = FALSE, file = '/home/nosa2k/CraigslistExample.xlsx')wb = createWorkbook()
  

  
  
  
  
  
  

  
}

#Craigslist()

url1 <- "https://dallas.craigslist.org/d/computers/search/sya?query=dell"
url2 <- "https://dallas.craigslist.org/d/computers/search/sya?s=120&query=dell"
url3 <- "https://dallas.craigslist.org/d/computers/search/sya?s=240&query=dell"

urls = list(url1, url2, url3)


for(url in urls){
  
  Craigslist(url)
}  



