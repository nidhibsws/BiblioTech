-- student entity table
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    email_address VARCHAR(100) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(12) NOT NULL
) ;

-- librarybranch entity table
CREATE TABLE librarybranch (
    branch_id INTEGER PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    street_address VARCHAR(255) NOT NULL
);

-- university admin entity table
CREATE TABLE university_admin (
    admin_id INTEGER PRIMARY KEY,
    email_address VARCHAR(100) NOT NULL,
    admin_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    branch_id INTEGER,
    FOREIGN KEY (branch_id) REFERENCES librarybranch(branch_id)
);

-- author entity table
CREATE TABLE author (
    author_id INTEGER PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
    
);

-- book entity table
CREATE TABLE book (
    ISBN VARCHAR(13) PRIMARY KEY,
    book_title VARCHAR(255) NOT NULL,
    author_id INTEGER NOT NULL,
    publication_year INT NOT NULL,
    genre VARCHAR(200)NOT NULL,
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- can_contain relation between book and Librarybranch entity
CREATE TABLE can_contain (
    ISBN VARCHAR(13),
    branch_id INTEGER,
    PRIMARY KEY (ISBN, branch_id),
    FOREIGN KEY (ISBN) REFERENCES book(ISBN),
    FOREIGN KEY (branch_id) REFERENCES librarybranch(branch_id)
);



-- published relation between author and book entity
 CREATE TABLE published (
    author_ID INTEGER NOT NULL,
    ISBN VARCHAR(13)NOT NULL,
    PRIMARY KEY (author_ID, ISBN),
    FOREIGN KEY (author_ID) REFERENCES author(author_ID),
    FOREIGN KEY (ISBN) REFERENCES book(ISBN)
);

-- part_of relation between student and librarybranch entity
CREATE TABLE part_of (
    student_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    PRIMARY KEY (student_id, branch_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (branch_id) REFERENCES librarybranch(branch_id)
);





-- book_fine entity table
CREATE TABLE book_fine (
    fine_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'unpaid',
    amount DECIMAL(10, 2) NOT NULL,
    reason VARCHAR(255) NOT NULL,
    fine_date DATE NOT NULL, 
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);



-- librarybranch entity table
CREATE TABLE loan (
    loan_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    loan_date DATE NOT NULL, 
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (ISBN) REFERENCES book(ISBN)
);







COMMIT;



