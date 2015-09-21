--l1q2 Which titles are written by Paulette Bourgeois?
SELECT title 
FROM books, authors 
WHERE   books.author_id=authors.author_id 
        AND last_name='Bourgeois' 
        AND first_name='Paulette';
/*
        title         
----------------------
 Franklin in the Dark
(1 row)
*/
