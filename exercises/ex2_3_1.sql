DROP TABLE IF EXISTS Product;
CREATE TABLE Product (
    maker CHAR(25),
    model CHAR(100),
    type_ CHAR(100)
);

DROP TABLE IF EXISTS PC;
CREATE TABLE PC (
    model CHAR(25) PRIMARY KEY,
    speed INTEGER,
    ram INTEGER,
    hd INTEGER,
    price INTEGER
);

DROP TABLE IF EXISTS Printer;
CREATE TABLE Printer (
    model CHAR(25),
    color CHAR(6),
    type_ CHAR(10),
    price INTEGER
);

DROP TABLE IF EXISTS Laptop;
CREATE TABLE Laptop (
    model CHAR(25),
    speed INTEGER,
    ram INTEGER,
    hd INTEGER,
    screen INTEGER,
    price INTEGER
);

ALTER TABLE Printer DROP color;
ALTER TABLE Laptop ADD opticaldrive CHAR(25) DEFAULT 'none';
