# Financial time series econometrics — R code from report appendix A
# Original analysis supplied by the author; requires quantmod and moments.
library(quantmod)
library(moments)
 
tickers <- c("^GSPC", "XLK", "AAPL", "MSFT", "TLT", "SPY", "EURUSD=X", "BTC-USD", "CL=F", "GC=F")
noms <- c("S&P 500", "ETF Techno", "Apple", "Microsoft", "Obligations (TLT)",
          "ETF S&P 500 (SPY)", "Euro/Dollar", "Bitcoin", "Futur Pétrole", "Or (Gold)")
 
# Téléchargement (prix de clôture)
data <- list()
for (i in seq_along(tickers)) {
  temp <- getSymbols(tickers[i], src = "yahoo", from = "2020-01-01", to = "2025-01-01", auto.assign = FALSE)
  data[[noms[i]]] <- Cl(temp)
}
 
# Rentabilités logarithmiques
rentabilites <- list()
for (nom in names(data)) {
  prix <- na.omit(data[[nom]])
  rentabilites[[nom]] <- na.omit(diff(log(prix)))
}
 
# Graphiques prix / rentabilités
for (nom in names(data)) {
  plot(as.numeric(data[[nom]]), type = "l", col = "steelblue",
       main = paste(nom, "- Prix"), xlab = "Temps", ylab = "Prix")
  plot(as.numeric(rentabilites[[nom]]), type = "l", col = "darkorange",
       main = paste(nom, "- Rentabilités"), xlab = "Temps", ylab = "Rentabilité")
}
 
# Statistiques descriptives
stats <- data.frame(
  Actif = names(rentabilites),
  Moyenne = sapply(rentabilites, mean),
  Ecart_type = sapply(rentabilites, sd),
  Min = sapply(rentabilites, min),
  Max = sapply(rentabilites, max),
  Skewness = sapply(rentabilites, skewness),
  Kurtosis = sapply(rentabilites, kurtosis)
)
print(stats)
 
# ---- Données simulées ----
set.seed(42)
n <- 500
modeles <- list(
  "AR(1)" = list(ar = 0.6, ma = NULL),
  "AR(2)" = list(ar = c(0.5, -0.3), ma = NULL),
  "AR(3)" = list(ar = c(0.4, -0.2, 0.1), ma = NULL),
  "MA(1)" = list(ar = NULL, ma = 0.7),
  "MA(2)" = list(ar = NULL, ma = c(0.6, 0.3)),
  "MA(3)" = list(ar = NULL, ma = c(0.5, 0.3, 0.2)),
  "ARMA(1,1)" = list(ar = 0.6, ma = 0.4),
  "ARMA(1,2)" = list(ar = 0.5, ma = c(0.4, 0.2)),
  "ARMA(2,1)" = list(ar = c(0.5, -0.3), ma = 0.4),
  "ARMA(2,2)" = list(ar = c(0.4, -0.2), ma = c(0.3, 0.2))
)
series_simulees <- list()
for (nom in names(modeles)) {
  m <- modeles[[nom]]
  series_simulees[[nom]] <- arima.sim(model = list(ar = m$ar, ma = m$ma), n = n)
}
 
# Trajectoires
for (nom in names(series_simulees)) {
  plot(series_simulees[[nom]], type = "l", col = "darkcyan",
       main = nom, xlab = "Temps", ylab = "Valeur")
}
 
# Moyennes, variances, autocorrélations (retards 1 à 5)
stats_simulees <- data.frame(
  Modele = names(series_simulees),
  Moyenne = sapply(series_simulees, mean),
  Variance = sapply(series_simulees, var)
)
autocorr_table <- data.frame(
  Modele = names(series_simulees),
  t(sapply(series_simulees, function(s) round(acf(s, lag.max = 5, plot = FALSE)$acf[2:6], 4)))
)
 
# Corrélogrammes (simulées puis réelles)
for (nom in names(series_simulees)) {
  acf(series_simulees[[nom]], main = paste("ACF -", nom), lag.max = 20)
}
for (nom in names(rentabilites)) {
  acf(rentabilites[[nom]], main = paste("ACF -", nom, "(réel)"), lag.max = 20)
}
