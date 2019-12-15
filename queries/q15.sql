/* Q15 */
/* 
	Find users in a given sub-category along with the list of URLs used
	in the user’s tweets in a given month of a given year. Show the 
	user’s screen name, the state the user lives, and the list of URLs.
	
	Input: Values of a sub-category (e.g., 'GOP'), month, year.
	
	Rationale: This query finds URLs shared by a party.
	
	• The value of k is between 1 and 100.
*/
SET @subcategory = 'GOP'; /* User input here */

SET @month = '1'; /* User input here */

SET @year = '2016'; /* User input here */

SELECT u.screen_name, 
       u.state_name, 
       Group_concat(url.address SEPARATOR ', ') AS URLs 
FROM   user u 
       INNER JOIN tweet t 
               ON t.uscreen_name = u.screen_name 
       INNER JOIN url_used 
               ON url_used.tid = t.tid 
       INNER JOIN url 
               ON url.address = url_used.url 
WHERE  u.sub_category = @subcategory 
       AND Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @year 
       AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @month 
GROUP  BY u.screen_name 
LIMIT  100; /* User input here */
