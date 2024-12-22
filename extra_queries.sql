-- Query: Find all students with fines greater than 5.00
SELECT student_id, amount, reason
FROM book_fine
WHERE amount > 5.00;

-- find all students number in asc


-- Query: Find all students who belong to branch 1111 and have unpaid fines
SELECT p.student_id
FROM part_of p 
WHERE p.branch_id = 1111
AND EXISTS (
    SELECT *  FROM book_fine f
    WHERE f.student_id = p.student_id
    AND f.status = 'Unpaid'
);


-- Find all books that are either sci-fi or romance
SELECT ISBN, book_title, genre
FROM book 
WHERE genre = 'sci-fi' OR genre = 'romance';



--Query: Find all students who borrowed the book '1983' and list them in ascending order by student_id
SELECT s.student_id, s.student_name
FROM loan l, student s
WHERE l.ISBN = '633433'  -- ISBN for '1983'
AND l.student_id = s.student_id
ORDER BY s.student_id ASC;


--Query: Find all students, ordered by student_name in ascending order
SELECT student_id, student_name
FROM student
ORDER BY student_name ASC;


--Find students who have an unpaid fine
SELECT s.student_id, s.student_name
FROM student s
WHERE EXISTS (
    SELECT fine.student_id
    FROM book_fine fine
    WHERE fine.student_id = s.student_id
    AND fine.status = 'unpaid'
);

--Find students who have never borrowed any books.
SELECT s.student_id, s.student_name
FROM student s
WHERE NOT EXISTS (
    SELECT l.student_id
    FROM loan l
    WHERE l.student_id = s.student_id
);


--  count the number of students who's name start 
SELECT 
    COUNT(*) AS StudentCount
FROM 
    student
WHERE 
    student_name LIKE 'A%' 
    AND email_address LIKE '%gmail.com';


--- views:
view for Current Students in Alphabetical Order
CREATE VIEW CurrentStudents AS
SELECT student_name FROM student
ORDER BY student_name;

view for Books by a Specific Author
CREATE VIEW BooksByAuthor AS
SELECT book_title FROM book
WHERE author_id = 4325;  -- You can replace 4325 with a parameter if needed

View for Unpaid Fines
CREATE VIEW UnpaidFines AS
SELECT student_id, amount, reason FROM book_fine
WHERE status = 'unpaid';



----
#List of students without fines who are part of a specific library branch
SELECT *
FROM student
MINUS
(
    SELECT s.*
    FROM student s, book_fine bf
    WHERE s.student_id = bf.student_id
)
MINUS
(
    SELECT s.*
    FROM student s, part_of p
    WHERE s.student_id = p.student_id
      AND p.branch_id = (
          SELECT branch_id
          FROM librarybranch
          WHERE branch_name = 'SLC'  
      )
);

-----

#List of students with unpaid fines and the total amount they owe
SELECT 
    s.student_id, 
    s.student_name, 
    SUM(bf.amount) AS total_fines
FROM student s, book_fine bf 
WHERE EXISTS (
    SELECT * 
    FROM book_fine bf 
    WHERE bf.student_id = s.student_id AND bf.status = 'unpaid'
)
GROUP BY s.student_id, s.student_name
HAVING SUM(bf.amount) > 0;


#Calculate Total Unpaid Fines for All Students

SELECT 
    SUM(amount) AS total_unpaid_fines
FROM book_fine
WHERE status = 'unpaid';
