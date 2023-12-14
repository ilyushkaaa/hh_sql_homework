SELECT area_id,
       AVG(
               CASE
                   WHEN is_before_tax_deduction THEN compensation_from - compensation_from * 0.13
                   ELSE compensation_from
                   END
           ) AS avg_compensation_from
FROM vacancies
GROUP BY area_id;

SELECT area_id,
       AVG(
               CASE
                   WHEN is_before_tax_deduction THEN compensation_to - compensation_to * 0.13
                   ELSE compensation_to
                   END
           ) AS avg_compensation_to
FROM vacancies
GROUP BY area_id;


SELECT area_id,
       AVG((CASE
                WHEN is_before_tax_deduction THEN compensation_to - compensation_to * 0.13
                ELSE compensation_to
                END + CASE
                          WHEN is_before_tax_deduction THEN compensation_from - compensation_from * 0.13
                          ELSE compensation_from
                END) / 2) AS avg_compensation_to
FROM vacancies
GROUP BY area_id;

