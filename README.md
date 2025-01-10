# CRM_project

Proyecto para Sistema de gestión de las relaciones con los clientes (CRM)

Mi objetivo es identificar entidades como clientes, clientes potenciales, contactos y oportunidades
Crear un esquema relacional con SQL, estableciendo las relaciones adecuadas

Link del dataset 💡: https://www.kaggle.com/datasets/innocentmfa/crm-sales-opportunities

Para eso sigo estos ejercicios para ponerme a prueba:
* 1. Oportunidades abiertas por etapa de venta. Calcula cuántas oportunidades se encuentran en cada etapa del trato (deal_stage). Incluye únicamente aquellas cuya fecha de cierre (close_date) es a partir de mayo del 2017.
* 2. Duración promedio del ciclo de ventas por producto. Calcula el tiempo promedio entre la fecha de inicio de contacto (engage_date) y la fecha de cierre (close_date) para cada producto.
* 3. Volumen de ingresos por agente de ventas. Calcula el total de ingresos (close_value) que cada agente de ventas (sales_agent) ha generado. Ordena el resultado de mayor a menor.
* 4. Cuentas por sector. Obtén el número total de cuentas en cada sector (sector). Incluye únicamente aquellas cuentas que tienen ingresos (revenue) mayores a $15000.
* 5. Agentes y sus oficinas regionales. Lista los nombres de todos los agentes de ventas (sales_agent) junto con la oficina regional (regional_office) a la que pertenecen.
* 6. Top 5 productos más vendidos. Identifica los 5 productos con mayor cantidad de oportunidades cerradas (deal_stage = 'Closed Won'). Muestra el nombre del producto y el total de oportunidades ganadas.
* 7. Relación entre cuentas y subsidiarias. Encuentra todas las cuentas (account) que son subsidiarias de otra cuenta (subsidiary_of). Muestra el nombre de la cuenta principal y su subsidiaria.
* 8. Participación de mercado por sector. Calcula el porcentaje del total de ingresos (revenue) generado por cada sector (sector).
* 9. Oportunidades ganadas por fecha de cierre. Calcula cuántas oportunidades han sido cerradas como ganadas (deal_stage = 'Closed Won') para cada mes del 2017.
* 10. Información faltante en cuentas. Identifica todas las cuentas que no tienen un valor especificado en la columna sector o office_location.
* 11. Precio promedio por serie de productos. Enunciado: Calcula el precio promedio (sales_price) para cada serie de productos (series).
* 12. Distribución de agentes por gerente. Lista cuántos agentes de ventas (sales_agent) están asignados a cada gerente (manager).
* 13. Oportunidades más largas. Encuentra las 10 oportunidades con la mayor duración (diferencia entre engage_date y close_date). Muestra el ID de la oportunidad, el agente y la duración en días. 
* 14. Validación de ingresos en cuentas. Identifica todas las cuentas cuyo ingreso (revenue) tiene un formato incorrecto, por ejemplo, aquellas que contienen texto o caracteres especiales.
* 15. Productos más caros. Encuentra los 3 productos con el precio de venta (sales_price) más alto. Incluye el nombre del producto y la serie.
* 16. Oportunidades perdidas por producto. Calcula el total de oportunidades perdidas (deal_stage = 'Lost') para cada producto.
* 17. Ingresos por región. Calcula el ingreso total (close_value) generado por cada oficina regional (regional_office).
* 18. Agentes sin oportunidades ganadas. Lista los nombres de los agentes de ventas que no tienen ninguna oportunidad cerrada como ganada.
* 19. Historico de oportunidades por año. Calcula el número total de oportunidades abiertas y cerradas (deal_stage) en cada mes, según la fecha de cierre (close_date).
* 20. Consistencia del diccionario de datos. Valida que cada campo (Field) en el diccionario de datos (Diccionario_datos) esté presente en las tablas correspondientes.Reporta aquellos campos que no tienen una correspondencia.

