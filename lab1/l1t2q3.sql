--l1t2q3 Try  to  insert  into  editions a  new  tuple  only  setting  its  isbn='5555'. Explain  what happened
INSERT INTO editions (isbn)
VALUES ('5555');

/*
ERROR:  new row for relation "editions" violates check constraint "integrity"
DETAIL:  Failing row contains (5555, null, null, null, null).
*/
-- As there is a constraint called intergrity that checks that book_id is not null and that edition is not null, the constraint is violated and rightfully the system gives rise to an error.
