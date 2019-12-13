/* Q23 */
/* 
	Find k most used hashtags with the count of tweets it appeared
	posted by a given sub-category of users in a list of months. 
	Show the hashtag name and the count in descending order of the count.
	
	Input: Values of k, sub-category (e.g., 'GOP'), 
		   a list of months (e.g., [1, 2, 3]), year=2016
	
	• The value of k is between 1 and 100.
*/



/*	Fix.
	SELECT hashtagname, 
		   Count(DISTINCT tweet_hashtag.tid) AS count_of_tweets 
	FROM   tweet_hashtag 
		   INNER JOIN tweet 
				   ON tweet_hashtag.tid = tweet.tid 
		   INNER JOIN user 
				   ON tweet.screen_name = user.screen_name 
	WHERE  user.sub_category =? 
		   AND Year(tweet.posted) = ? 
		   AND Find_in_set(Month(tweet.posted), ?) != 0 
	GROUP  BY hashtagname 
	ORDER  BY count_of_tweets DESC 
	LIMIT  10; 
*/