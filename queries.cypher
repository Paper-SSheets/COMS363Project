1)
	List k most retweeted tweets in a given month and a given year;
	show the retweet count, the tweet text, the posting user's screen name,
	the posting user's category, the posting user's sub-category in descending
	order of the retweet count values

	match (t:Tweet)<-[:POSTED]-(u:User) WHERE t.year='2016' AND t.month='1' RETURN tointeger(t.retweet_count), t.text, u.screen_name, u.category, u.sub_category ORDER BY tointeger(t.retweet_count) DESC limit 5




3)
	Find k hashtags that appeared in the most number of states in a given year; list the total number of states the
	hashtag appeared, the list of the distinct states it appeared (FL is the same as Florida*), and the hashtag itself in
	descending order of the number of states the hashtag appeared.

	match(h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)-[:FROM]->(s:State)
	where t.year="2016" and h.name<>'' and s.name<>'' and s.name<>"na"
	return count(distinct(s.name)) as statenum, collect(distinct(s.name)) as statelist, toUpper(h.name) as hashtag
	order by statenum desc limit 5




6)
	Find k users who used at least one of the hashtags in a given list of hashtags in their
	tweets.  Show the user's screen name and the state the user lives in descending order of the
	number of this user's followers.
	sample input: k = 5, hashtag=[GOPDebate, DemDebate]

	match (u:User)-[:POSTED]->(t:Tweet)<-[:TAGGED]-(h:Hashtag) WHERE h.name IN ['DemDebate', 'GOPDebate'] WITH distinct u return u.screen_name, u.location, u.followers order by tointeger(u.followers) desc limit 5



9) 
	Find top k most followed users in a given party. Show the user’s screen name, 
	the user’s party, and the number of followers in descending order of the number of followers.

	match (u:User) where u.sub_category="(?i)GOP"
	return u.screen_name as screenName, u.sub_category, tointeger(u.followers) AS numFollowers
	order by tointeger(u.followers) desc limit 5





10) 
	Find the list of distinct hashtags that appeared in one of the states in a given list in a
	given month, of a given year; show the list of the hashtags and the names of the states in
	which they appeared
	sample input:
	State = [Ohio, Alaska, Alabama] month = 1, year = 2016

	match (h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)-[:FROM]->(s:State) WHERE s.name IN ['Ohio', 'Alaska', 'Alabama'] AND t.month = "1" AND t.year = '2016' return toUpper(h.name), collect(distinct s.name)



11) 
	Find k tweets (with the given hashtag) posted by republican (GOP) or democrat members of a 
	given state in a given month of a given year. Show the tweet text, the hashtag, the screen name 
	of the posting user, and the users’ party

	match (u:User)-[:POSTED]->(t:Tweet)<-[:TAGGED]-(h:Hashtag)
	where u.location="Ohio" and h.name=~'Ohio' and t.month='1' and t.year='2016'
	return t.text, h.name, u.screen_name, u.sub_category limit 5





15) 
	Find users in a given sub-category along with the list of URLs used in the user's tweets in a
	given month of a given year.  Show the user's screen name, the state the user lives, and the
	list of URLs.

	month = 1, year = 2016, subcat = GOP

	Input: Values of a sub-category (e.g. "GOP"), month, year

	// I think

	match (u:User)-[:POSTED]->(t:Tweet)-[:URL_USED]->(ur:Url) WHERE u.sub_category = "GOP" AND t.year = '2016' AND t.month = '1' WITH distinct(u), collect(ur.url) as url_list return u.screen_name, u.location, url_list

	// this is better
	match (u:User{sub_category:"GOP"})-[:POSTED]->(t:Tweet)-[:URL_USED]->(ur:Url) WHERE t.year = '2016' AND t.month = '1' WITH distinct(u), collect(ur.url) as url_list return u.screen_name, u.location, url_list order by toUpper(u.screen_name) asc


	// this is probably better maybe order by something not sure
	match (s:State)<-[:FROM]-(u:User{sub_category:"GOP"})-[:POSTED]->(t:Tweet)-[:URL_USED]->(ur:Url) WHERE t.year = '2016' AND t.month = '1' WITH u, collect(ur.url) as url_list return u.screen_name, u.location, url_list





18) 
	Find k users who were mentioned the most in tweets of users of a given party in a given month of a given year. Show 
	the user’s screen name, user’s state, and the list of the screen name of the user(s) who mentioned this user in 
	descending order of the number of tweets mentioning this user

	match ((u:User)-[:POSTED]->(t:Tweet)-[r:MENTIONED]->(m:User)) 
	optional match((m)-[:FROM]->(c:State)) 
	with u,t,r,m,c 
	where u.sub_category="GOP" and m.screen_name<>''
	and t.year="2016" and t.month='1' with count(distinct(r)) as num, m.screen_name as mentionedUser, c.name as stateOfMentionedUser, collect(distinct(u.screen_name)) as listMentioningUsers 
	return mentionedUser, stateOfMentionedUser, listMentioningUsers
	order by num desc limit 5





23) 
	Find k most used hashtags with the count of tweets it appeared posted by a given sub-category
	of users in a list of months. Show the hashtag name and the count in descending order of the count.

	match(h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)
	where h.name<>'' and u.sub_category=~'(?i)GOP' and t.month in ["1","2","3"] and t.year="2016"
	return toUpper(h.name), count(h) as numUses
	order by numUses desc limit 5

