CREATE TABLE Companies(
    id INT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    name VARCHAR(80) NOT NULL,
    president VARCHAR(50),
    birth DATE,
    FOREIGN KEY (president, birth) REFERENCES Executives(name, birth) ON UPDATE SET NULL
);
CREATE TABLE Executives (
    name VARCHAR(50),
    birth DATE,
    FOREIGN KEY (name, birth) REFERENCES Employees(name, birth) ON UPDATE CASCADE,
    PRIMARY KEY (name, birth)
);
CREATE TABLE Employees (
    name VARCHAR(50),
    birth DATE,
    PRIMARY KEY (name, birth)
);
CREATE TABLE Positions (
    id INT PRIMARY KEY,
    employee VARCHAR(50),
    birth DATE,
    FOREIGN KEY (employee, birth) REFERENCES Employees (name, birth),
    company INT REFERENCES Companies(id),
    salary INT,
    type_ CHAR(4) CHECK (type IN (’FULL’, ’PART’))
);
CREATE TABLE Payments (
    id INT PRIMARY KEY,
    amount INT,
    position INT References Positions(id),
    date_ DATE NOT NULL
);

--d) (3 pts.) List the names of all company presidents that earn more than 100,000 in total salary from all their (possibly several) Positions.
SELECT president FROM Positions JOIN Companies ON Positions.company=Companies.id
HAVING sum(Positions.salary) > 100000
GROUP BY president;
--e) (4 pts.) CREATE a view that has columns company name, date, total payments, where the last column holds the sum of all payments from positions in the company on the date.
CREATE VIEW totalSalaryPaidOnDate AS
SELECT Companies.name AS companyName, Payments.date_, sum(amount) as totalPayments
FROM Payments JOIN Positions ON position=Positions.id JOIN Companies ON company=Companies.id
GROUP BY Companies.name, Payments.date_;

--f) (4 pts.) Add a constraint called no_easy_money to prevent a position of type ’PART’ having a salary of more than 10,000.
ALTER TABLE Positions ADD CONSTRAINT no_easy_money
CHECK salary <= 10000 OR type_ = 'FULL';
--CHECK salary > 10000 AND type_ <> 'PART'; --alternative

--a) (2 pts.) List the city or cities of all Companies that have ’Harold Arlen’ as president.
SELECT city FROM Companies WHERE president = 'Harold Arlen';
--b) (2 pts.) List the name(s) of all Employees that have a Positions with salary above 20,000.
SELECT Employees.name
FROM Employees JOIN Positions ON name=employee AND Employees.birth=Positions.birth
WHERE Positions.salary > 20000;
--c) (3 pts.) List the position and total amount of Payments on June 30, 2013 for each position which had payments that day.
SELECT position, sum(amount)
FROM Payments
WHERE Payments.date_ = DATE '2013-06-30'
GROUP BY position;
