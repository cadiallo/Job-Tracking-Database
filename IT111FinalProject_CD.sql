-- --------------------------------------------------------------------------------
-- Name: Cheikh A Diallo
-- Class: 25_SU_IT-111-401
-- Abstract: Final Project
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbJobTracker;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Final Project
-- --------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Drop Tables
------------------------------------------------------------------------------------

IF OBJECT_ID ('TJobMaterials')					IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID ('TJobWorkers')					IS NOT NULL DROP TABLE TJobWorkers
IF OBJECT_ID ('TWorkerSkills')					IS NOT NULL DROP TABLE TWorkerSkills
IF OBJECT_ID ('TJobs')							IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID ('TMaterials')						IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID ('TVendors')						IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TWorkers')						IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID ('TSkills')						IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID ('TCustomers')						IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TCities')						IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TStates')						IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TStatus')						IS NOT NULL DROP TABLE TStatus

-- --------------------------------------------------------------------------------
-- Create table / adding foreign Keys
-- --------------------------------------------------------------------------------

CREATE TABLE TJobs
(
	 intJobID							INTEGER				NOT NULL
	,intCustomerID						INTEGER				NOT NULL
	,intStatusID						INTEGER				NOT NULL
	,dtmStartDate						DATETIME			NOT NULL
	,dtmEndDate							DATETIME			NOT NULL
	,strJobDesc							VARCHAR(2000)		NOT NULL
	,CONSTRAINT TJobs_PK				PRIMARY KEY ( intJobID )
)

