create database InsuranceAndClaimManagementDB1;
use InsuranceAndClaimManagementDB1;

CREATE TABLE Roles (
    ID INT PRIMARY KEY IDENTITY,
    RoleName VARCHAR(50) NOT NULL
);


CREATE TABLE Users (
    ID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    RoleId INT FOREIGN KEY REFERENCES Roles(ID) NOT NULL,
    IsApproved INT, --default 0 for admin and agent. 1 for approved, 2 for rejected, for customer 3(no need to be approved)
    IsActive BIT 
);


CREATE TABLE PolicyTypes (
    ID INT PRIMARY KEY IDENTITY,
    PolicyTypeName VARCHAR(100) NOT NULL
);


CREATE TABLE Policies (
    ID INT PRIMARY KEY IDENTITY,
    PolicyNumber VARCHAR(50) NOT NULL,
    PolicyTypeID INT FOREIGN KEY REFERENCES PolicyTypes(ID) NOT NULL,
    PolicyName VARCHAR(100),
    Duration INT,
    Description VARCHAR(MAX),
    Installment DECIMAL(18,2),
    PremiumAmount DECIMAL(18,2),
    IsActive BIT NOT NULL
);


CREATE TABLE DocumentList (
    ID INT PRIMARY KEY IDENTITY,
    PolicyId INT FOREIGN KEY REFERENCES Policies(ID) NOT NULL,
    DocumentType VARCHAR(100) NOT NULL
);


CREATE TABLE UserPolicy (
    ID INT PRIMARY KEY IDENTITY,
    UserId INT FOREIGN KEY REFERENCES Users(ID) NOT NULL,
    PolicyId INT FOREIGN KEY REFERENCES Policies(ID) NOT NULL,
                AgentId INT FOREIGN KEY REFERENCES Users(ID) NOT NULL,
    EnrollmentDate DATE NOT NULL,
    EndDate DATE,
                isClaimed INT DEFAULT 0
);


CREATE TABLE Claims (
    ID INT PRIMARY KEY IDENTITY,
    PolicyId INT FOREIGN KEY REFERENCES Policies(ID) NOT NULL,
    UserId INT FOREIGN KEY REFERENCES Users(ID) NOT NULL,
    IncidentDate DATE NOT NULL,
    IncidentLocation VARCHAR(100),
    Address VARCHAR(255),
    Description VARCHAR(MAX),
    Status INT 
);

--1 for Pending
--2 for Under Review
--3 for Approved
--4 for Denied
--5 for Processing
--6 for Done
--7 for Closed


CREATE TABLE ClaimDocuments (
    ID INT PRIMARY KEY IDENTITY,
    ClaimId INT FOREIGN KEY REFERENCES Claims(ID) NOT NULL,
    DocumentPath VARCHAR(255) NOT NULL
);


CREATE TABLE AuditLogs (
    ID INT PRIMARY KEY IDENTITY,
    UserId INT FOREIGN KEY REFERENCES Users(ID) NOT NULL,
    Timestamp DATETIME NOT NULL,
    Action VARCHAR(100) NOT NULL,
    Category VARCHAR(100), 
    Details VARCHAR(MAX),
    IsSuccess BIT
);


INSERT INTO Roles (RoleName)
VALUES ('Insurer'), ('Agent'), ('Claimant');

INSERT INTO Users (FirstName, LastName, Password, Email, PhoneNumber, RoleId, IsApproved, IsActive)
VALUES ('Admin', 'Admin', 'admin@123', 'admin@gmail.com', '9876543210', 1, 1, 1);



