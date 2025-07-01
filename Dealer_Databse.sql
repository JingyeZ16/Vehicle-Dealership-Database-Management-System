-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- Team2_Dealer.dbo.Address definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Address;

CREATE TABLE Team2_Dealer.dbo.Address (
	AddressID int NOT NULL,
	Street varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	City varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	State varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PostalCode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Address__091C2A1B537F0DBA PRIMARY KEY (AddressID)
);


-- Team2_Dealer.dbo.Configuration definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Configuration;

CREATE TABLE Team2_Dealer.dbo.Configuration (
	ConfigurationID int NOT NULL,
	Model varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Make varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Year] int NULL,
	Color varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Transmission varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FuelType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BodyType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DriveType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MSRP decimal(10,2) NULL,
	SeatCount int NULL,
	CONSTRAINT PK__Configur__95AA539BA1C30E65 PRIMARY KEY (ConfigurationID)
);


-- Team2_Dealer.dbo.Customer definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Customer;

CREATE TABLE Team2_Dealer.dbo.Customer (
	CustomerID int NOT NULL,
	FirstName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LastName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DateOfBirth date NULL,
	DriverLicenseNumber varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Phone varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Customer__A4AE64B8A45B3F2D PRIMARY KEY (CustomerID)
);
ALTER TABLE Team2_Dealer.dbo.Customer WITH NOCHECK ADD CONSTRAINT CHK_PhoneFormat CHECK (([dbo].[ValidatePhoneFormat]([Phone])=(1)));


-- Team2_Dealer.dbo.Previous_Owners definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Previous_Owners;

CREATE TABLE Team2_Dealer.dbo.Previous_Owners (
	PreviousOwnerID int NOT NULL,
	FirstName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LastName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Previous__D3C73A2ED0F4F906 PRIMARY KEY (PreviousOwnerID)
);


-- Team2_Dealer.dbo.Supplier definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Supplier;

CREATE TABLE Team2_Dealer.dbo.Supplier (
	SupplierID int NOT NULL,
	SupplierType varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SupplierInformation text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Supplier__4BE666948FA8B324 PRIMARY KEY (SupplierID)
);


-- Team2_Dealer.dbo.Team definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Team;

CREATE TABLE Team2_Dealer.dbo.Team (
	TeamID int NOT NULL,
	CONSTRAINT PK__Team__123AE7B96CA019BA PRIMARY KEY (TeamID)
);



-- Team2_Dealer.dbo.Configuration_Inventory definition

-- Drop table

DROP TABLE Team2_Dealer.dbo.Configuration_Inventory;

-- Computed Columns based on a function
Create TABLE Team2_Dealer.dbo.Configuration_Inventory (
	ConfigurationID int NULL,
	InventoryLevel int not null,
	InventoryStatu as dbo.GetInventoryLevel(InventoryLevel),
	CONSTRAINT FK_ConfigInventory_Config FOREIGN KEY (ConfigurationID) REFERENCES Team2_Dealer.dbo.Configuration(ConfigurationID)
);


-- Team2_Dealer.dbo.Employee definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Employee;

CREATE TABLE Team2_Dealer.dbo.Employee (
	EmployeeID int NOT NULL,
	TeamID int NULL,
	FirstName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LastName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PositionTitle varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Department varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Phone varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Employee__7AD04FF10E405E71 PRIMARY KEY (EmployeeID),
	CONSTRAINT FK_Employee_Team FOREIGN KEY (TeamID) REFERENCES Team2_Dealer.dbo.Team(TeamID)
);


-- Team2_Dealer.dbo.Part_Information definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Part_Information;

CREATE TABLE Team2_Dealer.dbo.Part_Information (
	PartID int NOT NULL,
	SupplierID int NULL,
	PartInfo text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PartInventoryLevel int NULL,
	CONSTRAINT PK__Part_Inf__7C3F0D3068E0AD0C PRIMARY KEY (PartID),
	CONSTRAINT FK_PartInfo_Supplier FOREIGN KEY (SupplierID) REFERENCES Team2_Dealer.dbo.Supplier(SupplierID)
);


-- Team2_Dealer.dbo.Vehicle_Information definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Vehicle_Information;

CREATE TABLE Team2_Dealer.dbo.Vehicle_Information (
	VIN varchar(17) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ConfigurationID int NULL,
	PreviousOwnerID int NULL,
	Mileage int NULL,
	Status varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SupplierID int NULL,
	CONSTRAINT PK__Vehicle___C5DF234DB718C577 PRIMARY KEY (VIN),
	CONSTRAINT FK_VehicleInfo_Config FOREIGN KEY (ConfigurationID) REFERENCES Team2_Dealer.dbo.Configuration(ConfigurationID),
	CONSTRAINT FK_VehicleInfo_PreviousOwner FOREIGN KEY (PreviousOwnerID) REFERENCES Team2_Dealer.dbo.Previous_Owners(PreviousOwnerID),
	CONSTRAINT FK_VehicleInformation_Supplier FOREIGN KEY (SupplierID) REFERENCES Team2_Dealer.dbo.Supplier(SupplierID)
);


-- Team2_Dealer.dbo.[Order] definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.[Order];

