
USE cybersecurity_incident_db;
CREATE OR REPLACE VIEW eurepoc_incidents_clean AS
SELECT*,
    CASE
        WHEN receiver_country IS NULL
          OR TRIM(receiver_country) = ''
          OR LOWER(TRIM(receiver_country)) = 'not available'
        THEN 'Unknown'
        ELSE TRIM(receiver_country)
    END AS receiver_country_clean
FROM eurepoc_incidents_raw;

-- Verify the cleaned view
SELECT COUNT(*) AS total_records
FROM eurepoc_incidents_clean;

-- Review the cleaned receiver country values
SELECT
    receiver_country_clean,
    COUNT(*) AS incident_count
FROM eurepoc_incidents_clean
GROUP BY receiver_country_clean
ORDER BY incident_count DESC;
