/* Q18 */
/* 
	Find k users who were mentioned the most in tweets of users of a
	given party in a given month of a given year. Show the user’s screen 
	name, user’s state, and the list of the screen name of the user(s) 
	who mentioned this user in descending order of the number of tweets
	mentioning this user.
	
	Input: Values of k, sub-category (e.g., 'GOP'), month, year
	
	• The value of k is between 1 and 100.
*/
SET @subcategory = 'GOP'; 

SET @month = '1'; 

SET @year = '2016'; 

SELECT mentU.screen_name                                    AS mentionedUser, 
       mentU.state_name                                     AS 
       mentionedUserState, 
       Group_concat(DISTINCT t.uscreen_name SEPARATOR ', ') AS postingUsers 
FROM   tweet t 
       INNER JOIN mentioned AS ment 
               ON ment.tid = t.tid 
       INNER JOIN user AS ownU 
               ON ownU.screen_name = t.uscreen_name 
       INNER JOIN user AS mentU 
               ON mentU.screen_name = ment.uscreen_name 
WHERE  ownU.sub_category = @subcategory 
       AND Year(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @year 
       AND Month(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @month 
GROUP  BY mentU.screen_name 
ORDER  BY Count(ment.uscreen_name) DESC 
LIMIT  5; 