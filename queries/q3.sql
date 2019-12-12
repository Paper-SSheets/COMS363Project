/* Finds k hashtags that appeared in the most number of states
in a given year; lists the total number of states the hashtag
appeared, the distict states it appeared, and the hashtag itself
in descending order of the number of states the hashtag appeared */

SELECT retweet_count, textbody, user.screen_name, category, sub_category
FROM tweet
INNER JOIN user on tweet.screen_name = user.screen_name
WHERE YEAR(tweet.posted) = ?
AND tid in
    (SELECT tid from tweet_hashtag
     WHERE hname = ? )
ORDER BY retweet_count DESC limit ?;
