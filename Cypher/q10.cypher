Q10.

Find the list of distinct hashtags that appeared in one of the states in a given list in a
given month, of a given year; show the list of the hashtags and the names of the states in
which they appeared

sample input:
State = [Ohio, Alaska, Alabama] month = 1, year = 2016


match (h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)-[:FROM]->(s:State) WHERE s.name IN ['Ohio', 'Alaska', 'Alabama'] AND t.month = "1" AND t.year = '2016' return toUpper(h.name), collect(distinct s.name)