delete from users;
-- Inserting approved agents
INSERT INTO Users (FirstName, LastName, Password, Email, PhoneNumber, RoleId, IsApproved, IsActive)
VALUES 
   
    ('Pritam', 'Jena', 'Pritam@123', 'pritam@gmail.com', '9876543210', 2, 1, 1),
    ('Smriti', 'Kumari', 'Smriti@123', 'smriti@gmail.com', '9876543211', 2, 1, 1),
    ('Siddharth', 'Saumya', 'Siddharth@123', 'siddharth@gmail.com', '9876543212', 2, 1, 1),
    ('Smit', 'Prajapati', 'Smit@123', 'smit@gmail.com', '9876543213', 2, 1, 1),
    ('Tathagata', 'Sarakr', 'Tathagata@123', 'tathagata@gmail.com', '9876543214', 2, 1, 1),
                ('Amit', 'Sharma', 'Amit@123', 'amit.sharma@example.com', '9876543215', 2, 1, 1),
    ('Priya', 'Patel', 'Priya@123', 'priya.patel@example.com', '9876543216', 2, 1, 1),
    ('Rahul', 'Gupta', 'Rahul@123', 'rahul.gupta@example.com', '9876543217', 2, 1, 1),
    ('Deepika', 'Singh', 'Deepika@123', 'deepika.singh@example.com', '9876543218', 2, 1, 1),
    ('Neha', 'Kumar', 'Neha@123', 'neha.kumar@example.com', '9876543219', 2, 1, 1);

-- Inserting users
INSERT INTO Users (FirstName, LastName, Password, Email, PhoneNumber, RoleId, IsApproved, IsActive)
VALUES 
    ('Ayesha', 'Gupta', 'Ayesha@123', 'ayesha@gmail.com', '9876543215', 3, 3, 1),
    ('Kabir', 'Shah', 'Kabir@123', 'kabir@gmail.com', '9876543216', 3, 3, 1),
    ('Neha', 'Verma', 'Neha@123', 'neha@gmail.com', '9876543217', 3, 3, 1),
    ('Aryan', 'Rao', 'Aryan@123', 'aryan@gmail.com', '9876543218', 3, 3, 1),
    ('Zoya', 'Malhotra', 'Zoya@123', 'zoya@gmail.com', '9876543219', 3, 3, 1),
    ('Prabhuddha', 'Bhan', 'Prabhuddha@123', 'prabhuddha.bhan@example.com', '9876543201', 3, 3, 1),
    ('Sagar', 'Devani', 'Sagar@123', 'sagar.devani@example.com', '9876543202', 3, 3, 1),
    ('Mehak', 'Bhat', 'Mehak@123', 'mehak.bhat@example.com', '9876543203', 3, 3, 1),
    ('Rishita', 'Konungo', 'Rishita@123', 'rishita.konungo@example.com', '9876543204', 3, 3, 1),
    ('Debashish', 'Nayak', 'Debashish@123', 'debashish.nayak@example.com', '9876543205', 3, 3, 1),
    ('Aryan', 'Verma', 'Aryan@123', 'aryan.verma@example.com', '9876543206', 3, 3, 1),
    ('Kalpit', 'Prajapati', 'Kalpit@123', 'kalpit.prajapati@example.com', '9876543207', 3, 3, 1),
    ('Nisarg', 'Patel', 'Nisarg@123', 'nisarg.patel@example.com', '9876543208', 3, 3, 1),
    ('Shruti', 'Kumari', 'Shruti@123', 'shruti.kumari@example.com', '9876543209', 3, 3, 1),
    ('David', 'Patel', 'David@123', 'david.patel@example.com', '9876543210', 3, 3, 1),
    ('Yash', 'Prajapati', 'Yash@123', 'yash.prajapati@example.com', '9876543211', 3, 3, 1),
    ('Ayush', 'Kumar', 'Ayush@123', 'ayush.kumar@example.com', '9876543212', 3, 3, 1);


UPDATE Users Set Password= 'PPMbzgtS1o93uZ8F0Amkvw==';

                                                                                                                                                                                                                                                                                                                                                                                
INSERT INTO PolicyTypes (PolicyTypeName)
VALUES ('Health'), ('Life'), ('Automobile'), ('Home'), ('Travel');


INSERT INTO Policies (PolicyNumber, PolicyTypeID, PolicyName, Duration, Description, Installment, PremiumAmount, IsActive)
VALUES 
-- Health Policies
('HEA001', 1, 'HealthGuard Plus', 365, 'Comprehensive health insurance for individuals.', 1500 , 25000, 1),
('HEA002', 1, 'Wellness Shield', 365, 'Health insurance policy with comprehensive coverage.', 3500, 55000, 1),

