CREATE INDEX idx_date_of_response ON responses(date_of_response);
--индекс оптимизирует группировку по дате отклика и ускоряет доступ к датам отклика
CREATE INDEX idx_vacancy_id_date_of_publication ON responses(vacancy_id, date_of_response);
--индекс ускоряет inner join и where в 5 задании
CREATE INDEX idx_area_id ON vacancies(area_id);
--индекс ускоряет group by в 3 задании

