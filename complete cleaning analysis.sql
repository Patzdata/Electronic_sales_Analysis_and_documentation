CREATE DATABASE CORONA_ANALYSIS;

SELECT 
    *
FROM
    corona_data;

SELECT 
    *
FROM
    corona_data
WHERE
    Deaths IS NULL OR Confirmed IS NULL
        OR Recovered IS NULL
        OR Latitude IS NULL
        OR Longitude IS NULL
        OR `Date` IS NULL
        OR Province IS NULL
        OR `Country/Region` IS NULL;

SELECT 
    *
FROM
    corona_data
WHERE
    Deaths = '' OR Confirmed = ''
        OR Recovered = ''
        OR Latitude = ''
        OR Longitude = ''
        OR `Date` = ''
        OR Province = ''
        OR `Country/Region` = '';
-- check null field
/*UPDATE corona_data
SET Recovered=0
WHERE Recorvered IS NULL;*/

-- total number of rows
SELECT 
    COUNT(*) AS total_no_row
FROM
    corona_data;

-- date strings from the format day-month-year to the DATE data type
UPDATE corona_data 
SET 
    `Date` = STR_TO_DATE(`Date`, '%d-%m-%Y');

ALTER TABLE corona_data
MODIFY COLUMN `Date` DATE;

-- start_date and end_date
SELECT 
    MIN(`Date`) AS start_date, MAX(`Date`) AS end_date
FROM
    corona_data;

-- Number of month present in dataset
SELECT 
    COUNT(DISTINCT (SUBSTR(`Date`, 1, 7))) AS no_of_month
FROM
    corona_data;

-- monthly average for confirmed, deaths, recovered
SELECT 
    SUBSTR(`Date`, 1, 7) AS `MONTH`,
    ROUND(AVG(Confirmed), 2) AS avg_confirmed,
    ROUND(AVG(Deaths), 2) AS avg_death,
    ROUND(AVG(Recovered), 2) AS avg_recovered
FROM
    corona_data
GROUP BY `MONTH`
ORDER BY `MONTH` DESC;

-- most frequent value for confirmed, deaths, recovered each month 
WITH ConfirmedCounts AS (
    SELECT SUBSTR(`Date`,1,7) AS `MONTH`, Confirmed, COUNT(*) AS freq
    FROM corona_data
    WHERE Confirmed !=0
    GROUP BY `MONTH`, Confirmed
),
MostFrequentConfirmed AS (
    SELECT `MONTH`, Confirmed
    FROM (
        SELECT `MONTH`, Confirmed, freq,
               ROW_NUMBER() OVER (PARTITION BY `MONTH` ORDER BY freq DESC) AS rn
        FROM ConfirmedCounts
    ) AS sub
    WHERE rn = 1
),

DeathsCounts AS (
    SELECT SUBSTR(`Date`,1,7) AS `MONTH`, Deaths, COUNT(*) AS freq
    FROM corona_data
     WHERE Deaths !=0
    GROUP BY `MONTH`, Deaths
),
MostFrequentDeaths AS (
    SELECT `MONTH`, Deaths
    FROM (
        SELECT `MONTH`, Deaths, freq,
               ROW_NUMBER() OVER (PARTITION BY `MONTH` ORDER BY freq DESC) AS rn
        FROM DeathsCounts
    ) AS sub
    WHERE rn = 1
),

RecoveredCounts AS (
    SELECT SUBSTR(`Date`,1,7) AS `MONTH`, Recovered, COUNT(*) AS freq
    FROM corona_data
     WHERE Recovered !=0
    GROUP BY `MONTH`, Recovered
),
MostFrequentRecovered AS (
    SELECT `MONTH`, Recovered
    FROM (
        SELECT `MONTH`, Recovered, freq,
               ROW_NUMBER() OVER (PARTITION BY `MONTH` ORDER BY freq DESC) AS rn
        FROM RecoveredCounts
    ) AS sub
    WHERE rn = 1
)

SELECT c.`MONTH`, c.Confirmed AS Most_Frequent_Confirmed, d.Deaths AS Most_Frequent_Deaths, r.Recovered AS Most_Frequent_Recovered
FROM MostFrequentConfirmed c
JOIN MostFrequentDeaths d ON c.`MONTH` = d.`MONTH`
JOIN MostFrequentRecovered r ON c.`MONTH` = r.`MONTH`
ORDER BY c.`MONTH`;

