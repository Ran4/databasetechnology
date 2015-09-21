--l1t2q6 Try to delete the new tuple from books. Explain what happens.
DELETE FROM books
WHERE book_id=12345;

/* Output:
update or delete on table "books" violates foreign key constraint "editions_book_id_fkey" on table "editions"
DETAIL:  Key (book_id)=(12345) is still referenced from table "editions".
*/
-- We see here that we have an foreign key constraint from the book_id to editions,
--making it impossible to delete a book before the reference is deleted from the editions relation.
