--l1t2q8 Now insert a book with (isbn, title, subject_id ) of (12345, 'How I Insert', 3443).-- Explain what happened.

INSERT INTO books (book_id, title, subject_id)
VALUES (12345, 'How I Insert', 3443);

/*Output:
ERROR:  insert or update on table "books" violates foreign key constraint "books_subject_id_fkey"
DETAIL:  Key (subject_id)=(3443) is not present in table "subjects".
*/ -- In this case it checks the constraint whether the subject_id is present as a primary key in subject, which it is not - therefore giving rise to an error.
