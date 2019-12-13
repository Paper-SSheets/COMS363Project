//Find k users who were mentioned the most in tweets of users of a given party in a given month of a given year. Show 
//the user’s screen name, user’s state, and the list of the screen name of the user(s) who mentioned this user in 
//descending order of the number of tweets mentioning this user


q18.)
match ((u:User)-[:POSTED]->(t:Tweet)-[r:MENTIONED]->(m:User)) 
optional match((m)-[:FROM]->(c:State)) 
with u,t,r,m,c 
where u.sub_category="GOP" and m.screen_name<>''
and t.year="2016" and t.month='1' with count(distinct(r)) as num, m.screen_name as mentionedUser, c.name as stateOfMentionedUser, collect(distinct(u.screen_name)) as listMentioningUsers return mentionedUser, stateOfMentionedUser, listMentioningUsers
order by num desc limit 5