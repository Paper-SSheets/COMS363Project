//Find top k most followed users in a given party. Show the user’s screen name, 
//the user’s party, and the number of followers in descending order of the number of followers.

q9).
match (u:User) where u.sub_category="(?i)GOP"
return u.screen_name as screenName, u.sub_category, tointeger(u.followers) AS numFollowers
order by tointeger(u.followers) desc limit 5