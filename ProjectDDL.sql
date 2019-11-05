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
     FOREIGN KEY(location) REFERENCES State(name) 
  ); 
  
DROP TABLE IF EXISTS tweet;

CREATE TABLE tweet
  (
	 id bigint,
     text VARCHAR(280),
     retweet_count BIGINT,
  );