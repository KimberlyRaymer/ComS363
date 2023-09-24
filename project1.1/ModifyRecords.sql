use `project1`;

#Q1
UPDATE students SET name='Scott' where ssn=746897816;

#Q2
UPDATE major SET name='Computer Science', level='MS' where snum in (select snum from students where ssn=746897816);

#Q3
SET SQL_SAFE_UPDATES=0;
DELETE FROM register where register.regtime='Spring2021';
SET SQL_SAFE_UPDATES=1;