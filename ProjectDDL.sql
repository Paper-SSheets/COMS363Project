DROP DATABASE IF EXISTS group6; 

CREATE DATABASE group6; 

USE group6; 

CREATE TABLE user 
  ( 
     name         VARCHAR(50), 
     screen_name  VARCHAR(50), 
     sub_category VARCHAR(50), 
     category     VARCHAR(50), 
     location     VARCHAR(50), 
     state        VARCHAR(2), 
     followers    BIGINT, 
     following    BIGINT, 
     PRIMARY KEY(screen_name) 
  ); 

CREATE TABLE tweet 
  ( 
     id            BIGINT, 
     created_at    DATE, 
     day           VARCHAR(31), 
     month         VARCHAR(12), 
     year          BIGINT, 
     text          VARCHAR(280), 
     retweet_count BIGINT, 
     retweeted     BIT, 
     posting_user  VARCHAR(50), 
     PRIMARY KEY(id), 
     FOREIGN KEY(posting_user) REFERENCES user(screen_name) 
  ); 

CREATE TABLE url 
  ( 
     address  VARCHAR(50), 
     tweet_id BIGINT, 
     PRIMARY KEY(address), 
     FOREIGN KEY(tweet_id) REFERENCES tweet(id) ON DELETE CASCADE 
  ); 

CREATE TABLE hashtag 
  ( 
     name VARCHAR(50), 
     PRIMARY KEY(name) 
  ); 

CREATE TABLE mentioned 
  ( 
     uscreen_name VARCHAR(50), 
     tid          BIGINT, 
     PRIMARY KEY(uscreen_name, tid), 
     FOREIGN KEY(uscreen_name) REFERENCES user(screen_name), 
     FOREIGN KEY(tid) REFERENCES tweet(id) 
  );
  
  CREATE TABLE url_used
  (
	address  	VARCHAR(50), 
	tid 		BIGINT, 
    PRIMARY KEY(address, tid),
    FOREIGN KEY(address) REFERENCES url(address),
    FOREIGN KEY(tid) REFERENCES tweet(id)
  );
  
  CREATE TABLE tagged
  (
	name  		VARCHAR(50), 
	tid 		BIGINT, 
    PRIMARY KEY(name, tid),
    FOREIGN KEY(name) REFERENCES hashtag(name),
    FOREIGN KEY(tid) REFERENCES tweet(id)
  );

delimiter ||

CREATE TRIGGER `load_new_hashtag` 
BEFORE INSERT ON tagged FOR EACH ROW 
BEGIN IF (SELECT count(*) FROM hashtag WHERE hashtag.name=NEW.hashtag) = 0 
THEN INSERT INTO hashtag(name) VALUES(NEW.hashtag); 
END IF;
END;||

CREATE TRIGGER `delete_hashtag` 
BEFORE DELETE ON tagged FOR EACH ROW 
BEGIN IF (SELECT count(*) FROM tagged WHERE tagged.hashtag=OLD.hashtag) <= 1 THEN
DELETE FROM hashtag WHERE OLD.hashtag=hashtag.name; END IF;
END;||

CREATE TRIGGER `load_new_url` 
BEFORE INSERT ON url_used FOR EACH ROW
BEGIN IF (SELECT count(*) FROM url WHERE url.address=NEW.url) = 0 
THEN INSERT INTO url(address) VALUES(NEW.url);
END IF; 
END;||

CREATE TRIGGER `delete_url` 
BEFORE DELETE ON `url_used` FOR EACH ROW 
BEGIN IF (SELECT count(*) FROM url_used WHERE url_used.url=OLD.url) <= 1 
THEN DELETE FROM url WHERE OLD.url=url.address; 
END IF;
END;||

delimiter ;