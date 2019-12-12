/* Q10 */
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