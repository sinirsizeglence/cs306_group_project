# Progress and Processes

## Step 1: Data Collection, Cleaning, Creating ER Diagram

We have gathered all the data from [Our World in Data](https://ourworldindata.org/hiv-aids) and downloaded the CSV files. We have selected to work on the CSV files for the following datasets:

- [hivaids-deaths-and-averted-due-to-art.csv](csv_files/inputs/hivaids-deaths-and-averted-due-to-art.csv)
- [deaths-from-hiv-by-age.csv](csv_files/inputs/deaths-from-hiv-by-age.csv)
- [new-cases-of-hiv-infection.csv](csv_files/inputs/new-cases-of-hiv-infection.csv)
- [life-expectancy.csv](csv_files/inputs/life-expectancy.csv)
- [deaths-and-new-cases-of-hiv.csv](csv_files/inputs/deaths-and-new-cases-of-hiv.csv)

After that, we have decided which columns we will use in our database.

Next, we have removed the unnecessary columns from the datasets and renamed filenames into our database structure. The new filenames are as follows:

- from [hivaids_deaths_and_averted_due_to_art.csv](csv_files/inputs/hivaids_deaths_and_averted_due_to_art.csv) to [art_treatment.csv](csv_files/outputs/art_treatment.csv)
- from [deaths_from_hiv_by_age.csv](csv_files/inputs/deaths_from_hiv_by_age.csv) to [death_count.csv](csv_files/outputs/death_count.csv)
- from [new_cases_of_hiv_infection.csv](csv_files/inputs/new_cases_of_hiv_infection.csv) to [incidence.csv](csv_files/outputs/incidence.csv)
- from [new_cases_of_hiv_infection.csv](csv_files/inputs/new_cases_of_hiv_infection.csv) to [prevalence.csv](csv_files/outputs/prevalence.csv)
- we have decided not to change the name [life_expectancy.csv](csv_files/inputs/life_expectancy.csv).

We have created the Entity Relationship Diagram (ERD) for our database:

![Entity Relationship Diagram](assets/er_diagram.png)

Our database have the following tables:

- Countries (name, iso_code)
- HIV_Prevelance (date, country, prevelance)
- HIV_Deaths (date, country, deaths)
- HIV_Incidence (date, country, incidence)
- ART_Treatment (date, country, treatment)
- Life_Expectancy (date, country, expectancy)

While we were creating the ERD, we have decided to add the following key constraints to our database:

- `name` is a primary key in the Countries table.
- `country` is a foreign key from `Countries.name` in the following tables:
  - HIV_Prevelance
  - HIV_Deaths
  - HIV_Incidence
  - ART_Treatment
  - Life_Expectancy
- Date is a partial key in the following weak entities:
  - HIV_Prevelance
  - HIV_Deaths
  - HIV_Incidence
  - ART_Treatment
  - Life_Expectancy

We have these relationships between the tables:

- `Countries` (entity) `Report` (relation) via one-to-many relationship:
  - HIV_Prevelance
  - HIV_Deaths
  - HIV_Incidence

- `Countries` (entity) `Announce` (relation) via one-to-many relationship:
  - ART_Treatment
  - Life_Expectancy

## Step 2: Creating Database and Importing Data

We have created the database in MySQL Workbench. We have created the following tables:

- Countries (name, iso_code)

  Because some countries do not have an ISO code, we have decided to make the `iso_code` column nullable.
  Because some data in Entity column from original files are not countries, they are unnecessarily long, so in order to add them to the database, we have decided to make the `name` column 200 characters long. Likewise, we have decided to make the `iso_code` column 100 characters long in order to add the ISO codes of non-country entities. (e.g. "World"). We have decided to make the `name` column the primary key of the table.

```sql
CREATE TABLE Countries
(country VARCHAR(200),
iso_code varchar(100),
PRIMARY KEY(country));
```

- Reported_HIV_Prevelance (country, date, prevelance, deaths)

```sql
CREATE TABLE Reported_HIV_Prevelance
(country VARCHAR(50),
date INTEGER,
prevelance double,
deaths INTEGER,
PRIMARY KEY (country,date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);
```

- Reported_HIV_Deaths (country, date, death_70plus, death_50_69, death_15_49, death_5_14, death_under5)

```sql
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
```

- Reported_HIV_Incidence (country, date, incidence)

```sql
CREATE TABLE Reported_HIV_Prevelance
(country VARCHAR(50),
date INTEGER,
prevelance double,
deaths INTEGER,
PRIMARY KEY (country,date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);
```

- ART_Treatment_Announcement (country, date, hiv_death, deaths_averted)

```sql
CREATE TABLE ART_Treatment_Announcement 
(country VARCHAR(50),
date INTEGER,
hiv_death FLOAT,
deaths_averted FLOAT,
PRIMARY KEY (country, date),
FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);
```

- Life_Expectancy_Announcement (country, date, longevity)

```sql
CREATE TABLE Life_Expectancy_Announcement (
  country VARCHAR(200),
  date INTEGER,
  longevity FLOAT,
  PRIMARY KEY (country, date),
  FOREIGN KEY (country) REFERENCES Countries(country) ON DELETE CASCADE
);
```

We have imported the data into the database using the following commands:

```sql
LOAD DATA LOCAL INFILE 'csv_files/outputs/art_treatment.csv' INTO TABLE ART_Treatment_Announcement FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'csv_files/outputs/death_count.csv' INTO TABLE Reported_HIV_Deaths FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'csv_files/outputs/incidence.csv' INTO TABLE Reported_HIV_Incidence FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'csv_files/outputs/life_expectancy.csv' INTO TABLE Life_Expectancy_Announcement FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'csv_files/outputs/prevalence.csv' INTO TABLE Reported_HIV_Prevelance FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
```
