CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);

 
CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255)
);


CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_professor VARCHAR(255)
);


CREATE TABLE ProjectMembers (
    project_id INT,
    employee_name VARCHAR(255),
    PRIMARY KEY (project_id, employee_name),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);


CREATE TABLE EquipmentRentals (
    client_id INT,
    equipment_id INT,
    rental_date DATE,
    PRIMARY KEY (client_id, equipment_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


