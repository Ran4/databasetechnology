--pre-test
SELECT name
FROM Events NATURAL JOIN Venues
WHERE venues.arena = "Friends Arena"

--Actual queries
--1. What is going on at Friends Arena on Sunday?
SELECT name
FROM Events NATURAL JOIN Schedules NATURAL JOIN Venues
WHERE venues.arena = "Friends Arena" AND schedules.datetime = SUNDAY

--2. What teams are competing in the women’s slalom alpine ski race?
/*
SELECT nationalTeamID
FROM NationalTeams NATURAL JOIN Sports
WHERE Sports.sportName = "slalom alpine ski race" AND Sport.sex = "F"
*/

--3. Where and when are the finals in the bobsleigh race being run?
--4. Who are the goal keepers for Russian’s men’s ice hockey team
