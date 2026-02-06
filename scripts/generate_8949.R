# Prerequisites

# install.packages(c("tidyverse", "knitr", "kableExtra", "rmarkdown"))


# This script prepares your data and calls a markdown template to generate the PDF.

library(tidyverse)
library(rmarkdown)
library(lubridate)

# 1. Load your Tidyverse-compliant CSV
# Ensure columns: Description, Date_Acquired, Date_Sold, Proceeds, Cost_Basis
data <- read_csv("C:/School/R_wd/tax_2025/data/2025_sales_8949.csv")

# 2. Calculate Gain/Loss and format for the IRS
data_clean <- data %>%
  mutate(
    #Gain_Loss = Proceeds - Cost_Basis,
    # IRS requires dates in MM/DD/YYYY for the form
    Date_Acquired = format(mdy(Date_Acquired), "%m/%d/%Y"),
    Date_Sold = format(mdy(Date_Sold), "%m/%d/%Y")
  )

# 3. Generate the PDF using an R Markdown template
render("template_8949.Rmd", 
       output_file = paste0("Form_8949_", Sys.Date(), ".pdf"),
       params = list(df = data_clean))
