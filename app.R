

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ui <- fluidPage(
  
  # App title ----
  titlePanel("Wordcloud generator"),
  
  sidebarLayout(
    
    # Sidebar panel for adjustment and input
    sidebarPanel(
      
      # File selection
      fileInput(inputId = "file", "Upload the text",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      checkboxInput(
        inputId = "box_stopwords",
        "Remove stopwords",
        TRUE),
      checkboxInput(
        inputId = "whatsapp_option",
        "Whatsapp chat",
        TRUE),
      numericInput(
        inputId = "top_words",
        "Top words",
        100,
        min = 0,
        max = 200,
        step = 1,
        width = NULL)
    ),
    
    mainPanel(
      
      wordcloud2Output(outputId = "wordcloud")
      
    )
  )
)

server <- function(input, output, session) {
  word_cloud <- WordCloud$new()
  output$wordcloud <- renderWordcloud2(
    {
      if (input$whatsapp_option) {
        word_cloud$process_whatsapp(
          input$file$datapath,
          drop_stopwords = input$box_stopwords,
          no_of_words = input$top_words)
      }
      
      word_cloud$create_wordcloud()
    }
  )
}