--pre-test
--SELECT name
--FROM Events NATURAL JOIN Venues
--WHERE venues.name = 'Friends Arena';

--Actual queries
--1. What is going on at Friends Arena on Sunday?
SELECT Events.sportName, Events.eventName, Competitions.roundName, Competitions.groupNumber
FROM Events NATURAL JOIN Competitions NATURAL JOIN Schedules
WHERE Competitions.competitionID IN (SELECT competitionID
                                     FROM Schedules WHERE (EXTRACT(DOW FROM Schedules.datetime) = 0))
        --AND Competitions.eventID = Events.eventID
        AND Schedules.arena = 'Friends Arena';
        
--2. What teams are competing in the women’s slalom alpine ski race?
SELECT nationalTeams.country, nationalTeams.sportName, nationalTeams.sex
    FROM CompetesIn NATURAL JOIN Competitions NATURAL JOIN Contestants NATURAL JOIN Events NATURAL JOIN nationalTeams
    WHERE Events.sportName = 'Slalom Alpine Ski' AND Events.sex = 'F';

--3. Where and when are the finals in the bobsleigh race being run?
SELECT datetime, arena, venueName
FROM Schedules NATURAL JOIN Events NATURAL JOIN Competitions
WHERE Events.sportName = 'Bobsleigh' AND Competitions.roundName = 'final';

--4. Who are the goal keepers for Russian’s men’s ice hockey team
SELECT contestantName
FROM Contestants
WHERE country = 'RUS' AND position = 'Goalie' AND sportName = 'Ice Hockey' AND sex = 'M';

--5. (own query) When, where (if scheduled) and in what is Anja Persson scheduled to compete?
SELECT contestantName, sportName, roundName, datetime, venueName, arena
--FROM Contestants NATURAL JOIN Schedules NATURAL JOIN Competitions NATURAL JOIN CompetesIn
FROM Contestants NATURAL JOIN (Schedules FULL JOIN Competitions USING (competitionID)) NATURAL JOIN CompetesIn
WHERE contestantName = 'Anja Persson';

--6. (own query) Which countries has both a Men's and Women's team in a given sport?
SELECT T1.country, T1.sportName
FROM nationalTeams AS T1, nationalTeams AS T2
WHERE T1.sex = 'M' AND T2.sex = 'F'
    AND T1.country = T2.country
    AND T1.sportName = T2.sportName AND T1.sportName = 'Ice Hockey';
    
--7 (own query) When are all the finals (scheduled or not?)
SELECT sex, eventName, sportName, datetime, Arena, Venuename
FROM (Schedules FULL JOIN Competitions USING (competitionID)) NATURAL JOIN Events
WHERE Competitions.roundName = 'final';


--8 (own query) Which arena is the most popular?

