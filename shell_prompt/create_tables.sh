#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64
"*****/*****@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)
(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF

CREATE TABLE AUTHOR{
        author_id INTEGER PRIMARY KEY,
        author_name VARCHAR(100) NOT NULL

};

CREATE TABLE BOOK{
        ISBN VARCHAR(13) PRIMARY KEY,
        book_title VARCHAR(255) NOT NULL,
        author_id INTEGER NOT NULL,
        publication_year INT NOT NULL,
        genre VARCHAR(200)NOT NULL,
        FOREIGN KEY (author_id) REFERENCES author(author_id)
};

CREATE TABLE BOOK_FINE{
        fine_id INTEGER PRIMARY KEY,
        student_id INTEGER NOT NULL,
        status VARCHAR(20) DEFAULT 'unpaid',
        amount DECIMAL(10, 2) NOT NULL,
        reason VARCHAR(255) NOT NULL,
        fine_date DATE NOT NULL,
        FOREIGN KEY (student_id) REFERENCES student(student_id)
};

CREATE TABLE CAN_CONTAIN {
        ISBN VARCHAR(13),
        branch_id INTEGER,
        PRIMARY KEY (ISBN, branch_id),
        FOREIGN KEY (ISBN) REFERENCES book(ISBN),
        FOREIGN KEY (branch_id) REFERENCES librarybranch(branch_id)
};

CREATE TABLE LIBRARYBRANCH {
        branch_id INTEGER PRIMARY KEY,
        branch_name VARCHAR(100) NOT NULL,
        contact_number VARCHAR(15) NOT NULL,
        city VARCHAR(100) NOT NULL,
        postal_code VARCHAR(20) NOT NULL,
        street_address VARCHAR(255) NOT NULL
};

CREATE TABLE LOAN {
        loan_id INTEGER PRIMARY KEY,
        student_id INTEGER NOT NULL,
        ISBN VARCHAR(13) NOT NULL,
        loan_date DATE NOT NULL,
        FOREIGN KEY (student_id) REFERENCES student(student_id),
        FOREIGN KEY (ISBN) REFERENCES book(ISBN)
};

CREATE TABLE PART_OF {
        student_id INTEGER NOT NULL,
        branch_id INTEGER NOT NULL,
        PRIMARY KEY (student_id, branch_id),
        FOREIGN KEY (student_id) REFERENCES student(student_id),
        FOREIGN KEY (branch_id) REFERENCES librarybranch(branch_id)
};

CREATE TABLE PUBLISHED {
        author_ID INTEGER NOT NULL,
        ISBN VARCHAR(13)NOT NULL,
        PRIMARY KEY (author_ID, ISBN),
        FOREIGN KEY (author_ID) REFERENCES author(author_ID),
        FOREIGN KEY (ISBN) REFERENCES book(ISBN)
};

CREATE TABLE STUDENT {
        student_id INTEGER PRIMARY KEY,
        email_address VARCHAR(100) NOT NULL,
        student_name VARCHAR(100) NOT NULL,
        phone_number VARCHAR(12) NOT NULL
};

CREATE TABLE UNIVERSITY_ADMIN {
        admin_id INTEGER PRIMARY KEY,
        email_address VARCHAR(100) NOT NULL,
        admin_name VARCHAR(100) NOT NULL,
        phone_number VARCHAR(12) NOT NULL,
        branch_id INTEGER,
        FOREIGN KEY (branch_id) REFERENCES librarybranch(branch_id)
};
exit;
EOF
