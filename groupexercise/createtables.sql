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
    country CHAR(3) NOT NULL,
    sportName TEXT REFERENCES Sports(sportName), --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    position TEXT,
    FOREIGN KEY (country, sportName, sex) REFERENCES NationalTeams
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
\i insertions.sql
