USE my_pipelineADS507_5;
-- ====================================================
-- Example Production Schema for a Data Pipeline
-- Inspired by instawdb.sql (e.g., AdventureWorks)
-- ====================================================

-- Drop the database if it exists (for development/testing purposes)
DROP DATABASE IF EXISTS production;

-- Create the database (i.e. the schema)
CREATE DATABASE production;
USE production;

-- ====================================================
-- Table: ProductCategory
-- A high-level grouping of products
-- ====================================================
CREATE TABLE ProductCategory (
    ProductCategoryID INT AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ProductCategoryID)
) ENGINE=InnoDB;

-- ====================================================
-- Table: ProductSubcategory
-- A subdivision of a product category; each subcategory belongs to one category
-- ====================================================
CREATE TABLE ProductSubcategory (
    ProductSubcategoryID INT AUTO_INCREMENT,
    ProductCategoryID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ProductSubcategoryID),
    CONSTRAINT fk_ProductSubcategory_Category
      FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ====================================================
-- Table: Product
-- The main product table with pricing and availability details.
-- This example is inspired by the instawdb.sql [Production].[Product] table.
-- ====================================================
CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT,
    ProductSubcategoryID INT,  -- This can be nullable if a product is not assigned a subcategory
    Name VARCHAR(100) NOT NULL,
    ProductNumber VARCHAR(25) NOT NULL,
    Color VARCHAR(25),
    StandardCost DECIMAL(10,2) NOT NULL,
    ListPrice DECIMAL(10,2) NOT NULL,
    SellStartDate DATE NOT NULL,
    SellEndDate DATE,
    DiscontinuedDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ProductID),
    CONSTRAINT fk_Product_Subcategory
      FOREIGN KEY (ProductSubcategoryID) REFERENCES ProductSubcategory(ProductSubcategoryID)
      ON DELETE SET NULL ON UPDATE CASCADE,
    UNIQUE KEY uq_Product_ProductNumber (ProductNumber)
) ENGINE=InnoDB;

-- ====================================================
-- Table: ProductInventory
-- Holds inventory details for products at different locations.
-- ====================================================
CREATE TABLE ProductInventory (
    InventoryID INT AUTO_INCREMENT,
    ProductID INT NOT NULL,
    Location VARCHAR(50) NOT NULL,
    Shelf VARCHAR(10),
    Bin TINYINT,
    Quantity INT NOT NULL DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (InventoryID),
    CONSTRAINT fk_Inventory_Product
      FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ====================================================
-- Table: WorkOrder
-- Represents production work orders for manufacturing products.
-- This table is simplified from the instawdb.sql [Production].[WorkOrder] table.
-- ====================================================
CREATE TABLE WorkOrder (
    WorkOrderID INT AUTO_INCREMENT,
    ProductID INT NOT NULL,
    OrderQty INT NOT NULL,
    -- For demonstration, StockedQty is calculated from OrderQty minus scrapped quantity.
    -- (In MySQL 5.7+ you can use generated columns if needed.)
    ScrappedQty INT DEFAULT 0,
    StartDate DATE NOT NULL,
    EndDate DATE,
    DueDate DATE NOT NULL,
    ScrapReason VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (WorkOrderID),
    CONSTRAINT fk_WorkOrder_Product
      FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ====================================================
-- Table: WorkOrderRouting
-- Details the routing (steps/operations) for each work order.
-- This table is inspired by [Production].[WorkOrderRouting] in instawdb.sql.
-- ====================================================
CREATE TABLE WorkOrderRouting (
    WorkOrderRoutingID INT AUTO_INCREMENT,
    WorkOrderID INT NOT NULL,
    OperationSequence SMALLINT NOT NULL,
    Location VARCHAR(50) NOT NULL,
    ScheduledStartDate DATETIME NOT NULL,
    ScheduledEndDate DATETIME NOT NULL,
    ActualStartDate DATETIME,
    ActualEndDate DATETIME,
    ActualResourceHrs DECIMAL(9,4) DEFAULT 0.0,
    PlannedCost DECIMAL(10,2) NOT NULL,
    ActualCost DECIMAL(10,2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (WorkOrderRoutingID),
    CONSTRAINT fk_WOR_WorkOrder
      FOREIGN KEY (WorkOrderID) REFERENCES WorkOrder(WorkOrderID)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;