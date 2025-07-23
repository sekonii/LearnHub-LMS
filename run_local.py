#!/usr/bin/env python3
"""
WAUU LMS - Local Development Server
Run this script to start the application locally with SQLite database
"""

import os
import sys
from app import app, db

def setup_local_environment():
    """Configure the application for local development"""
    
    # Set local configuration
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///wauu_lms_local.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = 'local_development_secret_key_change_in_production'
    app.config['DEBUG'] = True
    
    # Ensure uploads directory exists
    os.makedirs('uploads', exist_ok=True)
    
    # Create database tables
    with app.app_context():
        print("Creating database tables...")
        db.create_all()
        
        # Check if we need to initialize data
        from models import User
        if User.query.count() == 0:
            print("Initializing sample data...")
            from init_data import init_sample_data
            init_sample_data()
            print("Sample data initialized successfully!")
        else:
            print("Database already contains data.")

def main():
    """Main function to run the local server"""
    
    print("WAUU LMS - Local Development Server")
    print("=" * 40)
    
    # Setup local environment
    setup_local_environment()
    
    print("\nStarting local development server...")
    print("Access the application at: http://localhost:5000")
    print("\nDefault login credentials:")
    print("Admin - Username: admin, Password: admin123")
    print("Lecturer - Username: drsmith, Password: lecturer123") 
    print("Student - Username: student001, Password: student123")
    print("\nPress Ctrl+C to stop the server")
    print("-" * 40)
    
    try:
        # Run the development server
        app.run(
            host='0.0.0.0',
            port=5000,
            debug=True,
            use_reloader=True
        )
    except KeyboardInterrupt:
        print("\nServer stopped by user.")
        sys.exit(0)

if __name__ == '__main__':
    main()