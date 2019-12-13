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
