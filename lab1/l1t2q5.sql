--l1t2q5 Update the new book by setting the subject to ‘Mystery’.
UPDATE books
SET subject_id= (SELECT subject_id 
                FROM subjects
                WHERE subject='Mystery')
WHERE book_id=12345;
