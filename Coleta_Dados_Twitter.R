# Coleta de dados no Twitter com o R

# Biblioteca
install.packages("rtweet")
install.packages("ggplot2")

library(rtweet)
library(ggplot2)

# Definição do diretório de trabalho
setwd(" ")

# Autenticação
token <- create_token(app = " ",
                      consumer_key = " ",
                      consumer_secret = " ",
                      access_token = " ",
                      access_secret = " ")

# Parâmetros de Busca
screen_name <- "magazineluiza"
no.of.tweets <- 1000       # nº de tweets solicitados

# Busca
tweets <- get_timeline(screen_name, n = 1000, include_rts = TRUE,
                       exclude_replies = TRUE)
# "include_rts = TRUE" => opção para incluir retweets
# "exclude_replies = TRUE" => opção para excluir replies

# Arquivamento do vetor de tweets como csv e apenas o texto em TXT na codificação em português
write_as_csv(tweets, "TweetsByNameRawData.csv")
# write_as_csv(tweets, "TweetsByNameRawData.csv", fileEncoding = "latini//TRANSLIT")

# Plota a série temporal dos tweets
ts_plot(tweets, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text (face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequência dos tweets da conta 'magazineluiza' nos últimos 9 dias",
    subtitle = "Contagem de tweets agregados em intervalos de 3 horas",
    caption = "\nFonte: Dados coletados do Twitter com o pacote 'rtweet'"
  )

###########################################################################################

# Coleta de dados por hashtag

# Biblioteca
install.packages("rtweet")
install.packages("ggplot2")
install.packages("maps")

library(rtweet)
library(ggplot2)
library(maps)

# Definição do diretório de trabalho
setwd(" ")

# Autenticação
token <- create_token(app = " ",
                      consumer_key = " ",
                      consumer_secret = " ",
                      access_token = " ",
                      access_secret = " ")

# Parâmetros de busca
search.string <- c("#ficaemcasa or #coronavírus or #covid or #covid-19 or #covid19")
type = "mixed"        # opções: "mixed", "recent" ou "popular"

# Busca
tweets <- search_tweets(search.string, n = 18000, lang = "pt", type = type,
                        include_rts = FALSE, retryonratelimit = TRUE)

# Arquivamento do vetor de tweets como csv e apenas o texto em TXT na codificação em português
write_as_csv(tweets, "TweetsByNameRawData.csv")
# write_as_csv(tweets, "TweetsByNameRawData.csv", fileEncoding = "latini//TRANSLIT")
write.table(tweets$text, "TweetsByNameRawData.txt")

# Criação de lat/lng variáveis utilizando todos os tweets disponíveis
tweets <- lat_lng(tweets)
# "lat_lng" => função de latitude/longetude

# Plota o mapa do Brasil
par(mar = c(0, 0, 0, 0))   #função par que define/ajusta os parâmetros de plotagem
# parâmetro "mar" => ajusta as margens
m <- map("world", "Brazil", fill = T, col = "grey95")
map(,,add = T)
map.axes()
map.scale(ratio = F, cex = 0.7)
abline(h = 0, lty = 2)
map.cities(country = "brazil", minpop = 2000000, pch = 15, cex = 0.9)

# Adiciona os tweets ao mapa
with(tweets, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))