CREATE TABLE Team2_Dealer.dbo.[Order] (
	OrderID int NOT NULL,
	VIN varchar(17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerID int NULL,
	EmployeeID int NULL,
	OrderStatus varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrderDate date NULL,
	DeliveryOption varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Order__C3905BAF77950BFA PRIMARY KEY (OrderID),
	CONSTRAINT FK__Order__CustomerI__72C60C4A FOREIGN KEY (CustomerID) REFERENCES Team2_Dealer.dbo.Customer(CustomerID),
	CONSTRAINT FK__Order__EmployeeI__73BA3083 FOREIGN KEY (EmployeeID) REFERENCES Team2_Dealer.dbo.Employee(EmployeeID),
	CONSTRAINT FK__Order__VIN__74AE54BC FOREIGN KEY (VIN) REFERENCES Team2_Dealer.dbo.Vehicle_Information(VIN)
);


-- Team2_Dealer.dbo.Quote definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Quote;

CREATE TABLE Team2_Dealer.dbo.Quote (
	QuoteID int NOT NULL,
	EmployeeID int NULL,
	VIN varchar(17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Date] date NULL,
	QuotePrice decimal(10,2) NULL,
	CONSTRAINT PK__Quote__AF9688E1DFF96707 PRIMARY KEY (QuoteID),
	CONSTRAINT FK__Quote__EmployeeI__6E01572D FOREIGN KEY (EmployeeID) REFERENCES Team2_Dealer.dbo.Employee(EmployeeID),
	CONSTRAINT FK__Quote__VIN__6FE99F9F FOREIGN KEY (VIN) REFERENCES Team2_Dealer.dbo.Vehicle_Information(VIN)
);


-- Team2_Dealer.dbo.Sales definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Sales;

CREATE TABLE Team2_Dealer.dbo.Sales (
	TransactionID int NOT NULL,
	VIN varchar(17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerID int NULL,
	Amount decimal(10,2) NULL,
	Payment varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FinancingDetail varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SaleChannel varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BillingInfo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrderID int NULL,
	CONSTRAINT PK__Sales__55433A4B5A5E53C7 PRIMARY KEY (TransactionID),
	CONSTRAINT FK_Sales_Order FOREIGN KEY (OrderID) REFERENCES Team2_Dealer.dbo.[Order](OrderID),
	CONSTRAINT FK__Sales__CustomerI__6A30C649 FOREIGN KEY (CustomerID) REFERENCES Team2_Dealer.dbo.Customer(CustomerID),
	CONSTRAINT FK__Sales__VIN__6B24EA82 FOREIGN KEY (VIN) REFERENCES Team2_Dealer.dbo.Vehicle_Information(VIN)
);


-- Team2_Dealer.dbo.Service definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Service;

CREATE TABLE Team2_Dealer.dbo.Service (
	ServiceTicketID int NOT NULL,
	VIN varchar(17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TeamID int NULL,
	Service text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ServiceDate date NULL,
	PartID int NULL,
	CONSTRAINT PK__Service__3BB0FE64440C554E PRIMARY KEY (ServiceTicketID),
	CONSTRAINT FK_Service_Part_Information FOREIGN KEY (PartID) REFERENCES Team2_Dealer.dbo.Part_Information(PartID),
	CONSTRAINT FK_Service_Team FOREIGN KEY (TeamID) REFERENCES Team2_Dealer.dbo.Team(TeamID),
	CONSTRAINT FK_Service_Vehicle_Information FOREIGN KEY (VIN) REFERENCES Team2_Dealer.dbo.Vehicle_Information(VIN)
);


-- Team2_Dealer.dbo.Shipment definition

-- Drop table

-- DROP TABLE Team2_Dealer.dbo.Shipment;

CREATE TABLE Team2_Dealer.dbo.Shipment (
	TransactionID int NOT NULL,
	VIN varchar(17) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	AddressID int NULL,
	ShipDate date NULL,
	ArrivalDate date NULL,
	TrackingNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ShippingMethod varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ShipperInfo varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Shipment__991EC87F58D84501 PRIMARY KEY (TransactionID,VIN),
	CONSTRAINT FK__Shipment__Addres__797309D9 FOREIGN KEY (AddressID) REFERENCES Team2_Dealer.dbo.Address(AddressID),
	CONSTRAINT FK__Shipment__Transa__778AC167 FOREIGN KEY (TransactionID) REFERENCES Team2_Dealer.dbo.Sales(TransactionID),
	CONSTRAINT FK__Shipment__VIN__787EE5A0 FOREIGN KEY (VIN) REFERENCES Team2_Dealer.dbo.Vehicle_Information(VIN)
);


INSERT INTO Team2_Dealer.dbo.Address (AddressID,Street,City,State,PostalCode) VALUES
	 (101,N'2479 Stewart Street',N'Seattle',N'WA',N'98108'),
	 (102,N'593 Stewart Street',N'Seattle',N'WA',N'98106'),
	 (103,N'7983 Dexter Avenue',N'Seattle',N'WA',N'98119'),
	 (104,N'424 Pine Street',N'Seattle',N'WA',N'98107'),
	 (105,N'NU1824 Westlake AvenueLL',N'Seattle',N'WA',N'98103'),
	 (106,N'9807 Fremont Avenue',N'Seattle',N'WA',N'98116'),
	 (107,N'4258 3rd Avenue',N'Seattle',N'WA',N'98112'),
	 (108,N'3472 2nd Avenue',N'Seattle',N'WA',N'98107'),
	 (109,N'1672 Dexter Avenue',N'Seattle',N'WA',N'98118'),
	 (110,N'9622 Rainier Avenue',N'Seattle',N'WA',N'98102');
INSERT INTO Team2_Dealer.dbo.Address (AddressID,Street,City,State,PostalCode) VALUES
	 (111,N'5863 Dexter Avenue',N'Seattle',N'WA',N'98119'),
	 (112,N'1975 Eastlake Avenue',N'Seattle',N'WA',N'98108'),
	 (113,N'6449 Broadway',N'Seattle',N'WA',N'98106'),
	 (114,N'8930 Cherry Street',N'Seattle',N'WA',N'98109'),
	 (115,N'1831 Eastlake Avenue',N'Seattle',N'WA',N'98103'),
	 (116,N'3583 164th Avenue',N'Bellevue',N'WA',N'98004'),
	 (117,N'1544 NE 8th Street',N'Bellevue',N'WA',N'98015'),
	 (118,N'6601 112th Avenue',N'Bellevue',N'WA',N'98004'),
	 (119,N'5804 Northup Way',N'Bellevue',N'WA',N'98004'),
	 (120,N'7296 112th Avenue',N'Bellevue',N'WA',N'98004');
INSERT INTO Team2_Dealer.dbo.Address (AddressID,Street,City,State,PostalCode) VALUES
	 (121,N'2681 Northup Way',N'Bellevue',N'WA',N'98015'),
	 (122,N'9717 148th Avenue',N'Bellevue',N'WA',N'98005'),
	 (123,N'9652 NE 10th Street',N'Bellevue',N'WA',N'98008'),
	 (124,N'2814 Richards Road',N'Bellevue',N'WA',N'98015'),
	 (125,N'1143 NE 20th Street',N'Bellevue',N'WA',N'98007');
INSERT INTO Team2_Dealer.dbo.Configuration (ConfigurationID,Model,Make,[Year],Color,Transmission,FuelType,BodyType,DriveType,MSRP,SeatCount) VALUES
	 (1001,N'Camry',N'Toyota',2023,N'Silver',N'Automatic',N'Gasoline',N'Sedan',N'FWD',25000.00,5),
	 (1002,N'Civic',N'Honda',2023,N'Black',N'Automatic',N'Gasoline',N'Sedan',N'FWD',23000.00,5),
	 (1003,N'F-150',N'Ford',2024,N'White',N'Automatic',N'Gasoline',N'Truck',N'4WD',30000.00,5),
	 (1004,N'Accord',N'Honda',2023,N'Grey',N'Automatic',N'Hybrid',N'Sedan',N'FWD',27000.00,5),
	 (1005,N'Model 3',N'Tesla',2023,N'Blue',N'Automatic',N'Electric',N'Sedan',N'RWD',35000.00,5),
	 (1006,N'Mustang',N'Ford',2024,N'Red',N'Manual',N'Gasoline',N'Coupe',N'RWD',26000.00,4),
	 (1007,N'Tacoma',N'Toyota',2023,N'Green',N'Automatic',N'Gasoline',N'Truck',N'4WD',34000.00,5),
	 (1008,N'Q5',N'Audi',2023,N'Black',N'Automatic',N'Gasoline',N'SUV',N'AWD',43000.00,5),
	 (1009,N'GLE',N'Mercedes-Benz',2024,N'White',N'Automatic',N'Gasoline',N'SUV',N'AWD',54000.00,5),
	 (1010,N'X5',N'BMW',2023,N'Blue',N'Automatic',N'Diesel',N'SUV',N'AWD',61000.00,5);
INSERT INTO Team2_Dealer.dbo.Configuration (ConfigurationID,Model,Make,[Year],Color,Transmission,FuelType,BodyType,DriveType,MSRP,SeatCount) VALUES
	 (1011,N'3 Series',N'BMW',2024,N'Black',N'Automatic',N'Gasoline',N'Sedan',N'RWD',41000.00,5),
	 (1012,N'Corolla',N'Toyota',2023,N'Red',N'Automatic',N'Gasoline',N'Sedan',N'FWD',20000.00,5),
	 (1013,N'Silverado',N'Chevrolet',2024,N'Blue',N'Automatic',N'Diesel',N'Truck',N'4WD',29000.00,5),
	 (1014,N'CR-V',N'Honda',2023,N'Silver',N'Automatic',N'Gasoline',N'SUV',N'AWD',25000.00,5),
	 (1015,N'Explorer',N'Ford',2024,N'Black',N'Automatic',N'Gasoline',N'SUV',N'4WD',32000.00,7),
	 (1016,N'Impala',N'Chevrolet',2023,N'Grey',N'Automatic',N'Gasoline',N'Sedan',N'FWD',28000.00,5),
	 (1017,N'C-Class',N'Mercedes-Benz',2024,N'White',N'Automatic',N'Gasoline',N'Sedan',N'RWD',39000.00,5),
	 (1018,N'A4',N'Audi',2023,N'Blue',N'Automatic',N'Gasoline',N'Sedan',N'AWD',37000.00,5),
	 (1019,N'Model Y',N'Tesla',2023,N'Black',N'Automatic',N'Electric',N'SUV',N'AWD',48000.00,7),
	 (1020,N'S-Class',N'Mercedes-Benz',2024,N'Silver',N'Automatic',N'Hybrid',N'Sedan',N'AWD',70000.00,5);
INSERT INTO Team2_Dealer.dbo.Configuration (ConfigurationID,Model,Make,[Year],Color,Transmission,FuelType,BodyType,DriveType,MSRP,SeatCount) VALUES
	 (1021,N'Malibu',N'Chevrolet',2023,N'Red',N'Automatic',N'Gasoline',N'Sedan',N'FWD',22000.00,5),
	 (1022,N'TT',N'Audi',2024,N'White',N'Automatic',N'Gasoline',N'Coupe',N'AWD',45000.00,4),
	 (1023,N'Prius',N'Toyota',2023,N'Green',N'Automatic',N'Hybrid',N'Hatchback',N'FWD',24000.00,5),
	 (1024,N'Focus',N'Ford',2024,N'Black',N'Manual',N'Gasoline',N'Hatchback',N'FWD',20000.00,5),
	 (1025,N'Cruze',N'Chevrolet',2023,N'Blue',N'Automatic',N'Gasoline',N'Sedan',N'FWD',21000.00,5);
INSERT INTO Team2_Dealer.dbo.Configuration_Inventory (ConfigurationID,InventoryLevel) VALUES
	 (1001,3),
	 (1002,9),
	 (1003,9),
	 (1004,1),
	 (1005,10),
	 (1006,6),
	 (1007,8),
	 (1008,1),
	 (1009,2),
	 (1010,6);
INSERT INTO Team2_Dealer.dbo.Configuration_Inventory (ConfigurationID,InventoryLevel) VALUES
	 (1011,5),
	 (1012,4),
	 (1013,1),
	 (1014,4),
	 (1015,10),
	 (1016,2),
	 (1017,2),
	 (1018,8),
	 (1019,2),
	 (1020,9);
INSERT INTO Team2_Dealer.dbo.Configuration_Inventory (ConfigurationID,InventoryLevel) VALUES
	 (1021,3),
	 (1022,3),
	 (1023,8),
	 (1024,9),
	 (1025,3);
INSERT INTO Team2_Dealer.dbo.Customer (CustomerID,FirstName,LastName,DateOfBirth,DriverLicenseNumber,Phone,Email) VALUES
	 (1,N'Kimberly',N'Dean','1946-04-16',N'3110397097',N'(461)-477-8929',N'vcarey@gmail.com'),
	 (2,N'John',N'Shannon','1961-12-12',N'5026116510',N'(502)-611-6510',N'morgandenise@hotmail.com'),
	 (3,N'Henry',N'Smith','1964-04-27',N'4917272044',N'(549)-465-8156',N'brandon82@gmail.com'),
	 (4,N'Frank',N'Wall','1998-05-10',N'7644422349',N'(764)-442-2349',N'mullinsscott@hotmail.com'),
	 (5,N'Wendy',N'Brown','1961-09-12',N'6389771813',N'(527)-727-5586',N'brandtpeggy@yahoo.com'),
	 (6,N'Mathew',N'Wolfe','1990-04-21',N'4036038635',N'(403)-603-8635',N'evansmelinda@hotmail.com'),
	 (7,N'Jesse',N'James','1946-07-09',N'3598415663',N'(228)-903-4367',N'stevensmichael@yahoo.com'),
	 (8,N'Angela',N'Meyer','1986-10-14',N'4816978574',N'(655)-598-6253',N'jamesdouglas@hotmail.com'),
	 (9,N'Jonathan',N'Thomas','1943-07-11',N'8334010423',N'(296)-470-9474',N'nicholas98@yahoo.com'),
	 (10,N'Michael',N'Reynolds','1988-09-23',N'5819247995',N'(341)-555-1366',N'cfreeman@hotmail.com');
INSERT INTO Team2_Dealer.dbo.Customer (CustomerID,FirstName,LastName,DateOfBirth,DriverLicenseNumber,Phone,Email) VALUES
	 (11,N'Christine',N'Wright','1963-08-22',N'4815608515',N'(310)-821-8137',N'whitneynicole@hotmail.com'),
	 (12,N'Timothy',N'Carter','1949-04-08',N'2437678906',N'(408)-840-5881',N'cervantesmichelle@gmail.com'),
	 (13,N'Dawn',N'Lewis','1968-06-16',N'5568355009',N'(918)-788-0159',N'jennifer41@gmail.com'),
	 (14,N'Natalie',N'Griffin','1975-01-29',N'5758898710',N'(750)-748-1241',N'sandra50@yahoo.com'),
	 (15,N'Thomas',N'Pena','1997-08-08',N'7652019205',N'(744)-897-3337',N'brittany40@yahoo.com'),
	 (16,N'Jamie',N'Nolan','1989-09-08',N'0458882617',N'(606)-992-8321',N'robertsjamie@hotmail.com'),
	 (17,N'Dylan',N'Gutierrez','1955-08-19',N'0667692114',N'(309)-671-8674',N'jensenjeffrey@yahoo.com'),
	 (18,N'Angelica',N'Mcdaniel','1949-04-08',N'2451125457',N'(908)-245-1254',N'harristina@gmail.com'),
	 (19,N'Kristy',N'May','1958-11-08',N'7326042170',N'(231)-566-0631',N'kristywilliams@yahoo.com'),
	 (20,N'Amanda',N'Davis','1972-02-29',N'5822812673',N'(818)-248-0700',N'ylopez@yahoo.com');
INSERT INTO Team2_Dealer.dbo.Customer (CustomerID,FirstName,LastName,DateOfBirth,DriverLicenseNumber,Phone,Email) VALUES
	 (21,N'Samantha',N'House','1960-11-17',N'1300029935',N'(335)-222-0346',N'pchan@gmail.com'),
	 (22,N'Hayley',N'Andrews','1978-05-04',N'8496327760',N'(751)-407-3547',N'uharris@gmail.com'),
	 (23,N'Mary',N'Perkins','1952-12-11',N'3222225005',N'(978)-614-9018',N'thompsonjennifer@hotmail.com'),
	 (24,N'Jane',N'Martin','2004-01-13',N'3154548700',N'(747)-295-5707',N'espinozalaura@yahoo.com'),
	 (25,N'Claire',N'Newman','1970-06-10',N'0406194714',N'(306)-653-8355',N'chavezrobert@yahoo.com');
INSERT INTO Team2_Dealer.dbo.Employee (EmployeeID,TeamID,FirstName,LastName,PositionTitle,Department,Phone,Email) VALUES
	 (201,101,N'John',N'Smith',N'Salesperson',N'Sales',N'123-456-7890',N'john.smith@example.com'),
	 (202,101,N'Mary',N'Johnson',N'Salesperson',N'Sales',N'234-567-8901',N'mary.johnson@example.com'),
	 (203,101,N'Robert',N'Williams',N'Salesperson',N'Sales',N'345-678-9012',N'robert.williams@example.com'),
	 (204,101,N'Patricia',N'Brown',N'Salesperson',N'Sales',N'456-789-0123',N'patricia.brown@example.com'),
	 (205,101,N'Michael',N'Taylor',N'Salesperson',N'Sales',N'567-890-1234',N'michael.taylor@example.com'),
	 (206,101,N'Jessica',N'Miller',N'Manager',N'Sales',N'678-901-2345',N'jessica.miller@example.com'),
	 (207,102,N'David',N'Davis',N'HR',N'HR',N'789-012-3456',N'david.davis@example.com'),
	 (208,102,N'Jennifer',N'Wilson',N'HR',N'HR',N'890-123-4567',N'jennifer.wilson@example.com'),
	 (209,102,N'Richard',N'Anderson',N'Manager',N'HR',N'901-234-5678',N'richard.anderson@example.com'),
	 (210,103,N'Christopher',N'Martinez',N'Technician',N'Service',N'012-345-6789',N'christopher.martinez@example.com');
INSERT INTO Team2_Dealer.dbo.Employee (EmployeeID,TeamID,FirstName,LastName,PositionTitle,Department,Phone,Email) VALUES
	 (211,103,N'Linda',N'Thomas',N'Technician',N'Service',N'123-456-7890',N'linda.thomas@example.com'),
	 (212,103,N'Daniel',N'Hernandez',N'Technician',N'Service',N'234-567-8901',N'daniel.hernandez@example.com'),
	 (213,103,N'Ashley',N'Moore',N'Technician',N'Service',N'345-678-9012',N'ashley.moore@example.com'),
	 (214,103,N'Matthew',N'Nelson',N'Manager',N'Service',N'456-789-0123',N'matthew.nelson@example.com'),
	 (215,104,N'Amanda',N'Roberts',N'Technician',N'Service',N'567-890-1234',N'amanda.roberts@example.com'),
	 (216,104,N'Jason',N'Johnson',N'Technician',N'Service',N'678-901-2345',N'jason.johnson@example.com'),
	 (217,104,N'Sarah',N'Lee',N'Technician',N'Service',N'789-012-3456',N'sarah.lee@example.com'),
	 (218,104,N'Kevin',N'Scott',N'Technician',N'Service',N'890-123-4567',N'kevin.scott@example.com'),
	 (219,104,N'Laura',N'Garcia',N'Manager',N'Service',N'901-234-5678',N'laura.garcia@example.com'),
	 (220,105,N'Justin',N'King',N'Technician',N'Service',N'012-345-6789',N'justin.king@example.com');
INSERT INTO Team2_Dealer.dbo.Employee (EmployeeID,TeamID,FirstName,LastName,PositionTitle,Department,Phone,Email) VALUES
	 (221,105,N'Megan',N'Lewis',N'Technician',N'Service',N'123-456-7890',N'megan.lewis@example.com'),
	 (222,105,N'Brandon',N'Hall',N'Technician',N'Service',N'234-567-8901',N'brandon.hall@example.com'),
	 (223,105,N'Rachel',N'Young',N'Technician',N'Service',N'345-678-9012',N'rachel.young@example.com'),
	 (224,105,N'Tyler',N'Allen',N'Manager',N'Service',N'456-789-0123',N'tyler.allen@example.com'),
	 (225,106,N'Emily',N'White',N'Technician',N'Service',N'567-890-1234',N'emily.white@example.com'),
	 (226,106,N'Andrew',N'Perez',N'Technician',N'Service',N'678-901-2345',N'andrew.perez@example.com'),
	 (227,106,N'Kelsey',N'Carter',N'Technician',N'Service',N'789-012-3456',N'kelsey.carter@example.com'),
	 (228,106,N'Joshua',N'Robinson',N'Technician',N'Service',N'890-123-4567',N'joshua.robinson@example.com'),
	 (229,106,N'Alexis',N'Young',N'Manager',N'Service',N'901-234-5678',N'alexis.young@example.com'),
	 (230,107,N'Taylor',N'Lopez',N'Technician',N'Service',N'012-345-6789',N'taylor.lopez@example.com');
INSERT INTO Team2_Dealer.dbo.Employee (EmployeeID,TeamID,FirstName,LastName,PositionTitle,Department,Phone,Email) VALUES
	 (231,107,N'Nicholas',N'Gonzalez',N'Technician',N'Service',N'123-456-7890',N'nicholas.gonzalez@example.com'),
	 (232,107,N'Madison',N'Hill',N'Technician',N'Service',N'234-567-8901',N'madison.hill@example.com'),
	 (233,107,N'Jacob',N'Wright',N'Technician',N'Service',N'345-678-9012',N'jacob.wright@example.com'),
	 (234,107,N'Jordan',N'Mitchell',N'Manager',N'Service',N'456-789-0123',N'jordan.mitchell@example.com');
INSERT INTO Team2_Dealer.dbo.[Order] (OrderID,VIN,CustomerID,EmployeeID,OrderStatus,OrderDate,DeliveryOption) VALUES
	 (10001,N'4Y1SL65848Z411439',15,203,N'SOLD','2023-03-15',N'PICKUP'),
	 (10002,N'4Y1SL65848Z411440',8,201,N'ORDERED','2023-05-20',N'DELIVERY'),
	 (10003,N'4Y1SL65848Z411441',19,204,N'SOLD','2023-06-10',N'PICKUP'),
	 (10004,N'4Y1SL65848Z411442',6,204,N'ORDERED','2023-04-05',N'DELIVERY'),
	 (10005,N'4Y1SL65848Z411443',14,203,N'SOLD','2023-08-12',N'PICKUP'),
	 (10006,N'4Y1SL65848Z411444',21,202,N'ORDERED','2023-07-01',N'DELIVERY'),
	 (10007,N'4Y1SL65848Z411445',9,201,N'SOLD','2023-02-28',N'PICKUP'),
	 (10008,N'4Y1SL65848Z411446',12,204,N'ORDERED','2023-09-18',N'DELIVERY'),
	 (10009,N'4Y1SL65848Z411447',23,205,N'SOLD','2023-11-22',N'PICKUP'),
	 (10010,N'4Y1SL65848Z411448',4,205,N'ORDERED','2023-10-30',N'DELIVERY');
INSERT INTO Team2_Dealer.dbo.[Order] (OrderID,VIN,CustomerID,EmployeeID,OrderStatus,OrderDate,DeliveryOption) VALUES
	 (10011,N'4Y1SL65848Z411449',16,203,N'SOLD','2023-12-05',N'PICKUP'),
	 (10012,N'4Y1SL65848Z411450',18,202,N'ORDERED','2023-03-25',N'DELIVERY'),
	 (10013,N'4Y1SL65848Z411451',5,201,N'SOLD','2023-01-10',N'PICKUP'),
	 (10014,N'4Y1SL65848Z411452',10,204,N'ORDERED','2023-07-15',N'DELIVERY'),
	 (10015,N'4Y1SL65848Z411453',2,202,N'SOLD','2023-09-30',N'PICKUP'),
	 (10016,N'4Y1SL65848Z411454',24,205,N'ORDERED','2023-05-28',N'DELIVERY'),
	 (10017,N'4Y1SL65848Z411455',11,203,N'SOLD','2023-11-17',N'PICKUP'),
	 (10018,N'4Y1SL65848Z411456',1,201,N'ORDERED','2023-02-20',N'DELIVERY'),
	 (10019,N'4Y1SL65848Z411457',22,204,N'SOLD','2023-08-08',N'PICKUP'),
	 (10020,N'4Y1SL65848Z411458',7,205,N'ORDERED','2023-12-12',N'DELIVERY');
INSERT INTO Team2_Dealer.dbo.[Order] (OrderID,VIN,CustomerID,EmployeeID,OrderStatus,OrderDate,DeliveryOption) VALUES
	 (10021,N'4Y1SL65848Z411459',20,202,N'SOLD','2023-04-03',N'PICKUP'),
	 (10022,N'4Y1SL65848Z411460',25,201,N'ORDERED','2023-10-15',N'DELIVERY'),
	 (10023,N'4Y1SL65848Z411461',17,204,N'SOLD','2023-06-28',N'PICKUP'),
	 (10024,N'4Y1SL65848Z411462',3,203,N'ORDERED','2023-01-05',N'DELIVERY'),
	 (10025,N'4Y1SL65848Z411463',13,202,N'SOLD','2023-09-10',N'PICKUP'),
	 (10026,N'4Y1SL65848Z411464',24,201,N'ORDERED','2023-05-22',N'DELIVERY'),
	 (10027,N'4Y1SL65848Z411465',6,204,N'SOLD','2023-11-30',N'PICKUP'),
	 (10028,N'4Y1SL65848Z411466',9,205,N'ORDERED','2023-02-10',N'DELIVERY'),
	 (10029,N'4Y1SL65848Z411467',11,202,N'SOLD','2023-08-20',N'PICKUP'),
	 (10030,N'4Y1SL65848Z411468',14,201,N'ORDERED','2023-03-08',N'DELIVERY');
INSERT INTO Team2_Dealer.dbo.Part_Information (PartID,SupplierID,PartInfo,PartInventoryLevel) VALUES
	 (4001,301,N'Tire 235/60/18',50),
	 (4002,302,N'Tire 215/55/16',80),
	 (4003,303,N'Tire 275/35/18',20),
	 (4004,304,N'Tire 235/65/17',65),
	 (4005,305,N'Tire 225/55/18',30),
	 (4006,306,N'Synthetic Oil',40),
	 (4007,307,N'Conventional Oil',75),
	 (4008,308,N'Bearing',90),
	 (4009,309,N'Paint',15),
	 (4010,310,N'Car Part',70);
INSERT INTO Team2_Dealer.dbo.Part_Information (PartID,SupplierID,PartInfo,PartInventoryLevel) VALUES
	 (4011,311,N'Tire 235/60/18',55),
	 (4012,312,N'Tire 215/55/16',85),
	 (4013,313,N'Tire 275/35/18',25),
	 (4014,314,N'Tire 235/65/17',60),
	 (4015,315,N'Tire 225/55/18',35),
	 (4016,301,N'Synthetic Oil',45),
	 (4017,302,N'Conventional Oil',80),
	 (4018,303,N'Bearing',95),
	 (4019,304,N'Paint',20),
	 (4020,305,N'Car Part',75);
INSERT INTO Team2_Dealer.dbo.Part_Information (PartID,SupplierID,PartInfo,PartInventoryLevel) VALUES
	 (4021,306,N'Tire 235/60/18',60),
	 (4022,307,N'Tire 215/55/16',90),
	 (4023,308,N'Tire 275/35/18',30),
	 (4024,309,N'Tire 235/65/17',65),
	 (4025,310,N'Tire 225/55/18',40),
	 (4026,311,N'Synthetic Oil',50),
	 (4027,312,N'Conventional Oil',85),
	 (4028,313,N'Bearing',100),
	 (4029,314,N'Paint',25),
	 (4030,315,N'Car Part',80);
INSERT INTO Team2_Dealer.dbo.Previous_Owners (PreviousOwnerID,FirstName,LastName) VALUES
	 (501,N'James',N'Collin'),
	 (502,N'Emma',N'Watson'),
	 (503,N'Ethan',N'Parker'),
	 (504,N'Olivia',N'Turner'),
	 (505,N'Liam',N'Hughes'),
	 (506,N'Ava',N'Nelson'),
	 (507,N'Noah',N'Carter'),
	 (508,N'Isabella',N'Mitchell'),
	 (509,N'William',N'Murphy'),
	 (510,N'Sophia',N'Ward');
INSERT INTO Team2_Dealer.dbo.Previous_Owners (PreviousOwnerID,FirstName,LastName) VALUES
	 (511,N'Benjamin',N'Kelly'),
	 (512,N'Mia',N'Richardson'),
	 (513,N'Jacob',N'Price'),
	 (514,N'Charlotte',N'Bailey'),
	 (515,N'Michael',N'Wood'),
	 (516,N'Amelia',N'Foster'),
	 (517,N'Alexander',N'Perry'),
	 (518,N'Harper',N'Butler'),
	 (519,N'Daniel',N'Bryant'),
	 (520,N'Evelyn',N'Reed');
INSERT INTO Team2_Dealer.dbo.Previous_Owners (PreviousOwnerID,FirstName,LastName) VALUES
	 (521,N'Matthew',N'Cook'),
	 (522,N'Abigail',N'Howard'),
	 (523,N'Lucas',N'Coleman'),
	 (524,N'Emily',N'Bryant'),
	 (525,N'Logan',N'Powell'),
	 (526,N'Elizabeth',N'Long'),
	 (527,N'Oliver',N'Russell'),
	 (528,N'Madison',N'Green'),
	 (529,N'Jackson',N'Brooks'),
	 (530,N'Grace',N'Ramirez');
INSERT INTO Team2_Dealer.dbo.Quote (QuoteID,EmployeeID,VIN,[Date],QuotePrice) VALUES
	 (10001,203,N'4Y1SL65848Z411439','2023-02-23',21118.94),
	 (10002,201,N'4Y1SL65848Z411440','2022-05-02',22971.31),
	 (10003,204,N'4Y1SL65848Z411441','2022-08-07',16845.55),
	 (10008,204,N'4Y1SL65848Z411446','2022-05-23',13709.83),
	 (10009,205,N'4Y1SL65848Z411447','2022-10-06',45418.07),
	 (10010,205,N'4Y1SL65848Z411448','2022-11-25',42285.13),
	 (10011,203,N'4Y1SL65848Z411449','2023-03-29',36807.01),
	 (10013,201,N'4Y1SL65848Z411451','2022-09-25',37925.58),
	 (10014,204,N'4Y1SL65848Z411452','2022-08-30',36450.53),
	 (10019,204,N'4Y1SL65848Z411457','2022-10-14',14993.05);
INSERT INTO Team2_Dealer.dbo.Quote (QuoteID,EmployeeID,VIN,[Date],QuotePrice) VALUES
	 (10021,202,N'4Y1SL65848Z411459','2023-03-29',38640.78),
	 (10022,201,N'4Y1SL65848Z411460','2022-08-22',14453.24),
	 (10023,204,N'4Y1SL65848Z411461','2022-07-21',20709.64),
	 (10024,203,N'4Y1SL65848Z411462','2022-08-20',28490.41),
	 (10027,204,N'4Y1SL65848Z411465','2023-01-08',39626.71),
	 (10028,205,N'4Y1SL65848Z411466','2022-10-02',16506.16),
	 (10030,201,N'4Y1SL65848Z411468','2022-11-19',26780.79);
INSERT INTO Team2_Dealer.dbo.Sales (TransactionID,VIN,CustomerID,Amount,Payment,FinancingDetail,SaleChannel,BillingInfo,OrderID) VALUES
	 (5001,N'4Y1SL65848Z411439',15,35000.00,N'Financing',N'5-year loan',N'In-Store',N'Financing in progress',10001),
	 (5002,N'4Y1SL65848Z411440',8,20000.00,N'Credit',N'None',N'Third-party',N'Paid',10002),
	 (5003,N'4Y1SL65848Z411441',19,30000.00,N'Financing',N'None',N'Third-party',N'Payment due in 30 days',10003),
	 (5004,N'4Y1SL65848Z411442',6,25000.00,N'Cash',N'None',N'Online',N'Payment due in 30 days',10004),
	 (5005,N'4Y1SL65848Z411443',14,40000.00,N'Credit',N'None',N'Third-party',N'Payment due in 30 days',10005),
	 (5006,N'4Y1SL65848Z411444',21,41500.00,N'Cash',N'2-year Lease',N'In-Store',N'Paid',10006),
	 (5007,N'4Y1SL65848Z411445',9,27999.00,N'Cash',N'3-year Loan',N'In-Store',N'60-day Financing',10007),
	 (5008,N'4Y1SL65848Z411446',12,34995.00,N'Cash',N'5-year Loan',N'In-Store',N'Paid',10008),
	 (5009,N'4Y1SL65848Z411447',23,41500.00,N'Credit',N'2-year Lease',N'In-Store',N'Paid',10009),
	 (5010,N'4Y1SL65848Z411448',4,43500.00,N'Credit',N'None',N'Third-party',N'Payment due in 30 days',10010);
INSERT INTO Team2_Dealer.dbo.Sales (TransactionID,VIN,CustomerID,Amount,Payment,FinancingDetail,SaleChannel,BillingInfo,OrderID) VALUES
	 (5011,N'4Y1SL65848Z411449',16,40000.00,N'Credit',N'3-year Loan',N'Phone',N'Leasing',10011),
	 (5012,N'4Y1SL65848Z411450',18,41500.00,N'Credit',N'5-year Loan',N'Online',N'Payment due in 30 days',10012),
	 (5013,N'4Y1SL65848Z411451',5,19995.00,N'Financing',N'3-year Loan',N'In-Store',N'60-day Financing',10013),
	 (5014,N'4Y1SL65848Z411452',10,19995.00,N'Credit',N'5-year Loan',N'Phone',N'Leasing',10014),
	 (5015,N'4Y1SL65848Z411453',2,23450.00,N'Credit',N'None',N'Online',N'Payment due in 30 days',10015),
	 (5016,N'4Y1SL65848Z411454',24,27999.00,N'Credit',N'2-year Lease',N'Phone',N'Leasing',10016),
	 (5017,N'4Y1SL65848Z411455',11,41500.00,N'Cash',N'2-year Lease',N'In-Store',N'Paid',10017),
	 (5018,N'4Y1SL65848Z411456',1,37999.00,N'Financing',N'5-year Loan',N'Phone',N'Paid',10018),
	 (5019,N'4Y1SL65848Z411457',22,23450.00,N'Cash',N'5-year Loan',N'Phone',N'60-day Financing',10019),
	 (5020,N'4Y1SL65848Z411458',7,27999.00,N'Credit',N'3-year Loan',N'Phone',N'Paid',10020);
INSERT INTO Team2_Dealer.dbo.Sales (TransactionID,VIN,CustomerID,Amount,Payment,FinancingDetail,SaleChannel,BillingInfo,OrderID) VALUES
	 (5021,N'4Y1SL65848Z411459',20,43400.00,N'Credit',N'None',N'Third-party',N'Payment due in 30 days',10021),
	 (5022,N'4Y1SL65848Z411460',25,27999.00,N'Cash',N'None',N'Online',N'60-day Financing',10022),
	 (5023,N'4Y1SL65848Z411461',17,27999.00,N'Credit',N'3-year Loan',N'Phone',N'Paid',10023),
	 (5024,N'4Y1SL65848Z411462',3,29995.00,N'Cash',N'2-year Lease',N'In-Store',N'Payment due in 30 days',10024),
	 (5025,N'4Y1SL65848Z411463',13,55000.00,N'Credit',N'None',N'Third-party',N'Payment due in 30 days',10025),
	 (5026,N'4Y1SL65848Z411464',24,25000.00,N'Cash',N'None',N'Online',N'Payment due in 30 days',10026),
	 (5027,N'4Y1SL65848Z411465',6,40000.00,N'Financing',N'None',N'Online',N'Payment due in 30 days',10027),
	 (5028,N'4Y1SL65848Z411466',9,45000.00,N'Cash',N'None',N'In-Store',N'Paid',10028),
	 (5029,N'4Y1SL65848Z411467',11,25000.00,N'Cash',N'None',N'Online',N'Payment due in 30 days',10029),
	 (5030,N'4Y1SL65848Z411468',14,20000.00,N'Credit',N'None',N'In-Store',N'Financing in progress',10030);
INSERT INTO Team2_Dealer.dbo.Service (ServiceTicketID,VIN,TeamID,Service,ServiceDate,PartID) VALUES
	 (6001,N'2VVLGFJTWETMAF423',105,N'Oil Change','2021-06-22',4006),
	 (6002,N'G58EEH5C9DBKTM23N',105,N'Oil Change','2022-06-01',4007),
	 (6003,N'PMWVBK4BYPCKXACTT',107,N'Oil Change','2021-07-11',4016),
	 (6004,N'MDBB57YG742U3SUW1',105,N'Oil Change','2021-09-26',4017),
	 (6005,N'K55NLWP1CPYLRS77Y',106,N'Oil Change','2022-02-02',4026),
	 (6006,N'CYZF9CHYTT48MVJ3U',103,N'Oil Change','2022-08-07',4027),
	 (6007,N'25EGU3XTWXDDCC27A',103,N'Paint','2022-11-18',4009),
	 (6008,N'T49UN4PE028UJPH39',105,N'Paint','2021-09-07',4019),
	 (6009,N'1DTF3WK0H74EL7DM2',105,N'Part Changing','2021-05-19',4010),
	 (6010,N'YHSG0V1CCRB27M3KR',104,N'Part Changing','2021-04-01',4020);
INSERT INTO Team2_Dealer.dbo.Service (ServiceTicketID,VIN,TeamID,Service,ServiceDate,PartID) VALUES
	 (6011,N'BBMUNZF64PY16TWAA',106,N'Tire Changing','2024-01-18',4001),
	 (6012,N'F1M9V1M9TEDEYB6NC',107,N'Tire Changing','2022-07-01',4002),
	 (6013,N'TP2KUJA2MAKENB1VB',106,N'Tire Changing','2022-07-17',4003),
	 (6014,N'MT1NDGR51VNE47MBY',103,N'Tire Changing','2021-11-11',4004),
	 (6015,N'NYCSJHDM83RGCJ88E',107,N'Tire Changing','2022-08-08',4005),
	 (6016,N'NZ6425PZTYZNPJ995',104,N'Tire Changing','2023-01-11',4011),
	 (6017,N'G464T0JCTJL2AZPHS',107,N'Tire Changing','2021-06-01',4012),
	 (6018,N'4A2FH4UJKS4GVUHA5',104,N'Tire Changing','2022-12-10',4013),
	 (6019,N'YH926Y9LL3MKK5LWB',107,N'Tire Changing','2021-03-26',4014),
	 (6020,N'U01MKMSDMGL9YFTN9',103,N'Tire Changing','2021-05-03',4015);
INSERT INTO Team2_Dealer.dbo.Service (ServiceTicketID,VIN,TeamID,Service,ServiceDate,PartID) VALUES
	 (6021,N'5DFB4VAZBDSG374E4',103,N'Tire Changing','2022-08-18',4021),
	 (6022,N'YVDYWTXP65ZFWG2CF',104,N'Tire Changing','2022-03-17',4022),
	 (6023,N'K19KUN90348CD11JB',105,N'Tire Changing','2021-05-31',4023),
	 (6024,N'CEJULL43CZJC4KD11',105,N'Tire Changing','2023-08-29',4024),
	 (6025,N'H4W4XACLUKGGGJF0A',103,N'Tire Changing','2023-05-04',4025),
	 (6026,N'KTPN0FYSSKPK5LLU4',104,N'Bearing Changing','2021-03-06',4008),
	 (6027,N'JP6EDD6GLFURPHJZF',106,N'Bearing Changing','2022-10-05',4018),
	 (6028,N'YFHJNVNT8FY99YZSP',106,N'Bearing Changing','2022-10-12',4028),
	 (6029,N'FJXP9JHWDBS41Y2XM',106,N'Oil Change','2022-03-15',4006),
	 (6030,N'6HXN4LK8NHM1DP3S0',107,N'Oil Change','2021-11-20',4007);
INSERT INTO Team2_Dealer.dbo.Shipment (TransactionID,VIN,AddressID,ShipDate,ArrivalDate,TrackingNumber,ShippingMethod,ShipperInfo,Status) VALUES
	 (5001,N'4Y1SL65848Z411439',101,'2023-03-19','2023-03-28',N'TN000000001',N'Express',N'Dealer',N'Shipped'),
	 (5002,N'4Y1SL65848Z411440',102,'2023-05-24','2023-06-10',N'TN000000002',N'Standard',N'Thirdparty',N'Shipped'),
	 (5003,N'4Y1SL65848Z411441',103,'2023-06-15','2023-06-30',N'TN000000003',N'Standard',N'Dealer',N'Delivered'),
	 (5004,N'4Y1SL65848Z411442',104,'2023-04-11','2023-05-01',N'TN000000004',N'Standard',N'Dealer',N'In Transit'),
	 (5005,N'4Y1SL65848Z411443',105,'2023-08-17','2023-08-29',N'TN000000005',N'Express',N'Thirdparty',N'Shipped'),
	 (5006,N'4Y1SL65848Z411444',106,'2023-07-09','2023-07-25',N'TN000000006',N'Express',N'Thirdparty',N'Shipped'),
	 (5007,N'4Y1SL65848Z411445',107,'2023-03-01','2023-03-15',N'TN000000007',N'Standard',N'Dealer',N'Delivered'),
	 (5008,N'4Y1SL65848Z411446',108,'2023-09-18','2023-09-27',N'TN000000008',N'Express',N'Dealer',N'In Transit'),
	 (5009,N'4Y1SL65848Z411447',109,'2023-11-28','2023-12-09',N'TN000000009',N'Express',N'Thirdparty',N'Shipped'),
	 (5010,N'4Y1SL65848Z411448',110,'2023-11-04','2023-11-25',N'TN000000010',N'Standard',N'Dealer',N'Shipped');
INSERT INTO Team2_Dealer.dbo.Shipment (TransactionID,VIN,AddressID,ShipDate,ArrivalDate,TrackingNumber,ShippingMethod,ShipperInfo,Status) VALUES
	 (5011,N'4Y1SL65848Z411449',111,'2023-12-09','2023-12-28',N'TN000000011',N'Standard',N'Dealer',N'Delivered'),
	 (5012,N'4Y1SL65848Z411450',112,'2023-03-28','2023-04-10',N'TN000000012',N'Express',N'Dealer',N'In Transit'),
	 (5013,N'4Y1SL65848Z411451',113,'2023-01-17','2023-01-28',N'TN000000013',N'Express',N'Thirdparty',N'Shipped'),
	 (5014,N'4Y1SL65848Z411452',114,'2023-07-21','2023-07-29',N'TN000000014',N'Standard',N'Dealer',N'Shipped'),
	 (5015,N'4Y1SL65848Z411453',115,'2023-10-09','2023-10-21',N'TN000000015',N'Express',N'Dealer',N'Delivered'),
	 (5016,N'4Y1SL65848Z411454',116,'2023-06-01','2023-06-19',N'TN000000016',N'Express',N'Dealer',N'In Transit'),
	 (5017,N'4Y1SL65848Z411455',117,'2023-11-20','2023-12-03',N'TN000000017',N'Standard',N'Thirdparty',N'Shipped'),
	 (5018,N'4Y1SL65848Z411456',118,'2023-02-28','2023-03-11',N'TN000000018',N'Express',N'Thirdparty',N'Shipped'),
	 (5019,N'4Y1SL65848Z411457',119,'2023-08-11','2023-08-27',N'TN000000019',N'Standard',N'Dealer',N'Delivered'),
	 (5020,N'4Y1SL65848Z411458',120,'2023-12-17','2024-01-01',N'TN000000020',N'Express',N'Dealer',N'In Transit');
INSERT INTO Team2_Dealer.dbo.Shipment (TransactionID,VIN,AddressID,ShipDate,ArrivalDate,TrackingNumber,ShippingMethod,ShipperInfo,Status) VALUES
	 (5021,N'4Y1SL65848Z411459',121,'2023-04-09','2023-04-23',N'TN000000021',N'Standard',N'Thirdparty',N'Shipped'),
	 (5022,N'4Y1SL65848Z411460',122,'2023-10-21','2023-11-01',N'TN000000022',N'Express',N'Thirdparty',N'Shipped'),
	 (5023,N'4Y1SL65848Z411461',123,'2023-07-01','2023-07-15',N'TN000000023',N'Express',N'Dealer',N'Delivered'),
	 (5024,N'4Y1SL65848Z411462',124,'2023-01-09','2023-01-24',N'TN000000024',N'Standard',N'Dealer',N'In Transit'),
	 (5025,N'4Y1SL65848Z411463',125,'2023-09-16','2023-09-25',N'TN000000025',N'Standard',N'Thirdparty',N'Shipped');
INSERT INTO Team2_Dealer.dbo.Supplier (SupplierID,SupplierType,SupplierInformation) VALUES
	 (0,N'Car',N'OEM'),
	 (301,N'Part',N'2/10net30'),
	 (302,N'Tire',N'1/10 net 30'),
	 (303,N'Oil',N'2/10 net 30'),
	 (304,N'Part',N'1/10 net 30'),
	 (305,N'Tire',N'2/10 net 30'),
	 (306,N'Oil',N'1/10 net 30'),
	 (307,N'Part',N'2/10 net 30'),
	 (308,N'Tire',N'1/10 net 30'),
	 (309,N'Oil',N'2/10 net 30');
INSERT INTO Team2_Dealer.dbo.Supplier (SupplierID,SupplierType,SupplierInformation) VALUES
	 (310,N'Part',N'1/10 net 30'),
	 (311,N'Tire',N'2/10 net 30'),
	 (312,N'Oil',N'1/10 net 30'),
	 (313,N'Part',N'2/10 net 30'),
	 (314,N'Tire',N'1/10 net 30'),
	 (315,N'Oil',N'2/10 net 30');
INSERT INTO Team2_Dealer.dbo.Team (TeamID) VALUES
	 (101),
	 (102),
	 (103),
	 (104),
	 (105),
	 (106),
	 (107);
INSERT INTO Team2_Dealer.dbo.Vehicle_Information (VIN,ConfigurationID,PreviousOwnerID,Mileage,Status,SupplierID) VALUES
	 (N'1DTF3WK0H74EL7DM2',1001,501,8000,N'Available',NULL),
	 (N'25EGU3XTWXDDCC27A',1021,502,8628,N'Available',NULL),
	 (N'2VVLGFJTWETMAF423',1004,509,4309,N'Available',NULL),
	 (N'4A2FH4UJKS4GVUHA5',1001,505,13455,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411439',1024,514,10108,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411440',1009,511,15857,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411441',1008,510,21830,N'Available',NULL),
	 (N'4Y1SL65848Z411442',1008,515,12954,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411443',1005,514,6329,N'Available',NULL),
	 (N'4Y1SL65848Z411444',1024,506,13130,N'Available',NULL);
INSERT INTO Team2_Dealer.dbo.Vehicle_Information (VIN,ConfigurationID,PreviousOwnerID,Mileage,Status,SupplierID) VALUES
	 (N'4Y1SL65848Z411445',1004,510,12641,N'Available',NULL),
	 (N'4Y1SL65848Z411446',1022,504,7865,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411447',1024,512,22960,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411448',1018,502,9748,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411449',1003,501,23997,N'Available',NULL),
	 (N'4Y1SL65848Z411450',1019,511,23398,N'Available',NULL),
	 (N'4Y1SL65848Z411451',1014,504,22234,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411452',1002,513,3339,N'Available',NULL),
	 (N'4Y1SL65848Z411453',1001,505,20960,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411454',1003,502,21806,N'Unavailable',NULL);
INSERT INTO Team2_Dealer.dbo.Vehicle_Information (VIN,ConfigurationID,PreviousOwnerID,Mileage,Status,SupplierID) VALUES
	 (N'4Y1SL65848Z411455',1007,514,6607,N'Unavailable',NULL),
	 (N'4Y1SL65848Z411456',1008,NULL,0,N'Available',0),
	 (N'4Y1SL65848Z411457',1017,NULL,0,N'Unavailable',0),
	 (N'4Y1SL65848Z411458',1020,NULL,0,N'Available',0),
	 (N'4Y1SL65848Z411459',1001,NULL,0,N'Available',0),
	 (N'4Y1SL65848Z411460',1018,NULL,0,N'Unavailable',0),
	 (N'4Y1SL65848Z411461',1007,NULL,0,N'Unavailable',0),
	 (N'4Y1SL65848Z411462',1023,NULL,0,N'Unavailable',0),
	 (N'4Y1SL65848Z411463',1021,NULL,0,N'Unavailable',0),
	 (N'4Y1SL65848Z411464',1023,NULL,0,N'Available',0);
INSERT INTO Team2_Dealer.dbo.Vehicle_Information (VIN,ConfigurationID,PreviousOwnerID,Mileage,Status,SupplierID) VALUES
	 (N'4Y1SL65848Z411465',1018,NULL,0,N'Available',0),
	 (N'4Y1SL65848Z411466',1014,NULL,0,N'Unavailable',0),
	 (N'4Y1SL65848Z411467',1008,NULL,0,N'Available',0),
	 (N'4Y1SL65848Z411468',1015,NULL,0,N'Available',0),
	 (N'5DFB4VAZBDSG374E4',1019,NULL,0,N'Available',0),
	 (N'6HXN4LK8NHM1DP3S0',1009,NULL,0,N'Available',0),
	 (N'BBMUNZF64PY16TWAA',1001,NULL,0,N'Available',0),
	 (N'CEJULL43CZJC4KD11',1025,NULL,0,N'Unavailable',0),
	 (N'CYZF9CHYTT48MVJ3U',1006,NULL,0,N'Available',0),
	 (N'F1M9V1M9TEDEYB6NC',1023,NULL,0,N'Unavailable',0);
INSERT INTO Team2_Dealer.dbo.Vehicle_Information (VIN,ConfigurationID,PreviousOwnerID,Mileage,Status,SupplierID) VALUES
	 (N'FJXP9JHWDBS41Y2XM',1014,NULL,0,N'Unavailable',0),
	 (N'G464T0JCTJL2AZPHS',1011,NULL,0,N'Unavailable',0),
	 (N'G58EEH5C9DBKTM23N',1009,NULL,0,N'Unavailable',0),
	 (N'H4W4XACLUKGGGJF0A',1005,NULL,0,N'Available',0),
	 (N'JP6EDD6GLFURPHJZF',1007,NULL,0,N'Available',0),
	 (N'K19KUN90348CD11JB',1025,NULL,0,N'Unavailable',0),
	 (N'K55NLWP1CPYLRS77Y',1011,NULL,0,N'Unavailable',0),
	 (N'KTPN0FYSSKPK5LLU4',1004,NULL,0,N'Available',0),
	 (N'MDBB57YG742U3SUW1',1003,NULL,0,N'Unavailable',0),
	 (N'MT1NDGR51VNE47MBY',1013,NULL,0,N'Unavailable',0);
INSERT INTO Team2_Dealer.dbo.Vehicle_Information (VIN,ConfigurationID,PreviousOwnerID,Mileage,Status,SupplierID) VALUES
	 (N'NYCSJHDM83RGCJ88E',1004,NULL,0,N'Available',0),
	 (N'NZ6425PZTYZNPJ995',1012,NULL,0,N'Unavailable',0),
	 (N'PMWVBK4BYPCKXACTT',1012,NULL,0,N'Available',0),
	 (N'T49UN4PE028UJPH39',1020,NULL,0,N'Unavailable',0),
	 (N'TP2KUJA2MAKENB1VB',1009,NULL,0,N'Available',0),
	 (N'U01MKMSDMGL9YFTN9',1002,NULL,0,N'Available',0),
	 (N'YFHJNVNT8FY99YZSP',1024,NULL,0,N'Unavailable',0),
	 (N'YH926Y9LL3MKK5LWB',1015,NULL,0,N'Available',0),
	 (N'YHSG0V1CCRB27M3KR',1018,NULL,0,N'Available',0),
	 (N'YVDYWTXP65ZFWG2CF',1004,NULL,0,N'Unavailable',0);



CREATE FUNCTION dbo.CheckPaymentBillingInfo (
    @Payment VARCHAR(100),
    @BillingInfo VARCHAR(100)
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 1;  -- Default to valid

    IF @Payment = 'Cash' AND @BillingInfo = 'Leasing'
        SET @IsValid = 0;  -- Set to invalid if the condition is met

    RETURN @IsValid;
END;



CREATE FUNCTION dbo.FindCashLeasingErrors ()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM [dbo].[Sales]
    WHERE Payment = 'Cash'
      AND BillingInfo = 'Leasing'
);



CREATE OR ALTER FUNCTION GetInventoryLevel (@InventoryLevel INT)
RETURNs varchar(50)
AS
Begin
	declare @inventorystatus varchar(50);
	if @InventoryLevel>10
	set @inventorystatus = 'High Level'
	else if @InventoryLevel>3
	set @inventorystatus = 'Normal Level'
	else
	set @inventorystatus = 'Low Level'
	return @inventorystatus
end;



CREATE FUNCTION dbo.ValidatePhoneFormat (@Phone VARCHAR(20))
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 0;

    IF @Phone LIKE '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
        SET @IsValid = 1;

    RETURN @IsValid;
END;



-- dbo.salechannel source

create view salechannel as
select salechannel, count(*) as [Total Transactions], 
Cast(round(count(*)*100/(select count(TransactionID) from Sales), 2) as varchar)+'%' as [Percentage of Total Transactions],
sum(amount) as [Total Sales Value]
from Sales
group by SaleChannel;


-- dbo.teamservicetickets source

Create view 
teamservicetickets as
select teamid, STRING_AGG(cast(serviceticketid as varchar),',') as servicetickets
from service
group by teamid;
