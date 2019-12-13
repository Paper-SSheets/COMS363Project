Find k hashtags that appeared in the most number of states in a given year
list the total number of states the hashtag appeared, the list of the distinct states it
appeared (FL is the same as Florida) and the hashtag itself in descending order of the number
of states the hasthag appeared

match (h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)-[:FROM]->(s:State) where t.year = '2016' with t, h, count(s) as statecnt, collect(s) as stateslist return t.year, h, statecnt, stateslist order by statecnt desc limit 5
