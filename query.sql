-- DDL
create table if not exists teachers (
  teacher_id int primary key auto_increment,
  fullname varchar(50) not null,
  email varchar(100) not null unique
);

create table if not exists students (
  student_id int primary key auto_increment,
  fullname varchar(50) not null,
  birthdate date not null,
  email varchar(100) not null unique
);

create table if not exists courses (
  course_id int primary key auto_increment,
  course_name varchar(100) not null,
  description varchar(300),
  total_sessions int not null check (total_sessions > 0),
  teacher_id int,
  foreign key (teacher_id) references teachers(teacher_id) on delete set null
);

create table if not exists enrollments (
  student_id int not null,
  course_id int not null,
  enrollment_date date not null,
  primary key (student_id, course_id),
  foreign key (student_id) references students(student_id) on delete cascade,
  foreign key (course_id) references courses(course_id) on delete cascade
);

create table if not exists scores (
  student_id int not null,
  course_id int not null,
  midterm_score int not null check (midterm_score between 0 and 10),
  final_score int not null check (final_score between 0 and 10),
  primary key (student_id, course_id),
  foreign key (student_id) references students(student_id) on delete cascade,
  foreign key (course_id) references courses(course_id) on delete cascade
);

-- Initial data

-- teachers
insert into teachers (fullname, email) values
('Lê Hà Thanh Sang', 'sangle2000@gmail.com'), 
('Phạm Viết Hùng', 'hungpham2004@gmail.com'),
('Nguyễn Thanh Bình Phước', 'pntb@gmail.com'),
('Nguyễn Bá Minh Đạo', 'dbm@gmail.com'),
('Lê Huỳnh Phương Tùng', 'tlhp@gmail.com');

-- students
insert into students (fullname, birthdate, email) values
('Lê Trung Hiếu', '2007-05-17', 'warmdevofficial@gmail.com'),
('Hoàng Mai Phương', '2007-12-28', 'hoangmaiphuongtin@gmail.com'),
('Nguyễn Văn A', '2007-03-10', 'anv@gmail.com'),
('Trần Thị B', '2007-07-22', 'btt@gmail.com'),
('Phạm Văn C', '2007-11-05', 'cpv@gmail.com');

-- courses
insert into courses (course_name, description, total_sessions, teacher_id) values
('Data structures and algorithms', 'Learn about data structures and algorithms in depth', 30, 1),
('Database management systems', 'Understand the principles of database design and management', 25, 2),
('Web development', 'Learn how to build modern web applications using popular frameworks', 20, 3),
('Machine learning', 'Explore the fundamentals of machine learning and its applications', 35, null),
('Go Programming', 'Learn the Go programming language and its applications', 15, 4);

-- encrollments
insert into enrollments (student_id, course_id, enrollment_date) values 
(1, 1, '2026-01-10'),
(1, 2, '2026-01-15'),
(2, 1, '2026-01-12'),
(2, 3, '2026-01-20'),
(3, 2, '2026-01-18'),
(3, 4, '2026-01-25'),
(4, 3, '2026-01-22'),
(4, 5, '2026-01-30'),
(5, 1, '2026-02-01');

-- scores
insert into scores (student_id, course_id, midterm_score, final_score) values
(1, 1, 8, 9),
(1, 2, 7, 8),
(2, 1, 6, 7),
(2, 3, 9, 10),
(3, 2, 5, 6),
(3, 4, 8, 9),
(4, 3, 7, 8),
(4, 5, 9, 10);

-- update data
-- update email for a student 
update students set email = 'nhomnhom@gmail.com' where student_id = 3;

-- update description for a course 
update courses set description = 'Learn the Go programming language and its applications in depth' where course_id = 5;

-- update fianl score for a student in a course 
update scores set final_score = 9 where student_id = 3 and course_id = 4;

-- delete data 
-- delete invalid enrollments ( doesn't have score )
delete from enrollments where (student_id, course_id) in (
  select e.student_id, e.course_id from enrollments e
  left join scores s
    on e.course_id = s.course_id
    and e.student_id = s.student_id
  where s.student_id is null
);

-- get all
select * from students;
select * from teahcers;
select * from courses;
select * from enrlloments;
select * from scores;
