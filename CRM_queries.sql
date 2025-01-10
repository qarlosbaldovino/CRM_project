-- Cada uno de estos ejercicios está orientado a la creación de: 
-- tablas, relaciones y consultas para gestionar clientes, prospectos, contactos y oportunidades, que son los componentes clave de un sistema CRM (Customer Relationship Management)

SELECT * FROM CRM_Project..canal_ventas
SELECT * FROM CRM_Project..cuentas
SELECT * FROM CRM_Project..diccionario_datos
SELECT * FROM CRM_Project..equipos_ventas
SELECT * FROM CRM_Project..productos

-- Ejercicios

-- 1. Oportunidades abiertas por etapa de venta
-- Calcula cuántas oportunidades se encuentran en cada etapa del trato (deal_stage). 
-- Incluye únicamente aquellas cuya fecha de cierre (close_date) es a partir de mayo del 2017.

SELECT 
	deal_stage,
	COUNT(*) opportunity_count
FROM
	CRM_Project..canal_ventas
WHERE
	close_date >= '2017-05-01'
GROUP BY
	deal_stage
ORDER BY
	opportunity_count DESC


-- 2. Duración promedio del ciclo de ventas por producto
-- Calcula el tiempo promedio entre la fecha de inicio de contacto (engage_date) y la fecha de cierre (close_date) para cada producto.

SELECT 
    product,
    AVG(DATEDIFF(DAY, engage_date, close_date)) AS avg_sales_cycle_days -- Calcula la duración promedio en días
FROM 
    CRM_Project..canal_ventas
WHERE 
    engage_date IS NOT NULL AND close_date IS NOT NULL -- Asegurarse de que ambas fechas existan
GROUP BY
    product
ORDER BY
    avg_sales_cycle_days DESC;


-- 3. Volumen de ingresos por agente de ventas
-- Calcula el total de ingresos (close_value) que cada agente de ventas (sales_agent) ha generado. Ordena el resultado de mayor a menor.
SELECT 
	sales_agent,
	SUM(close_value) as total_ingresos
FROM 
	CRM_Project..canal_ventas
WHERE
	close_value IS NOT NULL
GROUP BY
	sales_agent
ORDER BY
	total_ingresos DESC


-- 4. Cuentas por sector
-- Obtén el número total de cuentas en cada sector (sector). Incluye únicamente aquellas cuentas que tienen ingresos (revenue) mayores a $15000.
SELECT 
	sector,
	SUM(CAST(revenue as float)) as ganancias
FROM 
	CRM_Project..cuentas
GROUP BY
	sector
HAVING
	SUM(CAST(revenue as float)) >= 15000
ORDER BY
	ganancias DESC


-- 5. Agentes y sus oficinas regionales
-- Lista los nombres de todos los agentes de ventas (sales_agent) junto con la oficina regional (regional_office) a la que pertenecen.
SELECT 
	sales_agent, regional_office 
FROM 
	CRM_Project..equipos_ventas
ORDER BY
	regional_office DESC


-- 6. Top 5 productos más vendidos
-- Identifica los 5 productos con mayor cantidad de oportunidades cerradas (deal_stage = 'Closed Won'). 
-- Muestra el nombre del producto y el total de oportunidades ganadas.
SELECT TOP 5
	product,
	COUNT(deal_stage) as estado
FROM 
	CRM_Project..canal_ventas
WHERE	
	deal_stage = 'Won' 
GROUP BY
	product
ORDER BY
	estado DESC
	

-- 7. Relación entre cuentas y subsidiarias
-- Encuentra todas las cuentas (account) que son subsidiarias de otra cuenta (subsidiary_of). Muestra el nombre de la cuenta principal y su subsidiaria.

SELECT 
    sub.account AS subsidiaria,
    sub.sector AS sector_subsidiaria,
    main.account AS cuenta_principal,
    main.sector AS sector_principal
FROM 
    CRM_Project..cuentas sub
JOIN 
    CRM_Project..cuentas main
ON 
    sub.subsidiary_of = main.account -- Darle un sector a la cuenta subsidiaria tambien
WHERE
    sub.subsidiary_of IS NOT NULL;


-- 8. Participación de mercado por sector
-- Calcula el porcentaje del total de ingresos (revenue) generado por cada sector (sector).
WITH ventas_sector AS (
	SELECT 
		sector,
		SUM(CAST(revenue as float)) as revenue
	FROM 
		CRM_Project..cuentas
	GROUP BY
		sector
),
total_ventas AS (
SELECT
	SUM(CAST(revenue as float)) total
FROM	
	CRM_Project..cuentas
)
SELECT
	vs.sector,
	ROUND((vs.revenue * 1.0 / tv.total)*100,2) as porcentaje_ventas
FROM
	ventas_sector vs
CROSS JOIN
	total_ventas tv
ORDER BY
	porcentaje_ventas DESC


-- 9. Oportunidades ganadas por fecha de cierre
-- Calcula cuántas oportunidades han sido cerradas como ganadas (deal_stage = 'Closed Won') para cada mes del 2017.
SELECT 
    FORMAT(close_date, 'yyyy-MM') AS close_month, -- Formatea la fecha como Año-Mes
    COUNT(*) AS total_won_opportunities
