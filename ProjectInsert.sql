USE group6;

LOAD DATA INFILE './dataCSV/user.csv'
INTO TABLE user
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(screen_name, dname, sub_category, category, 
 state_name, num_followers, num_following);

LOAD DATA INFILE './dataCSV/tweets.csv'
INTO TABLE tweet
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid, tweet_text, retweet_count, 
 retweeted, created_at, uscreen_name);

LOAD DATA INFILE './dataCSV/urlused.csv'
INTO TABLE Url_used
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid, url);
 
LOAD DATA INFILE './dataCSV/tagged.csv'
INTO TABLE tagged
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid, hashtag);

LOAD DATA INFILE './dataCSV/mentioned.csv'
INTO TABLE mentioned
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@Col1, uscreen_name)
set tid = @Col1;
