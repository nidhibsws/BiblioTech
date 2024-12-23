from flask import Flask, render_template, jsonify, request
import cx_Oracle
import os

app = Flask(__name__)

os.environ["PATH"] = r"C:\Users\Alizeh Zafar\Downloads\instantclient-basic-windows.x64-23.6.0.24.10\instantclient_23_6" + ";" + os.environ["PATH"]

dsn = cx_Oracle.makedsn('oracle12c.scs.ryerson.ca', '1521', sid='orcl12c')

#creating connection to the oracle server
try:
    connection = cx_Oracle.connect(user='a23zafar', password='07099589', dsn=dsn)
    print("Connection successful!")
except cx_Oracle.DatabaseError as e:
    error, = e.args
    print(f"Oracle Database connection error: {error.message}")

@app.route('/')
def index():
    return render_template('index.html')

#drop tables
@app.route('/dropTables', methods=['POST'])
def drop_tables():
    try:
        cursor = connection.cursor()
        cursor.execute("""
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE AUTHOR CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE BOOK CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE BOOK_FINE CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE CAN_CONTAIN CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE LIBRARYBRANCH CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE LOAN CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE PART_OF CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE PUBLISHED CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE STUDENT CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE 'DROP TABLE UNIVERSITY_ADMIN CASCADE CONSTRAINTS';
        EXCEPTION
            WHEN OTHERS THEN
                NULL;  -- Ignore error if table doesn't exist
        END;
        """)
        connection.commit()
        cursor.close()
        return jsonify({"output": "Tables dropped successfully!"})
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        return jsonify({"output": f"Error dropping tables: {error.message}"})

#create tables
@app.route('/createTables', methods=['POST'])
def create_tables():
    try:
        cursor = connection.cursor()

        cursor.execute("""
        CREATE TABLE LIBRARYBRANCH (
            branch_id INTEGER PRIMARY KEY,
            branch_name VARCHAR(100) NOT NULL,
            contact_number VARCHAR(15) NOT NULL,
            city VARCHAR(100) NOT NULL,
            street_address VARCHAR(255) NOT NULL
        )
        """)

        cursor.execute("""
        CREATE TABLE STUDENT (
            student_id INTEGER PRIMARY KEY,
            email_address VARCHAR(100) NOT NULL,
            student_name VARCHAR(100) NOT NULL,
            phone_number VARCHAR(12) NOT NULL
        )
        """)

        cursor.execute("""
        CREATE TABLE AUTHOR (
            author_id INTEGER PRIMARY KEY,
            author_name VARCHAR(100) NOT NULL
        )
        """)

        cursor.execute("""
        CREATE TABLE BOOK (
            ISBN VARCHAR(13) PRIMARY KEY,
            book_title VARCHAR(255) NOT NULL,
            author_id INTEGER NOT NULL,
            publication_year INT NOT NULL,
            genre VARCHAR(200) NOT NULL,
            FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id)
        )
        """)

        cursor.execute("""
        CREATE TABLE LOAN (
            loan_id INTEGER PRIMARY KEY,
            student_id INTEGER NOT NULL,
            ISBN VARCHAR(13) NOT NULL,
            loan_date DATE NOT NULL,
            FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
            FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
        )
        """)

        cursor.execute("""
        CREATE TABLE PART_OF (
            student_id INTEGER NOT NULL,
            branch_id INTEGER NOT NULL,
            PRIMARY KEY (student_id, branch_id),
            FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
            FOREIGN KEY (branch_id) REFERENCES LIBRARYBRANCH(branch_id)
        )
        """)

        cursor.execute("""
        CREATE TABLE PUBLISHED (
            author_ID INTEGER NOT NULL,
            ISBN VARCHAR(13) NOT NULL,
            PRIMARY KEY (author_ID, ISBN),
            FOREIGN KEY (author_ID) REFERENCES AUTHOR(author_ID),
            FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
        )
        """)

        cursor.execute("""
        CREATE TABLE BOOK_FINE (
            fine_id INTEGER PRIMARY KEY,
            student_id INTEGER NOT NULL,
            status VARCHAR(20) DEFAULT 'unpaid',
            amount DECIMAL(10, 2) NOT NULL,
            reason VARCHAR(255) NOT NULL,
            fine_date DATE NOT NULL,
            FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
        )
        """)

        cursor.execute("""
        CREATE TABLE CAN_CONTAIN (
            ISBN VARCHAR(13),
            branch_id INTEGER,
            PRIMARY KEY (ISBN, branch_id),
            FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN),
            FOREIGN KEY (branch_id) REFERENCES LIBRARYBRANCH(branch_id)
        )
        """)

        cursor.execute("""
        CREATE TABLE UNIVERSITY_ADMIN (
            admin_id INTEGER PRIMARY KEY,
            email_address VARCHAR(100) NOT NULL,
            admin_name VARCHAR(100) NOT NULL,
            phone_number VARCHAR(12) NOT NULL,
            branch_id INTEGER,
            FOREIGN KEY (branch_id) REFERENCES LIBRARYBRANCH(branch_id)
        )
        """)

        connection.commit()
        cursor.close()
        return jsonify({"output": "Tables created successfully!"})
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        return jsonify({"output": f"Error creating tables: {error.message}"})
    

