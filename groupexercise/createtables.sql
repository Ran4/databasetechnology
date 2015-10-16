/*Save data on:
1. National teams (ie. countries),
2. Contestants (ie. people),
3. Sports (e.g. Cross-country skiing),
4. Events (e.g. Men’s 30 km ski),
5. Competitions (e.g. round 1, group 3),
6. Venues (e.g. Globen, ice rink), and
7. Schedules.
8. ..

Phase 1
1.  Make a list of all data (attributes) that seem to be needed without worrying
    about the best way of organizing it.
2.  Test this list on the above criteria to see if the information is sufficient
    to, in principle, answer the questions and to ensure the consistency.
3.  Repeat steps 1 and 2 until your list seems complete
*/

DROP TABLE IF EXISTS CompetesIn;
DROP TABLE IF EXISTS Contestants;
DROP TABLE IF EXISTS Schedules;
DROP TABLE IF EXISTS Venues;
DROP TABLE IF EXISTS Competitions;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS NationalTeams;
DROP TABLE IF EXISTS Sports;

CREATE TABLE Sports (
    sportName TEXT PRIMARY KEY --e.g. Cross-country skiing
);

CREATE TABLE NationalTeams (
    country CHAR(3), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    sportName TEXT REFERENCES Sports(sportName), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    sex CHAR(1) CHECK (sex IN ('M', 'F', 'N')), --M,F,N as in Male, Female, N/A
    PRIMARY KEY (country, sportName, sex)
);

CREATE TABLE Contestants (
    contestantName TEXT PRIMARY KEY,
    sex CHAR(1) CHECK (sex IN ('M', 'F', 'N')), --M,F,N as in Male, Female, N/A
    country CHAR(3),
    sportName TEXT REFERENCES Sports(sportName), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    FOREIGN KEY (country, sportName, sex) REFERENCES NationalTeams
    
    --todo: sportName shouldn't be PRIMARY KEY... somethingsomething
);

CREATE TABLE Events ( --e.g. Men’s 30 km ski
    eventID SERIAL PRIMARY KEY,
    sportName TEXT REFERENCES Sports(sportName), --30 km ski
    eventName TEXT,
    sex CHAR(1) CHECK (sex IN ('M', 'F', 'N')) --M,F,N as in Male, Female, N/A
);

CREATE TABLE Competitions ( -- e.g. round 1, group 3
    competitionID SERIAL PRIMARY KEY,
    eventID SERIAL REFERENCES Events(eventID),
    roundName TEXT,
    groupNumber INTEGER
);

CREATE TABLE CompetesIn (
    contestantName TEXT REFERENCES Contestants(contestantName),
    competitionID SERIAL REFERENCES Competitions(competitionID)
);

CREATE TABLE Venues ( -- e.g. Globen, ice rink
    arena TEXT,
    venueName TEXT,
    PRIMARY KEY (arena, venueName)
);

CREATE TABLE Schedules (
    datetime DATE,
    arena TEXT,
    venueName TEXT,
    competitionID SERIAL REFERENCES Competitions(competitionID),
    FOREIGN KEY (arena, venueName) REFERENCES Venues(arena, venueName)
);

\i triggers.sql

INSERT INTO Sports VALUES ('Slalom Alpine Ski');
INSERT INTO NationalTeams VALUES ('FIN', 'Slalom Alpine Ski', 'F');
INSERT INTO NationalTeams VALUES ('SWE', 'Slalom Alpine Ski', 'F');
INSERT INTO NationalTeams VALUES ('RUS', 'Slalom Alpine Ski', 'M');
INSERT INTO Contestants VALUES ('Anja Persson', 'F', 'SWE', 'Slalom Alpine Ski');
INSERT INTO Contestants VALUES ('Ajna Nossrep', 'F', 'SWE', 'Slalom Alpine Ski');
--INSERT INTO Contestants VALUES ('Anja Persson', 'F', 'ARG', 'Slalom Alpine Ski'); --Not possible, same name
INSERT INTO Contestants VALUES ('Tanja Poutiainen', 'F', 'FIN', 'Slalom Alpine Ski');
INSERT INTO Venues VALUES ('Friends Arena', 'Main Venue');
INSERT INTO Venues VALUES ('Friends Arena', 'Secondary Venue');
INSERT INTO Events VALUES (DEFAULT, 'Slalom Alpine Ski', 'One-skii', 'F'); --event 1. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 1, 'first competition', 7); --competitionID 1. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 1, 'semi-final', 7); --competitionID 2. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 1, 'final', 7); --competitionID 3. Maybe
INSERT INTO CompetesIn VALUES ('Anja Persson', 1);
INSERT INTO CompetesIn VALUES ('Anja Persson', 2);
INSERT INTO CompetesIn VALUES ('Tanja Poutiainen', 1);
INSERT INTO Schedules VALUES ('2015-10-25', 'Friends Arena', 'Main Venue', 1);
INSERT INTO Schedules VALUES ('2015-10-25', 'Friends Arena', 'Main Venue', 2);


INSERT INTO Sports VALUES ('Bobsleigh');
INSERT INTO NationalTeams VALUES ('SWE', 'Bobsleigh', 'N');
INSERT INTO NationalTeams VALUES ('CHK', 'Bobsleigh', 'N');
INSERT INTO Venues VALUES ('Lillehammer Olympic Bobsleigh and Luge Track', 'Bobsleigh Track Venue');
INSERT INTO Venues VALUES ('Hammarbybacken Bobsleigh Track', 'Bobsleigh Track Venue');
INSERT INTO Events VALUES (DEFAULT, 'Bobsleigh', 'Four-person', 'N'); --event 2. Maybe
INSERT INTO Events VALUES (DEFAULT, 'Bobsleigh', 'Two-man', 'M'); --event 3. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 2, 'final', 7); --competitionID 4. Maybe
INSERT INTO Schedules VALUES ('2015-10-25', 'Hammarbybacken Bobsleigh Track', 'Bobsleigh Track Venue', 4);


/*
Consistency:
1. Contestants must belong to one and only one team,
   Each Contestants name must be unique, so this requirement is more than enforced.

2. No two competitions can take place at the same venue at the same time (A venue is not the same as
arena as it includes competitions locations within the arena.),

3. That a contestant can not compete at the same time in different competitions.
*/
