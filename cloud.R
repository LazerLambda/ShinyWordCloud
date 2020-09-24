

WordCloud <- R6Class(
  "WordCloud",
  list(
    
    initialize = function() {
      
    },
    
    frequent_terms = NA,
    wordcloud = NA,
    
    process_whatsapp = function(
      file_name,
      no_of_words = 100,
      drop_stopwords = TRUE) {
      data <- fread(
        file_name,
        skip = 1,
        header = F,
        sep = "",
        col.names = "original"
      )
      
      data[, c("index") := 1:.N, ]
      
      rm_reg_1 <- "<.* .*>"
      extr_reg <- "(.*), (.*) - (.*): (.*)"
      data[, 
           c("original", "date", "time", "name", "text") := 
             as.list(str_match(original, extr_reg)),
           by = index
      ]
      # remove  media placeholder
      data[, c("text") := gsub(rm_reg_1, "", .(text)), by = index]
      
      # detect language and get stopwords
      getmode <- function(v) {
        uniqv <- unique(v)
        uniqv[which.max(tabulate(match(v, uniqv)))]
      }
      if (drop_stopwords) {
        language <- getmode(detect_language(data[, text]))
        stopwords <- stopwords(language = language)
        self$frequent_terms <- freq_terms(
          data[, text],
          top = no_of_words,
          stopwords = stopwords
        )
      } else {
        self$frequent_terms <- freq_terms(
          data[, text],
          top = no_of_words
        )
      }
    },
    
    create_wordcloud = function() {
      set.seed(2)
      self$wordcloud <- wordcloud2(
        data = self$frequent_terms,
        shape = "cardiod",
        shuffle = F
      )
      return(self$wordcloud)
    },
    
    return_wordcloud = function() {
      return(self$wordcloud)
    }
  )
)