# 🎬 IMDB Movie Performance Dashboard

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-025E8C?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-005C84?style=for-the-badge)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github)
![Status](https://img.shields.io/badge/Project-Completed-success?style=for-the-badge)

> 🎥 Analyzing 1,000+ movies | 💰 Multi-billion dollar revenue dataset | 📅 Historical trend analysis

---

## 📊 End-to-End Analytics Pipeline

```
Data Collection → Python (Cleaning & EDA) → SQL (Analysis) → Power BI (Modeling) → DAX (KPIs) → Business Insights
```

---

## 📌 Project Overview

Movie studios invest hundreds of millions in production budgets — but which investments actually pay off?

This project builds an **advanced Power BI analytics dashboard** to answer that question using financial performance and audience rating data from IMDB. The dashboard is designed for a movie studio executive who needs to quickly understand ROI trends, audience behavior, and revenue drivers — without digging through raw data.

The result: a dark-themed, cinematic, interactive dashboard combining Python preprocessing, SQL analysis, and Power BI storytelling.

---

## 🎯 Business Problem

Studios face three core questions before greenlighting any project:

1. **Does a higher budget guarantee higher revenue?**
2. **Which genres and eras deliver the best ROI?**
3. **How does audience rating correlate with box office performance?**

This dashboard answers all three — with data.

---

## 📷 Dashboard Preview

![IMDB Dashboard](IMDB%20-%20Dashboard.png)

> 🎨 *Dark cinematic theme — designed for executive-level presentation*

---

## 📈 Key Insights & Business Impact

| Finding | Business Implication |
|---|---|
| **Avatar holds the highest single-movie revenue** | Franchise IP and visual spectacle drive outlier returns |
| **High budget ≠ high rating** | Audience satisfaction is driven by story, not spend |
| **Revenue peaked around 2012** | Studio output and global distribution expanded through this era |
| **Mid-budget films show strong ROI** | Risk-adjusted returns favor $50M–$150M productions |
| **Vote count correlates with revenue** | Audience engagement is a leading indicator of box office success |

---

## 📊 Dashboard Features

### 🔹 KPI Cards (Executive Summary)
- **Total Movies** — dataset size at a glance
- **Total Revenue** — cumulative box office performance
- **Average Rating** — overall audience satisfaction score
- **Total Votes** — engagement volume across all titles

### 🔹 Revenue Analysis
- **Top 5 Highest Revenue Movies** — bar chart ranking
- **Revenue Trend by Year** — time series showing industry growth & decline

### 🔹 Financial Comparison
- **Budget vs Revenue Clustered Chart** — side-by-side comparison per movie
- **Profitability Analysis** — which films made money vs lost it

### 🔹 Key Insights Panel
- Highest revenue movie callout
- Max revenue value card
- Analytical narrative summary

### 🔹 Detailed Data Table
- Revenue, Budget, Profit, Vote Average, Vote Count per title

---

## 🧠 DAX Calculations

```DAX
-- Total Revenue
Total Revenue = SUM(movies[revenue])

-- Total Budget
Total Budget = SUM(movies[budget])

-- Profit
Profit = [Total Revenue] - [Total Budget]

-- Profit Margin %
Profit Margin % = DIVIDE([Profit], [Total Budget])

-- Top Movie by Revenue
Top Movie = 
CALCULATE(
    FIRSTNONBLANK(movies[title], 1),
    TOPN(1, movies, movies[revenue], DESC)
)

-- Average Rating
Avg Rating = AVERAGE(movies[vote_average])

-- High ROI Movies (Budget < Revenue * 3)
High ROI Count = 
CALCULATE(
    COUNTROWS(movies),
    movies[revenue] >= movies[budget] * 3
)
```

---

## 🐍 Python — Data Cleaning & EDA

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load data
df = pd.read_csv('data/imdb_movies.csv')

# Data cleaning
df.dropna(subset=['revenue', 'budget', 'vote_average'], inplace=True)
df = df[df['revenue'] > 0]  # Remove unreleased/missing revenue
df = df[df['budget'] > 0]   # Remove movies with no budget listed

# Feature engineering
df['profit'] = df['revenue'] - df['budget']
df['roi'] = (df['profit'] / df['budget']) * 100
df['release_year'] = pd.to_datetime(df['release_date']).dt.year

# EDA — Revenue vs Budget correlation
print(f"Revenue-Budget Correlation: {df['revenue'].corr(df['budget']):.2f}")
print(f"Revenue-Rating Correlation: {df['revenue'].corr(df['vote_average']):.2f}")
print(f"\nTop 5 by Revenue:\n{df.nlargest(5, 'revenue')[['title','revenue','budget','roi']]}")

# Visualize
plt.figure(figsize=(10,6))
sns.scatterplot(data=df, x='budget', y='revenue', hue='vote_average', alpha=0.6)
plt.title('Budget vs Revenue — IMDB Movies')
plt.savefig('outputs/budget_vs_revenue.png')
```

---

## 🗄️ SQL Analysis

```sql
-- Top 10 highest revenue movies
SELECT title, revenue, budget, 
       (revenue - budget) AS profit,
       ROUND((revenue - budget) * 100.0 / budget, 2) AS roi_pct
FROM movies
WHERE budget > 0 AND revenue > 0
ORDER BY revenue DESC
LIMIT 10;

-- Revenue trend by year
SELECT YEAR(release_date) AS release_year,
       SUM(revenue) AS total_revenue,
       AVG(vote_average) AS avg_rating,
       COUNT(*) AS movie_count
FROM movies
GROUP BY release_year
ORDER BY release_year;

-- High budget but low rating movies (overinvestment analysis)
SELECT title, budget, revenue, vote_average
FROM movies
WHERE budget > 100000000
  AND vote_average < 6.0
ORDER BY budget DESC;

-- Profitable mid-budget films (ROI > 200%)
SELECT title, budget, revenue,
       ROUND((revenue - budget) * 100.0 / budget, 0) AS roi_pct
FROM movies
WHERE budget BETWEEN 10000000 AND 80000000
  AND revenue >= budget * 3
ORDER BY roi_pct DESC;
```

---

## 🎨 Design Strategy

| Principle | Implementation |
|---|---|
| **Dark cinematic theme** | Black/dark grey background — matches movie industry aesthetic |
| **High contrast KPIs** | White text on dark cards for instant readability |
| **Layout hierarchy** | KPIs top → Charts middle → Table bottom |
| **Consistent accent color** | Gold/yellow tones aligned with IMDB brand |
| **Minimal clutter** | No gridlines, clean borders, purposeful whitespace |

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|------|---------|
| Power BI Desktop | Interactive dashboard & data modeling |
| DAX | KPI calculations & advanced measures |
| Python (Pandas, Seaborn) | Data cleaning, EDA, feature engineering |
| SQL | Revenue analysis & profitability queries |
| GitHub | Version control & project documentation |

---

## 🚀 How to Use

1. Clone this repository
2. Open `powerbi/IMDB_Dashboard.pbix` in Power BI Desktop
3. Explore interactive visuals — filter by year, genre, or budget range
4. Review `python/imdb_eda.ipynb` for full preprocessing steps
5. Check `sql/imdb_analysis.sql` for all validation queries

---

## 📂 Repository Structure

```
IMDB-Movie-Performance-Dashboard/
│
├── data/
│   └── imdb_movies.csv
│
├── powerbi/
│   └── IMDB_Dashboard.pbix
│
├── python/
│   └── imdb_eda.ipynb
│
├── sql/
│   └── imdb_analysis.sql
│
├── IMDB - Dashboard.png          ← Dashboard preview screenshot
└── README.md
```

---

## 🔮 Future Improvements

- Add **ROI % calculation** per movie with conditional formatting
- Build **genre-level breakdown** page with drill-through
- Add **dynamic slicers** for year range, budget tier, and genre
- **Publish to Power BI Service** for live web access
- Integrate **live IMDB API** for real-time data refresh

---

## 👨‍💻 Author

**Khush Panchal** — Data Analyst
Specializing in business intelligence, financial analytics & data storytelling

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/khush-panchal-96b557352)
[![GitHub](https://img.shields.io/badge/GitHub-Portfolio-black?style=flat&logo=github)](https://github.com/khush3521)

---

⭐ If you found this project valuable, please consider starring this repository!
