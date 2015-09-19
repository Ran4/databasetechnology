--l1t3
/* Your task here is to write a trigger that functions so that whenever a new
shipment is recorded the stock is automatically decreased to reflect the shipment.

If the current stock=0 then the insertion should not happen and an ‘EXCEPTION’
should be raised with some message such as ‘There is no stock to ship’.
*/
DROP FUNCTION IF EXISTS decstock() CASCADE;
CREATE FUNCTION decstock() RETURNS TRIGGER AS $pname$
    BEGIN
        IF (
            SELECT stock 
            FROM stock 
            WHERE NEW.isbn=stock.isbn) = 0
                THEN RAISE EXCEPTION 'There is no stock to ship';
        ELSE
            UPDATE stock
                        SET stock = stock-1
                        WHERE isbn=NEW.isbn;
        END IF;
        RETURN NEW;
    END;

$pname$ LANGUAGE plpgsql;
CREATE TRIGGER decstocktrigger
BEFORE INSERT ON shipments --Triggering condition
FOR EACH ROW
    EXECUTE PROCEDURE decstock();


--INSERT INTO shipments VALUES(2000, 860, '0394900014', '2012-12-07');



SELECT * FROM stock;
--Output: the whole table before making shipments.

INSERT INTO shipments VALUES(2000, 860, '0394900014', '2012-12-07');
--Since this book is not in stock, this should give: Output: ERROR: There is no stock to ship

INSERT INTO shipments VALUES(2001, 860, '044100590X', '2012-12-07');
--This should give Output: INSERT 0 1
--Then test by:
SELECT * FROM shipments WHERE shipment_id > 1999;

--Which should show that only the second shipment was actually inserted:
--Output: 2001 | 860 | 044100590X | 2012-12-07 00:00:00+01
SELECT * FROM stock;
--Output: the stock table with 044100590X decremented.
--Remember to then restore the databASE TO ITs original state (in the .sql file):
DELETE FROM shipments WHERE shipment_id > 1999;
--Output: DELETE 1
UPDATE stock SET stock = 89 WHERE isbn = '044100590X';
--Output: UPDATE 1
--I would also end my sql file with
DROP FUNCTION decstock() CASCADE;
--*/

/* Actual output, in accordance with comments above:
 NOTICE:  function decstock() does not exist, skipping
DROP FUNCTION
CREATE FUNCTION
CREATE TRIGGER
    isbn    | cost  | retail_price | stock 
------------+-------+--------------+-------
 0385121679 | 29.00 |        36.95 |    65
 039480001X | 30.00 |        32.95 |    31
 0394900014 | 23.00 |        23.95 |     0
 0441172717 | 17.00 |        21.95 |    77
 0451160916 | 24.00 |        28.95 |    22
 0451198492 | 36.00 |        46.95 |     0
 0451457994 | 17.00 |        22.95 |     0
 0590445065 | 23.00 |        23.95 |    10
 0679803335 | 20.00 |        24.95 |    18
 0694003611 | 25.00 |        28.95 |    50
 0760720002 | 18.00 |        23.95 |    28
 0823015505 | 26.00 |        28.95 |    16
 0929605942 | 19.00 |        21.95 |    25
 1885418035 | 23.00 |        24.95 |    77
 0394800753 | 16.00 |        16.95 |     4
 044100590X | 36.00 |        45.95 |    89
(16 rows)

psql:/Users/sander/Documents/CMEDT/Databasteknik/databasetechnology/lab1/l1t3.sql:38: ERROR:  There is no stock to ship
INSERT 0 1
 shipment_id | customer_id |    isbn    |       ship_date        
-------------+-------------+------------+------------------------
        2001 |         860 | 044100590X | 2012-12-07 00:00:00+01
(1 row)

    isbn    | cost  | retail_price | stock 
------------+-------+--------------+-------
 0385121679 | 29.00 |        36.95 |    65
 039480001X | 30.00 |        32.95 |    31
 0394900014 | 23.00 |        23.95 |     0
 0441172717 | 17.00 |        21.95 |    77
 0451160916 | 24.00 |        28.95 |    22
 0451198492 | 36.00 |        46.95 |     0
 0451457994 | 17.00 |        22.95 |     0
 0590445065 | 23.00 |        23.95 |    10
 0679803335 | 20.00 |        24.95 |    18
 0694003611 | 25.00 |        28.95 |    50
 0760720002 | 18.00 |        23.95 |    28
 0823015505 | 26.00 |        28.95 |    16
 0929605942 | 19.00 |        21.95 |    25
 1885418035 | 23.00 |        24.95 |    77
 0394800753 | 16.00 |        16.95 |     4
 044100590X | 36.00 |        45.95 |    88
(16 rows)

DELETE 1
UPDATE 1
psql:/Users/sander/Documents/CMEDT/Databasteknik/databasetechnology/lab1/l1t3.sql:56: NOTICE:  drop cascades to trigger decstocktrigger on table shipments
DROP FUNCTION

*/
