--pre-test
--SELECT name
--FROM Events NATURAL JOIN Venues
--WHERE venues.name = 'Friends Arena';

--Actual queries
--1. What is going on at Friends Arena on Sunday?
SELECT Events.sportName, Events.eventName, Competitions.roundName, Competitions.groupNumber
FROM Events, Competitions, Schedules
WHERE Competitions.competitionID IN (SELECT competitionID
                                     FROM Schedules WHERE (EXTRACT(DOW FROM Schedules.datetime) = 0))
        AND Competitions.eventID = Events.eventID
        AND Schedules.arena = 'Friends Arena';
        
--2. What teams are competing in the women’s slalom alpine ski race?
SELECT nationalTeams.country
    FROM CompetesIn NATURAL JOIN Competitions NATURAL JOIN Contestants NATURAL JOIN Events NATURAL JOIN nationalTeams
    WHERE Events.sportName = 'Slalom Alpine Ski' AND Events.sex = 'F';

--3. Where and when are the finals in the bobsleigh race being run?
SELECT datetime, arena, venueName
FROM Schedules NATURAL JOIN Events NATURAL JOIN Competitions
WHERE Events.sportName = 'Bobsleigh' AND Competitions.roundName = 'final'


--4. Who are the goal keepers for Russian’s men’s ice hockey team
