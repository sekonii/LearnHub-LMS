# WAUU LMS - Download Package

## Complete Application Files for Local Deployment

This package contains all files needed to run the WAUU Learning Management System locally.

### 📁 **Package Contents**

#### **Core Application Files**
- `app.py` - Flask application configuration and setup
- `main.py` - Application entry point for production
- `run_local.py` - **START HERE** - Local development server with SQLite
- `models.py` - Database models and relationships
- `routes.py` - All URL routes and view functions
- `decorators.py` - Security decorators for access control
- `init_data.py` - Sample data initialization

#### **Database Files**
- `wauu_lms_database_export.sql` - Complete database with sample data
- `REQUIREMENTS.txt` - Python dependencies list

#### **Templates Directory** (`templates/`)
- `base.html` - Main layout template
- `home.html` - Homepage with WAUU branding
- `auth/` - Login/registration templates
- `admin/` - Admin panel templates (users, analytics, system health)
- All course, assignment, and discussion templates

#### **Static Files** (`static/`)
- `css/style.css` - Custom WAUU styling
- `js/main.js` - Interactive JavaScript features
- `images/` - WAUU logo and assets

#### **Documentation**
- `LOCAL_DEPLOYMENT.md` - **READ FIRST** - Complete setup instructions
- `replit.md` - Project architecture and preferences

### 🚀 **Quick Start (Easiest Method)**

1. **Download all files** to a folder called `wauu-lms`

2. **Install Python 3.11+** from https://python.org

3. **Run the local server:**
   ```bash
   cd wauu-lms
   python run_local.py
   ```

4. **Access the application:** http://localhost:5000

5. **Login with:**
   - Admin: `admin` / `admin123`
   - Lecturer: `drsmith` / `lecturer123`
   - Student: `student001` / `student123`

### 🐘 **Production Setup (PostgreSQL)**

For production deployment with PostgreSQL:

1. **Install dependencies:**
   ```bash
   pip install Flask Flask-SQLAlchemy Flask-Login psycopg2-binary gunicorn email-validator Werkzeug SQLAlchemy
   ```

2. **Set up PostgreSQL database**

3. **Import the database:**
   ```bash
   psql -U username -d database_name -f wauu_lms_database_export.sql
   ```

4. **Set environment variables:**
   ```bash
   export DATABASE_URL="postgresql://username:password@localhost/database_name"
   export SESSION_SECRET="your_secret_key_here"
   ```

5. **Run with Gunicorn:**
   ```bash
   gunicorn --bind 0.0.0.0:5000 main:app
   ```

### 📋 **What's Included**

- **15 Users:** 1 admin, 4 lecturers, 10 students with authentic West African names
- **6 Courses:** Computer Science, Mathematics, English, Business, History, Economics
- **12 Assignments:** Varied across all courses with realistic deadlines
- **18 Discussions:** Course-specific discussion forums with sample posts
- **Complete Admin Panel:** User management, analytics, system monitoring
- **Role-based Access:** Different features for admin, lecturers, and students

### 🎨 **Features**

#### **For Administrators**
- Advanced user management with search, filter, bulk operations
- Analytics dashboard with charts and metrics
- System health monitoring
- CSV export functionality
- Course and assignment oversight

#### **For Lecturers**
- Course management and student enrollment
- Assignment creation and grading
- Discussion forum moderation
- Grade reporting and feedback

#### **For Students**
- Course enrollment and materials access
- Assignment submission (text, file, URL)
- Discussion participation
- Grade viewing and progress tracking
- Profile management

### 🔧 **Technical Features**

- **Responsive Design:** Works on desktop, tablet, and mobile
- **Wine-colored Theme:** Authentic WAUU university branding
- **File Upload System:** Secure file handling for assignments
- **Search and Filter:** Advanced filtering throughout the application
- **Charts and Analytics:** Visual data representation
- **Security:** Role-based access control and secure authentication

### ⚠️ **Important Notes**

- **Default Passwords:** Change all default passwords in production
- **Security:** The included passwords are for demonstration only
- **File Permissions:** Ensure the `uploads/` directory is writable
- **Database:** SQLite for development, PostgreSQL recommended for production

### 📞 **Support**

For questions or issues:
1. Check `LOCAL_DEPLOYMENT.md` for detailed setup instructions
2. Verify all Python dependencies are installed
3. Ensure database connection is working
4. Check application logs for error messages

### 🏛️ **About WAUU**

West African Union University (WAUU) is located in Cotonou, Benin. This Learning Management System was designed specifically for African educational institutions with authentic African names, proper academic structure, and cultural awareness.

---

**Last Updated:** July 16, 2025  
**Version:** 1.0.0  
**Compatible with:** Python 3.11+, PostgreSQL 12+, SQLite 3.35+