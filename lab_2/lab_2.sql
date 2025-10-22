CREATE TABLE Hall (
    hall_id SERIAL PRIMARY KEY,
    hall_name VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO Hall (hall_name) VALUES
('Зал 1'),
('Зал 2'),
('VIP Зал');

CREATE TABLE Movie (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    budget NUMERIC(15,2),
    description TEXT,
    release_date DATE,
    box_office NUMERIC(15,2),
    duration INT,
    tagline VARCHAR(255),
    average_rating REAL
);

INSERT INTO Movie (title, budget, description, release_date, box_office, duration, tagline, average_rating) VALUES
('Inception', 160000000, 'Sci-fi thriller by Christopher Nolan', '2010-07-16', 830000000, 148, 'Your mind is the scene of the crime', 8.8),
('Interstellar', 165000000, 'Epic space adventure about love and time', '2014-11-07', 700000000, 169, 'Mankind was born on Earth. It was never meant to die here.', 8.6),
('The Dark Knight', 185000000, 'Batman faces Joker in Gotham', '2008-07-18', 1000000000, 152, 'Why so serious?', 9.0);

CREATE TABLE Genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO Genres (genre_name) VALUES
('Action'),
('Science Fiction'),
('Drama');

CREATE TABLE Movies_Genres (
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id) ON DELETE CASCADE
);

INSERT INTO Movies_Genres (movie_id, genre_id) VALUES
(1, 2),
(2, 2),
(3, 1);

CREATE TABLE Showings (
    showing_id SERIAL PRIMARY KEY,
    show_time TIMESTAMP NOT NULL,
    price NUMERIC(8,2) NOT NULL
);

INSERT INTO Showings (show_time, price) VALUES
('2025-10-21 18:00', 150.00),
('2025-10-21 20:00', 200.00),
('2025-10-22 16:00', 120.00);

CREATE TABLE Schedule (
    schedule_id SERIAL PRIMARY KEY,
    hall_id INT NOT NULL,
    showing_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (hall_id) REFERENCES Hall(hall_id) ON DELETE CASCADE,
    FOREIGN KEY (showing_id) REFERENCES Showings(showing_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE
);

INSERT INTO Schedule (hall_id, showing_id, movie_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

CREATE TABLE Clients (
    client_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL
);

INSERT INTO Clients (last_name, first_name) VALUES
('Іваненко', 'Олег'),
('Петренко', 'Марія'),
('Коваль', 'Андрій');

CREATE TABLE Tickets (
    ticket_id SERIAL PRIMARY KEY,
    show_date TIMESTAMP NOT NULL,
    schedule_id INT NOT NULL,
    client_id INT NOT NULL,
    seat VARCHAR(10) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES Schedule(schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE
);

INSERT INTO Tickets (show_date, schedule_id, client_id, seat) VALUES
('2025-10-21 18:00', 1, 1, 'A5'),
('2025-10-21 20:00', 2, 2, 'B3'),
('2025-10-22 16:00', 3, 3, 'C7');