Q1] Top 5 customers by total purchase amount:

SELECT
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS Customer_Name,
    SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY total_spent DESC
LIMIT 5;

-- Output:
-- Customerid  | Customer_Name        | total_spent
-- -------------------------------------------------
--  6          | Helena Holy          | 49.62
-- 26          | Richard Cunningham   | 47.62
-- 57          | Luis Rojas           | 46.62
-- 45          | Ladislav Kovacs      | 45.62
-- 46          | Hugh  O'Reilly       | 45.62


Q2] Find Most popular genre by total tracks sold:


SELECT
    g.name AS genre,
    COUNT(il.trackid) AS tracks_sold
FROM InvoiceLine il
JOIN Track t ON il.trackid = t.trackid
JOIN Genre g ON t.genreid = g.genreid
GROUP BY g.genreid
ORDER BY tracks_sold DESC
LIMIT 1;

-- Output:
-- genre       | tracks_sold
-- --------------------------
-- Rock        | 835


Q3] Retrieve all employees who are managers along with their subordinates.


SELECT
    m.FirstName || ' ' || m.LastName AS manager_name,
    e.FirstName || ' ' || e.LastName AS employee_name
FROM Employee e
JOIN Employee m ON e.reportsto = m.employeeid;


-- Output:
-- manager_name       | employee_name
-- -------------------------------------
-- Andrew Adams       | Nancy Edwards
-- Nancy Edwards      | Jane Peacock
-- Nancy Edwards      | Margaret Park
-- Nancy Edwards      | Steve Johnson
-- Andrew Adams       | Michael Mitchell


Q4] For each artist, find their most sold album. 

WITH album_sales AS (
    SELECT
        ar.artistid,
        ar.name AS artist,
        al.albumid,
        al.title AS album,
        COUNT(ii.invoiceid) AS total_sold
    FROM InvoiceLine ii
    JOIN Track t ON ii.trackid = t.trackid
    JOIN Album al ON t.albumid = al.albumid
    JOIN Artist ar ON al.artistid = ar.artistid
    GROUP BY ar.artistid, al.albumid
)
SELECT artist, album, MAX(total_sold) AS total_sold
FROM album_sales
GROUP BY artist;

-- Output:
-- artist              | album                                   | total_sold
-- ---------------------------------------------------------------------------
-- AC/DC               | For those About to Rock We Salute You   | 10
-- Aerosmith           | Big Ones                                | 10
-- Alanis Morissette   | Jagged Little Pill                      | 8
-- Accept              | Restless and Wild                       | 3
-- BackBeat            | Backbeat Soundtrack                     | 6
-- Billy Cobham        | The Best of Billy Cobham                | 4


Q5] Write a query to get monthly sales trends in the year 2013.

SELECT
    STRFTIME('%Y-%m', invoicedate) AS month,
    SUM(total) AS monthly_sales
FROM Invoice
WHERE STRFTIME('%Y', invoicedate) = '2013'
GROUP BY month
ORDER BY month;

-- Output:
-- month     | monthly_sales
-- ---------------------------
-- 2013-01   | 37.62
-- 2013-02   | 27.72
-- 2013-03   | 37.62
-- 2013-04   | 33.66
-- 2013-05   | 37.62
-- 2013-06   | 37.62


