# WAUU LMS - Local Deployment Guide

## Prerequisites

Before running the WAUU LMS locally, ensure you have the following installed:

1. **Python 3.11 or higher**
   - Download from: https://www.python.org/downloads/
   - Verify installation: `python --version`

2. **PostgreSQL Database**
   - Download from: https://www.postgresql.org/download/
   - Or use Docker: `docker run --name wauu-postgres -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres`

3. **Git** (optional, for version control)
   - Download from: https://git-scm.com/downloads/

## Installation Steps

### 1. Download the Project Files

Download all project files to your local machine and place them in a folder called `wauu-lms`.

### 2. Set Up Python Virtual Environment

```bash
# Navigate to project directory
cd wauu-lms

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install flask flask-sqlalchemy flask-login psycopg2-binary gunicorn email-validator werkzeug sqlalchemy
```

### 4. Set Up PostgreSQL Database

#### Option A: Using PostgreSQL Server
1. Create a new database:
   ```sql
   CREATE DATABASE wauu_lms;
   CREATE USER wauu_user WITH PASSWORD 'wauu_password';
   GRANT ALL PRIVILEGES ON DATABASE wauu_lms TO wauu_user;
   ```

2. Import the provided database dump:
   ```bash
   psql -h localhost -U wauu_user -d wauu_lms -f wauu_lms_database.sql
   ```

#### Option B: Using Docker
```bash
# Start PostgreSQL container
docker run --name wauu-postgres -e POSTGRES_DB=wauu_lms -e POSTGRES_USER=wauu_user -e POSTGRES_PASSWORD=wauu_password -p 5432:5432 -d postgres

# Import database (after container is running)
docker exec -i wauu-postgres psql -U wauu_user -d wauu_lms < wauu_lms_database.sql
```

### 5. Configure Environment Variables

Create a `.env` file in the project root:

```bash
# Database Configuration
DATABASE_URL=postgresql://wauu_user:wauu_password@localhost:5432/wauu_lms

# Session Security
SESSION_SECRET=your_secret_key_here_change_in_production

# Flask Configuration
FLASK_ENV=development
FLASK_DEBUG=True
```

### 6. Initialize the Application

```bash
# Create uploads directory
mkdir uploads

# Run the application
python main.py
```

Or using Gunicorn (recommended for production-like testing):

```bash
gunicorn --bind 0.0.0.0:5000 --reuse-port --reload main:app
```

## Access the Application

1. Open your web browser
2. Navigate to: `http://localhost:5000`
3. The homepage will load with the WAUU branding

## Default Login Credentials

### Administrator Account
- **Username**: `admin`
- **Password**: `admin123`
- **Role**: Administrator (full access)

### Sample Lecturer Accounts
- **Username**: `drsmith` | **Password**: `lecturer123`
- **Username**: `profjohnson` | **Password**: `lecturer123`
- **Username**: `drbrown` | **Password**: `lecturer123`
- **Username**: `profdavis` | **Password**: `lecturer123`

### Sample Student Accounts
- **Username**: `student001` | **Password**: `student123`
- **Username**: `student002` | **Password**: `student123`
- (Additional student accounts: student003-student010, all with password: `student123`)

## Features Available

### For Administrators
- User management (create, edit, delete users)
- Course management (create, edit, delete courses)
- Analytics dashboard with charts and metrics
- System health monitoring
- Bulk operations on users
- CSV export functionality

### For Lecturers
- Course management (own courses)
- Assignment creation and grading
- Student enrollment management
- Discussion forum moderation

### For Students
- Course enrollment
- Assignment submission (text, file, URL)
- Discussion participation
- Grade viewing
- Profile management

## File Structure

```
wauu-lms/
├── app.py                  # Flask application configuration
├── main.py                 # Application entry point
├── models.py               # Database models
├── routes.py               # URL routes and view functions
├── decorators.py           # Access control decorators
├── init_data.py           # Sample data initialization
├── static/                 # CSS, JavaScript, images
│   ├── css/
│   ├── js/
│   └── images/
├── templates/              # HTML templates
│   ├── admin/             # Admin panel templates
│   ├── auth/              # Authentication templates
│   └── ...
├── uploads/               # User uploaded files
└── wauu_lms_database.sql  # Database dump file
```

## Troubleshooting

### Database Connection Issues
1. Verify PostgreSQL is running: `pg_isready -h localhost -p 5432`
2. Check database credentials in `.env` file
3. Ensure database exists: `psql -l`

### Permission Errors
1. Check file permissions: `chmod 755 main.py`
2. Verify uploads directory is writable: `chmod 755 uploads/`

### Port Already in Use
1. Change port in command: `python main.py --port 8000`
2. Or kill existing process: `lsof -ti:5000 | xargs kill -9`

### Missing Dependencies
```bash
pip install --upgrade pip
pip install -r requirements.txt  # if you create one
```

## Production Deployment

For production deployment:

1. Set `FLASK_ENV=production` in environment variables
2. Use a proper WSGI server (Gunicorn, uWSGI)
3. Set up reverse proxy (Nginx, Apache)
4. Use environment variables for sensitive data
5. Enable SSL/TLS certificates
6. Set up database backups
7. Configure logging and monitoring

## Database Backup

To create a backup of your database:

```bash
pg_dump postgresql://wauu_user:wauu_password@localhost:5432/wauu_lms > backup_$(date +%Y%m%d_%H%M%S).sql
```

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Flask and PostgreSQL documentation
3. Verify all dependencies are correctly installed
4. Check application logs for error messages

## Security Notes

- Change default passwords in production
- Use strong SESSION_SECRET
- Enable HTTPS in production
- Regularly update dependencies
- Monitor access logs
- Implement rate limiting for production use

---

**Note**: This local deployment guide is for development and testing purposes. For production deployment, additional security measures and optimizations should be implemented.