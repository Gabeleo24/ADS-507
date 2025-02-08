USE production;

-- ====================================================
-- Data Loading Commands
-- ====================================================
-- Note: The CSV files are stored in the 'data/' folder,
-- are tab-delimited (\t), and include a header row (which is ignored).

-- 1. Load data into ProductCategory
LOAD DATA LOCAL INFILE '/Users/home/Documents/GitHub/ADS-507/Repo/MySQL Pipeline/data/ProductCategory.csv'
INTO TABLE ProductCategory
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Name, Description);

