-- Q1:
-- List k=10 most retweeted tweets in a given year = 2016; show the retweet count, the tweet text,
-- the posting user’s screen name, the posting user’s category, the posting user’s sub-category in
-- descending order of the retweet count values
#CORRECT
-- select t.retweet_count, t.text_body, u.screen_name, u.category, u.sub_category
-- from tweets t, TwitterUser u
-- where t.year_posted = 2016 and t.posting_user = u.screen_name
-- order by t.retweet_count desc limit 10;

-- Q2
-- Find k=10 hashtags that appeared in the most number of states in a given year = 2016; list the total
-- number of states the hashtag appeared, the list of the distinct states it appeared, and the hashtag
-- itself in descending order of the number of states the hashtag appeared.
-- Rationale: This query finds k hashtags that are used across the most number of states, which could
-- indicate a certain agenda (e.g., education, healthcare) that is widely discussed.
-- Hint: Use group_concat() function to create a list
#CORRECT
-- select count(distinct u.state) as statenum, group_concat(Distinct u.state SEPARATOR ', ') as states, tg.tag_name
--  from TwitterUser u, hashtag_used tg, tweets t
-- where u.screen_name = t.posting_user and t.year_posted = 2016 and tg.tweet_id=t.tweet_id and (not u.state LIKE 'na')
--  group by tg.tag_name order by count(distinct u.state) desc limit 10;
--  
-- Q3
-- Find all users used at least one hashtags from the list [“iowacaucus”,“iacaucus”] in their tweets. Show
-- the user’s screen name and the state the user lives in descending order of the number of this user’s followers.
-- Rationale: This is to find users with similar interests.
#CORRECT
-- select u.screen_name, u.state
-- from TwitterUser u, hashtag_used tg, tweets t
--  where u.screen_name = t.posting_user and tg.tweet_id = t.tweet_id and (tg.tag_name in ('iowacaucus' , 'iacaucus'))
-- group by u.screen_name order by u.followers desc;

-- Q4
-- Find top k=5 most followed users in a given party. Show the user’s screen name, the user’s party, and
-- the number of followers in descending order of the number of followers. Show your results with subcategory
-- to be 'GOP' and 'Democrat' in separate queries.
-- Rationale: This query finds the most influential users measured by the number of followers
#CORRECT
-- select u.screen_name, u.sub_category, u.followers
-- from TwitterUser u
--  where u.sub_category = 'GOP'
--  order by u.followers desc limit 5;
-- select u.screen_name, u.sub_category, u.followers
-- from TwitterUser u
--  where u.sub_category = 'Democrat'
--  order by u.followers desc limit 5;
 
-- Q5
-- Find the list of distinct hashtags that appeared in tweets posted by users from Iowa in a given month = 1
-- of a given year = 2016; show the list of the hashtags and the number of tweets that used these hashtags.
-- Rationale: This is to find interests among the users in the states of interest.
#CORRECT
-- select tg.tag_name as hashtag, count(t.tweet_id)
-- from hashtag_used tg, TwitterUser u, tweets t
--  where tg.tweet_id=t.tweet_id and t.month_posted=1 and t.year_posted=2016 and t.posting_user=u.screen_name and (u.state in ('Iowa'))
--  group by hashtag order by count(t.tweet_id) desc;
 
-- Q6
-- Find all tweets (with the give?n hashtag = Iowa) posted by republican (GOP) or democrat members in a
-- given month = 2 of a given year = 2016. Show the tweet text, the hashtag, the screen name of the
-- posting user, and the users’ party
#CORRECT
-- select t.text_body, tg.tag_name, u.screen_name, u.sub_category
-- from TwitterUser u, tweets t, hashtag_used tg
-- where t.posting_user=u.screen_name and tg.tweet_id=t.tweet_id and tg.tag_name = 'Iowa' and t.month_posted=2 and t.year_posted=2016 and u.sub_category in ('GOP','democrat');

-- Q7
-- Find users in a given sub-category = ‘GOP’ along with the list of URLs used in the user’s tweets in a
-- given month = 1 of a given year = 2016. Show the user’s screen name, the total number of tweets posted
#CORRECT
-- select t1.screen_name, t1.numtweets, t2.url
-- from (
-- select u.screen_name, count(t.tweet_id) as numTweets
-- from TwitterUser u, tweets t
--  where t.posting_user=u.screen_name and u.sub_category = 'GOP'
--  group by u.screen_name order by u.screen_name
--  ) t1
--  inner join (select u.screen_name, group_concat(url.url separator ', ') as url
-- from TwitterUser u, tweets t, url_used url
-- where t.posting_user=u.screen_name and t.month_posted =1
-- and t.year_posted=2016 and t.tweet_id=url.tweet_id and u.sub_category = 'GOP'
-- group by u.screen_name order by u.screen_name) t2
-- On t1.screen_name=t2.screen_name;

-- Q8
-- Find k=10 users who were mentioned the most in tweets. Show the mentioned user’s screen name, number of
-- followers, and the number of posting user(s) who mentioned this user, in descending order of
#CORRECT
-- select m.screen_name, max(mentionedUser.followers) as Followers, count(distinct tweeter.screen_name) as numTweets
-- from TwitterUser as tweeter
-- inner join tweets as t
--  on tweeter.screen_name = t.posting_user
--  inner join tweet_mentions as m
--  on m.tweet_id = t.tweet_id
-- inner join TwitterUser as mentionedUser
--  on m.screen_name = mentionedUser.screen_name
--  group by m.screen_name order by count(tweeter.screen_name) desc limit 10;

-- Q9
-- Find k=10 most used url with the count of tweets it appeared posted by a given sub-category = ‘GOP’ of
-- users in a list of months = [1, 2, 3] of a given year = 2016. Show the hashtag name and the count
-- in descending order of the count.
#CORRECT
-- select url.url as URL, count(t.tweet_id) as numTweets
-- from url_used as url
-- inner join tweets as t
-- on t.tweet_id = url.tweet_id
-- inner join TwitterUser as u
--  on u.screen_name = t.posting_user
--  where u.sub_category='GOP' and t.month_posted in (1,2,3) and t.year_posted=2016
--  group by url.url order by numTweets desc limit 10;