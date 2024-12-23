#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64
"a23zafar/07099589@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)
(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF

INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5167, 'ali@gmail.com', 'Alizeh Zafar', 111222333);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5165, 'nid@gmail.com', 'Nidhi Biswas', 888999444);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5156, 'do@gmail.com', 'Do Young Lee', 123789);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (4167, 'ash@gmail.com', 'Ashley Tisdale', 333444555);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (3167, 'mari@gmail.com', 'Mariah Carey', 444555666);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5368, 'brit@gmail.com', 'Brittney Tisdale', 555666777);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (9876, 'kelly@gmail.com', 'Kelly Song', 666777888);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (0162, 'ken@gmail.com', 'Kendall James', 777888999);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (5016,'pet@gmail.com', 'Peter McKinney', 888999000);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (7165, 'john@gmail.com', 'John Laughlin', 987654320);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (2160, 'james@gmail.com', 'James', 980380490);
INSERT INTO student (student_id, email_address, student_name, phone_number) VALUES (1331, 'tim@gmail.com', 'Timmy', 999444433);

INSERT INTO author (author_id, author_name) VALUES (4325, 'George Orwell');
INSERT INTO author (author_id, author_name) VALUES (4326, 'Jacqueline Wilson');
INSERT INTO author (author_id, author_name) VALUES (4327, 'Lewis Carroll');
INSERT INTO author (author_id, author_name) VALUES (4328, 'Erin Morgenstern');
INSERT INTO author (author_id, author_name) VALUES (4329, 'Mark Twain');
INSERT INTO author (author_id, author_name) VALUES (4331, 'J.K. Rowling');

INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('533443', 'Over the Blue Tree', 4331, 2000, 'sci-fi');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('633433', '1983', 4325, 2001, 'horror');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('733253', 'Secret Seven', 4331, 2002, 'romance');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('833873', 'Bumblebee', 4329, 2003, 'comedy');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('933953', 'The Night Circus', 4328, 2004, 'fiction');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('133023', 'Animal Farm', 4325, 2005, 'fiction');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('233483', 'Tracy Beaker', 4326, 2006, 'horror');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('333213', 'My Sister Jodie', 4326, 2007, 'sci-fi');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('433013', 'Here Come the Mountains', 4327, 2008, 'romance');
INSERT INTO book (ISBN, book_title, author_id, publication_year, genre) VALUES ('533023', 'My Sweet Betty', 4329, 2009, 'sci-fi');

INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, postal_code, street_address) VALUES (1111, 'DCC', '6661112222', 'Toronto', 'M3U 4M7', '87 Martin Blvd');
INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, postal_code, street_address) VALUES (2222, 'GCC', '6461112222', 'Toronto', 'K8K 4M7', '93 Ashville Ave');
INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, postal_code, street_address) VALUES (3333, 'ECC', '6651112222', 'Toronto', 'M31 5Y6', '32 Corning rd');
INSERT INTO librarybranch (branch_id, branch_name, contact_number, city, postal_code, street_address) VALUES (4444, 'SLC', '6661112282', 'Toronto', 'B7V 4M7', '45 Leslie St');

INSERT INTO can_contain (ISBN, branch_id) VALUES ('533443', 1111);
INSERT INTO can_contain (ISBN, branch_id) VALUES ('633433', 2222);
INSERT INTO can_contain (ISBN, branch_id) VALUES ('733253', 3333);
INSERT INTO can_contain (ISBN, branch_id) VALUES ('533443', 4444);

INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (1432, 5167, 'unpaid', 5.00, 'book not returned by due date', '2023-08-31');
INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (2332, 5156, 'unpaid', 3.50, 'book damaged', '2023-07-20');
INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (3123, 5165, 'paid', 4.00, 'book lost', '2023-06-15');
INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (4653, 9876, 'unpaid', 2.75, 'late return', '2023-05-10');
INSERT INTO book_fine (fine_id, student_id, status, amount, reason, fine_date) VALUES (5534, 5016, 'paid', 6.25, 'missing pages', '2023-04-05');

INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1234, 'ad1@fakeuniversity.ca','John Adams','9998887777',1111 );
INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1235, 'ad2@fakeuniversity.ca','Kelly McCarthy','9994447777',2222 );
INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1236, 'ad3@fakeuniversity.ca','James Bond','9998887332',3333 );
INSERT INTO university_admin(admin_id, email_address, admin_name, phone_number, branch_id) VALUES (1237, 'ad4@fakeuniversity.ca','Riley Stone','9458887777',4444 );

INSERT INTO loan (loan_id, student_id, ISBN, loan_date) VALUES (6543, 5167, '533443', '2023-07-20');
INSERT INTO loan (loan_id, student_id, ISBN, loan_date) VALUES (6544, 5165, '633433', '2023-08-20');
INSERT INTO loan (loan_id, student_id, ISBN, loan_date) VALUES (6546, 5156, '733253', '2023-09-20');

INSERT INTO part_of (student_id, branch_id) VALUES (5167, 1111);
INSERT INTO part_of (student_id, branch_id) VALUES (5165, 2222);
INSERT INTO part_of (student_id, branch_id) VALUES (5156, 3333);

INSERT INTO published (author_id, ISBN) VALUES (4325, '533443');
INSERT INTO published (author_id, ISBN) VALUES (4326, '633433');
INSERT INTO published (author_id, ISBN) VALUES (4327, '733253');
INSERT INTO published (author_id, ISBN) VALUES (4328, '333213');

exit
EOF
