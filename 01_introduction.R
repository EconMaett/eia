# EIA -----

# Retrieve data from the U.S. Energy Information Administration (EIA)
# https://www.eia.gov/opendata/index.php

# R Package: https://docs.ropensci.org/eia/index.html


## Setup ----

# Go to
# https://www.eia.gov/opendata/register.php
# and obtain a free API key.

# Open your .Renviron file by calling
usethis::edit_r_environ()
# and save it under the name "EIA_KEY".

# Then restart your R session.

# Check if your API key is available with
Sys.getenv("EIA_KEY")


## Installation ----

# The package is available on CRAN
# install.packages("eia")

library(eia)


## Explore the API directory ----

# Get a list of the EIA's data directory and sub-directories

# The top-level directory is returned by
eia_dir()


# The electricity sub-directory is returned by
eia_dir("electricity")


## Get data ----

# Retrieve annual retail electricity sales for the Ohio residential
# sector since 2010

d <- eia_data(
  dir = "electricity/retail-sales",
  data = "sales",
  facets = list(stateid = "OH", sectorid = "RES"),
  freq = "annual",
  start = "2010",
  sort = list(cols = "period", order = "asc")
)

print(d)


# Create a plot

library(ggplot2)

ggplot(data = d, mapping = aes(x = period, y = sales / 1e3)) +
  geom_bar(color = "steelblue", fill = "steelblue", stat = "identity") +
  theme_bw() +
  labs(
    title = "Annual retail sales of electricity (GWh)",
    subtitle = "State: Ohio; Sector: Residential",
    x = "Year",
    y = "Sales (GWh)"
  )

ggsave(filename = "ohio-retail-electricity-sales.png", width = 8, height = 4)
graphics.off()

# END