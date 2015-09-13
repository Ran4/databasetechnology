--l1q7 Which publisher has sold the most to Booktown?/*Note that all shipped books were sold at ‘cost’ to as well as all the books in the stock.Answer: Ace Books, 4566.00*/

SELECT A.name, SUM(A.sold+B.sold)
FROM (
        SELECT name,SUM(cost*stock) AS sold
        FROM publishers,editions,stock
        WHERE publishers.publisher_id=editions.publisher_id
            AND stock.isbn=editions.isbn
        GROUP BY name) A,
                -- Summan av cost av de böcker som sålts, grupperat på publisher
                    (SELECT name, SUM(cost) AS sold 
                    FROM shipments, editions, publishers, stock
                    WHERE shipments.isbn=editions.isbn
                        AND editions.publisher_id=publishers.publisher_id
                        AND stock.isbn=editions.isbn
                    GROUP BY name) B
WHERE A.name=B.name
GROUP BY A.name
ORDER BY SUM(A.sold+B.sold) DESC
LIMIT 1
;






/*
(shipments.isbn antal och styckpris) till publisher 

Värdet av alla sålda böcker (shipments) från en viss publisher plus summan av lagret(stock)
*/

-- TO DO: combine the to queries above. the sum of those are correct!