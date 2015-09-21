-- l1q5 How much money has Booktown collected for the books about Science Fiction? They collect the retail price of each book shiped.
-- Answer: 137.80
SELECT SUM(retail_price)
FROM stock, (SELECT title, isbn -- Science Fiction Books, all versions.
                        FROM books, subjects, editions
                        WHERE subjects.subject='Science Fiction'
                        AND books.subject_id=subjects.subject_id
                        AND  editions.book_id=books.book_id)SFBOOKS
WHERE  stock.isbn=SFBOOKS.isbn;

/*
sum
--------
 137.80
(1 row)
*/
