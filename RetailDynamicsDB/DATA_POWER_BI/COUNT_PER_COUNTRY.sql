USE RetailDynamicsDB;

SELECT * FROM Customers
ORDER BY Country;

SELECT c.Country, COUNT(c.Country)  AS CountPerCountry FROM Customers c
GROUP BY c.Country
 