DROP TABLE IF EXISTS Professor CASCADE;
DROP TABLE IF EXISTS Dept CASCADE;
DROP TABLE IF EXISTS Project CASCADE;
DROP TABLE IF EXISTS Graduate CASCADE;
DROP TABLE IF EXISTS work_in CASCADE;
DROP TABLE IF EXISTS work_dept CASCADE;
DROP TABLE IF EXISTS work_proj CASCADE;

-- Problem 1

CREATE TABLE Professor (ssn CHAR(11) NOT NULL, 
			PRIMARY KEY(ssn), 
			name text, 
			age INTEGER, 
			rank text, 
			specialty text);
CREATE TABLE Dept (dno INTEGER NOT NULL,
			ssn CHAR(11) NOT NULL, 
			PRIMARY KEY(dno), 
			dname text, 
			office text,
			FOREIGN KEY (ssn) REFERENCES Professor(ssn) ON DELETE NO ACTION); --runs
CREATE TABLE Project (pno INTEGER NOT NULL,
			ssn CHAR(11) NOT NULL,	 
			PRIMARY KEY(pno), 
			sponsor text, 
			start_date DATE, 
			end_date DATE, 
			budget FLOAT,
			FOREIGN KEY (ssn) REFERENCES Professor(ssn) ON DELETE SET NULL); --manage
CREATE TABLE Graduate (SSN CHAR(11) NOT NULL,
			dno INTEGER NOT NULL, 
			PRIMARY KEY(SSN), 
			name text, 
			age INTEGER, 
			deg_pg text,
			FOREIGN KEY (dno) REFERENCES Dept(dno) ON DELETE SET NULL, --major
			FOREIGN KEY (SSN) REFERENCES Graduate(SSN) ON DELETE NO ACTION); --advise
CREATE TABLE work_in (ssn CHAR(11) NOT NULL,  
			pno INTEGER NOT NULL, 
			PRIMARY KEY(ssn,pno), 
			FOREIGN KEY (ssn) REFERENCES Professor(ssn), 
			FOREIGN KEY (pno) REFERENCES Project(pno));
CREATE TABLE work_dept (ssn CHAR(11) NOT NULL,
			dno INTEGER NOT NULL,
			PRIMARY KEY(ssn,dno),
			time_pc INTEGER NOT NULL,
			FOREIGN KEY (ssn) REFERENCES Professor(ssn),
			FOREIGN KEY (dno) REFERENCES Dept(dno));
CREATE TABLE work_proj(pno INTEGER NOT NULL, 
			SSN_graduate CHAR(11) NOT NULL, 
			ssn CHAR(11) NOT NULL,
			PRIMARY KEY (pno,SSN), 
			since INTEGER,
			FOREIGN KEY (pno) REFERENCES Project(pno),
			FOREIGN KEY (SSN_graduate) REFERENCES Graduate(SSN),
			FOREIGN KEY (ssn) REFERENCES Professor(ssn)); -- supervise

-- Problem 2

DROP TABLE IF EXISTS Musicians CASCADE;
DROP TABLE IF EXISTS Instrument CASCADE;
DROP TABLE IF EXISTS Album CASCADE;
DROP TABLE IF EXISTS Songs CASCADE;
DROP TABLE IF EXISTS Perform CASCADE;
DROP TABLE IF EXISTS Plays CASCADE;
DROP TABLE IF EXISTS Telephone CASCADE;
DROP TABLE IF EXISTS Place CASCADE;
DROP TABLE IF EXISTS Lives CASCADE;


CREATE TABLE Musicians (ssn CHAR(11) NOT NULL,
			name text,
			PRIMARY KEY (ssn));

CREATE TABLE Instrument (instrId INTEGER,
			dname text,
			key text,
			PRIMARY KEY (instrId));

CREATE TABLE Album (albumIdentifier INTEGER,
			copyrightDate DATE,
			speed INTEGER,
			title text,
			PRIMARY KEY(albumIdentifier)
			FOREIGN KEY (ssn) REFERENCES Musicians(ssn) ON DELETE SET NULL);

CREATE TABLE Songs (songId INTEGER,
			title text,
			author text,
			albumIdentifier INTEGER,
			PRIMARY KEY (songID),
			FOREIGN KEY (albumIdentifier) REFERENCES Album(albumIdentifier) ON DELETE SET NULL); -- Appears

CREATE TABLE Perform (ssn CHAR(11),
			songId INTEGER,
			PRIMARY KEY (ssn,songID),
			FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
			FOREIGN KEY (songId) REFERENCES Songs(songId));

CREATE TABLE Plays (ssn CHAR(11),
			instrId INTEGER,
			PRIMARY KEY (ssn, instrID),
			FOREIGN KEY (ssn) REFERENCES Musicians(ssn)); 

CREATE TABLE Telephone (phone_no INTEGER,
					address text,
					FOREIGN KEY (address) REFERENCES Place(address)); -- Home

CREATE TABLE Place (address text,
				PRIMARY KEY (address));

CREATE TABLE Lives (address text,
				phone_no INTEGER,
				ssn CHAR(11),
				FOREIGN KEY (ssn) REFERENCES Musicians(ssn));


\dt
