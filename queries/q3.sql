/* Q3 */ 
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