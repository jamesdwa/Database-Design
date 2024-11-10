CREATE TABLE InsuranceCo (
    name VARCHAR(100) PRIMARY KEY,
    phone INT
);

CREATE TABLE Person (
    ssn INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Driver(
    ssn INT PRIMARY KEY REFERENCES Person(ssn),
    driverID INT
);

CREATE TABLE NonProfessionalDriver(
    ssn INT PRIMARY KEY REFERENCES Driver(ssn),
);

CREATE TABLE Vehicle (
    licensePlate VARCHAR(8) PRIMARY KEY,
    year INT,
    vname VARCHAR(100),
    maxLiability REAL,
    ssn INT,
    FOREIGN KEY(vname) REFERENCES InsuranceCo(name),
    FOREIGN KEY(ssn) REFERENCES Person(ssn)
);

CREATE TABLE ProfessionalDriver(
    ssn INT PRIMARY KEY,
    medicalHistory varchar(100),
);

CREATE TABLE Truck (
    licensePlate VARCHAR(8) PRIMARY KEY,
    ssn INT,
    capacity INT,
    FOREIGN KEY(licensePlate) REFERENCES Vehicle(licensePlate),
    FOREIGN KEY(ssn) REFERENCES ProfessionalDriver(ssn)
);

CREATE TABLE Car (
    licensePlate VARCHAR(8) PRIMARY KEY,
    ssn INT,
    make VARCHAR(100),
    FOREIGN KEY(licensePlate) REFERENCES Vehicle(licensePlate)
);

CREATE TABLE Drives (
    licensePlate VARCHAR(8),
    ssn INT,
    FOREIGN KEY(ssn) REFERENCES NonProfessionalDriver(ssn),
    FOREIGN KEY(licensePlate) REFERENCES Car(licensePlate),
    PRIMARY KEY (licensePlate, ssn)
);

-- b.
-- The vehicle relation cannot have more than one insurance, so it causes the the relationship
-- in the E/R diagram to be a one-to-many. The vehicle relation has a foreign key that references the
-- InsuranceCo relation. This means that the Vehicle relation is dependent on the InsuranceCo.
--
-- c.
-- The representation of the relationship "drives" is different from the representation of the
-- relationship "operates" because the relationship "drives" is a many-to-many relationship, while
-- the relationship "operates" is a one-to-many relationship. This means that the relationship
-- for one-to-many, would use foreign keys in the "many" entity table to reference the primary key in the "one" entity.
-- For the many-to-many, we create a new table to represent their relationship including foreign keys to reference primary keys
-- in both original tables. The truck can have at most one operator, so the relationship is expressed in the truck relation
-- itself by adding the operator's ssn. A car can be driven by multiple drivers, so it is represented using a separate table.