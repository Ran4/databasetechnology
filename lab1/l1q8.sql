--l1q8 How much money has Booktown earned (so far)? (Explain to the teacher how you reason about the incomes and costs of Booktown)

SELECT SUM(retail_price-cost)
FROM stock,shipments
WHERE shipments.isbn=stock.isbn;

/*
The stock is not included as a cost, but merely the earning from the sold books i shipments.
*/