--l1t2q4 Try to first insert a book with (book_id, title) of (12345, 'How I Insert') then One into editions as in 2.  Show that this worked by making an appropriate query of the database.
INSERT INTO books
VALUES (12345,'How I Insert');

INSERT INTO editions
VALUES ('5555', 12345, 1,59, '2012-12-02');

SELECT book_id, title
FROM books;
--Why do we not need an authoror subject?
--Answer: We do not have such a constraint.
