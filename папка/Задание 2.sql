CREATE DATABASE miniproject;
USE miniproject;

CREATE TABLE T_TAB1 (
ID INT UNIQUE, 
GOODS_TYPE VARCHAR(50) NOT NULL,
QUANTITY INT, 
AMOUNT INT, 
SELLER_NAME VARCHAR(50) NOT NULL
);

SELECT * FROM T_TAB1;

INSERT INTO T_TAB1 values (1,	'MOBILE PHONE',	2,	400000, 'MIKE');
INSERT INTO T_TAB1 values (2,	'KEYBOARD',	1,	10000,	'MIKE');
INSERT INTO T_TAB1 values (3,	'MOBILE PHONE',	1,	50000,	'JANE');
INSERT INTO T_TAB1 values (4,	'MONITOR',	1,	110000,	'JOE');
INSERT INTO T_TAB1 values (5,	'MONITOR',	2,	80000,	'JANE');
INSERT INTO T_TAB1 values (6,	'MOBILE PHONE',	1,	130000,	'JOE');
INSERT INTO T_TAB1 values (7,	'MOBILE PHONE',	1,	60000,	'ANNA');
INSERT INTO T_TAB1 values (8,	'PRINTER',	1,	90000,	'ANNA');
INSERT INTO T_TAB1 values (9,	'KEYBOARD',	2,	10000,	'ANNA');
INSERT INTO T_TAB1 values (10,	'PRINTER',	1,	80000,	'MIKE');


CREATE TABLE T_TAB2 (
ID INT UNIQUE, 
NAME  VARCHAR(50) NOT NULL,
SALARY  INT, 
AGE  INT
);

SELECT * FROM T_TAB2;

INSERT INTO T_TAB2 values (1,	'ANNA',	110000,	27);
INSERT INTO T_TAB2 values (2,	'JANE',	80000,	25);
INSERT INTO T_TAB2 values (3,	'MIKE',	120000,	25);
INSERT INTO T_TAB2 values (4,	'JOE',	70000,	24);
INSERT INTO T_TAB2 values (5,	'RITA',	120000,	29);

/*Подсказка: T_TAB1.SELLER_NAME = T_TAB2.NAME
После создания базы данных и таблиц, выполните следующие задания:
*/

#1.	Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). Какое количество уникальных категорий товаров вернёт запрос?
#запрос вернул 4 значения уникальных товара
SELECT DISTINCT
    GOODS_TYPE
FROM
    t_tab1;

#2.	Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?
#запрос вернул 5	640000
SELECT 
    SUM(QUANTITY) AS Count, SUM(AMOUNT) AS Revenue
FROM
    t_tab1
WHERE
    GOODS_TYPE = 'MOBILE PHONE';

#3.	Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?
#запрос вернул 3 сотрудника
SELECT 
    name
FROM
    t_tab2
WHERE
    salary > 100000;

#4.	Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.
SELECT 
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    MIN(salary) AS min_salary,
    MAX(salary) AS min_salary
FROM
    t_tab2;
    
#5.	Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
SELECT 
    GOODS_TYPE, ROUND(AVG(QUANTITY), 2) AS Avg_count
FROM
    t_tab1
WHERE
    GOODS_TYPE IN ('KEYBOARD' , 'PRINTER')
GROUP BY GOODS_TYPE;

#6.	Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
#
SELECT 
   t_tab2.NAME, SUM(t_tab1.AMOUNT) as amount_sum
FROM
    t_tab1
        JOIN
    t_tab2 ON t_tab1.SELLER_NAME = t_tab2.NAME
GROUP BY t_tab2.NAME;
    

#7.	Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.
# Майк продал три типа товаров
SELECT 
    t_tab2.NAME,
    t_tab1.GOODS_TYPE,
    t_tab1.QUANTITY,
    t_tab1.AMOUNT,
    t_tab2.salary,
    t_tab2.age
FROM
    t_tab1
        JOIN
    t_tab2 ON t_tab1.SELLER_NAME = t_tab2.NAME
    where  t_tab2.NAME='MIKE';

#8.	Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?
# такой продавец один, это Рита
SELECT 
    t_tab2.NAME, t_tab2.age
FROM
    t_tab2
        LEFT JOIN
    t_tab1 ON T_TAB2.NAME = t_tab1.SELLER_NAME
WHERE
    t_tab1.SELLER_NAME IS NULL;
    
#9.	Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос?
# запрос вернул три значения
SELECT 
    t_tab2.NAME, t_tab2.salary
FROM
    t_tab2
WHERE
    t_tab2.age < 26;


#10.	Сколько строк вернёт следующий запрос:
# запрос вернул пустое значениеб так как продавец Рита не делала продаж, данных по ней нет в первой таблице
SELECT 
    *
FROM
    T_TAB1 t
        JOIN
    T_TAB2 t2 ON t2.name = t.seller_name
WHERE
    t2.name = 'RITA';