CREATE TABLE TCustomers
(
	  intCustomerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(50)			NOT NULL
	 ,strLastName						VARCHAR(50)			NOT NULL
	 ,strAddress						VARCHAR(50)			NOT NULL
	 ,intCityID							INTEGER				NOT NULL
	 ,intStateID						INTEGER				NOT NULL
	 ,strZip							VARCHAR(50)			NOT NULL
	 ,strPhoneNumber					VARCHAR(50)			NOT NULL
	 ,CONSTRAINT TCustomer_PK			PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TStatus
(
	 intStatusID						INTEGER				NOT NULL
	,strStatus							VARCHAR(50)			NOT NULL
	,CONSTRAINT TStatus_PK				PRIMARY KEY ( intStatusID )
)

CREATE TABLE TJobMaterials
(
	 intJobMaterialID					INTEGER				NOT NULL
	,intJobID							INTEGER				NOT NULL
	,intMaterialID						INTEGER				NOT NULL
	,intQuantity						INTEGER				NOT NULL
	,CONSTRAINT TCustomerJobMaterials_PK PRIMARY KEY ( intJobMaterialID )
)

CREATE TABLE TMaterials
(
	 intMaterialID						INTEGER				NOT NULL
	,strDescription						VARCHAR(100)		NOT NULL
	,monCost							MONEY				NOT NULL
	,intVendorID						INTEGER				NOT NULL
	,CONSTRAINT TMaterials_PK			PRIMARY KEY ( intMaterialID )
)

CREATE TABLE TVendors
(
	 intVendorID						INTEGER				NOT NULL
	,strVendorName						VARCHAR(50)			NOT NULL
	,strAddress							VARCHAR(50)			NOT NULL
	,intCityID							INTEGER				NOT NULL
	,intStateID							INTEGER				NOT NULL
	,strZip								VARCHAR(50)			NOT NULL
	,strPhoneNumber						VARCHAR(50)			NOT NULL
	,CONSTRAINT TVendors_PK				PRIMARY KEY ( intVendorID )
)

CREATE TABLE TJobWorkers
(
	 intJobWorkerID						INTEGER				NOT NULL
	,intJobID							INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intHoursWorked						INTEGER				NOT NULL
	,CONSTRAINT TCustomerJobWorkers_PK	PRIMARY KEY ( intJobWorkerID )
)

CREATE TABLE TWorkers
(
	 intWorkerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(50)			NOT NULL
	 ,strLastName						VARCHAR(50)			NOT NULL
	 ,strAddress						VARCHAR(50)			NOT NULL
	 ,intCityID							INTEGER				NOT NULL
	 ,intStateID						INTEGER				NOT NULL
	 ,strZip							VARCHAR(50)			NOT NULL
	 ,strPhoneNumber					VARCHAR(50)			NOT NULL
	 ,dtmHireDate						DATETIME			NOT NULL
	 ,monHourlyRate						MONEY				NOT NULL
	 ,CONSTRAINT TWorkers_PK			PRIMARY KEY ( intWorkerID )
)

CREATE TABLE TWorkerSkills
(
	 intWorkerSkillID					INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intSkillID							INTEGER				NOT NULL
	,CONSTRAINT	TWorkerSkills_PK		PRIMARY KEY ( intWorkerSkillID )
)

CREATE TABLE TSkills
(
	 intSkillID							INTEGER				NOT NULL
	,strSkill							VARCHAR(50)			NOT NULL
	,strDescription						VARCHAR(100)		NOT NULL
	,CONSTRAINT TSkills_PK				PRIMARY KEY ( intSkillID )
)

CREATE TABLE TCities
(
	  intCityID							INTEGER			NOT NULL
	 ,strCity							VARCHAR(25)		NOT NULL
	 ,CONSTRAINT TCities_PK				PRIMARY KEY ( intCityID )
)

CREATE TABLE TStates
(
	 intStateID							INTEGER			NOT NULL
	,strState							VARCHAR(25)		NOT NULL
	,CONSTRAINT TStates_PK				PRIMARY KEY ( intStateID )
)

-- --------------------------------------------------------------------------------
-- Creating relationships.normalization, Foreign Keys
-- --------------------------------------------------------------------------------
--		Child						Parent					Column
--      -----						------					---------
--  1   TJobMaterials				TJobs					intJobID
--  2   TJobMaterials				TMaterials				intMaterialID
--	3	TJobWorkers					TJobs					intJobID
--	4	TJobWorkers					TWorkers				intWorkerID
--	5	TWorkerSkills				TWorkers				intWorkerID
--	6	TWorkerSkills				TSkills					intSkillID
--	7	TJobs						TCustomers				intCustomerID
--	8	TJobs						TStatus					intStatusID
--	9	TCustomers					TCities					intCityID
--	10	TCustomers					TStates					intStateID
--	11	TMaterials					TVendors				intVendorID
--	12	TVendors					TCities					intCityID
--	13	TVendors					TStates					intStateID
--	14	TWorkers					TCities					intCityID
--	15	TWorkers					TStates					intStateID


--ALTER TABLE <Child Table> ADD CONSTRAINT <Child Table>_<Parent Table>_FK1
--FOREIGN KEY ( <Child column> ) REFERENCES <Parent Table> ( <Parent column> )

-- --------------------------------------------------------------------------------
--	Writing Alter Commands and ordering Drop Tables
-- --------------------------------------------------------------------------------

-- 1
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

-- 2
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )

-- 3
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

-- 4
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 5
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 6
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TSkills_FK
FOREIGN KEY ( intSkillID ) REFERENCES TSkills ( intSkillID )

-- 7
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- 8
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatus_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatus ( intStatusID )

-- 9
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_Tcities_FK
FOREIGN KEY ( intCityID ) REFERENCES Tcities ( intCityID )

--10
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 11
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )

-- 12
ALTER TABLE TVendors ADD CONSTRAINT TVendors_Tcities_FK
FOREIGN KEY ( intCityID ) REFERENCES Tcities ( intCityID )

-- 13
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 14
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_Tcities_FK
FOREIGN KEY ( intCityID ) REFERENCES Tcities ( intCityID )

-- 15
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- --------------------------------------------------------------------------------
--	Adding INSERTS
-- --------------------------------------------------------------------------------

INSERT INTO TCities( intCityID, strCity)
VALUES				(1, 'Cincinnati')
				   ,(2, 'Mason')
				   ,(3, 'Fairfield')
				   ,(4, 'Milford')
				   ,(5, 'West Chester')

INSERT INTO TStates ( intStateID, strState)
VALUES				(1, 'Ohio')
					,(2, 'Kentucky')
					,(3, 'Indiana')

