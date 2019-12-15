/* Q3 */ 
/* 
	Find k hashtags that appeared in the most number of states in a given year; 
	list the total number of states the hashtag appeared, the list of the distinct 
	states it appeared (FL is the same as Florida*), and the hashtag itself in
	descending order of the number of states the hashtag appeared.
	
	Input: Value of k and year (e.g., 2016)
	
	Rationale: This query finds k hashtags that are used across the
			   most number of states, which could indicate a certain
			   agenda (e.g., education, healthcare) that is widely discussed.
			   
	Hint: Use group_concat() function to create a list
	
	• This requires making sure that each state is  
	  represented using one name, either FL or Florida
	
	• The value of k is between 1 and 100.
*/
SET @year = '2016'; /* User input here */

SELECT Count(DISTINCT u.state_name)                       AS statenum, 
       Group_concat(DISTINCT u.state_name SEPARATOR ', ') AS states, 
       h.hname                                            AS hashtag_text 
FROM   hashtag h 
       INNER JOIN tagged tag 
               ON tag.hashtag = h.hname 
       INNER JOIN tweet t 
               ON t.tid = tag.tid 
       INNER JOIN user u 
               ON u.screen_name = t.uscreen_name 
WHERE  u.state_name != "na" 
       AND Year(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @year 
GROUP  BY h.hname 
ORDER  BY statenum DESC 
LIMIT  5;  /* User input here */
