/* Q11 */
/* 
	Find k tweets (with the given hashtag) posted by republican (GOP)
	or democrat members of a given state in a given month of a given year. 
	Show the tweet text, the hashtag, the screen name of the posting 
	user, and the users’ party
	
	Input: Values of k, state (e.g., Ohio), month, year, hashtag
	
	Rationale: This query explores the context in which the hashtag was used
	
	• The value of k is between 1 and 100.
*/
SET @state = 'Ohio'; /* User input here */

SET @hashtag = 'Ohio'; /* User input here, based from above. */

SET @month = '1'; /* User input here */

SET @year = '2016'; /* User input here */

SELECT t.tweet_text, 
       h.hname        AS hashtag_text, 
       u.screen_name, 
       u.sub_category AS subcategory 
FROM   tweet t 
       INNER JOIN tagged tag 
               ON tag.tid = t.tid 
       INNER JOIN hashtag h 
               ON h.hname = tag.hashtag 
       INNER JOIN user u 
               ON u.screen_name = t.uscreen_name 
WHERE  h.hname = @hashtag 
       AND ( u.sub_category = 'GOP' 
              OR u.sub_category = 'Democrat' ) 
       AND u.state_name = @state 
       AND Year(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @year 
       AND Month(Str_to_date(created_at, '%Y-%m-%d %H:%i:%s')) = @month 
LIMIT  100; /* User input here */