INSERT INTO TStatus( intStatusID, strStatus)
VALUES				(1, 'Open')
					,(2, 'In Process')
					,(3, 'Complete')

INSERT INTO TSkills( intSkillID, strSkill, strDescription)
VALUES				(1, 'Plumber', 'install, repair and maintain watersystems')
					,(2, 'Electrician', 'handle wiring, lighting and electrical systems')
					,(3, 'Carpenter', 'build, repair and install wooden structures')
					,(4, 'HVAC Technician', 'installs and service heating, ventilation and AC systems')
					,(5, 'Painter', 'prepares and paint surfaces')

INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, strPhoneNumber)
VALUES				  (1, 'Beberly', 'Lopez', '8311 Main Street', 1, 1, '45236', '937 218 9213')
					 ,(2, 'Wendy', 'Hernandez', '428 Cambridge drive', 1, 1, '45241', '646 645 2355')
					 ,(3, 'Michael', 'Randall', '6566 Main Street', 2, 3, '45040', '937 728 3266')
					 ,(4, 'Keich', 'Lodia', '801 EdgeCombe Drive', 4, 2, '45250', '513 552 7728')
					 ,(5, 'Mariama', 'Diallo', '38 Main Street', 3, 1, '45242', '513 191 0098')

INSERT INTO TWorkers (intWorkerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, strPhoneNumber, dtmHireDate, monHourlyRate)
VALUES				(1, 'Berry', 'white', '103 Cornell Road', 1, 1, '45242', '513 726 3827', '7/1/2025', 22)
					,(2, 'Ming', 'You', '5 Plantation Drive', 5, 3, '45070', '513 736 0298', '10/10/2021', 30)
					,(3, 'Dila', 'Brown', '12 Winton Road', 1, 2, '45224', '513 276 2236', '5/12/2019', 28)
					,(4, 'Sally', 'Smith', '987 Main St.', 3, 1, '45218', '937 263 9037', '12/1/2010', 35)
					,(5, 'Jose', 'Hernandez', '1569 Windisch Rd.', 2, 1, '45069', '513 009 3421', '9/23/2006', 43)

INSERT INTO TVendors (intVendorID, strVendorName, strAddress, intCityID, intStateID, strZip, strPhoneNumber)
VALUES				(1, 'JonesLLC', '45 Benny Road', 2, 1, '45250', '542-635-6352')
					,(2, 'ASowPainT', '545 Colerain Avenue', 3, 3, '45070', '513-635-7222')
					,(3, 'Allpax Mechanics', '4 Peyton Road', 1, 1, '45224', '937-233-1322')
					,(4, 'ZumaParts', '267 Mount St.', 3, 1, '45218', '513-705-0074')
					,(5, 'Perezbrothers', '6 Ridge Rd.', 2, 1, '45069', '937-711-3236')

INSERT INTO TJobs (intJobID, intCustomerID, intStatusID, dtmStartDate, dtmEndDate,strJobDesc)
VALUES				 (1, 4, 2, '10/10/2024', '11/1/2024', 'Kitchen walls needed repainting with a fresh coating because wall had peeling paint')
					,(2, 3, 1, '6/10/2025', '6/17/2025', 'broken wooden door frame, damaged frame needs rebuild')
					,(3, 1, 2, '4/3/2025', '5/3/2025', 'AC systeme needed recharge, air filters change and a new thermostat')
					,(4, 2, 3, '7/10/2022', '7/25/2022', 'Lights not turning on, repaired faulty switch and rewire circuit')
					,(5, 5, 3, '12/6/2023', '12/10/2023', 'Kitchen sink leaking, pipe section need replacement')
					,(6, 2, 3, '7/7/2022', '7/12/2022', 'multiple electrical issues in the house due to an old system')
					,(7, 2, 3, '7/12/2022', '7/20/2022', 'we had to replace the wiring for the living room first, now we are working on the kitchen')
					,(8, 2, 2, '7/20/2022', '7/28/2022', 'tracking every old or burnt conduits and replacing them')
					,(9, 2, 1, '7/20/2023', '8/15/2023', 'rewiring some conductors to install an electric car charger in the garage')

