-- ============================================================
-- PRT563 Advanced Data Management
-- Assignment 2
-- Sydney Group 13
-- Fleet and Delivery Management Database
-- ============================================================


-- ============================================================
-- DATABASE SETTINGS
-- ============================================================

PRAGMA foreign_keys = ON;


-- ============================================================
-- DROP TABLES
-- Allows the complete script to be run again without
-- manually deleting existing tables.
-- Child tables are removed before parent tables.
-- ============================================================

DROP TABLE IF EXISTS DeliveryStatusHistory;
DROP TABLE IF EXISTS VehicleMaintenance;
DROP TABLE IF EXISTS DeliveryAssignment;
DROP TABLE IF EXISTS RouteStop;
DROP TABLE IF EXISTS Package;
DROP TABLE IF EXISTS Shipment;
DROP TABLE IF EXISTS DeliveryOrder;
DROP TABLE IF EXISTS IndividualCustomer;
DROP TABLE IF EXISTS BusinessCustomer;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Customer;


-- ============================================================
-- TABLE 1: Customer
-- Corresponds directly to Customer in the UML diagram.
-- ============================================================

CREATE TABLE Customer (
    customerID INTEGER PRIMARY KEY,
    email VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,
    customerType VARCHAR NOT NULL
);


-- ============================================================
-- TABLE 2: IndividualCustomer
-- IndividualCustomer is a subtype of Customer.
-- customerID is both its PK and FK.
-- ============================================================

CREATE TABLE IndividualCustomer (
    customerID INTEGER PRIMARY KEY,
    firstName VARCHAR NOT NULL,
    lastName VARCHAR NOT NULL,

    FOREIGN KEY (customerID)
        REFERENCES Customer(customerID)
);


-- ============================================================
-- TABLE 3: BusinessCustomer
-- BusinessCustomer is a subtype of Customer.
-- customerID is both its PK and FK.
-- ============================================================

CREATE TABLE BusinessCustomer (
    customerID INTEGER PRIMARY KEY,
    businessName VARCHAR NOT NULL,
    ABN VARCHAR NOT NULL,
    contactPerson VARCHAR NOT NULL,

    FOREIGN KEY (customerID)
        REFERENCES Customer(customerID)
);


-- ============================================================
-- TABLE 4: Route
-- ============================================================

CREATE TABLE Route (
    routeID INTEGER PRIMARY KEY,
    routeName VARCHAR NOT NULL,
    distanceKm DECIMAL NOT NULL
);


-- ============================================================
-- TABLE 5: Location
-- ============================================================

CREATE TABLE Location (
    locationID INTEGER PRIMARY KEY,
    street VARCHAR NOT NULL,
    suburb VARCHAR NOT NULL,
    state VARCHAR NOT NULL,
    postcode VARCHAR NOT NULL
);


-- ============================================================
-- TABLE 6: Driver
-- ============================================================

CREATE TABLE Driver (
    driverID INTEGER PRIMARY KEY,
    firstName VARCHAR NOT NULL,
    lastName VARCHAR NOT NULL,
    licenceNumber VARCHAR NOT NULL,
    licenceExpiry DATE NOT NULL,
    phone VARCHAR NOT NULL,
    employmentStatus VARCHAR NOT NULL
);


-- ============================================================
-- TABLE 7: Vehicle
-- ============================================================

CREATE TABLE Vehicle (
    vehicleID INTEGER PRIMARY KEY,
    registrationNumber VARCHAR NOT NULL,
    make VARCHAR NOT NULL,
    model VARCHAR NOT NULL,
    capacityKg DECIMAL NOT NULL,
    vehicleType VARCHAR NOT NULL,
    vehicleStatus VARCHAR NOT NULL
);


-- ============================================================
-- TABLE 8: DeliveryOrder
-- Customer 1 ---- 0..* DeliveryOrder
-- Therefore customerID appears here as a foreign key.
-- ============================================================

CREATE TABLE DeliveryOrder (
    orderID INTEGER PRIMARY KEY,
    customerID INTEGER NOT NULL,
    orderDate DATE NOT NULL,
    priority VARCHAR NOT NULL,
    requestedPickupDate DATE NOT NULL,
    requiredDeliveryDate DATE NOT NULL,

    FOREIGN KEY (customerID)
        REFERENCES Customer(customerID)
);


