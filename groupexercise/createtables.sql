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

DROP TABLE IF EXISTS Contestants;
DROP TABLE IF EXISTS Schedules;
DROP TABLE IF EXISTS Venues;
DROP TABLE IF EXISTS Competitions;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS NationalTeams;
DROP TABLE IF EXISTS Sports;

CREATE TABLE Sports (
    sportName TEXT PRIMARY KEY, --e.g. Cross-country skiing
    sex CHAR(1) CHECK (sex IN ('M', 'F', 'N')) --M,F,N as in Male, Female, N/A
);

CREATE TABLE NationalTeams (
    country CHAR(3), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    sportName TEXT REFERENCES Sports(sportName), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    PRIMARY KEY (country, sportName)
);

CREATE TABLE Contestants (
    contestantName TEXT,
    sex CHAR(1) CHECK (sex IN ('M', 'F', 'N')), --M,F,N as in Male, Female, N/A
    country CHAR(3),
    sportName TEXT REFERENCES Sports(sportName), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    FOREIGN KEY (country, sportName) REFERENCES NationalTeams
);

CREATE TABLE Events ( --e.g. Men’s 30 km ski
    eventID SERIAL PRIMARY KEY,
    sportName TEXT REFERENCES Sports(sportName), --30 km ski
    eventName TEXT
);

CREATE TABLE Competitions ( -- e.g. round 1, group 3
    competitionID SERIAL PRIMARY KEY,
    eventID SERIAL REFERENCES Events(eventID),
    roundNumber INTEGER,
    groupNumber INTEGER
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

--Insert stuff here

INSERT INTO Sports VALUES ('Slalom Alpine Ski', 'F');
INSERT INTO NationalTeams VALUES ('FIN', 'Slalom Alpine Ski');
INSERT INTO Venues VALUES ('Friends Arena', 'Main Venue');
INSERT INTO Venues VALUES ('Friends Arena', 'Secondary Venue');
INSERT INTO Events VALUES (DEFAULT, 'Slalom Alpine Ski', 'One-skii'); --event 1. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 1, 6, 7);
INSERT INTO Schedules VALUES ('2015-10-25', 'Friends Arena', 'Main Venue', 1);


INSERT INTO Sports VALUES ('Bobsleigh', 'N');
INSERT INTO NationalTeams VALUES ('SWE', 'Bobsleigh');
INSERT INTO Venues VALUES ('Lillehammer Olympic Bobsleigh and Luge Track', 'Bobsleigh Track Venue');
INSERT INTO Venues VALUES ('Hammarbybacken Bobsleigh Track', 'Bobsleigh Track Venue');
INSERT INTO Events VALUES (DEFAULT, 'Bobsleigh', 'Four-person'); --event 2. Maybe
INSERT INTO Events VALUES (DEFAULT, 'Bobsleigh', 'Two-man');
INSERT INTO Competitions VALUES (DEFAULT, 2, 6, 7);
INSERT INTO Schedules VALUES ('2015-10-25', 'Hammarbybacken Bobsleigh Track', 'Bobsleigh Track Venue', 1);
