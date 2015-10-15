--pre-test
--SELECT name
--FROM Events NATURAL JOIN Venues
--WHERE venues.name = 'Friends Arena';

--Actual queries
--1. What is going on at Friends Arena on Sunday?
SELECT Events.sportName, Events.eventName, Competitions.roundNumber, Competitions.groupNumber
FROM Events, Competitions, Schedules
WHERE Competitions.competitionID IN (SELECT competitionID
                                     FROM Schedules WHERE (EXTRACT(DOW FROM Schedules.datetime) = 0))
        AND Competitions.eventID = Events.eventID
        AND Schedules.arena = 'Friends Arena';
        

--SELECT competitionID EXTRACT(DOW FROM Schedules.datetime) = 0;

--2. What teams are competing in the women’s slalom alpine ski race?
/*
SELECT *
FROM NationalTeams NATURAL JOIN Sports
WHERE Sports.sportName = 'Slalom Alpine Ski' AND Sports.sex = 'F';

--3. Where and when are the finals in the bobsleigh race being run?
--SELECT venueName, arena, datetime
--FROM Schedules
--WHERE Schedules.eventID IN (SELECT Events.eventID
    --FROM )
*/


--4. Who are the goal keepers for Russian’s men’s ice hockey team
