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
     FOREIGN KEY(location) REFERENCES state(name) 
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
     retweeted     BIT, 
     /* A bit is either 1, 0, or null. Good to use as a boolean. */ 
     posting_user  VARCHAR(50), 
     PRIMARY KEY(id), 
     FOREIGN KEY(posting_user) REFERENCES user(screen_name) ON DELETE CASCADE 
  ); 