#populate table 
@app.route('/populateTables', methods=['POST'])
def populate_tables():
    try:
        cursor = connection.cursor()
    
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5167, 'ali@gmail.com', 'Alizeh Zafar', 111222333)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5165, 'nid@gmail.com', 'Nidhi Biswas', 888999444)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5156, 'do@gmail.com', 'Do Young Lee', 123789)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (4167, 'ash@gmail.com', 'Ashley Tisdale', 333444555)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (3167, 'mari@gmail.com', 'Mariah Carey', 444555666)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5368, 'brit@gmail.com', 'Brittney Tisdale', 555666777)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (9876, 'kelly@gmail.com', 'Kelly Song', 666777888)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (1162, 'ken@gmail.com', 'Kendall James', 777888999)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5016, 'pet@gmail.com', 'Peter McKinney', 888999000)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (7165, 'john@gmail.com', 'John Laughlin', 987654320)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (2160, 'james@gmail.com', 'James', 980380490)""")
        cursor.execute("""INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (1331, 'tim@gmail.com', 'Timmy', 999444433)""")

        cursor.execute("""INSERT INTO author (author_id, author_name) VALUES (4325, 'George Orwell')""")
        cursor.execute("""INSERT INTO author (author_id, author_name) VALUES (4326, 'Jacqueline Wilson')""")
        cursor.execute("""INSERT INTO author (author_id, author_name) VALUES (4327, 'Lewis Carroll')""")
        cursor.execute("""INSERT INTO author (author_id, author_name) VALUES (4328, 'Erin Morgenstern')""")
        cursor.execute("""INSERT INTO author (author_id, author_name) VALUES (4329, 'Mark Twain')""")
        cursor.execute("""INSERT INTO author (author_id, author_name) VALUES (4331, 'J.K. Rowling')""")

        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('533443', 'Over the Blue Tree', 4331, 2000, 'sci-fi')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('633433', '1983', 4325, 2001, 'horror')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('733253', 'Secret Seven', 4331, 2002, 'romance')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('833873', 'Bumblebee', 4329, 2003, 'comedy')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('933953', 'The Night Circus', 4328, 2004, 'fiction')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('133023', 'Animal Farm', 4325, 2005, 'fiction')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('233483', 'Tracy Beaker', 4326, 2006, 'horror')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('333213', 'My Sister Jodie', 4326, 2007, 'sci-fi')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('433013', 'Here Come the Mountains', 4327, 2008, 'romance')""")
        cursor.execute("""INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('533023', 'My Sweet Betty', 4329, 2009, 'sci-fi')""")

        cursor.execute("""INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, street_address) VALUES (1111, 'DCC', '6661112222', 'Toronto', '87 Martin Blvd')""")
        cursor.execute("""INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, street_address) VALUES (2222, 'GCC', '6461112222', 'Toronto', '93 Ashville Ave')""")
        cursor.execute("""INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, street_address) VALUES (3333, 'ECC', '6651112222', 'Toronto', '32 Corning rd')""")
        cursor.execute("""INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, street_address) VALUES (4444, 'SLC', '6661112282', 'Toronto', '45 Leslie St')""")

        cursor.execute("""INSERT INTO can_contain (ISBN, branch_id) VALUES ('533443', 1111)""")
        cursor.execute("""INSERT INTO can_contain (ISBN, branch_id) VALUES ('633433', 2222)""")
        cursor.execute("""INSERT INTO can_contain (ISBN, branch_id) VALUES ('733253', 3333)""")
        cursor.execute("""INSERT INTO can_contain (ISBN, branch_id) VALUES ('833873', 4444)""")
        cursor.execute("""INSERT INTO can_contain (ISBN, branch_id) VALUES ('933953', 1111)""")
        cursor.execute("""INSERT INTO can_contain (ISBN, branch_id) VALUES ('133023', 2222)""")

        cursor.execute("""INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (1432, 5167, 'unpaid', 5.00, 'book not returned by due date', TO_DATE('2023-08-31','YYYY-MM-DD'))""")
        cursor.execute("""INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (2332, 5156, 'unpaid', 3.50, 'book damaged', TO_DATE('2023-07-20','YYYY-MM-DD'))""")
        cursor.execute("""INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (3123, 5165, 'paid', 4.00, 'book lost', TO_DATE('2023-06-15','YYYY-MM-DD'))""")
        cursor.execute("""INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (4653, 9876, 'unpaid', 2.75, 'late return', TO_DATE('2023-05-10','YYYY-MM-DD'))""")
        cursor.execute("""INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (5534, 5016, 'paid', 6.25, 'missing pages', TO_DATE('2023-04-05','YYYY-MM-DD'))""")

        cursor.execute("""INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1234, 'ad1@fakeuniversity.ca','John Adams','9998887777',1111)""")
        cursor.execute("""INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1235, 'ad2@fakeuniversity.ca','Kelly McCarthy','9994447777',2222)""")
        cursor.execute("""INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1236, 'ad3@fakeuniversity.ca','James Bond','9998887332',3333)""")
        cursor.execute("""INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1237, 'ad4@fakeuniversity.ca','Riley Stone','9458887777',4444)""")

        cursor.execute("""INSERT INTO loan (loan_id, student_id, ISBN, loan_date) VALUES (6543, 5167, '533443', TO_DATE('2023-07-20','YYYY-MM-DD'))""")
        cursor.execute("""INSERT INTO loan (loan_id, student_id, ISBN, loan_date) VALUES (6544, 5165, '633433', TO_DATE('2023-08-20','YYYY-MM-DD'))""")
        cursor.execute("""INSERT INTO loan (loan_id, student_id, ISBN, loan_date) VALUES (6546, 5156, '733253', TO_DATE('2023-09-20','YYYY-MM-DD'))""")

        cursor.execute("""INSERT INTO part_of (student_id, branch_id) VALUES (5167, 1111)""")
        cursor.execute("""INSERT INTO part_of (student_id, branch_id) VALUES (5165, 2222)""")
        cursor.execute("""INSERT INTO part_of (student_id, branch_id) VALUES (5156, 3333)""")

        cursor.execute("""INSERT INTO published (author_id, ISBN) VALUES (4325, '533443')""")
        cursor.execute("""INSERT INTO published (author_id, ISBN) VALUES (4326, '633433')""")
        cursor.execute("""INSERT INTO published (author_id, ISBN) VALUES (4327, '733253')""")
        cursor.execute("""INSERT INTO published (author_id, ISBN) VALUES (4328, '333213')""")

        connection.commit()
        cursor.close()
        return jsonify({"output": "Tables populated successfully!"})
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        return jsonify({"output": f"Error populating tables: {error.message}"})

