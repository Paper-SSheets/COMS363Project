/* Q1 */ 
/* 
	List k most retweeted tweets in a given month and a given year; 
	show the retweet count, the tweet text, the posting user’s screen name, 
	the posting user’s category, the posting user’s sub-category in 
	descending order of the retweet count values. 
	
	Input: Value of k (e.g., 10), month (e.g., 1), and year (e.g., 2016) 
	
	Rationale: This query finds k most influential tweets 
			   in a given time frame and the users who posted them
	
	• The value of k is between 1 and 100.
*/
/*
SELECT retweet_count, 
       tweet_text, 
       user.screen_name, 
       category, 
       sub_category 
FROM   tweet 
       INNER JOIN user 
               ON tweet.uscreen_name = user.screen_name 
WHERE  Year(tweet.created_at) = 2016 /* User input here */ 
/*       AND Month(tweet.created_at) = 01 /* User input here */ 
/*ORDER  BY retweet_count DESC 
LIMIT  10; /* User input here */

/* test */
SELECT * 
FROM   tweet t 
       INNER JOIN user u 
               ON t.uscreen_name = u.screen_name 
WHERE  Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = "2016" 
       AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = "2" 
ORDER  BY t.retweet_count DESC 
LIMIT  10; 