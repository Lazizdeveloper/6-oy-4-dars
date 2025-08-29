CREATE DATABASE online_dokon;

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role_id INT REFERENCES roles(role_id)
);




CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    category_id INT REFERENCES categories(category_id)
);


CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE course_categories (
    course_id INT REFERENCES courses(course_id),
    category_id INT REFERENCES categories(category_id),
    PRIMARY KEY (course_id, category_id)
);


CREATE TABLE lectures (
    lecture_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id),
    title VARCHAR(100) NOT NULL,
    content TEXT
);






INSERT INTO roles (role_name) VALUES
('Admin'),
('Student'),
('Instructor');


INSERT INTO users (username, email, role_id) VALUES
('ali', 'ali@gmail.com', 2),
('vali', 'vali@gmail.com', 2),
('admin', 'admin@gmail.com', 1);


INSERT INTO categories (category_name) VALUES
('Programming'),
('Design'),
('Marketing');


INSERT INTO courses (title, description, category_id) VALUES
('Python Programming', 'Learn Python from scratch', 1),
('UI/UX Design', 'Master UI/UX design principles', 2);


INSERT INTO course_categories (course_id, category_id) VALUES
(1, 1),
(2, 2);


INSERT INTO enrollments (user_id, course_id) VALUES
(1, 1),
(2, 2);


INSERT INTO payments (user_id, amount) VALUES
(1, 99.99),
(2, 149.99);


INSERT INTO lectures (course_id, title, content) VALUES
(1, 'Introduction to Python', 'Basics of Python programming'),
(1, 'Python Functions', 'Learn about functions in Python'),
(2, 'Introduction to UI/UX', 'Basics of UI/UX design');



SELECT u.username, c.title AS course_title, e.enrollment_date
FROM users u
JOIN enrollments e ON u.user_id = e.user_id
JOIN courses c ON e.course_id = c.course_id;


SELECT u.username, c.title AS course_title, p.amount, p.payment_date
FROM users u
JOIN enrollments e ON u.user_id = e.user_id
JOIN courses c ON e.course_id = c.course_id
JOIN payments p ON u.user_id = p.user_id;

SELECT c.title AS course_title, l.title AS lecture_title, l.content
FROM courses c
JOIN lectures l ON c.course_id = l.course_id;

SELECT u.username, u.email, r.role_name
FROM users u
JOIN roles r ON u.role_id = r.role_id;