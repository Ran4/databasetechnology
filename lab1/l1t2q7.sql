-- l1t2q7 Delete both new tuples from step 4 and query the database to confirm.
DELETE FROM editions
WHERE isbn='5555';

DELETE FROM books
WHERE book_id=12345;

SELECT title, book_id
FROM books;

/*Output before deletion:
            title            | book_id 
-----------------------------+---------
 The Shining                 |    7808
 Dune                        |    4513
 2001: A Space Odyssey       |    4267
 The Cat in the Hat          |    1608
 Bartholomew and the Oobleck |    1590
 Franklin in the Dark        |   25908
 Goodnight Moon              |    1501
 Little Women                |     190
 The Velveteen Rabbit        |    1234
 Dynamic Anatomy             |    2038
 The Tell-Tale Heart         |     156
 Programming Python          |   41473
 Learning Python             |   41477
 Perl Cookbook               |   41478
 Practical PostgreSQL        |   41472
 How I Insert                |   12345
(16 rows)

Output after deletion:

DELETE 1
DELETE 1
            title            | book_id 
-----------------------------+---------
 The Shining                 |    7808
 Dune                        |    4513
 2001: A Space Odyssey       |    4267
 The Cat in the Hat          |    1608
 Bartholomew and the Oobleck |    1590
 Franklin in the Dark        |   25908
 Goodnight Moon              |    1501
 Little Women                |     190
 The Velveteen Rabbit        |    1234
 Dynamic Anatomy             |    2038
 The Tell-Tale Heart         |     156
 Programming Python          |   41473
 Learning Python             |   41477
 Perl Cookbook               |   41478
 Practical PostgreSQL        |   41472
(15 rows)

*/
