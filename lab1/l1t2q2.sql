-- l1t2q2 -- Try  to  insert  into  editions a  new  tuple  ('5555', 12345,  1,59, '2012-12-02').   Explain what happened.
INSERT INTO editions
VALUES ('5555', 12345, 1,59, '2012-12-02');
/* Output:
ERROR:  insert or update on table "editions" violates foreign key constraint "editions_book_id_fkey"
DETAIL:  Key (book_id)=(12345) is not present in table "books".
postgres=#
*/ --The book_id tried to input was not present in the books-relation, giving rise to an error since there is a foreign key constraint from the editions.book_id to the primary key of books.
