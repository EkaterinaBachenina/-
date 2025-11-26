CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY, -- [translate:Уникальный идентификатор студента]
    full_name VARCHAR(255) NOT NULL, -- [translate:Полное имя студента]
    email VARCHAR(255) UNIQUE NOT NULL, -- [translate:Электронная почта студента (должна быть уникальной)]
    start_year INT -- [translate:Год поступления студента]
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY, -- [translate:Уникальный идентификатор курса]
    course_name VARCHAR(255) NOT NULL, -- [translate:Название курса]
    credits INT CHECK (credits > 0) -- [translate:Количество зачетных единиц курса (должно быть больше 0)]
);

CREATE TABLE Enrollments (
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE, -- [translate:Ссылка на ID студента (внешний ключ)]
    course_id INT REFERENCES Courses(course_id) ON DELETE CASCADE, -- [translate:Ссылка на ID курса (внешний ключ)]
    grade CHAR(1), -- [translate:Оценка студента за курс (например, 'A', 'B', 'C')]
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO Students (full_name, email, start_year) VALUES 
('Алексей Смирнов', 'aleksey.smirnov@example.com', 2021),
('Елена Кузнецова', 'elena.kuznetsova@example.com', 2022),
('Дмитрий Новиков', 'dmitriy.novikov@example.com', 2021),
('Ольга Морозова', 'olga.morozova@example.com', 2023);

INSERT INTO Courses (course_name, credits) VALUES
('Введение в программирование', 5),
('Базы данных', 4),
('Веб-технологии', 4);


INSERT INTO Enrollments (student_id, course_id, grade)
SELECT s.student_id, c.course_id, 'A' FROM Students s, Courses c
WHERE s.full_name = 'Алексей Смирнов' AND c.course_name = 'Базы данных';

INSERT INTO Enrollments (student_id, course_id, grade)
SELECT s.student_id, c.course_id, 'B'
FROM Students s, Courses c
WHERE s.full_name = 'Елена Кузнецова' AND c.course_name = 'Базы данных';

INSERT INTO Enrollments (student_id, course_id, grade)
SELECT s.student_id, c.course_id, 'A'
FROM Students s, Courses c
WHERE s.full_name = 'Елена Кузнецова' AND c.course_name = 'Веб-технологии';


INSERT INTO Enrollments (student_id, course_id)
SELECT s.student_id, c.course_id FROM Students s, Courses c
WHERE s.full_name = 'Дмитрий Новиков';

UPDATE Students SET email = 'elena.kuznetsova@newmail.com'
WHERE full_name = 'Елена Кузнецова';

UPDATE Enrollments SET grade = 'A'
WHERE student_id = (SELECT student_id FROM Students WHERE full_name = 'Дмитрий Новиков')
AND course_id = (SELECT course_id FROM Courses WHERE course_name = 'Введение в программирование');

DELETE FROM Students WHERE full_name = 'Ольга Морозова';