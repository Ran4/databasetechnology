CREATE TABLE Buildings(
    year INT,
    id INT PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    manager VARCHAR(50) REFERENCES Managers(name) ON UPDATE CASCADE,
    maintainer VARCHAR(50) REFERENCES Maintenance(name));
CREATE TABLE Managers (
    salary INT,
    name VARCHAR(50) PRIMARY KEY);
CREATE TABLE Maintenance (
    salary INT,
    name VARCHAR(50) PRIMARY KEY);
CREATE TABLE Units (
    number_ INT,
    building INT REFERENCES Buildings(id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED,
    PRIMARY KEY (number, building),
    type_ VARCHAR(40) NOT NULL,
    area INT,
    rooms INT);
CREATE TABLE Tenants (
    name VARCHAR(50) PRIMARY KEY);
CREATE TABLE Landlords (
    name VARCHAR(50) PRIMARY KEY);
CREATE TABLE Contracts (
    rent INT,
    tenant VARCHAR(50),
    tenant2 VARCHAR(50),
    landlord VARCHAR(50),
    unit INT,
    building INT,
    FOREIGN KEY (tenant) REFERENCES Tenants(name),
    FOREIGN KEY (tenant2) REFERENCES Tenants(name),
    FOREIGN KEY (landlord) REFERENCES Landlords(name),
    FOREIGN KEY (unit, building) REFERENCES Units(number, building) DEFERRABLE INITIALLY DEFERRED,
    start_ DATE,
    end_ DATE,
    PRIMARY KEY ( unit, building, start_),
    check (start_ > ALL (SELECT end_
                        FROM Contracts AS C
                        WHERE C.unit = unit AND C.building = building AND C.start_ <> start_ ));
                
--f) Find the name(s) and salary(ies) of the manager(s) of the unit(s) that Jojo Johansson is or was one of the tenants in.
SELECT Managers.name, Managers.salary
FROM Managers JOIN Buildings ON manager JOIN Contracts ON Contracts.building=Buildings.id
WHERE (Contracts.tenant = 'Jojo Johansson' OR Contracts.tenant = 'Jojo Johansson')
    AND Contracts.start_ <= DATE '2015-10-27';

    
CREATE FUNCTION checkit() RETURNS TRIGGER AS $pname$ BEGIN
    IF COUNT( SELECT manager FROM Buildings WHERE NEW.id = Buildings.id)) > 100
        THEN RAISE EXCEPTION 'Can''t have more than 100 managers for a building!';
    END IF;
    RETURN NEW;
    END;

$pname$ LANGUAGE plpgsql;
CREATE TRIGGER managerlimit AFTER UPDATE ON Buildings
FOR EACH ROW
    EXECUTE PROCEDURE checkit();
    


--a) List the adress(es) of all buildings with year 1977
SELECT address FROM Buildings WHERE year=1977;
--b) List the name(s) of all Managers that manage buildings maintained by Joe Cole
SELECT Managers.name FROM Managers JOIN Buildings ON manager=name WHERE maintainer = 'Joe Cole';
--d) Create a view that lists all the buildings along with the total rent currently being collected for each building.
CREATE VIEW buildingListView AS
    SELECT Buildings.id, sum(Contracts.rent) AS totalRent
    FROM Buildings JOIN Contracts ON id=building
    GROUP BY Buildings.id;
--e) Add a constraint to prevent having a unit with negative area
ALTER TABLE Units ADD CONSTRAINT NoNegativeAreaConstraint
    CHECK (area >= 0);
    
