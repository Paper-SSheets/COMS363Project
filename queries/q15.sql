/* Q15 */
/* 
	Find users in a given sub-category along with the list of URLs used
	in the user’s tweets in a given month of a given year. Show the 
	user’s screen name, the state the user lives, and the list of URLs.
	
	Input: Values of a sub-category (e.g., 'GOP'), month, year.
	
	Rationale: This query finds URLs shared by a party.
	
	• The value of k is between 1 and 100.
*/



/*	Fix.
	SELECT USER.screen_name, 
		   ofstate, 
		   Group_concat(url) AS urls 
	FROM   tweet_url 
		   INNER JOIN tweet 
				   ON tweet_url.tid = tweet.tid 
		   INNER JOIN USER 
				   ON tweet.screen_name = USER.screen_name 
	WHERE  Year(tweet.posted) = ? 
		   AND Month(tweet.posted) = ? 
		   AND USER.sub_category = ? 
	GROUP  BY USER.screen_name; 
*/