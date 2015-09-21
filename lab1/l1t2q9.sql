--l1t2q9 Create a constraint, called ‘hasSubject’ that forces the subject_id to not be NULL and to match one in the subjects table. (HINT you might want to look at chap. 6.1.6 on testing NULL). Show that you can still insert an book with no author_id but not without a subject_id. Now remove the new constraint and any added books.


ALTER TABLE books
ADD CONSTRAINT hasSubject
CHECK (subject_id IS NOT NULL)

  ;
                          
INSERT INTO books --Test case with subject_id but no author
VALUES (5432,'Test without author but with subject_id',NULL,10);

INSERT INTO books -- Test case without both author and subject, should fail due to constraint above
VALUES(6543,'Test without subject_id, should fail',NULL,Null);


/* Output:
INSERT 0 1
ERROR:  new row for relation "books" violates check constraint "hassubject"
DETAIL:  Failing row contains (6543, Test without subject_id, should fail, null, null).
ALTER TABLE
DELETE 1*/

--As can be seen from the output, the constaint works.

ALTER TABLE books
DROP CONSTRAINT hasSubject; --Remove new made constraint

DELETE FROM books
WHERE book_id=5432; --Remove recently added test book
