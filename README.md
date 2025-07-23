# WAUU LMS - West African Union University Learning Management System

## Overview

This is a comprehensive Learning Management System (LMS) built with Flask for West African Union University in Cotonou, Benin. The system facilitates online education through course management, assignment distribution, discussion forums, and grade tracking. It supports three user roles: students, lecturers, and administrators, each with appropriate access controls and functionality.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Template Engine**: Jinja2 templates with Bootstrap 5 framework
- **UI Framework**: Bootstrap 5 with custom WAUU wine color theme (#8b4049)
- **Icons**: Font Awesome for consistent iconography
- **JavaScript**: Vanilla JavaScript for interactive features (tooltips, form validation, file upload preview)
- **Responsive Design**: Mobile-first approach with Bootstrap grid system

### Backend Architecture
- **Framework**: Flask (Python web framework) with modular structure
- **Database ORM**: SQLAlchemy with Flask-SQLAlchemy integration
- **Authentication**: Flask-Login for session management and user authentication
- **Security**: Basic password storage (plain text as specified), secure file uploads with MIME type validation
- **File Handling**: Werkzeug utilities for secure filename handling and file uploads
- **Middleware**: ProxyFix for handling reverse proxy headers

### Database Architecture
- **Primary Database**: SQLite (default) with PostgreSQL support via DATABASE_URL environment variable
- **ORM**: SQLAlchemy with declarative base model
- **Connection Management**: Connection pooling with automatic reconnection (pool_recycle: 300s, pool_pre_ping: True)
- **Schema**: Comprehensive relational model with proper foreign key relationships

## Key Components

### User Management System
- **Role-Based Access Control**: Three distinct roles (student, lecturer, admin) with appropriate permissions
- **Authentication**: Username/password based login with plain text password storage
- **User Profiles**: Complete user information management with profile editing capabilities
- **Access Control Decorators**: `@admin_required`, `@lecturer_required`, and `@student_required` for route protection

### Course Management
- **Course Creation**: Lecturers can create courses with unique course codes
- **Course Enrollment**: Students can enroll in available courses
- **Course Materials**: File upload system for course resources and materials
- **Instructor Assignment**: Courses are assigned to specific lecturers

### Assignment System
- **Multiple Submission Types**: Support for text submissions, file uploads, and URL submissions
- **Due Date Management**: Optional due dates with overdue detection
- **Point-Based Grading**: Configurable maximum points per assignment
- **Submission Tracking**: Complete history of student submissions with timestamps

### Discussion Forums
- **Course-Based Discussions**: Discussion threads tied to specific courses
- **Threaded Posts**: Support for posts and replies within discussions
- **Real-Time Interaction**: Students and lecturers can participate in course discussions

### Grading System
- **Assignment Grading**: Lecturer interface for grading with feedback
- **Grade Analytics**: Statistics and performance tracking for students
- **Grade Reports**: Comprehensive grade viewing for students

### File Management
- **Secure Upload**: File validation with allowed extensions (txt, pdf, images, documents, archives)
- **Size Limits**: 16MB maximum file size for uploads
- **Storage**: Local file system storage in uploads directory

## Data Flow

### Authentication Flow
1. User submits login credentials
2. System validates username and password against database
3. Flask-Login creates user session
4. Role-based access control determines available features

### Course Enrollment Flow
1. Admin or lecturer creates course
2. Students browse available courses
3. Students enroll in courses
4. Enrollment relationship created in database

### Assignment Workflow
1. Lecturer creates assignment for course
2. Students access assignment through course page
3. Students submit assignments (text, file, or URL)
4. Lecturer grades submissions and provides feedback
5. Grades are stored and visible to students

### Discussion Flow
1. Lecturer or student creates discussion thread
2. Course participants can view and post replies
3. Posts are displayed chronologically with author information

## External Dependencies

### Python Packages
- **Flask**: Web application framework
- **Flask-SQLAlchemy**: Database ORM integration
- **Flask-Login**: User session management
- **Werkzeug**: WSGI utilities and security helpers

### Frontend Dependencies
- **Bootstrap 5**: UI framework and responsive design
- **Font Awesome**: Icon library
- **jQuery**: JavaScript utilities (implied by Bootstrap usage)

### Database Support
- **SQLite**: Default development database
- **PostgreSQL**: Production database support via DATABASE_URL

## Deployment Strategy

### Development Setup
- **Local Development**: Uses SQLite database and Flask development server
- **Configuration**: Environment variables for database URL and session secret
- **File Storage**: Local uploads directory with automatic creation

### Production Considerations
- **Database**: PostgreSQL via DATABASE_URL environment variable
- **Session Security**: Configurable session secret via SESSION_SECRET environment variable
- **Proxy Support**: ProxyFix middleware for reverse proxy deployments
- **File Uploads**: Local file system storage (may need cloud storage for production scale)

### Environment Configuration
- **DATABASE_URL**: PostgreSQL connection string for production
- **SESSION_SECRET**: Secure session key for production
- **Debug Mode**: Controlled via Flask debug flag

The system is designed for educational institutions and provides a complete LMS solution with intuitive navigation, role-based access, and comprehensive course management features. The architecture supports both development and production deployments with minimal configuration changes.