INSERT INTO TMaterials (intMaterialID, strDescription, monCost, intVendorID)
VALUES				 (1, 'Copper Pipes', 500, 1)
					,(2, 'Circuit Breakers', 100, 4)
					,(3, 'Plywood', 2000, 5)
					,(4, 'Thermostat', 12000,  3)
					,(5, 'Painters Tape', 50, 2)
					,(6, 'Electrical Wires', 30, 4)
					,(7, 'Conduits', 60, 4)

INSERT INTO TWorkerSkills(intWorkerSkillID, intWorkerID, intSkillID)
VALUES						 (1, 2, 5)
							,(2, 4, 1)
							,(3, 1, 3)
							,(4, 5, 4)
							,(5, 3, 2)

INSERT INTO TJobWorkers(intJobWorkerID, intJobID, intWorkerID, intHoursWorked)
VALUES						 (1, 3, 4, 120)
							,(2, 4, 2, 80)
							,(3, 5, 1, 19)
							,(4, 2, 5, 48)
							,(5, 1, 3, 72)
							,(6, 9, 3, 0)
							,(7, 6, 3, 52)
							,(8, 8, 2, 12)
							,(9, 7, 1, 30)

INSERT INTO TJobMaterials(intJobMaterialID, intJobID, intMaterialID, intQuantity)
VALUES						 (1, 3, 4, 1)
							,(2, 4, 2, 10)
							,(3, 5, 1, 5)
							,(4, 2, 3, 4)
							,(5, 1, 5, 25)
							,(6, 6, 6, 10)
							,(7, 7, 6, 5)
							,(8, 6, 7, 3)

-- --------------------------------------------------------------------------------
--	UPDATES and DELETES
-- --------------------------------------------------------------------------------

-- 3.1: Updating the address for a specific customer

SELECT *
FROM TCustomers

UPDATE TCustomers
SET strAddress = '54 Grove drive'
	,intCityID = 4
	,intStateID = 3
WHERE intCustomerID = 1

SELECT *
FROM TCustomers

-- 3.2: Increasing the hourly rate by $2 for each customer that has been an employee for at least 1 year. 

SELECT *
FROM TWorkers

UPDATE TWorkers
SET monHourlyRate += 2
WHERE dtmHireDate < '8/16/2024'

SELECT *
FROM TWorkers

-- 3.3: Deleting a specific job that has associated work hours and materials assigned to it.

SELECT *
FROM TJobs

DELETE FROM TJobMaterials
WHERE intJobID = 5

DELETE FROM TJobWorkers
WHERE intJobID = 5

DELETE FROM TJobs
WHERE intJobID = 5

SELECT *
FROM TJobs

-- --------------------------------------------------------------------------------
--	QUERIES
-- --------------------------------------------------------------------------------

-- 4.1: Query to list all jobs that are in process. Including the Job ID and Description, Customer ID and name, and the start date. Order by the Job ID

SELECT 
	 TJ.intJobID
	 ,TJ.strJobDesc
	 ,TJ.dtmStartDate
	 ,TC.intCustomerID
	 ,TS.strStatus
	 ,TC.strLastName + ', ' + TC.strFirstName AS Name
FROM TJobs AS TJ
	JOIN TCustomers AS TC
		ON TC.intCustomerID = TJ.intCustomerID
	JOIN TStatus AS TS
		ON TS.intStatusID = TJ.intStatusID
WHERE TS.strStatus = 'In Process'
ORDER BY intJobID

-- 4.2: Query to list all complete jobs for a specific customer and the materials used on each job. Include the quantity, unit cost, and total cost for each material on each job. Order by Job ID and material ID

SELECT 
	 TJ.intJobID
	 ,TJ.strJobDesc
	 ,TJM.intQuantity
	 ,TM.strDescription
	 ,TM.monCost
	 ,TM.monCost * TJM.intQuantity AS TotalCost
	 ,TC.intCustomerID
	 ,TS.strStatus
	 ,TC.strLastName + ', ' + TC.strFirstName AS Name
