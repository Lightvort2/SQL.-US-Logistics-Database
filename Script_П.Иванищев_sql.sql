USE ummc;

/* Готовим запрос, который выбирает клиентов с типом “manufacturer” из городов с кодами 266 и 602. 
Интересует название клиента, его адрес, телефон и выручка. Результат отсортируем по коду города и в 
порядке убывания выручки по клиенту в этом городе.*/

SELECT 
	cust_name AS 'Название клиента, тип - manufacturer',
	address AS 'Адрес',
	phone AS 'Телефон',
	annual_revenue AS 'Выручка',
	city_id AS 'Код города'
	FROM sql_customer
		WHERE cust_type = 'manufacturer' AND city_id IN (266, 602)
	ORDER BY city_id, annual_revenue DESC
;

/* Задание 2.1. У кого из клиентов в городе с кодом 266 лучшая выручка*/

SELECT
	cust_name AS 'Название клиента',
	annual_revenue AS 'Лучшая выручка в городе 266'
	FROM sql_customer
		WHERE city_id = '266'
	ORDER BY annual_revenue DESC
	LIMIT 1
;

/* Отвечаем на вопрос, сколько клиентов каждого типа есть у транспортной компании. 
Отсортируйем результат в порядке возрастания численности клиентов по типам */

SELECT 
	cust_type,	
	count(cust_id) AS number_of_customers
	FROM sql_customer
	GROUP BY cust_type
	ORDER BY Number_of_customers DESC	
;

/* Отвечаем на вопрос, какую доставку выполнил какой водитель, на каком грузовике он ее 
выполнил и какому клиенту доставлял */

SELECT 
	ship_date AS 'Дата доставки',
	cust_name AS 'Название клиента',
	city_name AS 'Город, где находится клиент',
	concat(first_name, ' ', last_name) AS 'Имя и фамилия водителя',
	make AS 'Марка грузовика'
	FROM sql_shipment sh
		LEFT JOIN sql_customer cus ON sh.cust_id = cus.cust_id 
		LEFT JOIN sql_city cit ON sh.city_id  = cit.city_id 
		LEFT JOIN sql_driver dr ON sh.driver_id  = dr.driver_id 
		LEFT JOIN sql_truck tr ON sh.truck_id = tr.truck_id 
;

/* Выводим все значения атрибутов по всем поставкам. 
Это представление должно включать в себя в денормализованной форме все данные по поставке из БД.
Одна строка – одна поставка. ...  Только фактические значения */

DROP VIEW IF EXISTS denorm_shipment;
CREATE VIEW denorm_shipment AS
	SELECT
		ship_date AS 'Дата доставки',
		cust_name AS 'Название клиента',
		annual_revenue AS 'Выручка',
		cust_type AS 'Тип клиента',
		concat(cus.address, ' ', zip) AS 'Адрес клиента с zip-кодом',
		cus.phone AS 'Телефон клиента',
		city_name AS 'Город, где находится клиент',
		concat(first_name, ' ', last_name) AS 'Имя и фамилия водителя',
		concat(dr.address, ' ', zip_code) AS 'Адрес водителя с zip-кодом',
		dr.phone AS 'Телефон водителя',
		make AS 'Марка грузовика',
		model_year AS 'Год выпуска грузовика'
		FROM sql_shipment sh
			LEFT JOIN sql_customer cus ON sh.cust_id = cus.cust_id 
			LEFT JOIN sql_city cit ON sh.city_id  = cit.city_id 
			LEFT JOIN sql_driver dr ON sh.driver_id  = dr.driver_id 
			LEFT JOIN sql_truck tr ON sh.truck_id = tr.truck_id 
		ORDER BY ship_date ASC 
;

SELECT * FROM denorm_shipment;