-- Life Policies
('LIF001', 2, 'LifeSure Protector', 730, 'Term life insurance policy for up to 2 years.', 2100,100000 , 1),
('LIF002', 2, 'EternalLife Assurance', 1095, 'Whole life insurance policy with lifetime coverage.', 4000, 500000, 1),

-- Automobile Policies
('AUT001', 3, 'AutoShield Comprehensive', 365, 'Comprehensive insurance coverage for automobiles.', 2000, 30000, 1),
('AUT002', 3, 'DriveSafe Liability Coverage', 365, 'Third-party liability insurance for automobiles.', 750, 12000, 1),

-- Home Policies
('HOM001', 4, 'HomeSafe Property Insurance', 365, 'Home insurance policy covering property and belongings.', 4500, 65000, 1),
('HOM002', 4, 'RentGuard Tenant Insurance', 365, 'Renter insurance policy for tenants.', 1200, 18000, 1),

-- Travel Policies
('TRA001', 5, 'TravelCare Protection', 7, 'Travel insurance policy for short-term trips.', 999, 100000, 1),
('TRA002', 5, 'GlobalGuard Medical Coverage', 15, 'International travel insurance policy with medical coverage.', 1499, 500000, 1)


INSERT INTO UserPolicy (UserId, PolicyId, AgentId, EnrollmentDate, EndDate)
VALUES 
                (12, 1, 7, '2023-11-01', '2024-11-01'),
    (13, 2, 7, '2023-12-01', '2024-12-01'),
    (14, 9, 10, '2024-01-01', '2025-01-01'),
    (15, 4, 10, '2024-02-01', '2025-02-01'),
    (16, 5, 11, '2024-03-01', '2025-03-01'),
    (17, 6, 2, '2024-04-01', '2025-04-01'),
    (18, 9, 5, '2024-05-01', '2025-05-01'),
    (19, 8, 4, '2024-06-01', '2025-06-01'),
    (20, 9, 5, '2024-07-01', '2025-07-01'),
                (21, 9, 6, '2024-08-01', '2025-08-01'),
    (22, 1, 8, '2024-09-01', '2025-09-01'),
    (23, 2, 8, '2024-10-01', '2025-10-01'),
    (24, 3, 9, '2024-11-01', '2025-11-01'),
    (25, 4, 10, '2024-12-01', '2025-12-01'),
    (26, 5, 11, '2025-01-01', '2026-01-01'),
    (27, 10, 2, '2025-02-01', '2026-02-01'),
    (28, 2, 5, '2025-03-01', '2026-03-01'),
    (12, 8, 5, '2025-04-01', '2026-04-01'),
                (13, 9, 5, '2025-05-01', '2026-05-01'),
    (14, 10, 6, '2025-06-01', '2026-06-01'),
    (15, 1, 8, '2025-07-01', '2026-07-01'),
    (16, 2, 8, '2025-08-01', '2026-08-01'),
    (17, 3, 9, '2025-09-01', '2026-09-01'),
    (18, 4, 10, '2025-10-01', '2026-10-01'),
    (19, 5, 11, '2025-11-01', '2026-11-01'),
    (20, 6, 2, '2025-12-01', '2026-12-01'),
    (21, 7, 3, '2026-01-01', '2027-01-01'),
                (22, 8, 4, '2026-02-01', '2027-02-01'),
    (23, 9, 5, '2026-03-01', '2027-03-01'),
    (24, 9, 10, '2026-04-01', '2027-04-01'),
    (25, 1, 7, '2026-05-01', '2027-05-01'),
    (26, 2, 8, '2026-06-01', '2027-06-01'),
    (27, 9, 9, '2026-07-01', '2027-07-01'),
    (28, 4, 10, '2026-08-01', '2027-08-01'),
    (12, 5, 10, '2026-09-01', '2027-09-01'),
    (13, 6, 2, '2026-10-01', '2027-10-01');

delete from UserPolicy;

-- Insert documents for Policy 1 (HEA001)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(1, 'Health Checkup Report'),
(1, 'Medical Bills');

