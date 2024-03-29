-- l1q3 Who bought books about "horror"?
SELECT last_name,first_name
FROM  ( SELECT last_name,first_name,book_id -- alla kunder som köpt någon bok.    
        FROM editions, shipments, customers 
        WHERE editions.isbn=shipments.isbn 
        AND customers.customer_id=shipments.customer_id)BookBuyer ,
             
             (SELECT book_id,title -- alla horror-böcker
             FROM books, subjects
             WHERE subject='Horror'
             AND subjects.subject_id=books.subject_id)HorrorBook
WHERE BookBuyer.book_id=HorrorBook.book_id; last_name | first_name 
/*
-----------+------------
 Brown     | Chuck
 Gould     | Ed
 Holloway  | Adam
 Black     | Jean
 King      | Jenny
 Anderson  | Jonathan
 Becker    | Owen
 Morrill   | Royce
 Jackson   | Annie
(9 rows)
*/
