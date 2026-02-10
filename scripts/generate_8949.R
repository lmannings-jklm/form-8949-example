# Prerequisites

# install.packages(c("tidyverse", "knitr", "kableExtra", "rmarkdown"))


# This script prepares your data and calls a markdown template to generate the PDF.

library(tidyverse)  # Load collection of R tools designed specifically for
                    # data science
library(rmarkdown)  # Load tool for adding r code chunks to standard Markdown
library(lubridate)  # Load tool for handling dates and times

# 1. Load your Tidyverse-compliant CSV
# Ensure columns: Description, Date_Acquired, Date_Sold, Proceeds, Cost_Basis
data <- read_csv("C:/School/R_wd/tax_2025/data/public_demo_sales.csv")

# 2. Calculate Gain/Loss and format for the IRS
data_clean <- data %>%
  mutate(
    # IRS requires dates in MM/DD/YYYY for the form
    Date_Acquired = format(Date_Acquired, "%m/%d/%Y"),
    Date_Sold = format(Date_Sold, "%m/%d/%Y")
  )

# 3. Generate the PDF using an R Markdown template
render("scripts/template_8949.Rmd", 
       output_file = paste0("../output/Form_8949_", Sys.Date(), ".pdf"),
       params = list(df = data_clean))
