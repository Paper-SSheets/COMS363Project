/* Q23 */
/* 
	Find k most used hashtags with the count of tweets it appeared
	posted by a given sub-category of users in a list of months. 
	Show the hashtag name and the count in descending order of the count.
	
	Input: Values of k, sub-category (e.g., 'GOP'), 
		   a list of months (e.g., [1, 2, 3]), year=2016
	
	• The value of k is between 1 and 100.
*/
SET @subcategory = 'GOP'; /* User input here */

SET @months = '1, 2, 3'; /* User input here */

SET @year = '2016'; /* User input here */

SELECT h.hname                                               AS hashtag_text, 
       Count(tag.hashtag)                                    AS num_uses, 
       Month(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) AS post_month 
FROM   hashtag h 
       INNER JOIN tagged tag 
               ON tag.hashtag = h.hname 
       INNER JOIN tweet t 
               ON t.tid = tag.tid 
       INNER JOIN user u 
               ON u.screen_name = t.uscreen_name 
WHERE  u.sub_category = @subcategory && Find_in_set(Month( 
                                        Str_to_date(t.created_at, 
                                                    '%Y-%m-%d %H:%i:%s') 
                                                           ), @months) 
       AND Year(Str_to_date(t.created_at, '%Y-%m-%d %H:%i:%s')) = @year 
GROUP  BY h.hname 
ORDER  BY num_uses DESC 
LIMIT  5; /* User input here */


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