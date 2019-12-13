//Find k hashtags that appeared in the most number of states in a given year; list the total number of states the
//hashtag appeared, the list of the distinct states it appeared (FL is the same as Florida*), and the hashtag itself in
//descending order of the number of states the hashtag appeared.



q3.)
match(h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)-[:FROM]->(s:State)
where t.year="2016" and h.name<>'' and s.name<>'' and s.name<>"na"
return count(distinct(s.name)) as statenum, collect(distinct(s.name)) as statelist, toUpper(h.name) as hashtag
order by statenum desc limit 5
