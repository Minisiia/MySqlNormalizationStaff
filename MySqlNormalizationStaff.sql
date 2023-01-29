/*
Спроектировать базу данных для вымышленной системы отдела кадров, провести нормализацию всех таблиц.
В таблице departments проиведено раделение по столбцам ФИО начальников отделов
Таблица serviceInformation разделена на staff, education и staffContactInformation
Таблица personalInformation переименована в staffContactInformation, столбец city объединился с adress
*/

DROP DATABASE HumanResourcesDepartment;
CREATE DATABASE HumanResourcesDepartment;
USE HumanResourcesDepartment;

CREATE TABLE departments(
	id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50),
    head_lname VARCHAR(20),
    head_fname VARCHAR(20),
    head_patronymic VARCHAR(20),
    phone VARCHAR(15),
    PRIMARY KEY(id)
    );
INSERT INTO departments
(name,  head_lname , head_fname, head_patronymic, phone)
VALUES ('Продажа','Полякова', 'Анна', 'Семеновна','12-68-12'),
('Охрана','Петров', ' Антон', 'Сергеевич','45-45-89'),
('Транспортный','Иванов', 'Петр', 'Михайлович','89083457896'),
('Грузчики','Сидоров', 'Михаил', 'Васильевич',null),
('Техническое обслуживание','Королев', 'Александр', 'Александрович','87-95-37');
    
CREATE TABLE positions (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50),
    PRIMARY KEY (id)
);

INSERT INTO positions
(name)
VALUES ('Директор'),('Охранник'),('Шофер'),('Грузчик'),('Продавец'),('Электрик');

CREATE TABLE education(
	id INT AUTO_INCREMENT NOT NULL,
	type_education VARCHAR(50),
	PRIMARY KEY(id)
);

INSERT INTO education
(type_education)
VALUES ('Среднее'),('Средне специальное'),('Среднее (неполное)'),('Высшее');

CREATE TABLE staff(
	id int auto_increment not null,
	last_name  VARCHAR(20),
    first_name VARCHAR(20),
    patronymic VARCHAR(20),
    department_id INT,
    position_id INT,
    contacts_id INT,
    education_id INT,
    date_of_hiring DATE,
    date_of_dismissal DATE,
    FOREIGN KEY(department_id) REFERENCES departments(id),
    FOREIGN KEY(position_id) REFERENCES positions(id),
    FOREIGN KEY(education_id) REFERENCES education(id),
    PRIMARY KEY(id)    
    );
    
INSERT INTO staff
(last_name, first_name , patronymic, department_id , position_id , contacts_id, education_id, date_of_hiring, date_of_dismissal)
VALUES ('Старков', 'Андрей', 'Владимирович', 1, 1, 1, 4, '2020-02-02',null),
('Иванов', 'Петр', 'Михайлович', 3, 3, 2, 2, '2010-10-02',null),
('Сидоров', 'Михаил', 'Васильевич', 2, 2, 3, 1, '2020-02-02',null),
('Полякова', 'Анна', 'Семеновна', 1, 5, 4, 2, '2000-02-10',null),
('Воробьева', 'Ольга', 'Андреевна', 1, 5, 5, 2, '2020-02-02',null),
('Петров', 'Антон', 'Сергеевич', 2, 2, 6, 1, '2020-02-02',null),
('Абрамов', 'Сергей', 'Абрамович', 4, 4, 7, 3, '200-01-02',null),
('Королев', 'Александр', 'Александрович', 5, 6, 8, 2, '2020-02-02',null);


CREATE TABLE staffContactInformation(
	id int auto_increment PRIMARY KEY NOT NULL,
	person_id INT,
	phone VARCHAR(15),
	email VARCHAR(50),
	FOREIGN KEY(person_id) REFERENCES staff(id)
);

INSERT INTO staffContactInformation
(person_id, phone,email)
VALUES (1,'+380952020121','mi_lkj@gmail.com'),
(2,'+380952010121','dsdfj@gmail.com'),
(3,'+380441220121','slfkj@gmail.com'),
(4,'+380506666021','sdfa@gmail.com'),
(5,'+380952020521','333@gmail.com'),
(6,'+380952156152','55ssss@gmail.com'),
(7,'+380952154442','55444ss@gmail.com'),
(8,'+380500066005','2fffff@gmail.com');

ALTER TABLE staff 
ADD CONSTRAINT FK_staff_staffContactInformation FOREIGN KEY (contacts_id) REFERENCES staffContactInformation(id);

CREATE TABLE personalInformation(
	id INT AUTO_INCREMENT NOT NULL,
	birth_date DATE,
    passport VARCHAR(50),
    inn VARCHAR(50),
    adress VARCHAR(100),
    maritalstatus VARCHAR(10),
    children INT, 
    staff_id INT,
    FOREIGN KEY(staff_id) REFERENCES staff(id),
    PRIMARY KEY(id)    
    );
    
INSERT INTO personalInformation
(birth_date, passport, inn, adress, maritalstatus, children, staff_id)
VALUES('1987-12-12','ИИ 654358', '1235466431256', 'Харьков, ул. Шевченко, 34, кв. 32', 'женат', 2, 1),
('1990-11-10','ММ 654358', '54647547546', 'Киев, ул. Свободы, 265, кв. 87', 'женат', 1, 2),
('1991-12-12','КА 5464564', '356756376565', 'Одесса, ул. Метрополита, 55, кв. 32', 'не женат', 0, 3),
('2000-07-12','ИП 332342', '356766735', 'Житомир, ул. Духновича, 4, кв. 32', 'замужем', 0, 4),
('1999-08-05','КП 3453453', '35675367575', 'Лозовая, ул. Мира, 546, кв. 234', 'не замужем', 0, 5),
('2000-09-22','ИВ 34345346', '35775637656', 'Красноград, ул. Счастья, 4, кв. 32', 'женат', 2, 6),
('2001-10-08','ИВ 345354', '356767537', 'Киев, ул. Радости, 34, кв. 234', 'не женат', 0, 7),
('1997-12-11','РВ 5675675', '3567375676', 'Киев, ул. Научная, 2, кв. 342', 'женат', 1, 8);
    
-- Проверка каждой таблицы
SELECT * FROM personalInformation;
SELECT * FROM staff;
SELECT * FROM staffContactInformation;
SELECT * FROM education;
SELECT * FROM positions;
SELECT * FROM departments;

-- Проверка связей таблицы. Вывести по одному столбцу с каждой таблицы: фамилия, email, должность, отдел, образование, количество детей
SELECT 
    staff.last_name AS last_name,
    staffContactInformation.email AS email,
    positions.name AS position,
    departments.name AS department,
    education.type_education AS education,
    personalInformation.children AS children
FROM staff
LEFT JOIN personalInformation
ON staff.id = personalInformation.staff_id
LEFT JOIN positions 
ON staff.position_id = positions.id
LEFT JOIN departments 
ON staff.department_id = departments.id
LEFT JOIN staffContactInformation
ON staff.contacts_id = staffContactInformation.id
LEFT JOIN education
ON staff.education_id = education.id
ORDER BY staff.last_name;
        
        


    