WITH test_data AS (SELECT 'company' || num AS name,
                          CASE
                              WHEN random() > 0.5 THEN 'https://company' || num || '.ru'
                              END          AS website_url
                   FROM generate_series(1, 2000) AS num)
INSERT
INTO companies (name,
                website_url)
SELECT name,
       website_url
FROM test_data;


WITH test_data AS (SELECT md5(random()::varchar) AS name,
                          md5(random()::varchar) AS surname,
                          CASE
                              WHEN random() > 0.2 THEN md5(random()::varchar)
                              END                AS patronymic,
                          CASE
                              WHEN random() > 0.2 THEN floor(random() * 2000) + 1
                              END                AS company_id
                   FROM generate_series(1, 7000))
INSERT
INTO employers(name,
               surname,
               patronymic,
               company_id)
SELECT name,
       surname,
       patronymic,
       company_id
FROM test_data;



WITH test_data AS (SELECT generate_series(1, 100000),
                          md5(random()::varchar)   AS name,
                          md5(random()::varchar)   AS surname,
                          CASE
                              WHEN random() > 0.2 THEN md5(random()::varchar)
                              END                  AS patronymic,
                          (SELECT current_gender
                           FROM unnest(enum_range(NULL::gender)) current_gender
                           ORDER BY random()
                           LIMIT 1)                AS gender,
                          CAST(random() * ('2006-01-01'::DATE - '1970-01-01'::DATE) AS INTEGER) +
                          '1970-01-01'::DATE       AS birthday,
                          floor(random() * 89) + 1 AS area_id,
                          CONCAT(
                                  '+7',
                                  floor(random() * 900) + 100,
                                  floor(random() * 9000000) +
                                  1000000
                              )                    AS phone_number,
                          md5(random()::varchar)   AS citizenship,
                          (SELECT current_edu
                           FROM unnest(enum_range(NULL::education_level)) current_edu
                           ORDER BY random()
                           LIMIT 1)                AS education_level)
INSERT
INTO job_seekers(name,
                 surname,
                 patronymic,
                 gender,
                 birthday,
                 area_id,
                 phone_number,
                 citizenship,
                 education_level)
SELECT name,
       surname,
       patronymic,
       gender,
       birthday,
       area_id,
       phone_number,
       citizenship,
       education_level
FROM test_data;


WITH test_data AS (SELECT 'Specialization' || num AS name
                   FROM generate_series(1, 200) as num)
INSERT
INTO specializations(name)
SELECT name
FROM test_data;


WITH test_data AS (SELECT md5(random()::varchar)    AS title,
                          num                       AS job_seeker_id,
                          floor(random() * 200) + 2 AS specialization_id,
                          CAST(random() * ('2023-11-30'::DATE - '2015-01-01'::DATE) AS INTEGER) +
                          '2015-01-01'::DATE        AS date_of_publication,
                          (SELECT current_exp
                           FROM unnest(enum_range(NULL::work_experience)) current_exp
                           ORDER BY random()
                           LIMIT 1)                 AS work_experience,
                          (SELECT current_sch
                           FROM unnest(enum_range(NULL::schedule_type)) current_sch
                           ORDER BY random()
                           LIMIT 1)                 AS schedule_type
                   FROM generate_series(1, 100000) as num)
INSERT
INTO resumes (title,
              job_seeker_id,
              specialization_id,
              date_of_publication,
              work_experience,
              schedule_type)
SELECT title,
       job_seeker_id,
       specialization_id,
       date_of_publication,
       work_experience,
       schedule_type
FROM test_data;

WITH test_data AS (SELECT md5(random()::varchar)              AS title,
                          floor(random() * 200) + 2           AS specialization_id,
                          floor(random() * 7000) + 1          AS employer_id,
                          round((random() * 200000)::int, -3) as salary,
                          random() > 0.5                      AS is_before_tax_deduction,
                          (SELECT current_exp
                           FROM unnest(enum_range(NULL::work_experience)) current_exp
                           ORDER BY random()
                           LIMIT 1)                           AS required_experience,
                          md5(random()::text || random()::text
                                  || random()::text || random()::text
                              || random()::text)              AS description,
                          (SELECT current_edu
                           FROM unnest(enum_range(NULL::education_level)) current_edu
                           ORDER BY random()
                           LIMIT 1)                           AS required_education_level,
                          (SELECT current_sch
                           FROM unnest(enum_range(NULL::schedule_type)) current_sch
                           ORDER BY random()
                           LIMIT 1)                           AS schedule_type,
                          CAST(random() * ('2023-11-30'::DATE - '2015-01-01'::DATE) AS INTEGER) +
                          '2015-01-01'::DATE                  AS date_of_publication,
                          floor(random() * 89) + 1            AS area_id,
                          CASE
                              WHEN random() > 0.5 THEN md5(random()::varchar)
                              END                             AS address
                   FROM generate_series(1, 10000))
INSERT
INTO vacancies (title,
                specialization_id,
                employer_id,
                compensation_from,
                compensation_to,
                is_before_tax_deduction,
                required_experience,
                description,
                required_education_level,
                schedule_type,
                date_of_publication,
                area_id,
                address)
SELECT title,
       specialization_id,
       employer_id,
       salary,
       salary + 20000,
       is_before_tax_deduction,
       required_experience,
       description,
       required_education_level,
       schedule_type,
       date_of_publication,
       area_id,
       address
FROM test_data;


INSERT INTO responses(vacancy_id, resume_id, date_of_response)
SELECT v.id                                                         AS vacancy_id,
       r.id                                                         AS resume_id,
       CAST(random() * ('2006-02-01'::DATE - '2006-01-01'::DATE) AS INTEGER) +
       greatest(v.date_of_publication, r.date_of_publication)::DATE AS date_of_response

FROM vacancies v
         INNER JOIN resumes r ON v.specialization_id = r.specialization_id
WHERE random() > 0.8
