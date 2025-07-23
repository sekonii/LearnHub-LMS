-- WAUU LMS Database Export
-- Compatible with PostgreSQL and SQLite
-- Generated on 2025-07-16

-- Create tables
CREATE TABLE IF NOT EXISTS user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) UNIQUE NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(256),
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS course (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    lecturer_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lecturer_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS enrollment (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (course_id) REFERENCES course(id),
    UNIQUE(user_id, course_id)
);

CREATE TABLE IF NOT EXISTS assignment (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    course_id INTEGER NOT NULL,
    max_points INTEGER DEFAULT 100,
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE IF NOT EXISTS submission (
    id SERIAL PRIMARY KEY,
    assignment_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    content TEXT,
    file_path VARCHAR(255),
    url VARCHAR(255),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assignment_id) REFERENCES assignment(id),
    FOREIGN KEY (student_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS grade (
    id SERIAL PRIMARY KEY,
    assignment_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    points_earned FLOAT DEFAULT 0,
    feedback TEXT,
    graded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assignment_id) REFERENCES assignment(id),
    FOREIGN KEY (student_id) REFERENCES user(id),
    UNIQUE(assignment_id, student_id)
);

CREATE TABLE IF NOT EXISTS discussion (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    course_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE IF NOT EXISTS post (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    discussion_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    parent_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (discussion_id) REFERENCES discussion(id),
    FOREIGN KEY (author_id) REFERENCES user(id),
    FOREIGN KEY (parent_id) REFERENCES post(id)
);

-- Insert sample data
-- Users (Admin, Lecturers, Students)
INSERT INTO user (username, email, password_hash, first_name, last_name, role) VALUES
('admin', 'admin@wauu.edu.bj', 'admin123', 'System', 'Administrator', 'admin'),
('drsmith', 'k.smith@wauu.edu.bj', 'lecturer123', 'Kwame', 'Smith', 'lecturer'),
('profjohnson', 'a.johnson@wauu.edu.bj', 'lecturer123', 'Adunni', 'Johnson', 'lecturer'),
('drbrown', 'o.brown@wauu.edu.bj', 'lecturer123', 'Olusegun', 'Brown', 'lecturer'),
('profdavis', 'n.davis@wauu.edu.bj', 'lecturer123', 'Nkechi', 'Davis', 'lecturer'),
('student001', 'ama.koffi@student.wauu.edu.bj', 'student123', 'Ama', 'Koffi', 'student'),
('student002', 'kwame.asante@student.wauu.edu.bj', 'student123', 'Kwame', 'Asante', 'student'),
('student003', 'fatou.diallo@student.wauu.edu.bj', 'student123', 'Fatou', 'Diallo', 'student'),
('student004', 'ibrahim.traore@student.wauu.edu.bj', 'student123', 'Ibrahim', 'Traore', 'student'),
('student005', 'grace.mensah@student.wauu.edu.bj', 'student123', 'Grace', 'Mensah', 'student'),
('student006', 'kofi.owusu@student.wauu.edu.bj', 'student123', 'Kofi', 'Owusu', 'student'),
('student007', 'aisha.bah@student.wauu.edu.bj', 'student123', 'Aisha', 'Bah', 'student'),
('student008', 'sekou.kone@student.wauu.edu.bj', 'student123', 'Sekou', 'Kone', 'student'),
('student009', 'adama.sankara@student.wauu.edu.bj', 'student123', 'Adama', 'Sankara', 'student'),
('student010', 'mariama.barry@student.wauu.edu.bj', 'student123', 'Mariama', 'Barry', 'student');

-- Courses
INSERT INTO course (code, title, description, lecturer_id) VALUES
('CS101', 'Introduction to Computer Science', 'Fundamental concepts of computer science and programming.', 2),
('MATH201', 'Calculus II', 'Advanced calculus including integration techniques and series.', 3),
('ENG101', 'Academic Writing', 'Essential writing skills for university-level communication.', 4),
('BUS301', 'Business Management', 'Principles and practices of modern business management.', 5),
('HIST205', 'West African History', 'Comprehensive study of West African historical developments.', 2),
('ECON101', 'Principles of Economics', 'Basic economic principles and market analysis.', 3);

-- Enrollments
INSERT INTO enrollment (user_id, course_id) VALUES
(6, 1), (7, 1), (8, 1), (9, 1), (10, 1),  -- CS101 enrollments
(6, 2), (7, 2), (8, 2), (11, 2),          -- MATH201 enrollments
(9, 3), (10, 3), (11, 3), (12, 3),        -- ENG101 enrollments
(6, 4), (13, 4), (14, 4), (15, 4),        -- BUS301 enrollments
(7, 5), (8, 5), (9, 5), (10, 5),          -- HIST205 enrollments
(11, 6), (12, 6), (13, 6), (14, 6);       -- ECON101 enrollments

-- Assignments
INSERT INTO assignment (title, description, course_id, max_points, due_date) VALUES
('Programming Basics', 'Introduction to Python programming concepts', 1, 100, '2025-08-15 23:59:00'),
('Data Structures Lab', 'Implementation of basic data structures', 1, 150, '2025-08-30 23:59:00'),
('Integration Techniques', 'Solve integration problems using various methods', 2, 100, '2025-08-20 23:59:00'),
('Series and Sequences', 'Analysis of mathematical series convergence', 2, 120, '2025-09-05 23:59:00'),
('Essay Writing', 'Academic essay on chosen topic with proper citations', 3, 100, '2025-08-25 23:59:00'),
('Research Paper', 'Original research project with literature review', 3, 200, '2025-09-15 23:59:00'),
('Business Plan', 'Develop a comprehensive business plan for a startup', 4, 150, '2025-08-28 23:59:00'),
('Market Analysis', 'Analyze market trends in West African economies', 4, 100, '2025-09-10 23:59:00'),
('Historical Timeline', 'Create detailed timeline of West African kingdoms', 5, 100, '2025-08-22 23:59:00'),
('Cultural Analysis', 'Analyze cultural exchanges in historical West Africa', 5, 120, '2025-09-08 23:59:00'),
('Economic Models', 'Apply economic models to real-world scenarios', 6, 100, '2025-08-26 23:59:00'),
('Policy Analysis', 'Evaluate the impact of economic policies', 6, 130, '2025-09-12 23:59:00');

-- Sample Submissions
INSERT INTO submission (assignment_id, student_id, content, submitted_at) VALUES
(1, 6, 'Here is my Python programming assignment with basic concepts covered...', '2025-07-15 10:30:00'),
(1, 7, 'My solution includes variables, loops, and functions as requested...', '2025-07-15 14:45:00'),
(3, 6, 'Integration solutions using substitution and parts methods...', '2025-07-15 16:20:00'),
(5, 9, 'Academic essay on the importance of digital literacy in education...', '2025-07-15 11:15:00'),
(7, 6, 'Business plan for eco-friendly packaging startup in Benin...', '2025-07-15 13:40:00');

-- Sample Grades
INSERT INTO grade (assignment_id, student_id, points_earned, feedback, graded_at) VALUES
(1, 6, 85.0, 'Good understanding of basic concepts. Work on code organization.', '2025-07-15 18:30:00'),
(1, 7, 92.0, 'Excellent work! Clean code and good documentation.', '2025-07-15 19:15:00'),
(3, 6, 78.0, 'Correct methods used. Show more work in calculations.', '2025-07-15 20:00:00');

-- Discussions
INSERT INTO discussion (title, description, course_id) VALUES
('Course Introduction', 'Welcome to CS101! Introduce yourself and share your programming goals.', 1),
('Programming Questions', 'Ask questions about Python programming and help your classmates.', 1),
('Calculus Applications', 'Discuss real-world applications of calculus in various fields.', 2),
('Integration Challenges', 'Share challenging integration problems and solutions.', 2),
('Writing Techniques', 'Share tips and techniques for effective academic writing.', 3),
('Research Methods', 'Discuss different approaches to academic research.', 3),
('Business Trends', 'Current trends in West African business environment.', 4),
('Entrepreneurship', 'Stories and advice for aspiring entrepreneurs.', 4),
('Historical Debates', 'Discuss controversial topics in West African history.', 5),
('Cultural Heritage', 'Preserving and celebrating West African cultural heritage.', 5),
('Economic Policies', 'Impact of government policies on economic development.', 6),
('Market Analysis', 'Current economic conditions and market opportunities.', 6),
('Study Groups', 'Form study groups and share learning resources.', 1),
('Assignment Help', 'Collaborative problem-solving for course assignments.', 2),
('Career Guidance', 'Advice for career development and job preparation.', 3),
('Project Ideas', 'Share and discuss innovative project concepts.', 4),
('Research Opportunities', 'Information about research programs and opportunities.', 5),
('Industry Insights', 'Insights from business and economic professionals.', 6);

-- Sample Posts
INSERT INTO post (content, discussion_id, author_id, created_at) VALUES
('Welcome everyone! I''m excited to learn Python programming this semester.', 1, 6, '2025-07-15 09:00:00'),
('Hello class! I have some experience with JavaScript and looking forward to Python.', 1, 7, '2025-07-15 09:30:00'),
('Can someone explain the difference between lists and tuples in Python?', 2, 8, '2025-07-15 11:00:00'),
('Great question! Lists are mutable while tuples are immutable. Lists use [] and tuples use ().', 2, 6, '2025-07-15 11:15:00'),
('Calculus is everywhere! From physics to economics, it helps us understand change and optimization.', 3, 7, '2025-07-15 14:00:00'),
('Academic writing requires clear structure: introduction, body paragraphs with evidence, and conclusion.', 5, 9, '2025-07-15 16:00:00');

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_user_role ON user(role);
CREATE INDEX IF NOT EXISTS idx_course_lecturer ON course(lecturer_id);
CREATE INDEX IF NOT EXISTS idx_enrollment_user ON enrollment(user_id);
CREATE INDEX IF NOT EXISTS idx_enrollment_course ON enrollment(course_id);
CREATE INDEX IF NOT EXISTS idx_assignment_course ON assignment(course_id);
CREATE INDEX IF NOT EXISTS idx_submission_assignment ON submission(assignment_id);
CREATE INDEX IF NOT EXISTS idx_submission_student ON submission(student_id);
CREATE INDEX IF NOT EXISTS idx_grade_assignment ON grade(assignment_id);
CREATE INDEX IF NOT EXISTS idx_grade_student ON grade(student_id);
CREATE INDEX IF NOT EXISTS idx_discussion_course ON discussion(course_id);
CREATE INDEX IF NOT EXISTS idx_post_discussion ON post(discussion_id);
CREATE INDEX IF NOT EXISTS idx_post_author ON post(author_id);