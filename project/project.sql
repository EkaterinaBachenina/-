

CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    birthdate DATE,
    Email VARCHAR(100) UNIQUE,
    phonenumber VARCHAR(20),
    createdat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Idsubscription_plan INTEGER) ;


CREATE TABLE Tariffs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    billingperiod VARCHAR(20),
    price DECIMAL(10,2),
    maxdevices INTEGER,
    description TEXT
);

-- SubscriptionPlan
CREATE TABLE SubscriptionPlan (
    id SERIAL PRIMARY KEY,
    idtariffs INTEGER REFERENCES Tariffs(id),
    startdate DATE,
    enddate DATE,
    autorenew BOOLEAN DEFAULT TRUE,
    status VARCHAR(20) DEFAULT 'active'
);

-- Playlists
CREATE TABLE Playlists (
    id SERIAL PRIMARY KEY,
    userid INTEGER REFERENCES Users(id),
    name VARCHAR(100) NOT NULL
);

-- Tracks
CREATE TABLE Tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    releasedate DATE,
    duration INTEGER, 
    idalbum INTEGER,
    idgenres INTEGER REFERENCES Genres(id),
    idautours  INTEGER 
);

-- Genres
CREATE TABLE Genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Authors (Авторы/Музыканты)
CREATE TABLE Authors (
    id SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    birthdate DATE,
    country VARCHAR(50),
    stagename VARCHAR(100),
    yearsactive VARCHAR(20));

-- Album
CREATE TABLE Album (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    releasedate DATE
);

-- AuthorsTracks (связующая)
CREATE TABLE AuthorsTracks (
    autorid INTEGER REFERENCES Authors(id),
    trackid INTEGER REFERENCES Tracks(id),
    PRIMARY KEY (autorid, trackid)
);

-- PlaylistsTracks (связующая)
CREATE TABLE PlaylistsTracks (
    playlistid INTEGER REFERENCES Playlists(id),
    trackid INTEGER REFERENCES Tracks(id),
    PRIMARY KEY (playlistid, trackid)
);


INSERT INTO Tariffs (name, billingperiod, price, maxdevices, description) VALUES
('Базовый', 'monthly', 169.00, 1, 'Без рекламы, 1 устройство'),
('Премиум', 'monthly', 299.00, 4, 'Полный доступ, оффлайн, HiFi'),
('Семья', 'monthly', 499.00, 6, 'Для всей семьи до 6 аккаунтов'); 

INSERT INTO Genres (name) VALUES
('Hip-hop'), ('R&B'), ('Trap'), ('Rap'), ('Grime'), ('Jazz-rap'); 

INSERT INTO Authors (Name, birthdate, country, stagename, yearsactive) VALUES
('Lancey Omal', '1995-11-30', 'London', 'Lancey Foux', '2015'),
('Jordan Terrell Carter', '1995-09-13', 'USA', 'Playboi Carti', '2011'),
('Joseph Junior Adenuga', '1982-09-19', 'London', 'Skepta',  '2002'),
('Caled Zackery Toliver', '1994-06-12', 'USA', 'Don Toliver', '2017'),
('Chase Shaun Mitchell', '2006-08-29', 'USA', 'Cheromani', '2020'),
('Jordan Timothy Jenks', '1993-09-19', 'USA', 'Pierre Bourne', '2017'),
('Tyler-Justin Anthony Sharpe', '2002-09-26', 'USA', 'Lil Tecca', '2017'),
('Kendrick Lamar Duckworth', '1987-06-17', 'USA', 'Kendrick Lamar', '2003'),
('Tyler Gregory Okonma', '1991-03-06', 'USA', 'Tyler, the Creator', '2007'),
('Tyreek Solomon Pellerin', '2003-12-02', 'USA', 'SSGkobe', '2018');

