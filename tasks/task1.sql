CREATE TYPE gender AS ENUM ('мужской', 'женский');
CREATE TYPE education_level AS ENUM ('Среднее', 'Среднее специальное', 'Неполное высшее',
    'Высшее', 'Бакалавр', 'Магистр', 'Кандидат наук', 'Доктор наук');
CREATE TYPE work_experience AS ENUM ('отсутствует', 'меньше года', '1-3 года', '3-6 лет', 'больше 6 лет');
CREATE TYPE schedule_type AS ENUM ('Полный рабочий день', 'Неполный рабочий день', 'Дистанционно', 'Гибридный');


CREATE TABLE job_seekers
(
    id              serial primary key,
    name            varchar         not null,
    surname         varchar         not null,
    patronymic      varchar,
    gender          gender          not null,
    birthday        date            not null,
    area_id         varchar         not null,
    phone_number    varchar         not null,
    citizenship     varchar         not null,
    education_level education_level not null
);

CREATE TABLE specializations
(
    id   serial primary key,
    name varchar not null unique
);

CREATE TABLE companies
(
    id          serial primary key,
    name        varchar not null,
    website_url varchar

);

CREATE TABLE employers
(
    id         serial primary key,
    name       varchar not null,
    surname    varchar not null,
    patronymic varchar,
    company_id integer references companies (id)
);

CREATE TABLE resumes
(
    id                  serial primary key,
    title               varchar not null,
    job_seeker_id       integer not null references job_seekers (id),
    specialization_id   integer not null references specializations (id),
    date_of_publication date    not null,
    work_experience     work_experience,
    schedule_type       schedule_type

);

CREATE TABLE vacancies
(
    id                       serial primary key,
    title                    varchar         not null,
    specialization_id        integer         not null references specializations (id),
    employer_id              integer         not null references employers (id),
    compensation_from        integer         not null,
    compensation_to          integer         not null,
    is_before_tax_deduction  boolean         not null,
    required_experience      work_experience not null,
    description              text            not null,
    required_education_level education_level not null,
    schedule_type            schedule_type   not null,
    date_of_publication      date            not null,
    area_id                  varchar         not null,
    address                  varchar
);

CREATE TABLE responses
(
    id               serial primary key,
    vacancy_id       integer not null references vacancies (id),
    resume_id        integer not null references resumes (id),
    date_of_response date    not null
);