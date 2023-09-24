#Q1
select snum, ssn from students where name='Becky';

#Q2    
select name, level from major where snum in (select snum from students where ssn = 123097834);

#Q3                
select distinct c.name from courses c, departments d where c.department_code = d.code and d.name = 'Computer Science';

#Q4
select distinct g.name, g.level from degrees g, departments d where g.department_code = d.code and d.name = 'Computer Science';

#Q5
select distinct s.name from students s, minor m where s.snum = m.snum;

-- #Q6
-- select count(m.snum) from minor m;

-- #Q7
-- select s.name, s.snum from students s where s.snum in (select r.snum from register r where r.course_number in (select c.number from courses c where c.name = 'Algorithm'));
--                                                                          
-- #Q8
-- select s.name, s.snum from students s ORDER by s.dob ASC limit 1;

-- #Q9
-- select s.name, s.snum from students s ORDER by s.dob DESC limit 1;

-- #Q10
-- select s.name, s.snum,s.ssn from students s where ( s.name LIKE '%n%' or s.name LIKE '%N%');

-- #Q11
-- select s.name, s.snum,s.ssn from students s where (not s.name LIKE '%n%' or not s.name LIKE '%N%');

-- #Q12
-- select c.name, c.number, COUNT(*) from courses c, register r where c.number = r.course_number group by r.course_number;

-- #Q13
-- select s.name from students s where s.snum in ( select r.snum from register r where r.regtime = 'Fall2020');

-- #Q14
-- select c.number, c.name from courses c where c.department_code in (select d.code from departments d where d.name = 'Computer Science');

-- #Q15
-- select c.number, c.name from courses c where c.department_code in (select d.code from departments d where d.name = 'Computer Science' OR d.name = 'Landscape Architect');