USE group6;

/* 	--secure-file-priv option so it cannot execute these statements 
	EVEN THOUGH, I have this option set to null in .ini file.	*/

/* LOAD DATA INFILE './dataCSV/user.csv' */
LOAD DATA INFILE 'U:/fall19/coms363/COMS363Project/dataCSV/user.csv'
INTO TABLE user
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* LOAD DATA INFILE './dataCSV/urlused.csv' */
LOAD DATA INFILE 'U:/fall19/coms363/COMS363Project/dataCSV/urlused.csv'
INTO TABLE url
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* LOAD DATA INFILE './dataCSV/tweets.csv' */
LOAD DATA INFILE 'U:/fall19/coms363/COMS363Project/dataCSV/tweets.csv'
INTO TABLE tweet
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* LOAD DATA INFILE './dataCSV/tagged.csv' */
LOAD DATA INFILE 'U:/fall19/coms363/COMS363Project/dataCSV/tagged.csv'
INTO TABLE hashtag
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* LOAD DATA INFILE './dataCSV/mentioned.csv' */
LOAD DATA INFILE 'U:/fall19/coms363/COMS363Project/dataCSV/mentioned.csv'
INTO TABLE mentioned
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;