-- Insert documents for Policy 2 (HEA002)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(2, 'Doctor''s Prescription'),
(2, 'Lab Test Results');

-- Insert documents for Policy 3 (LIF001)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(3, 'Medical History'),
(3, 'Proof of Age'),
(3, 'Income Proof');

-- Insert documents for Policy 4 (LIF002)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(4, 'Medical History'),
(4, 'Proof of Age'),
(4, 'Income Proof');

-- Insert documents for Policy 5 (AUT001)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(5, 'Vehicle Registration Certificate'),
(5, 'Driver''s License'),
(5, 'Insurance Policy');

-- Insert documents for Policy 6 (AUT002)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(6, 'Vehicle Registration Certificate'),
(6, 'Vehicle Inspection Report'),
(6, 'Driver''s License');

-- Insert documents for Policy 7 (HOM001)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(7, 'Property Deed'),
(7, 'Rental Agreement'),
(7, 'Property Insurance Certificate');

-- Insert documents for Policy 8 (HOM002)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(8, 'Property Deed'),
(8, 'Rental Agreement'),
(8, 'Property Insurance Certificate');

-- Insert documents for Policy 9 (TRA001)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(9, 'Travel Itinerary'),
(9, 'Passport Copy'),
(9, 'Hotel Booking Details');

-- Insert documents for Policy 10 (TRA002)
INSERT INTO DocumentList (PolicyId, DocumentType) VALUES
(10, 'Travel Itinerary'),
(10, 'Passport Copy'),
(10, 'Hotel Booking Details');

-- Inserting sample data into the Claims table with UserId between 7 and 11
INSERT INTO Claims (PolicyId, UserId, IncidentDate, IncidentLocation, Address, Description, Status)
VALUES 
    (1, 7, '2023-01-15', 'City Hospital', '123 Main St, City', 'Car accident on the way to work.', 1), -- Pending
    (2, 7, '2023-06-10', 'Office Building', '222 Maple St, Town', 'Slip and fall accident at workplace.', 6),-- Done
                (3, 8, '2023-02-20', 'Highway 101', '456 Elm St, Town', 'Medical emergency during travel.', 2), -- Under Review
    (4, 8, '2023-07-15', 'Restaurant', '333 Birch St, City', 'Food poisoning after dining out.', 7), -- Closed
                (5, 9, '2023-03-25', 'Shopping Mall', '789 Oak St, Village', 'Vehicle damage due to parking lot collision.', 3), -- Approved
    (6, 9, '2023-08-20', 'Beach', '444 Pine St, Resort', 'Vehicle theft from the parking area.', 1), -- Pending
    (5, 11, '2023-10-30', 'Concert Venue', '666 Cedar St, Arena', 'Vehicle vandalism during event.', 3), -- Approved
                (7, 10, '2023-04-30', 'City Park', '101 Pine St, County', 'Damage to home due to natural disaster.', 4), -- Denied
                (10, 11, '2023-05-05', 'Airport', '111 Cedar St, State', 'Lost luggage during travel.', 5); -- Processing

INSERT INTO ClaimDocuments (ClaimId, DocumentPath)
VALUES 
    (1, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (1, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (2, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (2, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (3, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (3, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (3, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (4, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (4, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (4, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (5, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (5, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (5, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (6, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (6, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (6, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (7, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (7, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (7, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (8, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (8, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (8, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (9, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (9, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp'),
                (9, 'http://res.cloudinary.com/dssuslfy0/raw/upload/v1713504148/4e32baac-f318-495a-bcd4-5079adfff35c.tmp');


--DELETE FROM UserPolicy;
--DBCC CHECKIDENT ('UserPolicy', RESEED, 0);

--delete from DocumentList;
--DBCC CHECKIDENT ('DocumentList', RESEED, 0);

select * from Roles;
select * from Users;
select * from PolicyTypes;
select * from Policies;
select * from Claims;
select * from DocumentList;
select * from UserPolicy;
select * from ClaimDocuments;
select * from AuditLogs;
delete from AuditLogs;


