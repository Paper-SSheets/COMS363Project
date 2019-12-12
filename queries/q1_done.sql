/* Q1 */ 
SELECT retweet_count, 
       tweet_text, 
       user.screen_name, 
       category, 
       sub_category 
FROM   tweet 
       INNER JOIN user 
               ON tweet.uscreen_name = user.screen_name 
WHERE  Year(tweet.created_at) = 2016 /* User input here */ 
       AND Month(tweet.created_at) = 01 /* User input here */ 
ORDER  BY retweet_count DESC 
LIMIT  10; /* User input here */