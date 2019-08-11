select 
	title,
	avg(r.rating) as avg_rating
from series as s
inner join reviews as r
on
s.id = r.series_id
group by s.id
order by avg_rating;

# 2
select
	reviewers.first_name,
	reviewers.last_name,
	rating
from reviews
join
reviewers
on
reviews.reviewer_id = reviewers.id
order by reviewers.first_name;

# 3 find unreviewed series
select title, rating from series as s
left join reviews as r
on s.id = r.series_id
where r.rating is null;

# 4 find avg ratings by genre
select
	genre,
	avg(rating) as avg_rating
from 
	series
inner join
	reviews
on
	series.id = reviews.series_id
group by
	genre;
	
# get each reviewer's status
select
	first_name,
	last_name,
	ifnull(count(rating),0) as cnt,
	ifnull(min(rating),0) as min_rating,
	ifnull(max(rating),0) as max_rating,
	ifnull(avg(rating), 0) as avg_rating,
	IF(count(rating)=0, 'INACTIVE', 'ACTIVE') as r_status
	# case
	# 	when count(rating) = 0 then 'INACTIVE'
	# 	else 'ACTIVE'
	# end as r_status
from reviewers
left join reviews
on reviewers.id = reviews.reviewer_id
group by reviewers.id;

# 5 
select 
	title,
	rating,
	concat_ws(' ', first_name, last_name) as viewer_name
from reviews
join series on reviews.series_id = series.id
join reviewers on reviews.reviewer_id = reviewers.id
order by title;
