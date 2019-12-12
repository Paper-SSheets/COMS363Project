/* The ? represents a user-input */
SELECT retweet_count, textbody, user.screen_name, category, sub_category

FROM tweet
INNER JOIN user ON tweet.screen_name = user.screen_name
WHERE YEAR(tweet.posted) = ?
ORDER BY retweet_count DESC  limit ?;
