//Find ktweets (with the given hashtag) posted by republican (GOP) or democrat members of a 
//given state in a given month of a given year. Show the tweet text, the hashtag, the screen name 
//of the posting user, and the users’ party

q11).
match (u:User)-[:POSTED]->(t:Tweet)<-[:TAGGED]-(h:Hashtag)
where u.location="Ohio" and h.name=~'Ohio' and t.month='1' and t.year='2016'
return t.text, h.name, u.screen_name, u.sub_category limit 5