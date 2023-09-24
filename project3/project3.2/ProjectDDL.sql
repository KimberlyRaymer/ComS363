create database if not exists twitter;
use twitter;

drop table if exists tweeturl;
drop table if exists tagged;
drop table if exists mentioned;
drop table if exists tweet;
drop table if exists user;

create table `user`(
	name varchar(50) DEFAULT NULL,
    screen_name varchar(50) NOT NULL,
    numFollowers int,
    `numFollowing` int,
    category varchar(30),
    sub_category varchar(30),
    ofstate varchar(30),
    primary key (screen_name)
);

create table tweet(
	tid bigint NOT NULL,
    textbody varchar(300),
    retweet_count int(11) DEFAULT NULL,
    retweeted tinyint(1) DEFAULT NULL,
    posting_user varchar(50),
	day_posted int DEFAULT NULL,
	month_posted int DEFAULT NULL,
	year_posted int default NULL,
    foreign key (posting_user) references `user`(screen_name) ON DELETE CASCADE ON UPDATE CASCADE,
    primary key (tid)
);

create table mentioned(
	tid bigint,
    screen_name varchar(50),
    foreign key(tid) references tweet(tid) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(screen_name) references `user`(screen_name) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key(tid, screen_name)
);

create table url(
	tid bigint,
    url varchar(500),
    foreign key (tid) references tweet(tid) ON DELETE CASCADE ON UPDATE CASCADE,
    primary key (tid, url)
);

create table hashtag(
	tid bigint,
    hashtagname varchar(100),
    foreign key (tid) references tweet(tid) ON DELETE CASCADE ON UPDATE CASCADE,
    primary key(tid, hashtagname)
);