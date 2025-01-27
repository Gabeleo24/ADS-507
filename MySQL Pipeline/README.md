# MySQL Pipeline

## Overview

This project focuses on developing a production-ready data pipeline using SQL and MySQL database tools, with the AdventureWorks database as the core data source. The primary objective is to implement an ETL (Extract, Transform, Load) or ELT (Extract, Load, Transform) pipeline to process key datasets from AdventureWorks and produce actionable outputs, such as business analytics dashboards or triggered reports.

## Key Datasets

For this project, we will focus on the following five datasets from the AdventureWorks database:
1. **SalesOrderHeader**
    - Contains information about customer orders, including order dates, due dates, and totals.
    - Use Case: Aggregate sales performance metrics over time and regions.
2. **SalesOrderDetail**
    - Provides detailed line-item information for each order, such as quantity and product IDs.
    - Use Case: Analyze product-level sales trends and identify best-selling items.
3. **Customer**
    - Contains customer demographic information, including geographic location and company affiliation.
    - Use Case: Segment customers by demographics and purchase behavior.
4. **Product**
    - Includes data on products sold, including product names, categories, and standard costs.
    - Use Case: Generate insights into product profitability and category performance.
5. **Employee**
    - Contains employee details, including titles, department assignments, and hire dates.
    - Use Case: Analyze sales performance by employee and identify top-performing sales staff.

## Features
- **Database:** MySQL database setup for data storage and transformations.
- **Pipeline:** Fully reproducible ETL/ELT pipeline to ingest, process, and store data.
- **SQL Transformations:** Use of SQL for data cleaning, aggregation, and querying.
- **Output:** Outputs include data visualizations, notifications, or API integrations.
- **Version Control:** Collaborative development via GitHub with version control.

## Requirements
- MySQL Server (version 8.0 or later)
- VS Code with MySQL Shell or MySQL Workbench
- Python (for additional scripting if required)
- Docker (optional, for containerized deployments)

## Setup Instructions

1. **Clone the Repository**
    ```sh
    git clone https://github.com/Gabeleo24/ADS-507/tree/main/MySQL%20Pipeline
    ```

2. **Set Up the MySQL Database**
    1. Download and install MySQL Server from MySQL Downloads.
    2. Use `instnwnd.sql` or `instpubs.sql` to create and populate the database:
        ```sh
        mysql -u [username] -p < instnwnd.sql
        ```
    3. Alternatively, set up the Pagila database:
        ```sh
        psql -U [username] -f pagila-schema.sql
        psql -U [username] -f pagila-data.sql
        ```

3. **Configure the Pipeline**
    1. Edit the configuration file in `config/` to set database credentials and file paths.
    2. Run the ETL/ELT script:
        ```sh
        python pipeline.py
        ```

## Project Structure

```
/project-root
│
├── data/                  # Input datasets
│   └── pagila-data.sql
├── docs/                  # Documentation files
├── sql/                   # SQL scripts for schema and transformations
│   ├── create-adventureworks.sql
│   ├── insert-data.sql
│   ├── transformations.sql
├── src/                   # Source code for ETL pipeline
│   └── pipeline.py
├── tests/                 # Unit tests for pipeline
├── Dockerfile             # Docker setup (if applicable)
├── README.md              # Project README
└── config/                # Configuration files
```

## How to Run the Project
1. **Start the Database:**
    - Start MySQL using your local installation or Docker:
        ```sh
        docker run -d --name mysql-server -p 3306:3306 -e MYSQL_ROOT_PASSWORD=yourpassword mysql:latest
        ```

2. **Load the Data:**
    - Run the SQL scripts to create the database and load the data.

3. **Execute the Pipeline:**
    - Navigate to the `src/` folder and run:
        ```sh
        python pipeline.py
        ```

4. **View Outputs:**
    - Outputs such as visualizations or email triggers will be available based on the pipeline configuration.

## Monitoring
- Logs are stored in the `logs/` folder for pipeline execution tracking.
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

Let me know if you’d like any modifications or additional sections!
