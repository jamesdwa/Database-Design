-- 1.
CREATE TABLE Sales (
    name VARCHAR(100),
    discount VARCHAR(4),
    month VARCHAR(3),
    price INT
);

-- 2.
-- name -> price
SELECT *
FROM Sales A, Sales B
WHERE A.name = B.name 
    AND A.price != B.price

-- month -> discount
SELECT *
FROM Sales A, Sales B
WHERE A.month = B.month 
    AND A.discount != B.discount

-- discount -> price (functional dependency does not exist in the dataset)
SELECT *
FROM Sales A, Sales B
WHERE A.discount = B.discount
    AND A.price != B.price


-- FDs: name -> price, and month -> discount

-- 3. 
-- S(name, discount, month, price)
-- (1) name -> name, price
-- (2) S1(name, price)
-- (3) S2(name, discount, month)

-- S2(name, discount, month)
-- (1) month -> month, discount
-- (2) S3(month, discount)
-- (3) S4(month, name)

-- BCNF is S1(name, price), S3(month, discount), and S4 (month, name)

CREATE TABLE namePrice (
    name VARCHAR(100) PRIMARY KEY,
    price INT
);

CREATE TABLE monthDiscount (
    month VARCHAR(3)  PRIMARY KEY,
    discount VARCHAR(4)
);

CREATE TABLE monthName (
    month VARCHAR(3),
    name VARCHAR(100),
    FOREIGN KEY(name) REFERENCES namePrice(name),
    FOREIGN KEY(month) REFERENCES monthDiscount(month)
);

-- 4.
INSERT INTO namePrice
SELECT DISTINCT name, Price
FROM Sales

SELECT COUNT(*) 
FROM namePrice
-- 36 rows

INSERT INTO monthDiscount
SELECT DISTINCT month, discount 
FROM Sales

SELECT COUNT(*) 
FROM monthDiscount
-- 12 rows

INSERT INTO monthName
SELECT DISTINCT month, name
FROM Sales

SELECT COUNT(*) 
FROM monthName
-- 426 rows

-- 426 rows (BCNF lossless decomposition)
SELECT A.name, A.price, B.month, B.discount
FROM namePrice A, monthDiscount B, monthName C
WHERE B.discount = B.discount
    AND A.price != A.price