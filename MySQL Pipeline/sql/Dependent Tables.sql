USE Sales;

-- 1️⃣ Drop Dependent Tables First to Avoid Foreign Key Errors
DROP TABLE IF EXISTS BusinessEntityAddress;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS StateProvince;
DROP TABLE IF EXISTS AddressType;
DROP TABLE IF EXISTS BusinessEntity;

-- 2️⃣ Create `BusinessEntity`
CREATE TABLE BusinessEntity (
    BusinessEntityID INT AUTO_INCREMENT PRIMARY KEY,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3️⃣ Create `StateProvince`
CREATE TABLE StateProvince (
    StateProvinceID INT AUTO_INCREMENT PRIMARY KEY,
    StateProvinceCode CHAR(3) NOT NULL,
    CountryRegionCode VARCHAR(3) NOT NULL,
    IsOnlyStateProvinceFlag TINYINT(1) NOT NULL DEFAULT 1,
    Name VARCHAR(50) NOT NULL,
    TerritoryID INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Key Constraint
    CONSTRAINT FK_StateProvince_Territory FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4️⃣ Create `AddressType`
CREATE TABLE AddressType (
    AddressTypeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 5️⃣ Create `Address`
CREATE TABLE Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    AddressLine1 VARCHAR(60) NOT NULL,
    AddressLine2 VARCHAR(60) NULL,
    City VARCHAR(30) NOT NULL,
    StateProvinceID INT NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    SpatialLocation GEOMETRY NULL, -- Changed from GEOGRAPHY (not supported in MySQL)
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Key Constraint
    CONSTRAINT FK_Address_StateProvince FOREIGN KEY (StateProvinceID) REFERENCES StateProvince(StateProvinceID)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6️⃣ Create `BusinessEntityAddress`
CREATE TABLE BusinessEntityAddress (
    BusinessEntityID INT NOT NULL,
    AddressID INT NOT NULL,
    AddressTypeID INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Primary Key
    PRIMARY KEY (BusinessEntityID, AddressID, AddressTypeID),

    -- Foreign Key Constraints
    CONSTRAINT FK_BusinessEntityAddress_BusinessEntity FOREIGN KEY (BusinessEntityID) REFERENCES BusinessEntity(BusinessEntityID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_BusinessEntityAddress_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_BusinessEntityAddress_Type FOREIGN KEY (AddressTypeID) REFERENCES AddressType(AddressTypeID) 
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7️⃣ Create `Store`
CREATE TABLE Store (
    BusinessEntityID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    SalesPersonID INT NULL,
    Demographics JSON NULL, -- Changed from XML to JSON (MySQL does not support XML natively)
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Key Constraints
    CONSTRAINT FK_Store_BusinessEntity FOREIGN KEY (BusinessEntityID) REFERENCES BusinessEntity(BusinessEntityID)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Store_SalesPerson FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8️⃣ Create `Customer` (Without `AccountNumber`)
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    StoreID INT NULL, 
    TerritoryID INT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Key Constraints
    CONSTRAINT FK_Customer_Store FOREIGN KEY (StoreID) REFERENCES Store(BusinessEntityID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_Customer_Territory FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;