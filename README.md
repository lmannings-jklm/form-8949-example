# form-8949-example
This project explores the use of data wrangling principles to construct an R/Tidyverse script that imports asset sales data and generates an IRS tax return compliant form 8949.

# Tidyverse Form 8949 Generator

**Automated IRS Tax Reporting for High-Volume Collectible Sales (LEGO & Vinyl)**

![R](https://img.shields.io/badge/Made%20with-R-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📌 Overview

This project provides a reproducible data pipeline for independent consultants and hobbyist sellers to generate IRS-compliant **Form 8949** statements. 

Created by **JKLM Data Analytics**, this tool solves the challenge of manually reporting hundreds of transactions from platforms like PayPal, eBay, and Discogs. By leveraging the R **Tidyverse** and **LaTeX**, it transforms raw CSV data into a professional, multi-page PDF suitable for attachment to a federal tax return.

## 🚀 Features

* **Automatic Categorization:** Logic automatically sorts transactions into **Short-Term** (≤ 1 year) and **Long-Term** (> 1 year) tables based on holding periods.
* **Data Sanitation:** Handles "dirty" currency strings (e.g., `$1,200.00`), converting them to numeric types for accurate math.
* **Professional Formatting:** Generates landscape PDFs with `longtable` support, ensuring rows span multiple pages without breaking layout constraints.
* **Audit-Ready:** Automatically calculates and highlights **Grand Totals** for Proceeds, Cost Basis, and Gain/Loss.
* **Privacy-First:** Includes a script to anonymize sensitive financial data for public demonstration.

## 📂 Project Structure

```text
JKLM_Tax_Project/
├── generate_8949.R          # Controller script: loads data & renders PDF
├── template_8949.Rmd        # R Markdown template with LaTeX formatting logic
├── data/
│   ├── sales_2025.csv       # Input: Your raw transaction data
│   └── public_demo.csv      # Output: Sanitized data for sharing
└── output/
    └── Form_8949_2026-02-04.pdf  # Final generated tax statement
