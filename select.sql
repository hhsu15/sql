select distinct book_id, author_fname, author_lname from books;

select * from books where author_fname like 'D____';

select count(distinct author_fname) from books;

select author_fname, count(released_year) as cnt, author_lname from books
group by author_fname;

select concat(author_fname, ' has ' , count(*)) as des from books group by author_fname;

select min(released_year) as mi from books;

select author_fname, min(released_year) as earliest from books group by author_fname;

select author_fname, author_lname, max(pages) as max_pages from books group by author_fname, author_lname;

select concat_ws(', ',author_fname, author_lname) as full_name, sum(pages) as total_pages from books group by author_fname, author_lname order by total_pages desc limit 1;

select released_year, count(title) as num_books, avg(pages) as avg_pages from books group by released_year;