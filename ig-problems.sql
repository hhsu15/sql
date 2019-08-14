# 1 find the oldest 5 users
select * from users 
order by created_at
limit 5;


# 2 find what day of week do most users register
select 
	day_tb.*,
	count(day) as day_cnt
from (
	select
		dayname(created_at) as day
	from users
) as day_tb
group by day
order by day_cnt desc;

# 2 this is a better solution
select 
	dayname(created_at) as day,
	count(*) as cnt
from users
group by day
order by cnt desc
limit 2;

# 3 find the uers who have never posted a photo
select
	users.id, 
	users.username
from users
left join photos
on users.id = photos.user_id
where
	photos.id is null;
	
# 4
select
	photos.id,
	image_url,
	count(likes.user_id) as cnt_like
from photos
left join likes
on photos.id = likes.photo_id
group by photo_id
order by cnt_like desc
limit 1;

# 5 
#how many times does an average user post? Notice you should check againt your entire user base rather than just the users who have posted

select 
(select count(*) from photos) /
(select count(*) from users);

#6
# find out the most popular hash tags, say top 5
select
	tag_id,
	tag_name,
	count(tag_id) as tag_cnt
from photo_tags
inner join tags
on tags.id = photo_tags.tag_id
group by tag_id
order by tag_cnt desc limit 5;

# 7 
# find users who have liked every single photo on the site
# this can be a usecase to identify is a user is a bot
select 
	users.id,
	users.username,
	count(likes.user_id) as cnt
from likes
join users
on users.id = likes.user_id
group by likes.user_id
having cnt = 
(select count(*) from photos);



