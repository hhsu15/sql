if not exists create database ig_clone;
use ig_clone;

# users table
create table users (
	id int auto_increment primary key,
	username varchar(50) unique not null,
	created_at timestamp default now()
		on update current_timestamp
);

# photos table
create table photos (
	id int auto_increment primary key,
	image_url varchar(255) not null,
	user_id int not null,
	created_at timestamp default now());
	
# comments table
create table comments (
	id int auto_increment primary key,
	comment_text varchar(255),
	user_id int not null,
	photo_id int,
	created_at timestamp default now(),
	foreign key (user_id) references users(id),
	foreign key (photo_id) references photos(id)
);

# likes table
create table likes (
	created_at timestamp default now(),
	user_id int not null,
	photo_id int not null,
	foreign key(user_id) references users(id),
	foreign key(photo_id) references photos(id),
	primary key(user_id, photo_id) # this will prevent one user enter a like to a same photo
);

# follows table
create table follows (
	created_at timestamp default now(),
	follower_id int not null,
	followee_id int not null,
	foreign key(follower_id) references users(id),
	foreign key(followee_id) references users(id),
	primary key(follower_id, followee_id)
)