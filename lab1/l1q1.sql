SELECT authors.last_name, authors.first_name 
FROM authors, books 
WHERE book.title="The Shining"
