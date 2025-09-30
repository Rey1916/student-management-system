from flask import Flask, render_template, request, redirect, session, flash
import pyodbc

app = Flask(__name__)
app.secret_key = "your_secret_key_here_2024"

# Database Connection
def get_db_connection():
    try:
        conn_str = (
            "DRIVER={ODBC Driver 17 for SQL Server};"
            "SERVER=localhost\\SQLEXPRESS;"  # Update if using default instance
            "DATABASE=StudentDB;"
            "Trusted_Connection=yes;"
        )
        conn = pyodbc.connect(conn_str)
        return conn
    except pyodbc.Error as err:
        print(f"Database connection error: {err}")
        return None

@app.route("/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        conn = get_db_connection()
        if not conn:
            flash("Database connection failed! Please try again later.", "error")
            return render_template("login.html")

        cursor = conn.cursor()
        cursor.execute("SELECT student_id, name FROM Students WHERE username=? AND password=?", (username, password))
        user = cursor.fetchone()

        conn.close()

        if user:
            session["student_id"] = user[0]
            session["name"] = user[1]
            flash(f"Welcome {user[1]}!", "success")
            return redirect("/dashboard")
        else:
            flash("Invalid username or password.", "error")

    return render_template("login.html")

@app.route("/dashboard")
def dashboard():
    if "student_id" not in session:
        flash("Please login to view your dashboard.", "error")
        return redirect("/")

    student_id = session["student_id"]

    conn = get_db_connection()
    if not conn:
        flash("Database connection failed! Please try again later.", "error")
        return redirect("/")

    cursor = conn.cursor()
    
    # Simplified query that works with your current database structure
    cursor.execute("""
        SELECT C.course_name, A.attendance_percentage
        FROM Enrollments E
        JOIN Courses C ON E.course_id = C.course_id
        LEFT JOIN Attendance A ON E.student_id = A.student_id AND E.course_id = A.course_id
        WHERE E.student_id=?
        ORDER BY C.course_name
    """, (student_id,))
    courses = cursor.fetchall()

    # Get student info
    cursor.execute("SELECT name, username, student_id FROM Students WHERE student_id=?", (student_id,))
    student_info = cursor.fetchone()

    conn.close()

    return render_template("dashboard.html", name=session["name"], courses=courses, student_info=student_info)

@app.route("/logout")
def logout():
    session.clear()
    flash("You have been logged out successfully.", "info")
    return redirect("/")

if __name__ == "__main__":
    print("🚀 Starting Student Management System...")
    print("📡 Testing database connection...")
    
    conn = get_db_connection()
    if conn:
        print("✅ Database connection successful!")
        conn.close()
        print("🌐 Starting Flask server on http://127.0.0.1:5000")
        app.run(debug=True)
    else:
        print("❌ Cannot start application - Database connection failed!")
        print("📋 Please check your database connection settings.")
