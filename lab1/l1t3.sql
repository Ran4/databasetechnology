--l1t3 
/*
Your task here is to write a trigger that functions so that whenever a new shipment is recorded the stock is automatically decreased to reflect the shipment. If the current stock=0 then the insertion should not happen and an ‘EXCEPTION’ raised with some message such as ‘There is no stock to ship’.
*/
DROP FUNCTION decstock() CASCADE;
CREATE FUNCTION decstock() RETURNS trigger AS $pname$      BEGIN            IF NEW.stock=0 --=SOME SQL QUERY, kolla i stock, men i shipments                 THEN RAISE EXCEPTION 'There is no stock to ship'                    ELSE                        NEW.stock=NEW.stock-1;            END IF;      END;$pname$ LANGUAGE plpgsql;
CREATE TRIGGER
AFTER UPDATE ON shipments      ... (state the triggering condition as in described inbook 7.5.1)      FOR EACH ROW             EXECUTE PROCEDURE decstock();



/*
SELECT * FROM stock;--Output: the whole table before making shipments.INSERT INTO shipmentsVALUES(2000, 860, '0394900014', '2012-12-07');--Since this book is not in stock, this should give: Output: ERROR: There is no stock to shipINSERT INTO shipmentsVALUES(2001, 860, '044100590X', '2012-12-07');--This should giveOutput: INSERT 0 1--Then test by:SELECT * FROM shipments WHERE shipment_id > 1999; --Which should show that only the second shipment was actually inserted: Output: 2001 | 860 | 044100590X | 2012-12-07 00:00:00+01SELECT * FROM stock;--Output: the stock table with 044100590X decremented.--Remember to then restore the database to its original state (in the .sql file): 
DELETE FROM shipments WHERE shipment_id > 1999;--Output: DELETE 1UPDATE stock SET stock = 89 WHERE isbn = '044100590X'; 
--Output: UPDATE 1--I would also end my sql file withDROP FUNCTION decstock() CASCADE;

*/