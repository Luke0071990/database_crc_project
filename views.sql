 --Widok 1 zamówień z wartością zamówienia:
 /*
CREATE OR REPLACE VIEW order_total_value AS
SELECT o.order_id, o.customer_id, o.order_date, NVL(o.order_value, 0) AS order_value,
       c.first_name, c.last_name, c.company_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
;
*/
-- 1
/*
SELECT o.order_id, o.customer_id, o.order_date, o.order_value
FROM order_total_value o
GROUP BY o.order_id, o.customer_id, o.order_date, o.order_value
ORDER BY o.order_value DESC;
*/

--########################################################################

/* -- Widok 2 pracowników z informacjami o departamentach:
CREATE VIEW employees_departments AS
SELECT e.employee_id, e.first_name, e.last_name, e.department_id,
       d.department_name, d.salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
*/

--2
/*
Select * FROM employees_departments;
*/

--########################################################################

-- Widok 3 ranking top wydawców
/*
CREATE VIEW top_publishing_houses AS
SELECT p.name_of_the_publisher, count(p.name_of_the_publisher) as number_of_books
FROM publishings p 
JOIN publishing_house_books hb ON p.publishing_id=hb.publishing_id
GROUP BY p.name_of_the_publisher;
/
SELECT * FROM top_publishing_houses
ORDER BY number_of_books DESC;
*/

--########################################################################

/* Widok 4 autorów i książek:
CREATE VIEW authors_books AS
SELECT a.author_id, a.first_name, a.last_name, b.product_id
FROM authors a
JOIN book_authors ba ON a.author_id = ba.author_id
JOIN products b ON ba.product_id = b.product_id;
/
SELECT * FROM authors_books;
*/
--4
/*
Select * FROM authors_books;
*/

--########################################################################

/* -- Widok 5 Top 5 najlepszych klientów
--CREATE MATERIALIZED VIEW LOG ON orders;
CREATE MATERIALIZED VIEW mv_customer_order_total
BUILD IMMEDIATE
REFRESH COMPLETE ON COMMIT
AS
SELECT c.first_name, c.last_name, c.customer_id, SUM(o.order_value) AS total_order_value
FROM orders o 
JOIN customers c on c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id;

*/

-- 5 
/*
SELECT first_name, last_name, customer_id, total_order_value
FROM (
    SELECT first_name, last_name, customer_id, total_order_value, RANK() OVER (ORDER BY total_order_value DESC) AS rank
    FROM mv_customer_order_total 
) 
WHERE rank <= 5;
*/

--########################################################################

/* -- Widok 6 Pokaż wszystkich klientów którzy nie dokonali żadnego zakupu.
-- INSERT INTO customers(first_name, last_name, city, postal_code, adress_street, adress_number, phone, e_mail, nip, company_name ) VALUES ('Michał', 'Mazur', 'Szczecin', 49462, 'Lipowa', '763', 383151691, 'mazur@gmail.com', Null, '');

CREATE VIEW show_unactive_customers AS
SELECT first_name, last_name, customer_id
FROM Customers
WHERE Customer_ID NOT IN (SELECT DISTINCT Customer_ID FROM Orders);

select * from show_unactive_customers
*/

--########################################################################

/*
-- Widok 7 Pokaż 10 najlepiej sprzedajacych się razem par produktów
CREATE OR REPLACE VIEW kupowane_pary AS 
WITH produkty_zamowienia AS (
  SELECT product_name, order_id
  FROM Products p JOIN Order_Details od ON p.Product_ID = od.Product_ID
)
SELECT t1.product_name AS product_name1, t2.product_name AS product_name2, COUNT(*) AS liczba_zamowien
FROM produkty_zamowienia t1 
JOIN produkty_zamowienia t2 ON t1.Order_ID = t2.order_id AND t1.Product_Name < t2.Product_Name
GROUP BY t1.product_name, t2.product_name
ORDER BY liczba_zamowien DESC
FETCH FIRST 10 ROWS ONLY;
/

select * from kupowane_pary;

*/

