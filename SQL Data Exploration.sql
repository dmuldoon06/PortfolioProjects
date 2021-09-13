--Data Exploration 
--Skills Used: Create Tables, Joins, Aggregate Functions, Case Statement 

--Creating two tables one with the fabric properties and the other with the testing data

CREATE TABLE fabric_profile
	(ID INT PRIMARY KEY, 
 	Class VARCHAR(255),
 	Vendor VARCHAR(255),
 	Brand VARCHAR(255),
 	Name VARCHAR(255),
	Display_Name VARCHAR(255),
 	Alternate_Style_Number VARCHAR(255),
 	Construction VARCHAR(255),
 	Structure VARCHAR(255),
 	Cocona_375_Polyester_White_Filament DECIMAL (3,2),
 	Cocona_375_Polyester_White_Fiber DECIMAL (3,2),
 	Cocona_375_Nylon_White_Fiber DECIMAL (3,2),
 	Cocona_375_Nylon_White_FIlament DECIMAL (3,2),	
 	Cotton DECIMAL (3,2),
 	Cotton_Pima DECIMAL (3,2),	
 	Linen DECIMAL (3,2),
 	Lyocell DECIMAL (3,2),	
 	Merino_Wool DECIMAL (3,2),	
 	Modacrylic DECIMAL (3,2),
 	Modal DECIMAL (3,2),
 	Nylon DECIMAL (3,2),
 	Other DECIMAL (3,2),	
 	Polyacrylic DECIMAL (3,2),	
 	Polyester DECIMAL (3,2),	
 	Polyester_Recycled DECIMAL (3,2),
 	Polypropylene DECIMAL (3,2),
 	Rayon DECIMAL (3,2),	
	Silk DECIMAL (3,2),	
	Stretch_Yarn DECIMAL (3,2),	
 	Viscose DECIMAL (3,2),
 	Acetate DECIMAL (3,2),
 	Acrylic DECIMAL (3,2),	
 	Bamboo DECIMAL (3,2),
 	Cashmere DECIMAL (3,2),	
 	Conducting_Fiber DECIMAL (3,2),	
 	FR_Polyester DECIMAL (3,2),
 	Hemp DECIMAL (3,2),	
 	Olefin	DECIMAL (3,2),
 	Other_Content DECIMAL (3,2),
 	PBT DECIMAL (3,2),	
 	Sorona DECIMAL (3,2),
 	Tencel DECIMAL (3,2),
 	Wool DECIMAL (3,2),
 	Cocona_375_Nylon_Grey_Fiber DECIMAL (3,2),	
 	Cocona_375_Nylon_Grey_Filament DECIMAL (3,2),
 	Cocona_375_Polyester_Grey_Fiber DECIMAL (3,2),	
 	Cocona_375_Polyester_Grey_Filament DECIMAL (3,2),
 	Yarn_Note VARCHAR(255), 
 	Weight DECIMAL (5,2),
 	Width DECIMAL (5,2));


CREATE TABLE lab_test_data
	(lab_id INT, 
 	FOREIGN KEY (lab_id) REFERENCES fabric_profile(id),
 	Item VARCHAR(255),
 	Color VARCHAR(255),
 	Lot VARCHAR(255),
 	Submit_Type VARCHAR(255),
 	Flagged VARCHAR(3),
	Reason_for_Flag VARCHAR(255),	
 	Flagged_Comments VARCHAR(255),
 	Approval VARCHAR(255),
 	Approved_By VARCHAR(255),
 	Received_Date DATE,  
 	Finished_Date DATE,
 	API DECIMAL (6,2),
 	Heated_Plate_Self DECIMAL (3,2),
 	Heated_Plate_deltaT DECIMAL (4,2),
 	Heated_Plate_System DECIMAL (3,2),
 	Air_flow DECIMAL (4,2),	
 	Air_Perm DECIMAL (6,2),
 	Absorbency_0W  DECIMAL (5,2),
 	Absorbency_2W DECIMAL (5,2));
 
--Shows all fabrics recieved in 2020 starting with D

SELECT id,vendor, brand, name, received_date 
FROM fabric_profile
INNER JOIN lab_test_data
	ON fabric_profile.id=lab_test_data.lab_id
WHERE vendor LIKE 'D%'
AND received_date BETWEEN '2020-01-01' 
AND '2020-12-31'
ORDER BY received_date;

--Shows tot. # of fabrics where api is <100 and heated_plate >=2
SELECT COUNT(api)
FROM lab_test_data
WHERE api <100
AND heated_plate_self >=2.00;

--Shows the distribution of drying rates for fabrics
SELECT COUNT(heated_plate_self),
CASE
	WHEN (heated_plate_self <= 0.99) THEN 'Low'
	WHEN (heated_plate_self BETWEEN 1.00 AND 1.99) THEN 'Med'
	ELSE 'High'
END AS drying_rates
FROM lab_test_data
GROUP BY drying_rates;

--Shows the average turn times of fabrics recieved in lab grouped by technician
SELECT approved_by,
	AVG(AGE(finished_date,received_date))
	AS turn_times 
FROM fabric_profile
	INNER JOIN lab_test_data 
	ON fabric_profile.id =lab_test_data.lab_id
GROUP BY approved_by;






