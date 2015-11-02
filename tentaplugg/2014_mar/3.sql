--Complete this trigger definition (replace ... by some expression)
--so that no Employee that is not a President can have
--more than one ’FULL’ type position inserted into Positions.

CREATE FUNCTION checkit() RETURNS TRIGGER AS $pname$ BEGIN
IF exists(SELECT employee, birth
        FROM Positions
        WHERE type_ = 'FULL' AND employee=NEW.employee AND birth=NEW.birth)
    AND NOT EXISTS(SELECT * FROM Companies WHERE president=NEW.employee AND birth=NEW.birth)
    THEN RAISE EXCEPTION 'Too much work';
END IF;
RETURN NEW;
END;

$pname$ LANGUAGE plpgsql;
CREATE TRIGGER FullMax BEFORE INSERT ON Positions
FOR EACH ROW
    EXECUTE PROCEDURE checkit();
