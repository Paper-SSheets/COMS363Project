/* Q10 */
/* 
	Find the list of distinct hashtags that appeared in one of 
	the states in a given list in a given month of a given year;
	show the list of the hashtags and the names of the states in 
	which they appeared.
	
	Input: list of states, (e.g., [Ohio, Alaska, Alabama]), month, year
	
	Rationale: This is to find common interests among the users in the states of interest.
	
	• The value of k is between 1 and 100.
*/
SET @states = 'Ohio, Alaska, Alabama'; 

SET @month = '1'; 

SET @year = '2016'; 

SELECT h.hname                                           AS hashtag_text, 
       Group_concat(DISTINCT u.state_name SEPARATOR ',') AS states 
FROM   hashtag h 
       INNER JOIN tagged tag 
               ON tag.hashtag = h.hname 
       INNER JOIN tweet t 
               ON t.tid = tag.tid 
       INNER JOIN user u 
               ON u.screen_name = t.uscreen_name 
WHERE  Find_in_set(u.state_name, @states) 
       AND Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @year 
       AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @month 
GROUP  BY h.hname; 
