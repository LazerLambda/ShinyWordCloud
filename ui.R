ui <- fluidPage(
  
  sidebarLayout(
    
    # Sidebar panel for adjustment and input
    sidebarPanel(
      
      # File selection
      fileInput(inputId = "file", "Upload the text",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      tags$hr(),
      
      checkboxInput(
        inputId = "box_stopwords",
        "Remove stopwords",
        TRUE),
      checkboxInput(
        inputId = "whatsapp_option",
        "Whatsapp chat",
        TRUE),
      tags$hr(),
      
      numericInput(
        inputId = "top_words",
        "Top words",
        100,
        min = 0,
        max = 200,
        step = 1,
        width = NULL),
      downloadButton("downloadData", "Download"),
      tags$hr()
    ),
    
    mainPanel(
      h1("Upload your Whatsapp chats!"),
      p("Use the functions on the left to create your customized wordcloud!"),
      wordcloud2Output(outputId = "wordcloud")
      
    )
  )
)