/*
SELECT SUBSTR(`Date`,1,7) AS `MONTH`,
MAX(Confirmed) AS Most_Frequent_Confirmed,MAX(Deaths) AS Most_Frequent_Deaths, MAX(Recovered) AS Most_Frequent_Recovered
FROM corona_data
GROUP BY `MONTH`
ORDER BY `MONTH`; */

-- minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(`Date`) AS `YEAR`,
    MIN(Confirmed) AS Min_count_Confirmed,
    MIN(Deaths) AS Min_count_Deaths,
    MIN(Recovered) AS Min_count_Recovered
FROM
    corona_data
WHERE
    Confirmed != 0 AND Deaths != 0
        AND Recovered != 0
GROUP BY `YEAR`
ORDER BY `YEAR`;

-- maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(`Date`) AS `YEAR`,
    MAX(Confirmed) AS MaxConfirmed,
    MAX(Deaths) AS MaxDeaths,
    MAX(Recovered) AS MaxRecovered
FROM
    corona_data
GROUP BY `YEAR`
ORDER BY `YEAR`;

-- total number of case of confirmed, deaths, recovered each month
SELECT 
    SUBSTR(`Date`, 1, 7) AS `MONTH`,
    SUM(Confirmed) AS total_no_Confirmed,
    SUM(Deaths) AS total_no_Deaths,
    SUM(Recovered) AS total_no_Recovered
FROM
    corona_data
GROUP BY `MONTH`
ORDER BY `MONTH`;

-- corona virus spread out with respect to confirmed case
SELECT 
    SUM(confirmed) AS Total_Confirmed_Cases,
    ROUND(AVG(confirmed), 3) AS Average_Confirmed_Cases,
    ROUND(VARIANCE(confirmed), 3) AS Variance_Confirmed_Cases,
    ROUND(STDDEV(confirmed), 3) AS Std_Dev_Confirmed_Cases
FROM
    corona_data;

-- corona virus spread out with respect to death case per month
SELECT 
    SUBSTR(`Date`, 1, 7) `MONTH`,
    SUM(Deaths) AS Total_Death_Cases,
    ROUND(AVG(Deaths), 3) AS Average_Death_Cases,
    ROUND(VARIANCE(Deaths), 3) AS Variance_Death_Cases,
    ROUND(STDDEV(Deaths), 3) AS Std_Dev_Death_Cases
FROM
    corona_data
GROUP BY `MONTH`;

-- how corona virus spread out with respect to recovered case
SELECT 
    SUM(Recovered) AS Total_Recovered_Cases,
    ROUND(AVG(Recovered), 3) AS Average_Recovered_Cases,
    ROUND(VARIANCE(Recovered), 3) AS Variance_Recovered_Cases,
    ROUND(STDDEV(Recovered), 3) AS Std_Dev_Recovered_Cases
FROM
    corona_data;

-- Country having highest number of the Confirmed case
-- SOLUTION 1 
WITH CountryConfirmed AS (
    SELECT `Country/Region` AS Country, SUM(Confirmed) AS TotalConfirmed
    FROM corona_data
    GROUP BY Country
)
SELECT Country
FROM CountryConfirmed
WHERE TotalConfirmed = (SELECT MAX(TotalConfirmed) FROM CountryConfirmed);
-- SOLUTION 2 
SELECT 
    `Country/Region` AS Country,
    SUM(Confirmed) AS Total_Confirmed_Cases
FROM
    corona_analysis.corona_data
GROUP BY Country
ORDER BY total_Confirmed_Cases DESC
LIMIT 1
;

-- Country having lowest number of the death case
-- SOLUTION 1
WITH CountryDeath AS (
    SELECT `Country/Region` AS Country, SUM(Deaths) AS TotalDeath
    FROM corona_data
    WHERE Deaths!=0 
    GROUP BY Country
)
SELECT Country
FROM CountryDeath
WHERE TotalDeath = (SELECT MIN(TotalDeath) FROM CountryDeath);

-- SOLUTION 2
SELECT 
    `Country/Region` AS Country,
    SUM(Deaths) AS Total_Death_Cases
FROM
    corona_analysis.corona_data
WHERE
    Deaths != 0
GROUP BY Country
ORDER BY total_Death_Cases
LIMIT 1
;

-- top 5 countries having highest recovered case
SELECT 
    `Country/Region` AS Country,
    SUM(Recovered) AS TotalRecoveredCase
FROM
    corona_analysis.corona_data
GROUP BY Country
ORDER BY TotalRecoveredCase DESC
LIMIT 5;