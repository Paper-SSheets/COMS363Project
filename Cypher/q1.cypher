// List k most retweeted tweets in a given month and a given year;
// show the retweet count, the tweet text, the posting user's screen name,
// the posting user's category, the posting user's sub-category in descending
/ /order of the retweet count values

q1.)
match (t:Tweet)<-[:POSTED]-(u:User) WHERE t.year='2016' AND t.month='1' RETURN tointeger(t.retweet_count), t.text, u.screen_name, u.category, u.sub_category ORDER BY tointeger(t.retweet_count) DESC limit 5

q2.)
