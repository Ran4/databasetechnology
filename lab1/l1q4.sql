--l1q4
SELECT title
FROM stock,books,editions
WHERE  editions.isbn=stock.isbn
    AND editions.book_id=books.book_id
    AND stock = (SELECT MAX(stock)
                  FROM stock)   ;
/*
     title 
-------
 Dune
(1 row)
*/
