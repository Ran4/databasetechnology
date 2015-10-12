-- 7.1.1 abc
-- Declare teh following referential integrity constraints for the movie database
--a) The producer of a movie must be someone mentioned in MovieExec. Modifications
--   to MovieExec that violate this constraint are rejected
--???b) repeat (a) but violations result in the producerC# in Movie being set to NULL
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS MovieExec;
CREATE TABLE MovieExec (
    name VARCHAR(255),
    address VARCHAR(255),
    cert INTEGER PRIMARY KEY,
    netWorth INTEGER
);

CREATE TABLE Movies (
    title VARCHAR(255),
    year INTEGER,
    length INTEGER,
    genre VARCHAR(255),
    studioName VARCHAR(255),
    producerC INTEGER REFERENCES MovieExec(cert),
    PRIMARY KEY (title, year)
);

INSERT INTO MovieExec VALUES ('Arnold', 'adr', 34, 40000);

INSERT INTO Movies VALUES ('Gone with the wind', '1933', 98, 'sci-fi', 'wind studios', 34);
INSERT INTO Movies VALUES ('Gone against the wind', '1931', 3, 'action', 'ground studios', 35); --This violates FKC
