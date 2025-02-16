# MySQL Pipeline

## Overview
This project aims to provide a production-ready data pipeline using MySQL databases and SQL-based transformations. Building on our original AdventureWorks-inspired schema, we have now expanded to incorporate multiple databases—**Sales**, **AdventurePurchase**, **AdventureSales**, and **HumanResources**—each supporting different functional areas. This document outlines how these databases fit into our updated ETL/ELT pipeline, the key tables, and how to configure and run the pipeline.

---

## Database Architecture

### 1. Sales Database
- Currently under development in our pipeline (no tables shown in the screenshot).  
- Future plans may include tables such as `SalesOrder`, `SalesInvoice`, or others depending on business requirements.

### 2. AdventurePurchase Database
- **Tables:**
  - **PurchaseOrderHeader**  
    Stores high-level information about each purchase order (e.g., vendor, order date, status).  
  - **PurchaseOrderDetail**  
    Contains line-item details for each purchase order (e.g., product, quantity, cost).  
  - **ShipMethod**  
    Enumerates shipping/carrier methods for orders, enabling logistics and cost analysis.  
- **Views (if any)**  
  - May contain pre-joined or aggregated data for reporting.

### 3. AdventureSales Database
- **Tables:**
  - **Customers**  
    Holds customer data such as names, addresses, and contact information.  
  - **SalesOrderDetail**  
    Represents line items for sales orders (product, quantity, price, etc.).  
  - **SalesTerritory**  
    Defines geographical or market segments (e.g., regions) to facilitate sales analytics.  
- **Views (if any)**  
  - Could aggregate or transform sales data for dashboards and reports.

### 4. HumanResources Database
- **Tables:**
  - **Employee**  
    Maintains employee records, including basic personal info, job title, department, etc.  
- **Views (if any)**  
  - Could integrate data from other sources (e.g., payroll, benefits) for HR-specific reporting.

---

## How These Databases Fit Into the Pipeline

1. **Data Ingestion (Extract):**  
   - We source raw data (e.g., CSV files, APIs) that map to each of the databases.  
   - For example, vendor data feeds into `AdventurePurchase`, while sales transactions feed into `AdventureSales`, and HR employee records flow into `HumanResources`.

2. **Data Loading (Load/ELT):**  
   - Data is either loaded directly into staging tables or appended to the final tables in each database.  
   - Python scripts or SQL `LOAD DATA` commands (bulk inserts) may be used to populate these tables.

3. **Transformations (Transform):**  
   - SQL transformations (e.g., in `sql/transformations.sql`) standardize data formats, apply business rules, and link tables across the different databases when needed.  
   - For example, a transformation could merge region codes in `SalesTerritory` with shipping zones used in `AdventurePurchase`.

4. **Analytics and Reporting:**  
   - Once the data is consistent and cleansed, it can be queried to produce dashboards, aggregated tables, or views.  
   - Tools like Power BI, Tableau, or Python libraries can connect to these MySQL databases for deeper analysis.

---

## Features

- **Multiple Schemas:**  
  Separate databases (`Sales`, `AdventurePurchase`, `AdventureSales`, and `HumanResources`) allow for clear boundaries and easier maintenance.

- **SQL-Centric Pipeline:**  
  Strong reliance on SQL for transformations, ensuring performance and simplicity within MySQL.

- **Modular ETL/ELT:**  
  The pipeline can be configured to handle each database individually or in sequence, depending on your data workflow.

- **Integration and Reporting:**  
  Each database can feed into the same reporting layer (e.g., BI tools) for comprehensive analytics or remain siloed for domain-specific insights.

---

## Requirements

1. **MySQL Server:** Version 8.0 or later.  
2. **Python (optional):** If using Python scripts for automation, version 3.7+ is recommended.  
3. **MySQL Workbench or VSCode MySQL Shell Extension:** Useful for running queries and reviewing schemas.  
4. **Docker (optional):** For containerized deployments.

---

## Setup Instructions

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/Gabeleo24/ADS-507/tree/main/MySQL%20Pipeline

2. **Set Up the MySQL Database**
    - Download and install MySQL Server from the [MySQL Downloads](https://dev.mysql.com/downloads/) page.
    - Run the SQL script to create your production-ready schema:
      ```sh
    const configUserC = {
    host: 'team-shared-mysql.cjwa24wusi...',
    user: 'ADS507',
    password: 'Gabrielleo24',
    database: 'Sales',
    localInfile: true
};
      ```
    - Load the CSV data files for each table (located in the `data/` folder) using the provided BULK INSERT commands or your preferred method.

3. **Configure the Pipeline**
    - Edit the configuration file in the `config/` directory to set database credentials and file paths.
    - Run the ETL/ELT script:
      ```sh
      python src/pipeline.py
      ```

## Project Structure
/MySQL Pipeline
├── js/
│   ├── Node.js
├── data/
│   ├── PurchaseOrderHeader.csv
│   ├── PurchaseOrderDetail.csv
│   ├── ShipMethod.csv
│   ├── Customers.csv
│   ├── SalesOrderDetail.csv
│   ├── SalesTerritory.csv
│   ├── Employee.csv
│   └── ...
├── docs/
├── sql/
│   ├── create-databases.sql
│   ├── transformations.sql
│   ├── ...
├── src/
│   └── pipeline.py
├── tests/
├── Dockerfile
├── README.md
└── config/
    └── db_config.yaml (example)
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

## Monitoring & Maintenance

- Logs: Check your logs folder (e.g., logs/) for pipeline execution statuses or errors.
- MySQL Monitoring: Tools such as MySQL Workbench, VS Code’s MySQL extension, or third-party dashboards (e.g., Percona Monitoring) can track server load, query performance, etc.
- Error Handling: Implement robust exception handling in your ETL scripts. If a load or transformation fails, the pipeline should log the error and optionally send notifications (e.g., via email or Slack).

## Next Steps

### Future Improvements

1. Scalability:
   - Partition large tables or implement data archiving for older records.
2. Cloud Integration:
   - Migrate the MySQL instances to AWS RDS, Azure Database for MySQL, or GCP Cloud SQL.
3. CI/CD:
   - Automate schema changes and data loading via a continuous integration pipeline (e.g., GitHub Actions).
4. Data Governance & Quality:
   - Implement validation rules and data quality checks within the pipeline.

## License
This project is licensed under the MIT License.

## Contributors
- Contributor 1: Duy Nguyen 
- Contributor 2: Jorge Roldan