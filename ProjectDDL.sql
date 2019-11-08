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
     name     VARCHAR(50), 
     PRIMARY KEY(name)
  ); 
  
  CREATE TABLE mentioned
  (
	uscreen_name	VARCHAR(50),
    tid				BIGINT,
    PRIMARY KEY(uscreen_name, tid),
    FOREIGN KEY(uscreen_name) REFERENCES user(screen_name),
    FOREIGN KEY(tid) REFERENCES tweet(id)
  );

  
  