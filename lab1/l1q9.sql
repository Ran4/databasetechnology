-- l1q9 Which customers have bought books about at least three different subjects?
/*
Answer: Jackson, Annie
*/

SELECT last_name, first_name
FROM customers,shipments, subjects, books, editions
WHERE customers.customer_id=shipments.customer_id
    AND books.subject_id=subjects.subject_id
    AND editions.isbn=shipments.isbn
    AND editions.book_id=books.book_id
GROUP BY last_name, first_name
HAVING COUNT(subjects.subject) >=3;

/*
last_name | first_name
-----------+------------
 Jackson   | Annie
(1 row)
*/
