/*
Consistency:
1. Contestants must belong to one and only one team,
   Each Contestants name must be unique, so this requirement is more than enforced.

2. No two competitions can take place at the same venue at the same time (A venue is not the same as
arena as it includes competitions locations within the arena.),

3. That a contestant can not compete at the same time in different competitions.
*/


/*2. No two competitions can take place at the same venue at the same time (A venue is not the same as
arena as it includes competitions locations within the arena.)*/
DROP FUNCTION IF EXISTS prevent_double_booking_function() CASCADE;
CREATE FUNCTION prevent_double_booking_function() RETURNS TRIGGER AS $pname$
BEGIN
    --RAISE EXCEPTION 'NO NO NO';
    IF (NEW.venueName IN (SELECT venueName FROM Schedules)
        AND NEW.datetime IN (SELECT datetime FROM Schedules))
            THEN RAISE EXCEPTION 'Already booked venue!';
    END IF;
    RETURN NEW;
END;
    
$pname$ LANGUAGE plpgsql;
CREATE TRIGGER prevent_double_booking_trigger
BEFORE INSERT ON Schedules --Triggering condition
FOR EACH ROW
    EXECUTE PROCEDURE prevent_double_booking_function();
    
/*3. That a contestant can not compete at the same time in different competitions.
Would it be ok to add a trigger that when adding a new value into competition
checks if there are any contestants that would be competing in the same time, and thus reject the event insertion?
*/
DROP FUNCTION IF EXISTS prevent_compete_on_same_time_function() CASCADE;
CREATE FUNCTION prevent_compete_on_same_time_function() RETURNS TRIGGER AS $pname$
BEGIN
    IF EXISTS(
        SELECT contestantName FROM
            (SELECT contestantName FROM CompetesIn NATURAL JOIN Schedules WHERE Schedules.datetime = New.datetime) AS newNames
        NATURAL JOIN
            (SELECT contestantName FROM CompetesIn WHERE NEW.competitionID = CompetesIn.competitionID) AS oldNames
    ) THEN RAISE EXCEPTION 'There are double-booked contestants! datetime: %, competitionID: %', NEW.datetime, NEW.competitionID ;
    END IF;
    RETURN NEW;
END;
    
$pname$ LANGUAGE plpgsql;
CREATE TRIGGER prevent_compete_on_same_time_trigger
BEFORE INSERT ON Schedules  --Triggering condition
FOR EACH ROW
    EXECUTE PROCEDURE prevent_compete_on_same_time_function();

