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
    
/*3. That a contestant can not compete at the same time in different competitions.*/

DROP FUNCTION IF EXISTS prevent_compete_on_same_time_function() CASCADE;
CREATE FUNCTION prevent_compete_on_same_time_function() RETURNS TRIGGER AS $pname$
BEGIN
    RAISE EXCEPTION 'NO NO NO from preventcompeteonsametimeee';
    IF (NEW.venueName IN (SELECT venueName FROM Schedules)
        AND NEW.datetime IN (SELECT datetime FROM Schedules))
            THEN RAISE EXCEPTION 'Already booked venue!';
    END IF;
    
    RETURN NEW;
END;
    
$pname$ LANGUAGE plpgsql;
CREATE TRIGGER prevent_compete_on_same_time_trigger
BEFORE INSERT ON competesIn  --Triggering condition
FOR EACH ROW
    EXECUTE PROCEDURE prevent_compete_on_same_time_function();

/*
Would it be okadd a trigger that when adding a new value into competition checks if there are any
 contestants that would be competing in the same time, and thus reject the event insertion?
*/