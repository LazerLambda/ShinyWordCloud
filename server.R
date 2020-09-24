server <- function(input, output, session) {

  # create wordcloud
  word_cloud <- WordCloud$new()
  output$wordcloud <- renderWordcloud2(
    {
      print(input$file$datapath)
      if (is.null(input$file$datapath)){
        return(NULL)
      }
      if (input$whatsapp_option) {
        word_cloud$process_whatsapp(
          input$file$datapath,
          drop_stopwords = input$box_stopwords,
          no_of_words = input$top_words)
      }
      
      word_cloud$create_wordcloud()
    }
  )

  # Download image
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("wordcloud", ".png", sep = "")
    },
    content = function(file) {
      htmlwidgets::saveWidget(
        word_cloud$return_wordcloud(),
        "tmp.html",
        selfcontained = F
      )
      webshot("tmp.html", file,
              delay = 5,
              vwidth = 7 * input$top_words,
              vheight = 7 * input$top_words)
    }
  )
}