#create view
@app.route('/createView', methods=['POST'])
def create_view():
    try:
        cursor = connection.cursor()

        cursor.execute("DROP VIEW latest_books")
        cursor.execute("""
        CREATE VIEW latest_books AS
        SELECT book_title, publication_year
        FROM book
        WHERE publication_year > 2004
        """)

        cursor.execute("DROP VIEW studentlist")
        cursor.execute("""
        CREATE VIEW studentlist AS
        SELECT student_name
        FROM student
        """)

        cursor.execute("DROP VIEW overdue_fine")
        cursor.execute("""
        CREATE VIEW overdue_fine AS
        SELECT fine_id, fine_date, amount
        FROM book_fine
        WHERE status='unpaid'
        """)

        cursor.execute("DROP VIEW scifi_books")
        cursor.execute("""
        CREATE VIEW scifi_books AS
        SELECT *
        FROM book
        WHERE genre='sci-fi'
        """)

        connection.commit()
        cursor.close()
        return jsonify({"output": "Views created successfully!"})
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        return jsonify({"output": f"Error creating views: {error.message}"})

    
@app.route('/queryTables', methods=['POST'])
def query_tables():
    try:
        cursor = connection.cursor()

        #studnet list
        cursor.execute("SELECT student_name FROM student ORDER BY student_name")
        student_names = cursor.fetchall()
        student_names = [name[0] for name in student_names]

        #book by author
        cursor.execute("SELECT book_title FROM book WHERE author_id = 4325")
        books_by_author = cursor.fetchall()
        books_by_author = [book[0] for book in books_by_author]

        #book title
        cursor.execute("SELECT book_title FROM book ORDER BY book_title")
        all_books = cursor.fetchall()
        all_books = [book[0] for book in all_books]

        #update student
        cursor.execute("""
            UPDATE student 
            SET email_address = 'ali567@gmail.com', phone_number = '111222334' 
            WHERE student_id = 5167
        """)
        cursor.execute("SELECT email_address, phone_number FROM student WHERE student_id = 5167")
        updated_student_info = cursor.fetchone()

        connection.commit()
        cursor.close()

        return jsonify({
            "status": "success",
            "student_names": student_names,
            "books_by_author": books_by_author,
            "all_books": all_books,
            "updated_student_info": {
                "email": updated_student_info[0],
                "phone": updated_student_info[1]
            }
        })
    except Exception as e:
        print("Error:", str(e)) 
        return jsonify({"status": "error", "message": str(e)}), 500

