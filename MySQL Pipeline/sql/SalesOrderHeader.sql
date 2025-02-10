USE Sales;

DROP TABLE IF EXISTS SalesOrderHeader;

CREATE TABLE SalesOrderHeader (
    SalesOrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL DEFAULT (CURDATE()),
    SalesPersonID INT NULL,
    SubTotal DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    TaxAmt DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    Freight DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    TotalDue DECIMAL(18,2) GENERATED ALWAYS AS (SubTotal + TaxAmt + Freight) STORED,
    RevisionNumber TINYINT NOT NULL DEFAULT 0,
    DueDate DATETIME NOT NULL,
    Status TINYINT NOT NULL DEFAULT 1 CHECK (Status BETWEEN 0 AND 8),
    OnlineOrderFlag TINYINT(1) NOT NULL DEFAULT 1,
    PurchaseOrderNumber VARCHAR(25) NULL,
    AccountNumber VARCHAR(25) NULL,
    CustomerID INT NOT NULL,
    TerritoryID INT NULL,
    BillToAddressID INT NOT NULL,
    ShipToAddressID INT NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- ✅ Changed SalesOrderNumber to a Normal Column
    SalesOrderNumber VARCHAR(30) NULL,

    -- Foreign Key Constraints
    CONSTRAINT FK_SalesOrderHeader_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_SalesOrderHeader_SalesPerson FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_SalesOrderHeader_Territory FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_SalesOrderHeader_BillTo FOREIGN KEY (BillToAddressID) REFERENCES Address(AddressID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_SalesOrderHeader_ShipTo FOREIGN KEY (ShipToAddressID) REFERENCES Address(AddressID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;