FROM TJobs AS TJ
	JOIN TJobMaterials AS TJM
		ON TJM.intJobID = TJ.intJobID
	JOIN TMaterials AS TM
		ON TJM.intMaterialID = TM.intMaterialID
	JOIN TCustomers AS TC
		ON TC.intCustomerID = TJ.intCustomerID
	JOIN TStatus AS TS
		ON TS.intStatusID = TJ.intStatusID
WHERE TS.strStatus = 'Complete'
ORDER BY TJ.intJobID, TM.intMaterialID

-- 4.3: Query query to list the total cost for all materials for each completed job for the customer.

SELECT 
	 TJ.intJobID
	 ,TJ.strJobDesc
	 ,TJM.intQuantity
	 ,TM.strDescription
	 ,TM.monCost
	 ,SUM(TM.monCost * TJM.intQuantity) As MaterialCost
	 ,TC.intCustomerID
	 ,TS.strStatus
	 ,TC.strLastName + ', ' + TC.strFirstName AS Name
FROM TJobs AS TJ
	JOIN TJobMaterials AS TJM
		ON TJM.intJobID = TJ.intJobID
	JOIN TMaterials AS TM
		ON TJM.intMaterialID = TM.intMaterialID
	JOIN TCustomers AS TC
		ON TC.intCustomerID = TJ.intCustomerID
	JOIN TStatus AS TS
		ON TS.intStatusID = TJ.intStatusID
WHERE TS.strStatus = 'Complete'
GROUP BY TJ.intJobID
	 ,TJ.strJobDesc
	 ,TJM.intQuantity
	 ,TM.strDescription
	 ,TM.monCost
	 ,TC.intCustomerID
	 ,TS.strStatus
	 ,TC.strLastName
	 ,TC.strFirstName
ORDER BY TJ.intJobID

-- 4.4: Query to list all jobs that have work entered for them.

SELECT
	 TJ.intJobID
	 ,TJ.strJobDesc
	 ,TS.strStatus
	 ,TJW.intHoursWorked
	 ,MIN(TW.monHourlyRate) As LowestRate
	 ,MAX(TW.monHourlyRate) As HighestRate
	 ,AVG(TW.monHourlyRate) As AverageRate
FROM TJobs AS TJ
	JOIN TJobWorkers AS TJW
		ON TJW.intJobID = TJ.intJobID
	JOIN TWorkers AS TW
		ON TW.intWorkerID = TJW.intWorkerID
	JOIN TStatus AS TS
		ON TS.intStatusID = TJ.intStatusID
GROUP BY TJ.intJobID
	 ,TJ.strJobDesc
	 ,TS.strStatus
	 ,TJW.intHoursWorked
ORDER BY AverageRate DESC

-- 4.5: Query that lists all materials that have not been used on any jobs

SELECT 
	 TJ.intJobID
	 ,TJ.strJobDesc
	 ,TM.intMaterialID
	 ,TM.strDescription
FROM TJobs AS TJ
	LEFT JOIN TJobMaterials AS TJM
		ON TJM.intJobID = TJ.intJobID
	LEFT JOIN TMaterials AS TM
		ON TM.intMaterialID = TJM.intMaterialID
ORDER BY TM.intMaterialID

-- 4.6: Query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on

SELECT
	TW.intWorkerID
	,TW.strLastName + ', ' + TW.strFirstName AS Name
	,TW.dtmHireDate
	,TS.strSkill
	,TS.strDescription
FROM TWorkers AS TW
	JOIN TWorkerSkills AS TWS
		ON TWS.intWorkerID = TWS.intWorkerID
	JOIN TSkills AS TS
		ON TWS.intSkillID = TS.intSkillID
	JOIN TJobWorkers AS TJW
		ON TJW.intWorkerID = TW.intWorkerID
	JOIN TJobs AS TJ
		ON TJW.intJobID = TJ.intJobID
WHERE TS.strSkill = 'Electrician'
ORDER BY TW.intWorkerID

-- 4.7: Query that lists all workers that worked greater than 20 hours for all jobs that they worked on

SELECT
	TW.intWorkerID
	,TW.strLastName + ', ' + TW.strFirstName AS Name
	,TJW.intHoursWorked
	,COUNT(TJ.intJobID) TotalJobs
