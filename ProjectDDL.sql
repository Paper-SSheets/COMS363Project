CREATE DATABASE IF NOT EXISTS 'group6'; 

USE group6; 

DROP TABLE IF EXISTS user; 

CREATE TABLE user 
  ( 
     name         VARCHAR(50), 
     screen_name  VARCHAR(50), 
     sub_category VARCHAR(50), 
     category     VARCHAR(50), 
     location     VARCHAR(50), 
     followers    BIGINT, 
     following    BIGINT, 
     PRIMARY KEY(screen_name), 
     FOREIGN KEY(location) REFERENCES state(name) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS tweet; 

CREATE TABLE tweet 
  ( 
     id            BIGINT, 
     created_at    DATE, 
     day           VARCHAR(31), 
     month         VARCHAR(12), 
     year          BIGINT, 
     text          VARCHAR(280), 
     retweet_count BIGINT, 
     retweeted     BOOL, 
     /* A bit is either 1, 0, or null. Good to use as a boolean. */ 
     /* True or false can also be null - Dylan */ 
     posting_user  VARCHAR(50), 
     PRIMARY KEY(id), 
     FOREIGN KEY(posting_user) REFERENCES user(screen_name) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS state; 

CREATE TABLE state 
  ( 
     name        VARCHAR(2), 
     screen_name VARCHAR(50), 
     PRIMARY KEY(name), 
     FOREIGN KEY(screen_name) REFERENCES user(screen_name) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS url; 

CREATE TABLE url 
  ( 
     address  VARCHAR(50), 
     tweet_id BIGINT, 
     PRIMARY KEY(address), 
     FOREIGN KEY(tweet_id) REFERENCES tweet(id) ON DELETE CASCADE 
  ); 

DROP TABLE IF EXISTS hashtag; 

CREATE TABLE hashtag 
  ( 
     name     VARCHAR(50), 
     tweet_id BIGINT, 
     PRIMARY KEY(name), 
     FOREIGN KEY(id) REFERENCES tweet(id) 
  ); 