SELECT v.id ,
       title
FROM vacancies v
         INNER JOIN responses r on v.id = r.vacancy_id
WHERE r.date_of_response - v.date_of_publication < 8
GROUP BY v.id
HAVING COUNT(*) > 5


