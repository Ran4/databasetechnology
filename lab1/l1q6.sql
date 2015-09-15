-- l1q6 Which books have been sold to only two people?
Dune
2001: A Space Odyssey*/

SELECT title
FROM books,editions, shipments
WHERE books.book_id=editions.book_id
    AND editions.isbn=shipments.isbn
GROUP BY title
HAVING COUNT(DISTINCT customer_id)=2;
;
