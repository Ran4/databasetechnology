--6.1.3ad
--a
INSERT INTO PC VALUES ('modell', 340, 32, 14, 800);
INSERT INTO PC VALUES ('modell2', 340, 64, 14, 1100);

SELECT model, speed, hd FROM PC WHERE price < 1000;

--d
INSERT INTO LAPTOP VALUES ('modell', 340, 32, 2000, 14, 800);
INSERT INTO LAPTOP VALUES ('modell2', 340, 64, 2000, 14, 2100);

SELECT model, ram, screen FROM Laptop WHERE price > 1500;
