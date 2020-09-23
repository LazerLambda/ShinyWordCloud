
# import librariesword_cloud$process_whatsapp(input$file$datapath)
library(cld3)
library(data.table)
library(qdap)
library(R6)
library(shiny)
library(stopwords)
library(stringr)
library(tokenizers)
library(wordcloud2)

# set directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# source files
source("cloud.R")
source("app.R")

# Run app
shinyApp(ui = ui, server = server)