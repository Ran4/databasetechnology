--l1 task 2 define view. Create a view that contains isbn and title of all the books in the database. Then query it to list all the titles and isbns. Then delete (drop) the new view. Why might this view be nice to have?

-- DROP VIEW isbn_title;

CREATE VIEW isbn_title AS 
SELECT title, isbn
FROM editions, books
WHERE editions.book_id=books.book_id;

SELECT * FROM isbn_title;

DROP VIEW isbn_title;

-- It is nice to have since the title and ISBN are not present in the same relation, giving a possibility to access them directly instead on incorporating two separate realtions.