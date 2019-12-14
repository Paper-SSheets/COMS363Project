/* Q6 */
/* 
	Find k users who used at least one of the hashtags in a given list 
	of hashtags in their tweets. Show the user’s screen name and the state
	the userlivesin descending order of the number of this user’s followers.
	
	Input: Value of k and list of hashtags (e.g., [GOPDebate, DemDebate])
	
	Rationale: This is to find k users with similar interests
	
	• The value of k is between 1 and 100.
*/

/* Code here. */
SET @hashtags = 'GOPDebate, DemDebate'; /* User input here. */

SELECT u.screen_name, 
       u.state_name 
FROM   user u 
       INNER JOIN tweet t 
               ON t.uscreen_name = u.screen_name 
       INNER JOIN tagged tag 
               ON tag.tid = t.tid 
       INNER JOIN hashtag h 
               ON h.hname = tag.hashtag 
WHERE  Find_in_set(h.hname, @hashtags) 
GROUP  BY u.screen_name 
ORDER  BY u.num_followers DESC 
LIMIT  5; /* User input here. */


/* 	Fix.
	SELECT * 
	FROM   (SELECT user.numfollowers, 
				   user.screen_name, 
				   Group_concat(DISTINCT hashtagname) AS all_hashtags 
			FROM   tweet_hashtag 
				   INNER JOIN tweet 
						   ON tweet_hashtag.tid = tweet.tid 
				   INNER JOIN user 
						   ON tweet.screen_name = user.screen_name 
			WHERE  Find_in_set(hashtagname, ?) != 0 
			GROUP  BY user.screen_name) AS x 
	WHERE  Length(all_hashtags) - Length(REPLACE(all_hashtags, ',', '')) = 
		   Length(?) - Length(REPLACE(?, ',', '')) 
	ORDER  BY numfollowers DESC 
	LIMIT  10; 
*/