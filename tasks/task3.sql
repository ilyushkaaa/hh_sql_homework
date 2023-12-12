SELECT
    area_id,
    AVG(compensation_from) AS avg_compensation_from
FROM vacancies
group by area_id;


SELECT
    area_id,
    AVG(compensation_to) AS avg_compensation_to
FROM vacancies
group by area_id;


SELECT
    area_id,
    AVG((compensation_to + compensation_from) / 2) AS compensation_diff
FROM vacancies
group by area_id;

