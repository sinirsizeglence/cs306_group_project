USE PROJE;

CREATE TABLE Countries
(country VARCHAR(200),
iso_code varchar(100),
PRIMARY KEY(country));

select * FROM Countries;


CREATE TABLE Reported_HIV_Incidence
(country VARCHAR(50),
date INTEGER,
incidence INTEGER,
PRIMARY KEY(country,date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);

SELECT * FROM Reported_HIV_Incidence;


CREATE TABLE Reported_HIV_Prevelance
(country VARCHAR(50),
date INTEGER,
prevelance double,
deaths INTEGER,
PRIMARY KEY (country,date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);


SELECT * FROM Reported_HIV_Prevelance;

CREATE TABLE ART_Treatment_Announcement 
(country VARCHAR(50),
date INTEGER,
hiv_death FLOAT,
deaths_averted FLOAT,
PRIMARY KEY (country, date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);
SELECT COUNT(country) FROM ART_Treatment_Announcement;
SELECT * FROM ART_Treatment_Announcement;


CREATE TABLE Life_Expectancy_Announcement (
  country VARCHAR(200),
  date INTEGER,
  longevity FLOAT,
  PRIMARY KEY (country, date),
  FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);

SELECT * FROM Life_Expectancy_Announcement;
SELECT COUNT(country) FROM Life_Expectancy_Announcement;

CREATE TABLE Reported_HIV_Deaths(
country VARCHAR(200),
date INTEGER,
death_70plus INTEGER,
death_50_69 INTEGER,
death_15_49 INTEGER,
death_5_14 INTEGER,
death_under5 INTEGER,
PRIMARY KEY (country,date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);

SELECT * FROM Reported_HIV_Deaths;
SELECT COUNT(country) FROM Reported_HIV_Deaths;



