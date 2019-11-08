CREATE DATABASE if not exists group6;
use group6;
CREATE USER IF NOT EXISTS 'cs363'@'%1' IDENTIFIED WITH mysql_native_password BY 'cs363pak';
GRANT view, drop, create, insert, 
delete
   ON group6.*TO'cs363'@'%1';