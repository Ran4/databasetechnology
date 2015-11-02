--e) Prevent having a concert with the same name at two different venues on the same day
ALTER TABLE Concerts ADD CONSTRAINT NotSameDay
CHECK NOT EXISTS(
    SELECT name FROM Concerts
    WHERE Concerts.name=name AND Concerts.cdate=cdate AND Concerts.venue <> venue);

