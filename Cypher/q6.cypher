Find k users who used at least one of the hashtags in a given list of hashtags in their
tweets.  Show the user's screen name and the state the user lives in descending order of the
number of this user's followers.

sample input: k = 5, hashtag=[GOPDebate, DemDebate]

match (u:User)-[:POSTED]->(t:Tweet)<-[:TAGGED]-(h:Hashtag) WHERE h.name IN ['DemDebate', 'GOPDebate'] WITH distinct u return u.screen_name, u.location, u.followers order by tointeger(u.followers) desc limit 5
