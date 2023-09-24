//1)	The student number and ssn of the student whose name is "Becky"
Match(s:student)
Where s.name='Becky'
return s.snum, s.ssn

//2)	The major name and major level of the student whose ssn is 123097834
Match(s:student)-[m:major]->(d:degree)
Where s.ssn = 123097834
return d.name,d.level

//3)	All degree names and levels offered by the department Computer Science
MATCH (dg:degree)<-[:administer]-(d:department)
WHERE d.dname="Computer Science"
RETURN dg.dname, dg.level;

//4)	The names of all students who have a minor
Match(s:student)-[:minor]->(d:degree)
return s.name

//5)	The count of students who have a minor
Match(s:student)-[:minor]->(d:degree)
return count(d);

//6)	The names and snums of all students enrolled in course “Algorithm”
Match(s:student)-[:register]->(c:courses)
Where c.name="Algorithm"
return s.name, s.snum

//7)	The names of all students who enrolled in course 363 and their corresponding grade 
Match(s:student)-[r:register]->(c:courses)
Where c.number=363
Return s.name, r.grade

//8)	The name and snum of the oldest student
Match(s:student)
return s.name, s.snum
order by s.dob asc limit 1

//9)	The name and snum of the youngest student
Match(s:student)
return s.name, s.snum
order by s.dob desc limit 1

//10)	The name, snum and SSN of the students whose name contains letter “n” or “N”
Match(s:student)
Where s.name Contains 'N' OR s.name Contains 'n'
return s.name, s.snum, s.ssn

//11)	The name, snum and SSN of the students whose name does not contain letter “n” or “N”
Match(s:student)
Where NOT (s.name Contains 'N') AND NOT (s.name Contains 'n')
return s.name, s.snum, s.ssn

//12)	The course number, name and the number of students registered for each course
Match(s:student)-[:register]->(c:courses)
return c.number, c.name, count(s)

//13)	The name of the students enrolled in Fall2020 semester.
Match(s:student)-[r:register]->(c:courses)
Where r.regtime="Fall2020"
return s.name

//14)	The course numbers and names of all courses offered by Department of Computer Science
Match(c:courses)-[:offers]->(d:department)
Where d.dname="Computer Science"
return c.number, c.name

//15)	The course numbers and names of all courses offered by either Department of Computer Science or Department of Landscape Architect.
Match(c:courses)-[:offers]->(d:department)
Where d.dname="Computer Science" OR d.dname="Landscape Architect"
return c.number, c.name
