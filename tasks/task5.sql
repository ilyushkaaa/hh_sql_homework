SELECT v.id,
       title
FROM vacancies v
         INNER JOIN responses r on v.id = r.vacancy_id
WHERE EXTRACT(day FROM (r.time_of_response - v.time_of_publication)) <= 7
GROUP BY v.id
HAVING COUNT(*) > 5

