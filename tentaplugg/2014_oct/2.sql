CREATE TABLE Stock(
    model INT REFERENCES Item(id) ON UPDATE CASCADE,
    warehouse VARCHAR(50),
    shelf VARCHAR(10),
    amount INT CHECK (amount>=0),
    reserved INT CHECK (amount>=reserved),
    FOREIGN KEY (warehouse, shelf) REFERENCES Storage(warehouse, shelf),
    PRIMARY KEY (model, warehouse, shelf));
CREATE TABLE Storage(
    warehouse VARCHAR(50),
    shelf VARCHAR(10),
    volume FLOAT CHECK (volume>0),
    freeVolume FLOAT CHECK (freeVolume>=0),
    CHECK (freeVolume <= volume),
    PRIMARY KEY (warehouse, shelf));
CREATE TABLE Item (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price FLOAT,
    volume FLOAT);
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    status VARCHAR(10) NOT NULL,
    customer INT REFERENCES Customer(id) ON UPDATE CASCADE,
    item INT REFERENCES Item(id) DEFERRABLE INITIALLY DEFERRED,
    date DATE,
    amount INT,
    street VARCHAR(50),
    city VARCHAR(50),
    postcode VARCHAR(5));
CREATE TABLE Customer (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(50));

--f) (5 pts.) List all orders that have status=’pending’ (ie. there was no stock to send when the order was taken) that now have some stock of that item that is not reserved (ie. (amount-reserved)> 0).
--Include the date of the order and the storage location or locations.  Give the following column headings: (orderID, orderAmount, date, warehouse, shelf, available), where available is amount of stock not reserved.  --Sort ascending by date.
SELECT Orders.id AS orderID, Orders.amount AS orderAmount, date_,
    Stock.warehouse, Stock.shelf, (Stock.amount - Stock.reserved) AS available
FROM Orders JOIN Stock ON item=model
WHERE status='pending' AND (Stock.amount - Stock.reserved) > 0
ORDER BY date_ ASC

--2. (20 pts.) Write a single SQL statement to answer each of the following problems.
--a) (1 pts.) List the names of all the items in category ’men shirts’.
SELECT name
FROM Item
WHERE category = 'men shirts';
--b) (2 pts.) List all the storage locations and the amount of space left (ie. columns: warehouse, shelf, freeVolume) that hold some amount>0 of items with category = ’men shirts’.
SELECT warehouse, shelf, freeVolume
FROM (Stock JOIN Items ON model=id) JOIN Storage ON warehouse=warehouse AND shelf=shelf
WHERE amount > 0 AND category = 'men shirts';
--c) (2 pts.) List the values for all attributes of tuples in the relation ’Orders’ that have the status = ’completed’ for the customer with name ’Jason Jones’.
SELECT * FROM ORDERS WHERE customer IN (SELECT id FROM Customer WHERE name='Jason Jones') AND
status = 'completed';
--d) (6 pts.) Create a view called VIP that has columns (email, value) where email is the customer’s email, value is total value of all that customer’s orders (ie price*amount)for all customers that have this value above 999
CREATE VIEW VIP AS
    SELECT email, sum(price*amount) AS value
    FROM Customer JOIN Orders ON customer=Customer.id JOIN Item ON Item.id=Orders.item
    GROUP BY customer, email HAVING SUM(price*amount) > 999;

--e) (4 pts.) Write the SQL code that would add a constraint to Customer that the email would have at least one character followed by ’@’ followed by at least one character.
ALTER TABLE Customer ADD CONSTRAINT Const
CHECK (email LIKE '_%@_%');
