from app import db
from models import User, Course, Enrollment, Assignment, Discussion, Post
from datetime import datetime, timedelta

def init_sample_data():
    # Check if data already exists
    if User.query.first():
        return
    
    # Create Admin
    admin = User(
        username='admin',
        email='admin@wauu.edu.bj',
        first_name='System',
        last_name='Administrator',
        role='admin'
    )
    admin.set_password('admin123')
    db.session.add(admin)
    
    # Create Lecturers
    lecturers_data = [
        {'username': 'drsmith', 'email': 'smith@wauu.edu.bj', 'first_name': 'John', 'last_name': 'Smith'},
        {'username': 'profjohnson', 'email': 'johnson@wauu.edu.bj', 'first_name': 'Mary', 'last_name': 'Johnson'},
        {'username': 'drbrown', 'email': 'brown@wauu.edu.bj', 'first_name': 'Robert', 'last_name': 'Brown'},
        {'username': 'profdavis', 'email': 'davis@wauu.edu.bj', 'first_name': 'Sarah', 'last_name': 'Davis'}
    ]
    
    lecturers = []
    for lecturer_data in lecturers_data:
        lecturer = User(
            username=lecturer_data['username'],
            email=lecturer_data['email'],
            first_name=lecturer_data['first_name'],
            last_name=lecturer_data['last_name'],
            role='lecturer'
        )
        lecturer.set_password('password123')
        lecturers.append(lecturer)
        db.session.add(lecturer)
    
    # Create Students
    students_data = [
        {'username': 'student001', 'email': 'ama.koffi@student.wauu.edu.bj', 'first_name': 'Ama', 'last_name': 'Koffi'},
        {'username': 'student002', 'email': 'kwame.asante@student.wauu.edu.bj', 'first_name': 'Kwame', 'last_name': 'Asante'},
        {'username': 'student003', 'email': 'fatou.diallo@student.wauu.edu.bj', 'first_name': 'Fatou', 'last_name': 'Diallo'},
        {'username': 'student004', 'email': 'ibrahim.traore@student.wauu.edu.bj', 'first_name': 'Ibrahim', 'last_name': 'Traore'},
        {'username': 'student005', 'email': 'grace.mensah@student.wauu.edu.bj', 'first_name': 'Grace', 'last_name': 'Mensah'},
        {'username': 'student006', 'email': 'kofi.owusu@student.wauu.edu.bj', 'first_name': 'Kofi', 'last_name': 'Owusu'},
        {'username': 'student007', 'email': 'aisha.bah@student.wauu.edu.bj', 'first_name': 'Aisha', 'last_name': 'Bah'},
        {'username': 'student008', 'email': 'sekou.kone@student.wauu.edu.bj', 'first_name': 'Sekou', 'last_name': 'Kone'},
        {'username': 'student009', 'email': 'adama.sankara@student.wauu.edu.bj', 'first_name': 'Adama', 'last_name': 'Sankara'},
        {'username': 'student010', 'email': 'mariama.barry@student.wauu.edu.bj', 'first_name': 'Mariama', 'last_name': 'Barry'}
    ]
    
    students = []
    for student_data in students_data:
        student = User(
            username=student_data['username'],
            email=student_data['email'],
            first_name=student_data['first_name'],
            last_name=student_data['last_name'],
            role='student'
        )
        student.set_password('student123')
        students.append(student)
        db.session.add(student)
    
    db.session.commit()
    
    # Create Courses
    courses_data = [
        {
            'code': 'CS101',
            'title': 'Introduction to Computer Science',
            'description': 'Fundamental concepts of computer science including programming, algorithms, and data structures.',
            'lecturer': lecturers[0]
        },
        {
            'code': 'MATH201',
            'title': 'Calculus II',
            'description': 'Advanced calculus concepts including integration techniques, series, and differential equations.',
            'lecturer': lecturers[1]
        },
        {
            'code': 'ENG101',
            'title': 'Academic Writing',
            'description': 'Development of academic writing skills with focus on research and critical thinking.',
            'lecturer': lecturers[2]
        },
        {
            'code': 'BUS301',
            'title': 'Business Management',
            'description': 'Principles of business management, leadership, and organizational behavior.',
            'lecturer': lecturers[3]
        },
        {
            'code': 'HIST205',
            'title': 'West African History',
            'description': 'Study of West African civilizations, colonial period, and independence movements.',
            'lecturer': lecturers[0]
        },
        {
            'code': 'ECON101',
            'title': 'Principles of Economics',
            'description': 'Introduction to microeconomics and macroeconomics principles and applications.',
            'lecturer': lecturers[1]
        }
    ]
    
    courses = []
    for course_data in courses_data:
        course = Course(
            code=course_data['code'],
            title=course_data['title'],
            description=course_data['description'],
            lecturer_id=course_data['lecturer'].id
        )
        courses.append(course)
        db.session.add(course)
    
    db.session.commit()
    
    # Enroll students in courses (each student enrolled in 3-4 courses)
    enrollments_data = [
        (students[0], [courses[0], courses[1], courses[2]]),
        (students[1], [courses[0], courses[3], courses[4]]),
        (students[2], [courses[1], courses[2], courses[5]]),
        (students[3], [courses[0], courses[4], courses[5]]),
        (students[4], [courses[1], courses[3], courses[4]]),
        (students[5], [courses[0], courses[2], courses[5]]),
        (students[6], [courses[1], courses[3], courses[4]]),
        (students[7], [courses[0], courses[2], courses[3]]),
        (students[8], [courses[1], courses[4], courses[5]]),
        (students[9], [courses[0], courses[3], courses[5]])
    ]
    
    for student, student_courses in enrollments_data:
        for course in student_courses:
            enrollment = Enrollment(user_id=student.id, course_id=course.id)
            db.session.add(enrollment)
    
    db.session.commit()
    
    # Create sample assignments for each course
    for i, course in enumerate(courses):
        # Assignment 1
        assignment1 = Assignment(
            title=f'{course.code} - Assignment 1',
            description=f'First assignment for {course.title}. Please complete the assigned readings and submit your analysis.',
            course_id=course.id,
            max_points=100,
            due_date=datetime.utcnow() + timedelta(days=7)
        )
        db.session.add(assignment1)
        
        # Assignment 2
        assignment2 = Assignment(
            title=f'{course.code} - Midterm Project',
            description=f'Midterm project for {course.title}. This is a comprehensive assignment covering the first half of the semester.',
            course_id=course.id,
            max_points=150,
            due_date=datetime.utcnow() + timedelta(days=14)
        )
        db.session.add(assignment2)
    
    db.session.commit()
    
    # Create discussion threads for each course
    discussion_topics = [
        "Course Introduction and Expectations",
        "Weekly Discussion: Key Concepts",
        "Study Group Formation",
        "Q&A for Upcoming Assignment",
        "Course Resources and Materials"
    ]
    
    for course in courses:
        for i, topic in enumerate(discussion_topics[:3]):  # 3 discussions per course
            discussion = Discussion(
                title=f'{course.code} - {topic}',
                description=f'Discussion thread for {course.title}: {topic}',
                course_id=course.id
            )
            db.session.add(discussion)
            db.session.commit()
            
            # Add initial posts to discussions
            if i == 0:  # Course Introduction
                post = Post(
                    content=f'Welcome to {course.title}! Please introduce yourself and share your expectations for this course.',
                    discussion_id=discussion.id,
                    author_id=course.lecturer_id
                )
                db.session.add(post)
                
                # Add a few student responses
                for j, student in enumerate(students[:3]):
                    if Enrollment.query.filter_by(user_id=student.id, course_id=course.id).first():
                        student_post = Post(
                            content=f'Hello everyone! I am {student.get_full_name()} and I am excited to learn about {course.title}.',
                            discussion_id=discussion.id,
                            author_id=student.id
                        )
                        db.session.add(student_post)
    
    db.session.commit()
    
    print("Sample data initialized successfully!")
