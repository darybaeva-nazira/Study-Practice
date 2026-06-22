/*Задание №1
Создайте в MySQL новую базу данных miniproject1. После этого создайте в ней таблицу users 
(данные загружаем из файла Users_db.sql). 
После создания базы данных и таблицы, выполните следующие задания:
*/

#1.	Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15. 

SELECT 
    COUNT(DISTINCT user_id) AS count
FROM
    users
WHERE
    date BETWEEN '2023-11-07' AND '2023-11-15';
# реультат 3199

#2.	Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 

SELECT 
    user_id
FROM
    users
GROUP BY user_id
ORDER BY SUM(view_adverts) DESC
LIMIT 1; 


#3.	Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.
SELECT 
    date
FROM
    users
GROUP BY date
HAVING COUNT(DISTINCT user_id) > 500
ORDER BY SUM(view_adverts) / COUNT(DISTINCT user_id) DESC
LIMIT 1;

#4.	Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.
#  продолжительность присутствия пользователя на сайте рассчмотрела как время его суммарных просмотров
SELECT 
    user_id, SUM(view_adverts) AS LT
FROM
    users
GROUP BY user_id
ORDER BY LT DESC;

#5.	Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните,
# у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.
SELECT 
    user_id, AVG(daily_views) AS avg_views
FROM
    (SELECT 
        user_id, date, SUM(view_adverts) AS daily_views
    FROM
        users
    GROUP BY user_id , date) t
GROUP BY user_id
HAVING COUNT(*) >= 5
ORDER BY avg_views DESC
LIMIT 1;

/*SELECT 
    user_id, date, count(view_adverts) AS dayly_view
FROM
    users
GROUP BY user_id, date
HAVING COUNT(DISTINCT date) >= 5
ORDER BY user_id, date;
*/
/*SELECT 
    user_id,
    date,
    SUM(view_adverts) AS daily_views
FROM users
GROUP BY user_id, date;*/



