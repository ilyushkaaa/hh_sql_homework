

SELECT DATE_TRUNC('month', date_of_response) AS month_year,
       COUNT(*) AS num
FROM responses
GROUP BY DATE_TRUNC('month', date_of_response)
ORDER BY num DESC
LIMIT 1;
