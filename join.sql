select first_name, title, ifnull(avg(grade), 0) as avg_grade
from students as s
left join papers as p 
on p.student_id = s.id
group by s.id
order by avg_grade desc;