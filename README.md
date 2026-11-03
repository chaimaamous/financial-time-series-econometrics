# Financial Time Series Econometrics

**Financial Markets Analysis Using R and Python**

## Project Overview

This academic project investigates the statistical behavior of financial time series, focusing on stationarity, financial returns, autocorrelation and ARMA processes.

The study covers **10 financial assets between January 2020 and January 2025**, including stocks, stock market indices, ETFs, currencies, commodities and cryptocurrency.

## Objectives

- Analyze financial asset prices and logarithmic returns.
- Apply stationarity tests and examine autocorrelation structures.
- Simulate and compare 10 AR, MA and ARMA processes.
- Identify volatility clustering in financial returns.
- Compare simulated time series with actual financial market behavior.

## Technologies

**R:** quantmod, moments, arima.sim, acf.

**Python:** yfinance, statsmodels.

**Data Source:** Yahoo Finance.

## Key Findings

The analysis illustrates important differences between financial prices and returns, particularly regarding stationarity and volatility.

Simulated ARMA processes help explain autocorrelation patterns, while real financial returns exhibit more complex volatility behavior.

## Author

**Chaimaa Moustaoui**

Master's Student in Finance, Actuarial Science and Data Science

Université Abdelmalek Essaâdi, Morocco

## Project Files

- [Python Jupyter Notebook](python/financial_time_series_analysis.ipynb) — Financial data analysis and automation.
- [R Econometrics Script](R/financial_time_series.R) — Financial returns and ARMA analysis.
- [Python Dependencies](requirements.txt) — Required Python packages.

## How to Run

Install Python dependencies:

```bash
pip install -r requirements.txt
```

Open `python/financial_time_series_analysis.ipynb` in Jupyter Notebook or VS Code.

The R analysis requires an R environment and the relevant R packages.
