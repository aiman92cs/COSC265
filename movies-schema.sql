drop table dvd;
drop table customer;
drop table stars;
drop table star;
drop table movie;
drop table director;



CREATE TABLE DIRECTOR
(DNUMBER /* Unique number */ INTEGER NOT NULL constraint dir_pk PRIMARY KEY,
LNAME /* Last name */ VARCHAR(16) NOT NULL,
FNAME /* First name */ VARCHAR(15),
BORN /* Year of birth */ INTEGER 
                constraint dir_born check (BORN between 1880 and 1990),
DIED /* Year of death */ INTEGER constraint dir_died check (DIED>1930),
constraint corr_years check (born <= died));

CREATE TABLE MOVIE
(MNUMBER /* Unique number for a movie */ INTEGER NOT NULL PRIMARY KEY,
TITLE /* Title */ VARCHAR(50) not null,
TYPE /* Type of the movie */ VARCHAR(15) NOT NULL,
AANOM /* Number of nominations for Academy Awards */ INTEGER,
AAWON /* Number of AA won */ INTEGER,
YEAR /* Year when the movie was made */ INTEGER,
CRITICS /* Critics' rating */ VARCHAR(2),
DIRECTOR /* Director's number */ INTEGER REFERENCES DIRECTOR);

CREATE TABLE STAR
(SNUMBER /* Unique number */ INTEGER NOT NULL,
LNAME /* Last name */ VARCHAR(15) NOT NULL,
FNAME /* First name */ VARCHAR(15),
BORN /* Year of birth */ INTEGER 
                constraint check_born check (BORN between 1880 and 2000),
DIED /* Year of death */ INTEGER constraint check_died check (DIED>1930),
CITY /* City of birth */ VARCHAR(15),
constraint corr_syears check (born <= died),
PRIMARY KEY (SNUMBER));

CREATE TABLE CUSTOMER
(LNAME /* Last name */ VARCHAR(15) NOT NULL,
FNAME /* First name */ VARCHAR(15) NOT NULL,
CNUMBER /* Unique number */ INTEGER NOT NULL,
ADDRESS /* Customer's address */ VARCHAR(40),
RENTALS /* The number of DVDs rented */ INTEGER check (rentals>=0),
BONUS /* 1/10 of RENTALS */ INTEGER,
JDATE /* Date of joining the club */ DATE,
PRIMARY KEY (CNUMBER));

CREATE TABLE DVD
(CODE /* Unique number */ INTEGER NOT NULL,
MOVIE /* Movie number */ INTEGER NOT NULL,
PDATE /* Purchase date */ DATE,
TIMES /* Times rented */ INTEGER default 0,
CUSTOMER /* Number of the customer renting the DVD */ INTEGER,
HIREDATE /* Date of hire */ DATE,
PRIMARY KEY (CODE),
FOREIGN KEY (CUSTOMER) REFERENCES CUSTOMER(CNUMBER),
FOREIGN KEY (MOVIE) REFERENCES MOVIE,
CONSTRAINT CHECK_TIMES CHECK (TIMES >= 0));

CREATE TABLE STARS
(MOVIE /* Movie number */ INTEGER NOT NULL REFERENCES MOVIE(MNUMBER),
STAR /* Star number */ INTEGER NOT NULL REFERENCES STAR(SNUMBER),
ROLE /* Name of the role */ VARCHAR(20) NOT NULL,
PRIMARY KEY (MOVIE,STAR,ROLE));
