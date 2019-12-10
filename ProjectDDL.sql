DROP TABLE IF EXISTS group6; 

CREATE DATABASE IF NOT EXISTS group6; 

USE group6; 

SET foreign_key_checks=0; 

DROP TABLE IF EXISTS user; 

CREATE TABLE user 
  ( 
     screen_name   VARCHAR(15), 
     dname         VARCHAR(50), 
     sub_category  VARCHAR(8), 
     category      VARCHAR(22), 
     state_name    VARCHAR(50), 
     num_followers BIGINT, 
     num_following BIGINT, 
     PRIMARY KEY(screen_name) 
  ); 

DROP TABLE IF EXISTS tweet; 

CREATE TABLE tweet 
  ( 
     tid           BIGINT, 
     tweet_text    VARCHAR(280), 
     retweeted     INT, 
     retweet_count BIGINT, 
     created_at    DATE, 
     uscreen_name  VARCHAR(15) NOT NULL, 
     PRIMARY KEY(tid), 
     FOREIGN KEY(uscreen_name) REFERENCES user(screen_name) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS url; 

CREATE TABLE url 
  ( 
     address VARCHAR(500), 
     PRIMARY KEY(address) 
  ); 

DROP TABLE IF EXISTS hashtag; 

CREATE TABLE hashtag 
  ( 
     hname VARCHAR(280), 
     PRIMARY KEY(hname) 
  ); 

DROP TABLE IF EXISTS mentioned; 

CREATE TABLE mentioned 
  ( 
     uscreen_name VARCHAR(15), 
     tid          BIGINT, 
     PRIMARY KEY(uscreen_name, tid), 
     FOREIGN KEY(uscreen_name) REFERENCES user(screen_name) ON DELETE CASCADE, 
     FOREIGN KEY(tid) REFERENCES tweet(tid) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS url_used; 

CREATE TABLE url_used 
  ( 
     tid BIGINT, 
     url VARCHAR(500), 
     PRIMARY KEY(tid, url), 
     FOREIGN KEY(tid) REFERENCES tweet(tid) ON DELETE CASCADE, 
     FOREIGN KEY(url) REFERENCES url(address) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS tagged; 

CREATE TABLE tagged 
  ( 
     tid     BIGINT, 
     hashtag VARCHAR(280), 
     PRIMARY KEY(tid, hashtag), 
     FOREIGN KEY(tid) REFERENCES tweet(tid) ON DELETE CASCADE, 
     FOREIGN KEY(hashtag) REFERENCES hashtag(hname) ON DELETE CASCADE 
  ); 

SET foreign_key_checks=1; 

delimiter //

CREATE TRIGGER `load_url` BEFORE INSERT ON `Url_Used` FOR EACH ROW
BEGIN
IF (SELECT count(*) FROM Url WHERE Url.address=NEW.url) = 0 THEN
INSERT INTO Url(address) VALUES(NEW.url);
END IF;
END;//

CREATE TRIGGER `delete_url` BEFORE DELETE ON `Url_Used` FOR EACH ROW
BEGIN
IF (SELECT count(*) FROM Url_Used WHERE Url_Used.url=OLD.url) <= 1 THEN
DELETE FROM Url WHERE OLD.url=Url.address;
END IF;
END;//
   
CREATE TRIGGER `load_hashtag` BEFORE INSERT ON `Tagged` FOR EACH ROW
BEGIN
IF (SELECT count(*) FROM Hashtag WHERE Hashtag.hname=NEW.hashtag) = 0 THEN
INSERT INTO Hashtag(hname) VALUES(NEW.hashtag);
END IF;
END;//

CREATE TRIGGER `delete_hashtag` BEFORE DELETE ON `Tagged` FOR EACH ROW
BEGIN
IF (SELECT count(*) FROM Tagged WHERE Tagged.hashtag=OLD.hashtag) <= 1 THEN
            DELETE FROM Hashtag WHERE OLD.hashtag=Hashtag.hname;
END IF;
END;//
   
delimiter ;