CREATE DATABASE IF NOT EXISTS group6; 

USE group6; 

DROP TABLE IF EXISTS appusers; 

CREATE TABLE appusers 
  ( 
     login_name VARCHAR(50), 
     upassword  VARCHAR(50), 
     privilege  VARCHAR(8), 
     PRIMARY KEY(login_name) 
  ); 

INSERT INTO appusers 
VALUES     ('adminUser', 
            Sha1('!Group6!@cs363'), 
            'all'); 

INSERT INTO appusers 
VALUES     (guestuser, 
            Sha1('Group6!@cs363'), 
            'readonly'); 