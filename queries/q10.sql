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
SELECT hname, 
       Group_concat(DISTINCT ofstate) AS all_the_states 
FROM   hashtag
       INNER JOIN tweet 
               ON tweet_hashtag.tid = tweet.tid 
       INNER JOIN USER 
               ON tweet.screen_name = USER.screen_name 
WHERE  Find_in_set(ofstate, 'FL') != 0 /* User input here */
       AND Year(tweet.posted) = 2016 /* User input here */
       AND Month(tweet.posted) = 01 /* User input here */
GROUP  BY hashtagname; 

/* 	Fix.
	SELECT hashtagname, 
		   Group_concat(DISTINCT ofstate) AS all_the_states 
	FROM   tweet_hashtag 
		   INNER JOIN tweet 
				   ON tweet_hashtag.tid = tweet.tid 
		   INNER JOIN USER 
				   ON tweet.screen_name = USER.screen_name 
	WHERE  Find_in_set(ofstate, ?) != 0 
		   AND Year(tweet.posted) = ? 
		   AND Month(tweet.posted) = ? 
	GROUP  BY hashtagname; 
*/