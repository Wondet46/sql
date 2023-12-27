-- Selects the city with the shortest name and its length
-- Orders the result by the length of the city name in ascending order (shortest first)
-- If there are multiple cities with the same shortest length, orders them alphabetically
-- Limits the result to only one row (the top result)
SELECT city, LENGTH(city) AS city_length
FROM station
ORDER BY city_length ASC, city
LIMIT 1;

-- Selects the city with the longest name and its length
-- Orders the result by the length of the city name in descending order (longest first)
-- If there are multiple cities with the same longest length, orders them alphabetically
-- Limits the result to only one row (the top result)
SELECT city, LENGTH(city) AS city_length
FROM station
ORDER BY city_length DESC, city
LIMIT 1;

-- Selects distinct cities that start and end with a vowel
SELECT DISTINCT city
FROM station
WHERE LOWER(LEFT(city, 1)) IN ('a', 'e', 'i', 'o', 'u') AND
      LOWER(RIGHT(city, 1)) IN ('a', 'e', 'i', 'o', 'u');

-- Selects distinct cities that don't start or end with a vowel
SELECT DISTINCT city
FROM station
WHERE LOWER(LEFT(city, 1)) NOT IN ('a', 'e', 'i', 'o', 'u') OR
      LOWER(RIGHT(city, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');

-- Retrieves company information with counts of lead managers, senior managers, managers, and employees
SELECT 
    C.company_code,
    C.founder,
    COUNT(DISTINCT L.lead_manager_code) AS lead_manager_count,
    COUNT(DISTINCT S.senior_manager_code) AS senior_manager_count,
    COUNT(DISTINCT M.manager_code) AS manager_count,
    COUNT(DISTINCT E.employee_code) AS employee_count
FROM 
    Company C
LEFT JOIN 
    Lead_Manager L ON C.company_code = L.company_code
LEFT JOIN 
    Senior_Manager S ON L.lead_manager_code = S.lead_manager_code AND C.company_code = S.company_code
LEFT JOIN 
    Manager M ON S.senior_manager_code = M.senior_manager_code AND L.lead_manager_code = M.lead_manager_code AND C.company_code = M.company_code
LEFT JOIN 
    Employee E ON M.manager_code = E.manager_code AND S.senior_manager_code = E.senior_manager_code AND L.lead_manager_code = E.lead_manager_code AND C.company_code = E.company_code
GROUP BY 
    C.company_code, C.founder
ORDER BY 
    C.company_code;

SELECT DISTINCT 
    CITY.name
FROM 
    city
JOIN 
    country ON CITY.CountryCode = COUNTRY.Code
WHERE 
    COUNTRY.Continent = 'Africa';