--########################################################################

/* -- Widok 8 Pokaż sprzedaż poszczególnych ksiazek uwzględniajac miesiac.
CREATE VIEW units_sold_per_month AS
SELECT
    p.product_name,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 1 THEN 1 ELSE 0 END) AS january,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 2 THEN 1 ELSE 0 END) AS february,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 3 THEN 1 ELSE 0 END) AS march,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 4 THEN 1 ELSE 0 END) AS april,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 5 THEN 1 ELSE 0 END) AS may,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 6 THEN 1 ELSE 0 END) AS june
FROM
    products p
JOIN
    order_details od ON p.product_id = od.product_id
JOIN 
    orders o on o.order_id = od.order_id
GROUP BY
    p.product_name
;

SELECT * FROM units_sold_per_month
ORDER BY product_name;
*/

--########################################################################

/*-- Widok 9 Pokaż różnice w wartości miesięcznej sprzedaży.
CREATE OR REPLACE VIEW difference_in_monthly_sales AS
SELECT
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(od.quantity * p.price_per_unit) AS sales,
    LAG(SUM(od.quantity * p.price_per_unit), 1, 0) OVER (ORDER BY EXTRACT(MONTH FROM o.order_date)) AS previous_month,
    SUM(od.quantity * p.price_per_unit) - LAG(SUM(od.quantity * p.price_per_unit), 1, 0) OVER (ORDER BY EXTRACT(MONTH FROM o.order_date)) AS difference
    
FROM
    orders o
JOIN
    order_details od ON o.order_id = od.order_id
JOIN
    products p ON p.product_id = od.product_id
GROUP BY
    EXTRACT(MONTH FROM o.order_date);
    /
SELECT * FROM difference_in_monthly_sales;
*/



--########################################################################
--Widok 10 Ranking miast wydajacych najwiecej na ksiazki.
/*
CREATE OR REPLACE VIEW top_cities AS
SELECT c.city, SUM(o.order_value) AS total_order_value, SUM(od.quantity) AS total_quantity
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN (
  SELECT order_id, SUM(quantity) AS quantity
  FROM order_details
  GROUP BY order_id
) od ON od.order_id = o.order_id
GROUP BY c.city;
/
SELECT * FROM top_cities
ORDER BY total_order_value DESC;
*/

--########################################################################

/* -- Widok 11 Najlepiej sprzedajace sie ksiazki w miastach.
CREATE VIEW best_selling_books_in_cities AS
SELECT p.product_name, c.city, SUM(od.quantity) AS total_quantity
FROM products p
JOIN order_details od ON od.product_id = p.product_id
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY p.product_name, c.city
HAVING SUM(od.quantity) = (
    SELECT MAX(total_quantity)
    FROM (
        SELECT p.product_name, c.city, SUM(od.quantity) AS total_quantity
        FROM products p
        JOIN order_details od ON od.product_id = p.product_id
        JOIN orders o ON o.order_id = od.order_id
        JOIN customers c ON c.customer_id = o.customer_id
        GROUP BY p.product_name, c.city
    ) subquery
    WHERE subquery.product_name = p.product_name
);

SELECT * FROM best_selling_books_in_cities
ORDER BY product_name;
*/

--########################################################################

/* -- Widok 12 Informacje o ksiązkach
CREATE VIEW book_information AS
SELECT p.product_name, a.first_name||' ' ||a.last_name as author, pu.name_of_the_publisher, p.number_of_pages, p.price_per_unit
FROM publishings pu 
JOIN publishing_house_books hb ON pu.publishing_id=hb.publishing_id
JOIN products p on p.product_id = hb.product_id
JOIN book_authors ba on ba.product_id=p.product_id
JOIN authors a on a.author_id = ba.author_id
/

SELECT * FROM book_information;
*/