-- ============================================================
-- TABLE 9: Shipment
-- The UML shows:
-- orderID FK
-- routeID FK
-- ============================================================

CREATE TABLE Shipment (
    shipmentID INTEGER PRIMARY KEY,
    orderID INTEGER NOT NULL UNIQUE,
    routeID INTEGER NOT NULL,
    shipmentDate DATE NOT NULL,
    expectedDeliveryDate DATE NOT NULL,

    FOREIGN KEY (orderID)
        REFERENCES DeliveryOrder(orderID),

    FOREIGN KEY (routeID)
        REFERENCES Route(routeID)
);


-- ============================================================
-- TABLE 10: Package
-- One Shipment contains one or more Packages.
-- ============================================================

CREATE TABLE Package (
    packageID INTEGER PRIMARY KEY,
    shipmentID INTEGER NOT NULL,
    description VARCHAR NOT NULL,
    weightKg DECIMAL NOT NULL,
    lengthCm DECIMAL NOT NULL,
    widthCm DECIMAL NOT NULL,
    heightCm DECIMAL NOT NULL,
    fragile BOOLEAN NOT NULL,

    FOREIGN KEY (shipmentID)
        REFERENCES Shipment(shipmentID)
);


-- ============================================================
-- TABLE 11: RouteStop
-- This follows your UML exactly:
-- routeID + locationID form the composite primary key.
-- ============================================================

CREATE TABLE RouteStop (
    routeID INTEGER NOT NULL,
    locationID INTEGER NOT NULL,
    stopSequence INTEGER NOT NULL,
    plannedArrival DATETIME NOT NULL,

    PRIMARY KEY (routeID, locationID),

    FOREIGN KEY (routeID)
        REFERENCES Route(routeID),

    FOREIGN KEY (locationID)
        REFERENCES Location(locationID)
);


-- ============================================================
-- TABLE 12: DeliveryAssignment
-- Connects Shipment, Driver and Vehicle.
-- ============================================================

CREATE TABLE DeliveryAssignment (
    assignmentID INTEGER PRIMARY KEY,
    shipmentID INTEGER NOT NULL,
    driverID INTEGER NOT NULL,
    vehicleID INTEGER NOT NULL,
    assignedDateTime DATETIME NOT NULL,
    completedDateTime DATETIME,

    FOREIGN KEY (shipmentID)
        REFERENCES Shipment(shipmentID),

    FOREIGN KEY (driverID)
        REFERENCES Driver(driverID),

    FOREIGN KEY (vehicleID)
        REFERENCES Vehicle(vehicleID)
);


-- ============================================================
-- TABLE 13: VehicleMaintenance
-- ============================================================

CREATE TABLE VehicleMaintenance (
    maintenanceID INTEGER PRIMARY KEY,
    vehicleID INTEGER NOT NULL,
    maintenanceDate DATE NOT NULL,
    maintenanceType VARCHAR NOT NULL,
    cost DECIMAL NOT NULL,
    nextDueDate DATE NOT NULL,

    FOREIGN KEY (vehicleID)
        REFERENCES Vehicle(vehicleID)
);


-- ============================================================
-- TABLE 14: DeliveryStatusHistory
-- Connected to Shipment and Location exactly as in UML.
-- ============================================================

CREATE TABLE DeliveryStatusHistory (
    statusHistoryID INTEGER PRIMARY KEY,
    shipmentID INTEGER NOT NULL,
    locationID INTEGER NOT NULL,
    status VARCHAR NOT NULL,
    statusDateTime DATETIME NOT NULL,
    notes VARCHAR,

    FOREIGN KEY (shipmentID)
        REFERENCES Shipment(shipmentID),

    FOREIGN KEY (locationID)
        REFERENCES Location(locationID)
);


-- ============================================================
-- SAMPLE DATA
-- Will be placed below this section.
-- ============================================================




-- ============================================================
-- SIMPLE QUERY 1
-- Will be placed below this section.
-- ============================================================




-- ============================================================
-- SIMPLE QUERY 2
-- Will be placed below this section.
-- ============================================================




-- ============================================================
-- MODERATELY COMPLEX QUERY
-- Will be placed below this section.
-- ============================================================




-- ============================================================
-- COMPLEX QUERY
-- Will be placed below this section.
-- ============================================================