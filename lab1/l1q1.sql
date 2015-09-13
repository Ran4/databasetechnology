SELECT last_name, first_name 
FROM authors, books 
WHERE books.author_id=authors.author_id AND title = 'The Shining';
/*
 last_name | first_name 
-----------+------------
 King      | Stephen
(1 row)
*/
