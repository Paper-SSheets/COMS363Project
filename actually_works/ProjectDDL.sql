CREATE DATABASE if not exists `group33`;

USE group6;

SET FOREIGN_KEY_CHECKS=0;

drop table if exists User;
create table User(
screen_name VARCHAR(15),
dname VARCHAR(50),
sub_category VARCHAR(8),
category VARCHAR(22),
state_name VARCHAR(50),
num_followers BIGINT,
num_following BIGINT,
primary key(screen_name)
);

drop table if exists Tweet;
create table Tweet(
tid BIGINT,
tweet_text VARCHAR(280),
retweeted INT,
retweet_count BIGINT,
created_at DATE,
uscreen_name VARCHAR(15) NOT NULL,
primary key(tid),
foreign key(uscreen_name) references User(screen_name) ON DELETE CASCADE
);


drop table if exists Url;
create table Url(
address VARCHAR(500),
primary key(address)
);

drop table if exists Hashtag;
create table Hashtag(
hname VARCHAR(280),
primary key(hname)
);

drop table if exists Mentioned;
create table Mentioned(
uscreen_name VARCHAR(15),
tid BIGINT,
primary key(uscreen_name, tid),
foreign key(uscreen_name) references User(screen_name) ON DELETE CASCADE,
foreign key(tid) references Tweet(tid) ON DELETE CASCADE
);

drop table if exists Url_Used;
create table Url_Used(
tid BIGINT,
url VARCHAR(500),
primary key(tid, url),
foreign key(tid) references Tweet(tid) ON DELETE CASCADE,
foreign key(url) references Url(address) ON DELETE CASCADE
);

drop table if exists Tagged;
create table Tagged(
tid BIGINT,
hashtag VARCHAR(280),
primary key(tid, hashtag),
foreign key(tid) references Tweet(tid) ON DELETE CASCADE,
foreign key(hashtag) references Hashtag(hname) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS=1;


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
