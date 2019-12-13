//Find k most used hashtags with the count of tweets it appeared posted by a given sub-category
//of users in a list of months. Show the hashtag name and the count in descending order of the count.

q23.)
match(h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)
where h.name<>'' and u.sub_category=~'(?i)GOP' and t.month in ["1","2","3"] and t.year="2016"
return toUpper(h.name), count(h) as numUses
order by numUses desc limit 5