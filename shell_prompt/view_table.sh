#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64
"a23zafar/07099589@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)
(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF

#this view is listing all the latest books in ascending order
CREATE VIEW latest_books AS
SELECT book_title, publication_year
FROM book
WHERE publication_year > 2004;


#this view is listing the names of all current students
CREATE VIEW studentlist AS
SELECT student_name
FROM student;


#this view is listing all unpaid fines
CREATE VIEW overdue_fine AS
SELECT fine_id, fine_date, amount
FROM book_fine
WHERE status='unpaid';


#this view is listing all books in the genre 'sci-fi'
CREATE VIEW scifi_books AS
( SELECT *
FROM  book
WHERE genre='sci-fi');


exit;
EOF
