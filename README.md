# Inventory Management Analysis

A data analysis project simulating the work of an Inventory Management Analyst, built using Python, MySQL, and Tableau.

**Dataset:** [Kaggle - DataCo Smart Supply Chain for Big Data Analysis]([https://www.kaggle.com/datasets/shivamb/supply-chain-dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis/data))

## Project Structure

| File | Description |
|------|-------------|
| `inventory_analysis.ipynb` | Data ingestion via Kaggle API, cleaning, preprocessing, and loading into MySQL |
| `inventory_analysis_queries.sql` | 5 core SQL analysis queries covering turnover, aging stock, demand trends, late delivery, and profitability |
| `[Tableau workbook .twbx]` | Interactive dashboards connected directly to MySQL |

## Data Cleaning & Validation

- Ingested raw data via Kaggle API (180,519 rows, 26 columns after cleanup)
- Dropped irrelevant columns (PII, redundant IDs, geographic noise)
- Fixed date types, mapped `Product Status` and `Late_delivery_risk` to readable labels
- Added `Order Year`, `Order Month`, `Order Month Name` derived columns
- Dropped `Product Status` column (no variation — all rows = "Available")
- **Null check:** Zero nulls found across all key columns
- **Duplicate check:** Verified that duplicate Order IDs are NOT true duplicates. They represent multiple line items per order across different products, quantities, and discount tiers. No rows were dropped.
- **No single unique key exists.** Each row is uniquely identified by the combination of `Order Id` + `Product Name` + `Order Item Discount Rate`, reflecting a standard order line-item structure.

### Distinct Categorical Values

| Column | Values |
|--------|--------|
| Delivery Status | Advance shipping, Late delivery, Shipping on time, Shipping canceled |
| Late_delivery_risk | On Time, Late Risk |
| Order Status | COMPLETE, PENDING, CLOSED, PENDING_PAYMENT, CANCELED, PROCESSING, SUSPECTED_FRAUD, ON_HOLD, PAYMENT_REVIEW |
| Shipping Mode | Standard Class, First Class, Second Class, Same Day |

> All analysis queries are filtered to `COMPLETE` and `CLOSED` orders only, excluding canceled, fraudulent, and pending records to ensure only fulfilled orders are analyzed.

## Analysis Questions

1. **Category Turnover** — Aggregated units sold and revenue by category to identify highest and lowest turnover segments
2. **Excess / Aging Stock** — Ranked products by total units sold to surface the slowest moving SKUs across the entire dataset
3. **Demand Trends Over Time** — Monthly units and revenue by category across 2015–2017 to identify demand patterns and consistency
4. **Late Delivery Patterns** — Calculated late delivery rate by region and shipping mode using CASE WHEN conditional aggregation
5. **Profitability by Category** — Compared total profit and profit margin % across all categories to identify high and low return segments

## Key Findings

- **Cleats** is the highest turnover category (32,181 units), while **Fishing** ranks 6th in volume but 2nd in total revenue ($3M) due to high price points per item
- The 15 slowest moving products sold only 6–20 units over 3+ years, with Fitness Accessories, Hockey, and Basketball concentrated at the bottom
- Monthly demand is remarkably flat at 4,500–5,300 units per month from 2015 through mid-2017 with no meaningful seasonal spikes
- **First Class shipping has a 92–100% late delivery rate** across nearly every region — the fastest promised option is consistently the least reliable
- **Standard Class and Same Day** are the most reliable shipping modes at 28–43% and 20–56% late rates respectively
- **Fishing generates the highest total profit** ($334K) and **Golf Bags & Carts has the highest margin** (25.1%), while Strength Training (2.4%) and Men's Clothing (2.9%) are the weakest margin categories

## Actionable Recommendations

- **Reassess First Class and Second Class shipping contracts.** Late rates of 92–100% on First Class are unsustainable. Renegotiate carrier SLAs or deprioritize these options until reliability improves.
- **Reduce stocking on bottom-15 products.** Items selling fewer than 20 units over 3+ years are tying up capital with minimal return. Flag for clearance or discontinuation.
- **Protect high-margin niche categories.** Golf Bags & Carts, Basketball, and Hockey generate outsized margins relative to their size. Targeted inventory investment could improve overall profitability without requiring high volume.
- **Investigate Fishing category pricing.** Fishing is the most profitable category by total profit despite mid-tier volume. Understanding its pricing premium could inform strategy across other categories.
- **Audit low-margin categories.** Strength Training and Men's Clothing margins below 3% suggest pricing issues or discount overuse. A SKU-level review is warranted before continuing to stock these categories.

## Tools
- Python (pandas, sqlalchemy, kagglehub)
- MySQL 8.0 (MySQL Workbench)
- Tableau
- Jupyter Notebook

## Roadblocks & Lessons Learned
- **Duplicate Order IDs:** Initial duplicate check flagged a large number of repeated Order IDs. Investigation revealed these were NOT true duplicates but standard order line-item structure — the same Order ID can contain multiple products at different quantities and discount tiers. No rows were dropped. The unique row identifier is the combination of `Order Id` + `Product Name` + `Order Item Discount Rate`.
