# R Script for Data Sanitization
# This "scrubber" script creates a version of your CSV that is safe for public
# consumption. It uses the digest package to mask sensitive strings and adds 
# "noise" to prices if you want to keep your exact profit margins private.
# It also generalizes the dates to mask business activity while maintaining the
# "Long-term vs. Short-term" logic. Lastly the Description column is dropped 
# from the sanitized table.

library(tidyverse)  # Load collection of R tools designed specifically for
                    # data science
library(digest) # Load tool used to create cryptographic hash digests of R 
                # objects.

# Load your real data
real_data <- read_csv("C:/School/R_wd/tax_2025/data/Private/2025_sales_8949.csv")

# Sanitize the data
public_data <- real_data %>%
  mutate(across(c(Proceeds, Cost_Basis, Gain_Loss), 
                ~ as.numeric(gsub("[\\$,]", "", .)))) |>
  mutate(
    # 1. Mask Order IDs using a hash (reproducible but anonymous)
    Order_ID = sapply(Description, function(x) digest(x, algo="crc32")),
    
    # 2. Generalize Dates (Keep month/year, but set day to 1st)
    Date_Acquired = as.character(floor_date(mdy(Date_Acquired), "month")),
    Date_Sold = as.character(floor_date(mdy(Date_Sold), "month")),
    
    # 3. Optional: Add 'Noise' to prices (e.g., +/- 5%) to hide exact earnings
    Proceeds = Proceeds * runif(n(), 0.75, 1.25),
    Cost_Basis = Cost_Basis * runif(n(), 0.75, 1.25),
    Gain_Loss = Proceeds - Cost_Basis
  ) %>%
  
  # 4. Remove any columns with Names or Addresses (not used in this case)
  #select(-matches("Name|Address|Email|Phone|Description"))
  
  # 4a. Return a set of columns as a new table
  select(Order_ID, Date_Acquired, Date_Sold, Proceeds, Cost_Basis, Code, 
         Adjustment, Gain_Loss, Marketplace)

# 5. Re-format back to currency
public_data <- public_data |> 
  mutate(across(c(Proceeds, Cost_Basis, Gain_Loss), 
                ~ scales::dollar(.)))

# 6. Write data frame to file
write_csv(public_data, "data/public_demo_sales.csv")