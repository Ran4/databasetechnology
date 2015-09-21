-- l1q6 Which books have been sold to only two people?
/*Note that some people buy more than one copy and some books appear as several editions.*/

SELECT title
FROM books,editions, shipments
WHERE books.book_id=editions.book_id
    AND editions.isbn=shipments.isbn
GROUP BY title
HAVING COUNT(DISTINCT customer_id)=2;
;

/*
Dune
Little Women
The Velveteen Rabbit
2001: A Space Odyssey
 */

