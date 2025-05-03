
CREATE DATABASE RetailDynamicsDB;
USE RetailDynamicsDB;

-- ------------------------------------------------------------------
-- Tabla: Tiendas (Stores)
-- ------------------------------------------------------------------
CREATE TABLE Stores (
    StoreID INT IDENTITY(1,1) PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    OpeningDate DATE,
    ManagerName VARCHAR(100)
);
GO

-- ------------------------------------------------------------------
-- Tabla: Productos (Products)
-- ------------------------------------------------------------------
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(100),
    Subcategory VARCHAR(100),
    UnitPrice DECIMAL(10, 2),
    Description TEXT
);
GO

-- ------------------------------------------------------------------
-- Tabla: Clientes (Customers)
-- ------------------------------------------------------------------
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    City VARCHAR(50),
    Country VARCHAR(50)
);
GO

-- ------------------------------------------------------------------
-- Tabla: Pedidos (Orders)
-- ------------------------------------------------------------------
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    StoreID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(50),
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);
GO

-- ------------------------------------------------------------------
-- Tabla: DetallesPedido (OrderDetails)
-- ------------------------------------------------------------------
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PricePerUnit DECIMAL(10, 2),
    Discount DECIMAL(3, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- ------------------------------------------------------------------
-- Tabla: Inventario (Inventory)
-- ------------------------------------------------------------------
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    StoreID INT,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT UQ_Inventory_StoreID_ProductID UNIQUE (StoreID, ProductID) -- Asegura unicidad en SQL Server
);
GO

-- ------------------------------------------------------------------
-- Tabla: Empleados (Employees)
-- ------------------------------------------------------------------
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    StoreID INT,
    JobTitle VARCHAR(100),
    HireDate DATE,
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);
GO

-- ------------------------------------------------------------------
-- Tabla: Promociones (Promotions)
-- ------------------------------------------------------------------
CREATE TABLE Promotions (
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    PromotionName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DiscountPercentage DECIMAL(3, 2),
    ApplicableToCategory VARCHAR(100),
	PromotionDescription VARCHAR(250),
);
GO

-- ------------------------------------------------------------------
-- Tabla: customer_reviews
-- ------------------------------------------------------------------
CREATE TABLE CustomerReviews (
    CustomerReviewsID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    ReviewDate DATE,
    Rating INT,
    ReviewText VARCHAR(250),
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
	FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
GO

CREATE TABLE ProductReviews (
	ProductReviewID INT IDENTITY(1, 1) PRIMARY KEY,
	ProductID INT,
	Likes INT,
	Click INT, 
	Views INT, 
	ReviewDate DATE,
	FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);

GO
-- ------------------------------------------------------------------
-- Fin del script
-- ------------------------------------------------------------------


SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM ProductReviews;
