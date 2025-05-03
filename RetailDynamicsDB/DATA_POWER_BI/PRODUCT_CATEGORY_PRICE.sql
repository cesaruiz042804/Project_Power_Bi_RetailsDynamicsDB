USE RetailDynamicsDB;

SELECT * FROM Products;


SELECT 
	ProductID, -- SELECCIONA LAS COLUMNAS QUE SE VAN A MOSTRAR
	ProductName,
	UnitPrice,
	CASE -- ESTE ES UN CASO QUE LO QUE HACE IDENTIFICAR EL PRECIO CATEGORIZANDOLO ENTRE BAJO, MEDIO O ALTO
		WHEN UnitPrice < 50 THEN 'Low'
		WHEN UnitPrice > 50 AND UnitPrice < 100 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory
FROM Products;
 