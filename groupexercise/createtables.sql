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

/*CREATE TABLE NationalTeams (
    country, --of type https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    nationalTeamID PRIMARY KEY
);

CREATE TABLE Contestants (
    nationalTeamID,
    contestantName,
    sex,
);*/

CREATE TABLE Sports (
    sportName TEXT PRIMARY KEY, --e.g. Cross-country skiing
);

CREATE TABLE Events ( --e.g. Men’s 30 km ski
    eventID SERIAL PRIMARY KEY,
    sportName TEXT REFERENCES Sports.sportName, --30 km ski
    sex CHAR(1), --M,F,N
    competitionID REFERENCES Competitions.competitionID,
);

CREATE TABLE Competitions ( -- e.g. round 1, group 3
    eventID SERIAL,
    competitionID PRIMARY KEY,
    round,
    group_,
    arenaID,
);

CREATE TABLE Venues ( -- e.g. Globen, ice rink
    venueName,
    arena, --can be in multiple venues but not multiple arenas at the same time
);
/*
CREATE TABLE Schedules (
    datetime,
    venueName,
    sport,
    event REFERENCES Events.eventID -- relation to event
);*/


--Insert stuff here
INSERT INTO Sports VALUES ('30 km ski');

INSERT INTO Events VALUES ('30 km ski', 'M', compid);
SELECT * FROM Events;
