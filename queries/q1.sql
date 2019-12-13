SELECT 
	retweet_count,  tweet_text, uscreen_name,
	subcategory, screen_name
FROM 
	User u, Tweet t
INNER JOIN Tweet t
	ON u.screen_name = t.uscreen_name
WHERE 
	MONTH(t.created_at) = '1' 
	AND
	YEAR(t.created_at) = '2016'
ORDER BY t.retweet_count DESC LIMIT 5;
