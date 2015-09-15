--l1q10 
/*
10. Which subjects have not sold any books?Answer: 
Mystery
Business
ReligionCooking
PoetryHistory
Romance
Entertainment
Science
*/

SELECT subject
FROM subjects
WHERE subject NOT in (SELECT subject
                        FROM subjects,books,editions,shipments
                        WHERE books.subject_id=subjects.subject_id
                        AND books.book_id=editions.book_id
                        AND editions.isbn=shipments.isbn)
;

/*
    subject    
---------------
 Business
 Cooking
 Entertainment
 History
 Mystery
 Poetry
 Religion
 Romance
 Science
(9 rows)
*/