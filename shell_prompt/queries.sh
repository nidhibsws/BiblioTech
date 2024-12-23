#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64
"a23zafar/07099589@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)
(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF
SELECT student_name FROM student ORDER BY student_name; #List the names of all current students of the library in alphabetical order

SELECT book_title FROM book WHERE author_id = 4325; #List all the books by [insert author ID here]

SELECT book_title FROM book ORDER BY book_title; --listing all the books in alphabetical order

UPDATE student SET email_address = 'ali567@gmail.com',  phone_number = 111222334 WHERE student_id = 5167; #Update a student's address and phone number where student_id is given
SELECT email_address, phone_number FROM student WHERE student_id = 5167; #This is to see if the information is updated

INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (6759, 'judyy@gmail.com','Joudy Altidore', '444474437'); #adding a new student into our db
SELECT * FROM student WHERE student_id = 6754; #This is to see if the information is updated

SELECT * FROM can_contain WHERE ISBN = '533443' AND branch_id = 1111; #This is just to list the contents of the table


SELECT book_title, publication_year AS latest_books
FROM book
WHERE publication_year > 2004
ORDER BY publication_year DESC; #list book titles and publication years of books which were published after 2004, ordered by latest books

INSERT INTO author (author_id, author_name) VALUES (4332, 'J.K Rowling'); --inserting new author name and id
UPDATE author SET author_name = 'J.K. Rowling' WHERE author_id = 4332; #updated/corrected the author name we just inserted
SELECT DISTINCT author_name FROM author; #distinct author names to avoid duplication

UPDATE librarybranch SET branch_name = 'The Ryerson Library' WHERE branch_id = 3333; #updated branch name of the given id

SELECT loan_date FROM loan ORDER BY loan_date; #to view the upcoming loans in order

SELECT * FROM part_of; #view all columns from part_of (relation) table

SELECT * FROM published; #view all columns from published (relation) table

UPDATE university_admin SET phone_number = '6663338898' WHERE admin_id = 1234; --update the phone number of an university admin who's id is given
SELECT * FROM university_admin WHERE admin_id = 1234;

#This is to see if the information is updated

SELECT book_title, genre
FROM book
WHERE genre= 'sci-fi' OR genre='romance'
;

#list book titles and genre of books which are either 'sci-fi' or 'romance'

SELECT DISTINCT email_address FROM student; --to get unique email addreses of studens to prevent duplication

SELECT DISTINCT student_name FROM student; --to get unique student names of studens to prevent duplication


#COMPLEX QUERIES USING JOIN


#student name and id of students who have borrowed books from the library

SELECT s.student_name, s.student_id, l.loan_id, b.ISBN
FROM student s, loan l, book b
WHERE s.student_id = l.student_id
AND l.ISBN = b.ISBN;


#list the student id of students who's fines are unpaid and is below or equals to 5$

SELECT s.student_id, s.student_name
FROM student s
WHERE EXISTS (
SELECT f.student_id, f.amount
FROM book_fine f
WHERE f.student_id = s.student_id
AND status='unpaid' AND amount <= 5.00
);


#list all the students who don't have a loan due

SELECT s.student_id, s.student_name
FROM student s
WHERE NOT EXISTS (
SELECT l.student_id
FROM loan l
WHERE l.student_id = s.student_id
)
ORDER BY s.student_id ASC;


exit
EOF
