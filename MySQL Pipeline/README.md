# MySQL Pipeline

## Overview
This project focuses on developing a production-ready data pipeline using SQL and MySQL database tools. Originally, the AdventureWorks database served as the core data source, with the objective of implementing an ETL (Extract, Transform, Load) or ELT (Extract, Load, Transform) pipeline to process key datasets and produce actionable outputs such as business analytics dashboards or triggered reports.

**Note:**  
We have updated our approach to include new production data inspired by the original instawdb.sql reference. This new data is organized using a production-ready schema and consists of CSV files that feed into our ETL pipeline.

## Notes on the New Data
- **Schema Enhancements:**  
  Our updated production schema now includes tables such as:
  - **ProductCategory**
  - **ProductSubcategory**
  - **Product**
  - **ProductInventory**
  - **WorkOrder**
  - **WorkOrderRouting**

- **CSV Files:**  
  Each table has a corresponding CSV file located in the `data/` folder. These CSV files are tab-delimited and formatted to match the schema requirements. They are used to simulate data updates and feed our ETL process.

- **ETL/ELT Process:**  
  The pipeline extracts data from these CSV files, transforms it as needed (using SQL transformations defined in the `sql/` directory), and loads it into the MySQL database.

## Key Datasets

For this project, we are working with the following key datasets, now based on our updated production-ready schema:

1. **ProductCategory**
    - **Description:** High-level grouping of products.
    - **Use Case:** Organize products into broad categories for analytical insights.

2. **ProductSubcategory**
    - **Description:** Detailed categorization within each product category.
    - **Use Case:** Enable granular analysis by product type.

3. **Product**
    - **Description:** Contains detailed product information, including names, costs, pricing, and availability.
    - **Use Case:** Analyze product performance, profitability, and inventory needs.

4. **ProductInventory**
    - **Description:** Tracks inventory details across various locations.
    - **Use Case:** Monitor stock levels and support supply chain optimization.

5. **WorkOrder**
    - **Description:** Represents production work orders and associated manufacturing data.
    - **Use Case:** Manage production processes and evaluate manufacturing efficiency.

6. **WorkOrderRouting**
    - **Description:** Details the routing steps for work orders, including operation sequences and scheduling.
    - **Use Case:** Optimize production scheduling and resource allocation.

## Features
- **Database:** MySQL database for data storage and transformations.
- **Pipeline:** Fully reproducible ETL/ELT pipeline to ingest, process, and store data.
- **SQL Transformations:** Extensive use of SQL for data cleaning, aggregation, and querying.
- **Output:** Actionable outputs such as visualizations, notifications, or API integrations.
- **Version Control:** Collaborative development via GitHub.

## Requirements
- MySQL Server (version 8.0 or later)
- VS Code with MySQL Shell or MySQL Workbench
- Python (for additional scripting, if required)
- Docker (optional, for containerized deployments)

## Setup Instructions

1. **Clone the Repository**
    ```sh
    git clone https://github.com/Gabeleo24/ADS-507/tree/main/MySQL%20Pipeline
    ```

2. **Set Up the MySQL Database**
    - Download and install MySQL Server from the [MySQL Downloads](https://dev.mysql.com/downloads/) page.
    - Run the SQL script to create your production-ready schema:
      ```sh
      mysql -u [username] -p < sql/create-adventureworks.sql
      ```
    - Load the CSV data files for each table (located in the `data/` folder) using the provided BULK INSERT commands or your preferred method.

3. **Configure the Pipeline**
    - Edit the configuration file in the `config/` directory to set database credentials and file paths.
    - Run the ETL/ELT script:
      ```sh
      python src/pipeline.py
      ```

## Project Structure
/project-root
│
├── data/                  # Input datasets (CSV files for new data)
│   ├── ProductCategory.csv
│   ├── ProductSubcategory.csv
│   ├── Product.csv
│   ├── ProductInventory.csv
│   ├── WorkOrder.csv
│   └── WorkOrderRouting.csv
├── docs/                  # Documentation files, including schema diagrams
├── sql/                   # SQL scripts for schema creation and transformations
│   ├── create-adventureworks.sql
│   ├── insert-data.sql
│   └── transformations.sql
├── src/                   # Source code for the ETL pipeline
│   └── pipeline.py
├── tests/                 # Unit tests for the pipeline
├── Dockerfile             # Docker setup (if applicable)
├── README.md              # Project README (this file)
└── config/                # Configuration files

## How to Run the Project

1. **Start the Database:**
    - Start MySQL using your local installation or via Docker:
      ```sh
      docker run -d --name mysql-server -p 3306:3306 -e MYSQL_ROOT_PASSWORD=yourpassword mysql:latest
      ```

2. **Load the Data:**
    - Run the SQL scripts to create the database schema and load the CSV data.

3. **Execute the Pipeline:**
    - Navigate to the `src/` directory and run:
      ```sh
      python pipeline.py
      ```

4. **View Outputs:**
    - Outputs such as visualizations or email triggers will be available based on the pipeline configuration.

## Monitoring
- Logs are stored in the `logs/` folder for tracking pipeline execution.
- Use MySQL Workbench or VS Code MySQL Shell to monitor the database.

## Next Steps
- Scale the pipeline to handle larger datasets.
- Add monitoring and alerting for failed ETL jobs.
- Integrate with cloud services for advanced analytics.

## License
This project is licensed under the MIT License.

## Contributors
- Contributor 1: Duy Nguyen 
- Contributor 2: Jorge Roldan