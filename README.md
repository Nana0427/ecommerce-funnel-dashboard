# E-Commerce Conversion Funnel Dashboard

## 📊 Project Overview
An interactive dashboard built to analyze e-commerce conversions for marketing managers, using real Google Analytics 4 data.

## 🛠️ Tools Used
- **BigQuery** — SQL queries for data extraction and transformation
- **Looker Studio** — Interactive dashboard visualization

## 🔗 Links
- [📊 Live Dashboard](https://datastudio.google.com/s/hNPXgzQvp28)

## 📁 SQL Queries
| File | Description |
|------|-------------|
| `query1_main_events.sql` | Main events query — extracts all funnel events with session, device and traffic data |
| `query2_funnel_summary.sql` | Funnel summary — counts sessions at each of the 7 funnel steps |
| `query3_daily_metrics.sql` | Daily metrics — aggregates sessions, orders, purchases and revenue by day |

## 📈 Key Findings
- Only **1.4%** of 354,857 sessions resulted in a purchase
- **78%** of visitors left without viewing a product
- Desktop users convert significantly better than mobile users
- Google organic is the top traffic source
