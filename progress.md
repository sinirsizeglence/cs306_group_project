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

We have created the Entity Relationship Diagram (ERD) for our database. The ERD is as follows:

![Entity Relationship Diagram](assets/er_diagram.png)

Our database have the following tables:

- Countries (name, code)
- HIV_Prevelance (date, country, prevelance)
  - Report {weak entity}
- HIV_Deaths (date, country, deaths)
  - Report {weak entity}
- HIV_Incidence (date, country, incidence)
  - Report {weak entity}
- ART_Treatment (date, country, treatment)
  - Announce {weak entity}
- Life_Expectancy (date, country, expectancy)
  - Announce {weak entity}

While we were creating the ERD, we have decided to add the following key constraints to our database:

- Name is a primary key in the Countries table.
- Country code is a foreign key in the following tables:
  - HIV_Prevelance
  - HIV_Deaths
  - HIV_Incidence
  - ART_Treatment
  - Life_Expectancy
- Date is a primary key in the following tables:
  - HIV_Prevelance
  - HIV_Deaths
  - HIV_Incidence
  - ART_Treatment
  - Life_Expectancy

We also decided to add the following custom constructs to our database:

- Report {weak entity}:
  - Report is a weak entity of HIV_Prevelance, HIV_Deaths, and HIV_Incidence.
  - Report has a primary key of ???.
  - Report has a foreign key of ???.

- Announce {weak entity}:
  - Announce is a weak entity of ART_Treatment and Life_Expectancy.
  - Announce has a primary key of ???.
  - Announce has a foreign key of ???.

After that, we wanted to include the participation constraints in our database. We have decided to add the following one to one and one to many participation constraints:

- One to one participation constraint:
  - Report is a one to one participation constraint of HIV_Prevelance, HIV_Deaths, and HIV_Incidence.
  - Announce is a one to one participation constraint of ART_Treatment and Life_Expectancy.