FROM 
    CRM_Project..canal_ventas
WHERE 
    deal_stage = 'Won' -- Solo considera las oportunidades ganadas
    AND YEAR(close_date) = 2017 -- Filtra por el año 2017
GROUP BY 
    FORMAT(close_date, 'yyyy-MM') -- Agrupa por Año-Mes
ORDER BY 
    close_month;


-- 10. Información faltante en cuentas
-- Identifica todas las cuentas que no tienen un valor especificado en la columna sector o office_location.
SELECT 
	* 
FROM 
	CRM_Project..cuentas
WHERE 
	sector IS NULL 
	OR office_location IS NULL;


-- 11. Precio promedio por serie de productos
-- Enunciado: Calcula el precio promedio (sales_price) para cada serie de productos (series).
SELECT 
	series,
	AVG(ISNULL(sales_price, 0)) as Promedio_ventas
FROM 
	CRM_Project..productos
GROUP BY
	series
ORDER BY
	Promedio_ventas DESC;


-- 12. Distribución de agentes por gerente
-- Lista cuántos agentes de ventas (sales_agent) están asignados a cada gerente (manager).
SELECT 
	manager,
	COUNT(*) as asistentes_ventas
FROM 
	CRM_Project..equipos_ventas
GROUP BY
	manager

-- 13. Oportunidades más largas
-- Encuentra las 10 oportunidades con la mayor duración (diferencia entre engage_date y close_date). 
-- Muestra el ID de la oportunidad, el agente y la duración en días.
SELECT TOP 10
	opportunity_id,
	sales_agent,
	DATEDIFF(DAY, engage_date, close_date) AS duration_days
FROM 
	CRM_Project..canal_ventas
WHERE
    engage_date IS NOT NULL AND close_date IS NOT NULL
ORDER BY
	duration_days DESC


-- 14. Validación de ingresos en cuentas
-- Identifica todas las cuentas cuyo ingreso (revenue) tiene un formato incorrecto, por ejemplo, aquellas que contienen texto o caracteres especiales.
SELECT 
	account,
	revenue
FROM 
	CRM_Project..cuentas
WHERE
	TRY_CAST(revenue AS FLOAT) IS NULL


-- 15. Productos más caros
-- Encuentra los 3 productos con el precio de venta (sales_price) más alto. Incluye el nombre del producto y la serie.
SELECT TOP 3 
	product,
	series,
	sales_price
FROM 
	CRM_Project..productos
WHERE
    sales_price IS NOT NULL AND sales_price > 0
ORDER BY
	sales_price DESC


-- 16. Oportunidades perdidas por producto
-- Calcula el total de oportunidades perdidas (deal_stage = 'Lost') para cada producto.
SELECT 
	product,
	COUNT(*) as lost_opportunities
FROM 
	CRM_Project..canal_ventas
WHERE
	deal_stage = 'Lost'
GROUP BY
	product
ORDER BY
	lost_opportunities DESC


-- 17. Ingresos por región
-- Calcula el ingreso total (close_value) generado por cada oficina regional (regional_office).
SELECT 
	ev.regional_office,
	SUM(cv.close_value) as total_revenue
FROM 
	CRM_Project..canal_ventas cv
JOIN
	CRM_Project..equipos_ventas ev
ON
	cv.sales_agent = ev.sales_agent
GROUP BY
	ev.regional_office
ORDER BY
	total_revenue DESC


-- 18. Agentes sin oportunidades ganadas
-- Lista los nombres de los agentes de ventas que no tienen ninguna oportunidad cerrada como ganada.
SELECT DISTINCT
	sales_agent
FROM
	CRM_Project..canal_ventas
WHERE
	deal_stage != 'Won' AND deal_stage != 'Lost'


-- 19. Historico de oportunidades por año
-- Calcula el número total de oportunidades abiertas y cerradas (deal_stage) en cada mes, según la fecha de cierre (close_date).
SELECT
	MONTH(close_date) AS Month,
	COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) AS Won_Opportunities,
    COUNT(CASE WHEN deal_stage = 'Lost' THEN 1 END) AS Lost_Opportunities
FROM
	CRM_Project..canal_ventas
WHERE
	MONTH(close_date) is not null 
GROUP BY
	MONTH(close_date)
ORDER BY
	Month ASC

-- 20. Consistencia del diccionario de datos
-- Valida que cada campo (Field) en el diccionario de datos (Diccionario_datos) esté presente en las tablas correspondientes. 
--	Reporta aquellos campos que no tienen una correspondencia.


SELECT 
    dd.Field AS Campo,
    ic.COLUMN_NAME AS Columna_En_Existente
FROM 
	CRM_Project..diccionario_datos dd
LEFT JOIN	
	CRM_Project.INFORMATION_SCHEMA.COLUMNS ic
ON
	dd.Field = ic.COLUMN_NAME
WHERE
	ic.COLUMN_NAME IS NOT NULL
