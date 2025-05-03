USE RetailDynamicsDB;

SELECT
	ProductReviewID,
	ProductID,
	Views,
	Click,
	Likes,
	((CAST(Click AS FLOAT) / Views) * 100) AS CTR, -- TASA DE CLICK
	((CAST(Likes AS FLOAT) / Views) * 100) AS VTL, -- TASA DE CONVERSIÓN DE VISTAS A LIKES
	((CAST(Click AS FLOAT) / NULLIF(Likes, 0)) * 100) AS CTL, -- TASA DE CLICKS POR LIKES
	((CAST(Likes AS FLOAT) / NULLIF(Click, 0)) * 100) AS LTC,  -- TASA DE LIKES POR CLICK
	ReviewDate
FROM ProductReviews;
-- SE UTILIZA CAST PARA CONVERTIR LA COLUMNA EN OTRO TIPO DE DATO

/*
CTR (Tasa de Clics): Como ya habíamos discutido, esta métrica te indica el porcentaje de 
veces que se hizo clic en un producto después de ser visto. Un valor más alto sugiere 
que la presentación del producto es atractiva para los usuarios.

LTR (Tasa de Likes por Vista): Esta métrica calcula el porcentaje de veces que un producto 
recibió un "me gusta" después de ser visto. Un valor alto indica que el producto genera una 
reacción positiva entre quienes lo visualizan.

CTL (Tasa de Clicks por Like): Esta métrica muestra el número de clics que recibe un producto 
por cada "me gusta". Un valor más alto podría sugerir que las personas que interactúan 
inicialmente con el producto (a través de un clic) son menos propensas a dejar un "me gusta", o viceversa. 
Es una métrica menos común pero podría revelar patrones interesantes en la interacción.

*/


SELECT SUM(Click) AS Clicks FROM ProductReviews

