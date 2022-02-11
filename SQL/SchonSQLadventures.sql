Drop Database SchonsDB;
Create Database SchonsDB;
Use SchonsDB;

Create Table Player(
	PlayerNr varchar(10),
    PlayerName varchar(45),
    PlayerAge int,
    Primary Key (PlayerNr)
);

Create Table Competition(
	CompetitionName varchar(45),
    CompetitionDate varchar(50),
    Primary Key (CompetitionName)
);

Create Table Weather(
	WeatherType varchar(45),
    WeatherWind int,
    Primary Key (WeatherType)
);

Create Table Forcast(
	TimeEst Time,
    Competition varchar(45),
    Weather varchar(45),
    Primary Key (Competition, Weather),
    Foreign Key (Competition) References Competition(CompetitionName),
    Foreign Key (Weather) References Weather(WeatherType)
);

Create Table Attendance(
	PlayerNr varchar(10),
    CompetitionName varchar(45),
    Primary Key (PlayerNr, CompetitionName),
    Foreign Key (PlayerNr) References Player(PlayerNr),
    Foreign Key (CompetitionName) References Competition(CompetitionName)
);

Create Table Jacket(
	JacketModel varchar(45),
    JacketSize int,
    JacketMaterial varchar(45),
    PlayerNr varchar(10),
    Primary Key (JacketModel),
    Foreign Key (PlayerNr) References Player(PlayerNr)
);

Create Table Construction(
	SerialNr int,
    Hardness int,
    Primary Key (SerialNr)
);

Create Table Club(
	ClubNr int,
    ClubMaterial varchar(45),
    SerialNr int,
    PlayerNr varchar(10),
    Primary Key (ClubNr),
    Foreign Key (SerialNr) References Construction(SerialNr),
    Foreign Key (PlayerNr) References Player(PlayerNr)
);

Insert Into Player Values (9605211337, "Johan Andersson", 25), (0204120420, "Nicklas Jansson", 19), (9407130666, "Annika Persson", 27);
Insert Into Competition Values ("Big Golf Cup Skövde", "10/06-2021");
Insert Into Attendance Values (9605211337, "Big Golf Cup Skövde"), (0204120420, "Big Golf Cup Skövde"), (9407130666, "Big Golf Cup Skövde");
Insert Into Weather Values ("Hail", 10);
Insert Into Forcast Values (12.00, "Big Golf Cup Skövde", "Hail");
Insert Into Jacket Values ("Fleece Jacka", 35, "Fleece", 9605211337), ("Goretex Jacka", 35, "Goretex", 9605211337);
Insert Into Construction Values (051001, 10), (050515, 5);
Insert Into Club Values (01, "Wood", 051001, 0204120420), (02, "Wood", 050515, 9407130666);

Select * From Player Where PlayerName = "Johan Andersson";
Select * From Competition Where CompetitionName = "Big Golf Cup Skövde";
Select * From Club Where PlayerNr = 9605211337;
Select * From Jacket Where PlayerNr = 9605211337;
Select * From Attendance Where CompetitionName = "Big Golf Cup Skövde";
Select WeatherWind From Weather Where WeatherType = (Select Weather From Forcast Where Competition = "Big Golf Cup Skövde");
Select * From Player Where PlayerAge < 30;
SET SQL_SAFE_UPDATES=0;
Delete From Jacket Where JacketModel IN ( Select * From (Select JacketModel From Jacket Where PlayerNr = 9605211337) AS X);
SET SQL_SAFE_UPDATES=1;
Select * From Jacket Where PlayerNr = 9605211337;
SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES=0;
Delete From Player Where PlayerNr IN ( Select * From (Select PlayerNr From Player Where PlayerName = "Nicklas Jansson") AS X);
SET SQL_SAFE_UPDATES=1;
SET FOREIGN_KEY_CHECKS=1;
Select Sum(PlayerAge) From Player;
