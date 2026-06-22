1.	Выведите сколько пользователей добавили книгу 'Coraline', сколько пользователей прослушало больше 10%. 
SELECT 
    COUNT(DISTINCT ac.user_id) AS users_added,
    COUNT(DISTINCT l.user_id) AS users_listened_10_percent
FROM audiobooks a
LEFT JOIN audio_cards ac 
    ON a.uuid = ac.audiobook_uuid
LEFT JOIN listenings l 
    ON a.uuid = l.audiobook_uuid
    AND (l.position_to - l.position_from) > a.duration * 0.1
WHERE a.title = 'Coraline';


2.	По каждой операционной системе и названию книги выведите количество пользователей, 
сумму прослушивания в часах, не учитывая тестовые прослушивания. 
SELECT  l.os_name, 
		a.title, 
		count(l.user_id) as count_of_users, 
		sum(l.position_to - l.position_from)/3600 as sum_of_listning
FROM listenings l 
JOIN audiobooks a
	ON l.audiobook_uuid=a.uuid
WHERE l.is_test = 0
GROUP BY  l.os_name , a.title
ORDER BY   l.os_name , a.title;

3.	Найдите книгу, которую слушает больше всего людей. 
SELECT 
    a.title,
    COUNT(DISTINCT l.user_id) AS listeners_count
FROM listenings l
JOIN audiobooks a 
  ON l.audiobook_uuid = a.uuid
GROUP BY l.audiobook_uuid, a.title
ORDER BY listeners_count DESC
LIMIT 1;

4.	Найдите книгу, которую чаще всего дослушивают до конца.

SELECT 
    a.title, count(ac.user_id) as finished_count
FROM audiobooks a 
JOIN audio_cards ac 
ON ac.audiobook_uuid = a.uuid
WHERE ac.state = 'finished'
GROUP BY a.title, ac.audiobook_uuid
ORDER BY finished_count DESC
LIMIT 1


