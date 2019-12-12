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
SELECT hname, 
       Count(DISTINCT ofstate)        AS number_of_states, 
       Group_concat(DISTINCT ofstate) AS states_list 
FROM   hashtag 
       INNER JOIN tweet 
               ON hashtag.tid = tweet.tid 
       INNER JOIN user 
               ON tweet.screen_name = user.screen_name 
WHERE  Year(tweet.posted) = 2016
GROUP  BY hname 
ORDER  BY number_of_states DESC 
LIMIT  10; 