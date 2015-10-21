CREATE TABLE Customer ( id INT PRIMARY KEY, name VARCHAR(100), city VARCHAR(100), email VARCHAR(50)
);
CREATE TABLE Product( id INT PRIMARY KEY, name VARCHAR(50), category VARCHAR(50),
    price FLOAT,
    weight FLOAT
);
CREATE TABLE Stock(
    product INT REFERENCES Product(id) ON UPDATE CASCADE,
    location INT REFERENCES Location(id),
    amount INT CHECK (amount>=0),
    PRIMARY KEY (product, location));
CREATE TABLE Location(
    id INT PRIMARY KEY,
    type CHAR(7) NOT NULL,
    address VARCHAR(50),
    city VARCHAR(50));
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customer INT REFERENCES Customer(id) ON UPDATE CASCADE,
    items INT,
    date DATE,
    total weight FLOAT, total item cost FLOAT, total shipping FLOAT,
    taxes FLOAT,
    CHECK (items=SELECT COUNT(*) FROM Order item WHERE order=id));
CREATE TABLE Order_item (
    order INT REFERENCES Order(id),
    product INT REFERENCES Stock(product) ON UPDATE CASCADE,
    location INT REFERENCES Stock(location),
    amount INT CHECK (amount>0),
    PRIMARY KEY (order, product, location));
/* -- 2. (18 pts.) Write a single SQL statement to answer each of the following problems.
a) (2 pts.) Find the ’email’ address(es) of the Customer named ’Joe Snow’.  */
SELECT email FROM Customer WHERE name = 'Joe Snow'
/* b) (2 pts.) List all Product tuples in category ’kitchen’ with price less than 5.00.  */
SELECT * FROM Product WHERE price < 5.0 AND category = 'kitchen'
/* c) (3 pts.) For the Order_items of Order with id of 888, list the product ’name’, unit ’price’, ’amount’ of units, cost of order item (ie. product of previous two columns). Output a table with headings product, price, amount, and cost.  */
SELECT Product.name AS 'product', Product.price AS 'price', Product.amount AS 'amount', Product*price * Product.amount AS 'cost'
FROM Order_item, product
WHERE Order_item.product = product.id AND Order_item.order = 888
-- d) (4 pts.) List for each product id, the Product name along with the total amount of sales of the product. Individual sales of a product are its price times the amount in a cooresponding Order_item. Output column headings product and sales.
SELECT Product.name AS 'product', sum(Product.price * Order_item.amount) AS 'sales'
FROM Product, Order_item
WHERE Product.id = Order_item.product
GROUP BY Product.name
-- e) (3 pts.) Write the SQL code that would add a constraint to Customer that the city should match one in the Location relation.
ALTER TABLE Customer ADD CONSTRAINT CityConstraint CHECK (city IN SELECT city FROM Location)
--f) (4 pts.) List all Location tuples exactly one time each, that have more than 0 stock amounts of a product with name ’Galaxy Phone’.
SELECT DISTINCT Location.id, location.type, location.address, location.city
FROM Location, Product, Stock
WHERE Stock.product = product.id AND Stock.amount > 0 AND Stock.location = Location.id AND Product.name = 'Galaxy Phone'


/*SELECT DISTINCT Location.id, location.type, location.address, location.city
FROM Location JOIN (SELECT location FROM (Stock JOIN Product ON Stock.product=product.id)) ON Location.id = location
WHERE Stock.amount > 0 AND Product.name = 'Galaxy Phone' */
