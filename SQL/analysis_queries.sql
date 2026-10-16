
USE cybersecurity_incident_db;

-- 1. Total cybersecurity incidents
SELECT COUNT(*) AS total_incidents
FROM eurepoc_incidents_clean;

-- 2. Incidents by year
SELECT
    YEAR(STR_TO_DATE(start_date, '%d.%m.%Y')) AS incident_year,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
WHERE STR_TO_DATE(start_date, '%d.%m.%Y') IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(start_date, '%d.%m.%Y'))
ORDER BY incident_year;

-- 3. Most frequently recorded incident types
SELECT
    incident_type,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
WHERE incident_type IS NOT NULL
  AND TRIM(incident_type) <> ''
GROUP BY incident_type
ORDER BY incident_count DESC
LIMIT 10;

-- 4. Incidents by initiator category
SELECT
    initiator_category,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
WHERE initiator_category IS NOT NULL
  AND TRIM(initiator_category) <> ''
GROUP BY initiator_category
ORDER BY incident_count DESC
LIMIT 10;

-- 5. Incidents by receiver country
SELECT
    receiver_country_clean,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
GROUP BY receiver_country_clean
ORDER BY incident_count DESC
LIMIT 10;

-- 6. Distribution of weighted intensity
SELECT
    weighted_intensity,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
WHERE weighted_intensity IS NOT NULL
GROUP BY weighted_intensity
ORDER BY weighted_intensity;

-- 7. Available economic impact values
SELECT
    economic_impact,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
WHERE economic_impact IS NOT NULL
  AND TRIM(economic_impact) <> ''
  AND LOWER(TRIM(economic_impact)) <> 'not available'
GROUP BY economic_impact
ORDER BY incident_count DESC;