INSERT INTO Album (title, releasedate) VALUES
('FRIEND OR FOUX', '2019-12-06'),
('Die Lit', '2018-05-11'),
('Vicious EP', '2017-10-31'),
('Life of a Don', '2021-10-08'),
('Sayso Says', '2024-08-30'),
('The Life of Pierre 4', '2019-06-21'),
('Plan A', '2024-09-20'),
('DAMN.', '2017-04-14'),
('Igor', '2019-05-17'),
('0.5 NPLH', '2024-12-02');

INSERT INTO Users (Name, birthdate, Email, phonenumber, Idsubscription_plan) VALUES
('Иван Иванов', '1995-03-15', 'ivan@test.ru', '+7-900-123-45-67', 1),
('Мария Петрова', '1998-07-22', 'maria@test.ru', '+7-900-234-56-78', 2),
('Алексей Сидоров', '1990-11-10', 'alex@test.ru', '+7-900-345-67-89', 2),
('Елена Козлова', '2000-01-05', 'elena@test.ru', '+7-900-456-78-90', 3),
('Дмитрий Морозов', '1985-09-30', 'dmitry@test.ru', '+7-900-567-89-01', 1),
('Светлана Цветова', '2002-12-04', 'svet@test.ru', '+7-900-472-65-01',2),
( 'Алексей Смирнов', '1998-04-01', 'alex.smirnov@example.com', '+7-940-574-90-78', 1),
( 'Елена Васильева','1995-07-12','elena.v@example.com','+7-457-356-97-85',2),
( 'Андрей Николаев','1995-08-24',  'andrey.n@example.com', '+7-956-635-20-61', 3);

INSERT INTO SubscriptionPlan (idtariffs, startdate, enddate, status) VALUES
(2, '2025-12-01', '2026-01-01', 'active'), 
(1, '2025-11-15', '2026-02-15', 'active'), 
(3, '2025-10-01', '2026-01-01', 'active'), 
(2, '2025-12-10', '2026-01-10', 'active'),
(1, '2025-11-20', '2026-12-20', 'active'),
(2, '2025-12-01', '2026-01-01', 'active'), 
(1, '2025-11-15', '2026-02-15', 'active'), 
(3, '2025-10-01', '2026-01-01', 'active'), 
(2, '2025-12-10', '2026-01-10', 'active');

INSERT INTO Tracks (title, releasedate, duration, idalbum, idgenres) VALUES
('NOKIA', '2019-12-06', 162, 1, 1),      
('R.I.P.', '2018-05-11', 199, 2, 1),       
('Hypocrisy', '2017-10-31', 215, 3, 2),   
('HUMBLE.', '2017-04-14', 335, 8, 4),     
('EARFQUAKE', '2019-05-17', 199, 9, 5);

INSERT INTO Playlists (userid, name) VALUES
(1, 'Trap Hits 2024'),       
(2, 'UK Bangers'),      
(1, 'Experimental Vibes');

INSERT INTO AuthorsTracks (autorid, trackid) VALUES
(1, 1),  
(2, 2),  
(3, 3), 
(8, 4),  
(9, 5);  

INSERT INTO PlaylistsTracks (playlistid, trackid) VALUES
(1, 1), 
(1, 2),    
(2, 3),             
(3, 4);           

SELECT 
    a.Name as author_name,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'title', t.title,
            'duration', t.duration,
            'releasedate', t.releasedate
        )
    ) as tracks
FROM Authors a
LEFT JOIN AuthorsTracks at ON a.id = at.autorid
LEFT JOIN Tracks t ON at.trackid = t.id
WHERE a.id = 1
GROUP BY a.id, a.Name;

SELECT Name, birthdate, Email
FROM Users
WHERE EXTRACT( MONTH FROM birthdate) = '12';

SELECT u.Name as user_name, u.birthdate as user_birthdate,
a.Name as author_name, a.birthdate as author_birthdate
FROM Users u
JOIN authors a ON u.birthdate = a.birthdate;
