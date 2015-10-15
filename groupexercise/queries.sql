--pre-test
SELECT name
FROM Events NATURAL JOIN Venues
WHERE venues.name = 'Friends Arena';

--Actual queries
--1. What is going on at Friends Arena on Sunday?
SELECT name
FROM Events NATURAL JOIN Schedules NATURAL JOIN Venues
WHERE Venues.name = 'Friends Arena' AND EXTRACT(DOW FROM Schedules.datetime) = 0;

--2. What teams are competing in the women’s slalom alpine ski race?
SELECT country
FROM NationalTeams, Sports
WHERE Sports.sportName = 'Slalom Alpine Ski' AND Sports.sex = 'F';

--3. Where and when are the finals in the bobsleigh race being run?


--4. Who are the goal keepers for Russian’s men’s ice hockey team
