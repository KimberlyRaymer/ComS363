#Author: Kimberly Raymer
CREATE database if not exists `project1`;
use `project1`;

CREATE TABLE students (
	snum integer,
    ssn integer,
    name varchar(10),
    gender varchar(1),
    dob date,
    c_addr varchar(20),
    c_phone varchar(10),
    p_addr varchar(20),
    p_phone varchar(10),
    primary key(ssn),
    unique(snum)
);

CREATE TABLE departments (
	code integer,
    name varchar(50),
    phone varchar(10),
    college varchar(20),
    primary key(code),
    unique(name)
);

CREATE TABLE degrees (
	name varchar(50),
    level varchar(5),
    department_code integer,
    primary key(name, level),
    foreign key(department_code) references departments(code)
);

CREATE TABLE courses (
	number integer,
    name varchar(50),
    description varchar(50),
    credithours integer,
    level varchar(20),
    department_code integer,
    primary key(number),
    unique(name),
    foreign key(department_code) references departments(code)
);

CREATE TABLE register (
	snum integer,
    course_number integer,
    regtime varchar(20),
    grade integer,
    primary key(snum, course_number),
    foreign key(snum) references students(snum),
    foreign key(course_number) references courses(number)
);

CREATE TABLE major (
	snum integer,
    name varchar(50),
    level varchar(5),
    primary key(snum, name, level),
    foreign key(snum) references students(snum),
	foreign key(name, level) references degrees(name, level)
);

CREATE TABLE minor (
	snum integer,
    name varchar(50),
    level varchar(5),
    primary key(snum, name, level),
	foreign key(snum) references students(snum),
	foreign key(name, level) references degrees(name, level)
);
    