#new added part
#search student record by id
@app.route('/searchRecords', methods=['GET'])
def search_records():
    try:
        search_term = request.args.get('term', '').strip()

        cursor = connection.cursor()

        #search id
        cursor.execute("SELECT student_name, email_address FROM student WHERE student_id = :id", {'id': int(search_term)})
        student_results = cursor.fetchall()

        #no results found
        if not student_results:
            return jsonify({"status": "error", "message": f"No student found with ID {search_term}."}), 404

        #get name and email
        student_data = [{"name": row[0], "email": row[1]} for row in student_results]
        cursor.close()

        return jsonify({
            "status": "success",
            "students": student_data
        })

    except Exception as e:
        print("Error:", str(e)) 
        return jsonify({"status": "error", "message": str(e)}), 500


    
#delete student
@app.route('/deleteRecord/<int:record_id>', methods=['DELETE'])
def delete_record(record_id):
    try:
        cursor = connection.cursor()

        #delete student id 
        cursor.execute("DELETE FROM student WHERE student_id = :id", {'id': record_id})
        affected_rows = cursor.rowcount

        connection.commit()
        cursor.close()

        #delete result
        if affected_rows == 0:
            return jsonify({"status": "error", "message": f"No record found with ID {record_id}"}), 404

        return jsonify({"status": "success", "message": f"Record with ID {record_id} deleted successfully."})

    except Exception as e:
        print("Error in delete_record:", str(e))
        return jsonify({"status": "error", "message": str(e)}), 500


#update email
@app.route('/updateEmail/<int:student_id>', methods=['PUT'])
def update_email(student_id):
    try:
        #get new email
        data = request.json
        new_email = data.get('email', '').strip()

        cursor = connection.cursor()

        #update student id and corresponding email
        cursor.execute(
            "UPDATE student SET email_address = :email WHERE student_id = :id",
            {'email': new_email, 'id': student_id}
        )
        affected_rows = cursor.rowcount

        connection.commit()
        cursor.close()

        if affected_rows == 0:
            return jsonify({"status": "error", "message": f"No record found with ID {student_id}"}), 404

        return jsonify({"status": "success", "message": f"Email updated successfully for student ID {student_id}."})
    
    except Exception as e:
        print("Error in update_email:", str(e))
        return jsonify({"status": "error", "message": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)