FROM TWorkers AS TW
	JOIN TJobWorkers AS TJW
		ON TJW.intWorkerID = TW.intWorkerID
	JOIN TJobs AS TJ
		ON TJW.intJobID = TJ.intJobID
WHERE TJW.intHoursWorked >20
GROUP BY TW.intWorkerID
	,TW.strLastName
	,TW.strFirstName
	,TJW.intHoursWorked
ORDER BY TW.intWorkerID

-- 4.8: Query that includes the labor costs associated with each job. 

SELECT 
	 TJ.intJobID
	 ,TJW.intHoursWorked
	 ,TW.monHourlyRate
	 ,TJW.intHoursWorked * TW.monHourlyRate AS TotalLaborCost
	 ,TC.intCustomerID
	 ,TC.strLastName + ', ' + TC.strFirstName AS Name
FROM TJobs AS TJ
	JOIN TJobWorkers AS TJW
		ON TJW.intJobID = TJ.intJobID
	JOIN TWorkers AS TW
		ON TW.intWorkerID = TJW.intWorkerID
	JOIN TCustomers AS TC
		ON TC.intCustomerID = TJ.intCustomerID
	JOIN TStatus AS TS
		ON TS.intStatusID = TJ.intStatusID
ORDER BY intJobID

-- 4.9: Query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. 

SELECT 
	TC.intCustomerID
	,TC.strLastName + ', ' + TC.strFirstName AS Name
	,TC.strAddress
	,TC.intCityID
	,TC.intStateID
FROM TCustomers AS TC
WHERE TC.strAddress = 'Main Street'
ORDER BY TC.intCustomerID

-- 4.10: Query to list completed jobs that started and ended in the same month. 

SELECT 
	 TJ.intJobID
	 ,TJ.strJobDesc
	 ,TJ.dtmStartDate
	 ,TJ.dtmEndDate
	 ,TS.strStatus
FROM TJobs AS TJ
	JOIN TCustomers AS TC
		ON TC.intCustomerID = TJ.intCustomerID
	JOIN TStatus AS TS
		ON TS.intStatusID = TJ.intStatusID
WHERE TS.strStatus = 'Complete'
AND TJ.dtmStartDate >'7/1/2022'
AND TJ.dtmEndDate < '7/31/2022'

-- 4.11: Query to list workers that worked on three or more jobs for the same customer. 

SELECT 
	 TJ.intJobID
	 ,TW.intWorkerID
	 ,TW.strLastName + ', ' + TW.strFirstName AS Name
	 ,TC.intCustomerID
	 ,TC.strLastName + ', ' + TC.strFirstName AS Name
FROM TJobs AS TJ
	JOIN TJobWorkers AS TJW
		ON TJW.intJobID = TJ.intJobID
	JOIN TWorkers AS TW
		ON TW.intWorkerID = TJW.intWorkerID
	JOIN TCustomers AS TC
		ON TC.intCustomerID = TJ.intCustomerID
WHERE TC.intCustomerID = 2
AND TJ.intJobID >= 3

-- 4.12: Query to list all workers and their total # of skills. Make sure that you have workers that have multiple skills and that you have at least 1 worker with no skills. The worker with no skills should be included with a total number of skills = 0. 

SELECT
	TW.intWorkerID
	,TW.strLastName + ', ' + TW.strFirstName AS Name
	,TW.dtmHireDate
	,TS.strSkill
	,TS.strDescription
FROM TWorkers AS TW
	JOIN TWorkerSkills AS TWS
		ON TWS.intWorkerID = TWS.intWorkerID
	JOIN TSkills AS TS
		ON TWS.intSkillID = TS.intSkillID
	JOIN TJobWorkers AS TJW
		ON TJW.intWorkerID = TW.intWorkerID
	JOIN TJobs AS TJ
		ON TJW.intJobID = TJ.intJobID
WHERE TS.strSkill = 'Electrician'
ORDER BY TW.intWorkerID

-- 4.13: Query to list the total Charge to the customer for each job. Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 


-- 4.14: Query that totals what is owed to each vendor for a particular job. 
