



CREATE VIEW HIV_DEATHS_BIGGER as Select country, date, deaths
FROM reported_hiv_prevelance
WHERE deaths > 29000;



CREATE VIEW HIV_DEATHS_SMALLER as Select country, date, deaths
FROM reported_hiv_prevelance
WHERE deaths < 29000;



CREATE VIEW HIV_INCIDENCE_BIGGER as Select country, date, incidence
FROM reported_hiv_incidence
WHERE incidence > 62000;



CREATE VIEW HIV_INCIDENCE_LESSER as Select country, date, incidence
FROM reported_hiv_incidence
WHERE incidence < 62000;



CREATE VIEW HIV_DEATH_AVERTED as Select country, date, hiv_death, deaths_averted
FROM art_treatment_announcement
WHERE hiv_death > 27000 AND deaths_averted > 14000;



SELECT count(*) FROM HIV_INCIDENCE_BIGGER B WHERE 
B.country NOT IN (SELECT S.country FROM HIV_DEATHS_BIGGER S WHERE S.country = B.country and S.date = B.date); 

SELECT count(*) FROM hiv_incidence_bigger B 
LEFT OUTER JOIN hiv_deaths_bigger S
on B.country = S.country and S.date = B.date WHERE S.country is NULL and S.date is NULL;



SELECT count(*) FROM hiv_incidence_lesser B WHERE 
B.country IN (SELECT S.country FROM hiv_death_averted S WHERE S.country = B.country and S.date = B.date); 

SELECT count(*) FROM hiv_incidence_lesser B WHERE EXISTS 
(SELECT S.country FROM hiv_death_averted S WHERE S.country = B.country and S.date = B.date); 




SELECT S.country, COUNT(D.date) as NumberOfReports FROM reported_hiv_deaths S
LEFT OUTER JOIN reported_hiv_prevelance D  ON (S.country = D.country and S.date = D.date) 
GROUP BY S.country
HAVING COUNT(D.date) < 10; 


SELECT S.country, SUM(S.death_70plus) as Death70Plus , sum(S.death_50_69) as Death50_69, sum(S.death_15_49) as Death15_49, SUM(S.death_5_14) as Death5_14, SUM(S.death_under5) as DeathUnder5,
SUM(D.deaths) as TotalDeaths, 
SUM(S.death_under5 + S.death_5_14 + S.death_15_49 + S.death_50_69 + S.death_70plus ) as AdditionOfAgeGroupDeath, 
SUM(S.death_under5 + S.death_5_14 + S.death_15_49 + S.death_50_69 + S.death_70plus - D.deaths) AS Difference FROM reported_hiv_deaths S
LEFT OUTER JOIN reported_hiv_prevelance D  ON (S.country = D.country and S.date = D.date) 
GROUP BY S.country
HAVING Difference >= -10 and Difference <= 10; 



SELECT S.country, CAST(AVG(S.deaths) AS decimal(10,2)) AS Average_Death, CAST(AVG(D.deaths_averted) AS decimal (10,2)) As Average_Death_Averted FROM reported_hiv_prevelance S
LEFT OUTER JOIN art_treatment_announcement D ON (S.country = D.country and S.date = D.date)
group by S.country
HAVING Average_Death_Averted is not NULL; 



SELECT S.country, MAX(S.longevity) as Longevity, MAX(D.deaths_averted) as Deaths_averted FROM life_expectancy_announcement S
LEFT OUTER JOIN art_treatment_announcement D ON (S.country = D.country and S.date = D.date)
group by S.country
HAVING Deaths_Averted is not Null;



SELECT S.country, MIN(S.longevity) as Longevity, MIN(D.deaths) as Deaths, MIN(K.incidence) as Incidence FROM life_expectancy_announcement S
LEFT OUTER JOIN reported_hiv_prevelance D  ON (S.country = D.country and S.date = D.date) LEFT OUTER JOIN reported_hiv_incidence K ON (S.country = K.country and S.date = K.date)
group by S.country
HAVING Deaths is not NULL and incidence is not null;




SELECT MAX(deaths) FROM reported_hiv_prevelance;
SELECT MIN(deaths) FROM reported_hiv_prevelance;


ALTER TABLE reported_hiv_prevelance ADD CONSTRAINT deaths_bigger_zero CHECK(deaths >= 0 and deaths <= 1844490);


INSERT INTO reported_hiv_prevelance (country,date,prevelance,deaths) 
VALUES ('Turkey', 2024, 560, -25);

INSERT INTO reported_hiv_prevelance (country,date,prevelance,deaths) 
VALUES ('Turkey', 2024, 560, 1844495);


delimiter //
CREATE TRIGGER death_number_check BEFORE INSERT ON reported_hiv_prevelance
FOR EACH ROW
BEGIN
	IF NEW.deaths < 0 THEN SET NEW.deaths = 0;
	ELSEIF NEW.deaths > 1844490 THEN SET NEW.deaths = 1844490;
    END IF;
END;//
delimiter ;


INSERT INTO reported_hiv_prevelance (country,date,prevelance,deaths) 
VALUES ('Turkey', 2024, 560, -25);


INSERT INTO reported_hiv_prevelance (country,date,prevelance,deaths) 
VALUES ('Turkey', 2025, 560, 1844495);


delimiter //
CREATE TRIGGER death_number_check_update BEFORE UPDATE ON reported_hiv_prevelance
FOR EACH ROW
BEGIN
	IF NEW.deaths < 0 THEN SET NEW.deaths = 0;
	ELSEIF NEW.deaths > 1844490 THEN SET NEW.deaths = 1844490;
    END IF;
END;//
delimiter ;

UPDATE reported_hiv_prevelance SET deaths = 1844498
WHERE date = 2025;


delimiter //
CREATE PROCEDURE bringALL(input VARCHAR(100))
BEGIN
	SELECT S.country, S.date, S.longevity as Longevity, D.deaths as Deaths, K.incidence as Incidence, L.deaths_averted as Death_Averted FROM life_expectancy_announcement S
	LEFT OUTER JOIN reported_hiv_prevelance D  ON (S.country = D.country and S.date = D.date) LEFT OUTER JOIN reported_hiv_incidence K ON (S.country = K.country and S.date = K.date) 
    LEFT OUTER JOIN art_treatment_announcement L ON (S.country = L.country and S.date = L.date) WHERE input = S.country;
    
END; //
delimiter ;



CALL bringALL('Turkey');

CALL bringALL('Zimbabwe');









