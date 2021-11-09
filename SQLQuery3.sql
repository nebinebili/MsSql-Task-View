--1. Create a database "Teachers" and add two tables to it
CREATE DATABASE Teachers

CREATE TABLE Posts(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(20)
)

CREATE TABLE Teachers(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(15),
Code CHAR(10),
IdPost INT FOREIGN KEY REFERENCES Posts(Id),
Tel CHAR(7),
Salary INT,
Rise NUMERIC(6,2),
HireDate DATETIME
)

--2.Delete the "POSTS" table.
DROP TABLE Teachers
DROP TABLE Posts

--3. In the "TEACHERS" table, delete the "IdPost" column.ALTER TABLE Teachers DROP CONSTRAINT FK__Teachers__IdPost__3A81B327ALTER TABLE Teachers DROP COLUMN IdPost--4. For the "HireDate" column, create a limit: the date of hiring must be at least 01/01/1990.ALTER TABLE TeachersADD CONSTRAINT CK_HireDate CHECK(HireDate>='1990.01.01')--5. Create a unique constraint for the "Code" column.ALTER TABLE TeachersADD CONSTRAINT UK_Code UNIQUE(Code)--6. Change the data type In the Salary field from INTEGER to NUMERIC (6,2).ALTER TABLE TeachersALTER COLUMN Salary NUMERIC(6,2)--7. Add to the table "TEACHERS" the following restriction: the salary should not be less than
--1000, but also should not Exceed 5000.ALTER TABLE TeachersADD CONSTRAINT CK_SalaryLessThan1000 CHECK(Salary>=1000),CONSTRAINT CK_SalaryNotExceed5000 CHECK(Salary<=5000)--8. Rename Tel column to Phone.SP_RENAME 'Teachers.Tel','Phone'--9. Change the data type in the Phone field from CHAR (7) to CHAR (11).ALTER TABLE TeachersALTER COLUMN Phone Char(11)--10. Create again the "POSTS" table.CREATE TABLE Posts(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(20)
)-- 11.For the Name field of the "POSTS" table, you must set a limit on the position (professor,
--assistant professor, teacher or assistant).ALTER TABLE PostsADD CONSTRAINT NameLimit CHECK([Name]='Professor' OR [Name]='Teacher' OR [Name]='Assistant' OR [Name]='Docent')--12.For the Name field of the "TEACHERS" table, specify a restriction in which to prohibit the
--presence of figures in the teacher's surname.ALTER TABLE TeachersADD CONSTRAINT CK_Teachers_Surname CHECK(Surname NOT LIKE '%[^A-Z]%')--13.Add the IdPost (int) column to the "TEACHERS" table.ALTER TABLE Teachers
ADD IdPost INT--14. Associate the field IdPost table "TEACHERS" with the field Id of the table "POSTS"ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_IdPost FOREIGN KEY(IdPost) REFERENCES Posts(Id)

--15. Fill both tables with data.
INSERT INTO Posts (Name)
VALUES (N'Professor');
INSERT INTO Posts (Name)
VALUES (N'Docent');
INSERT INTO Posts(Name)
VALUES (N'Teacher');
INSERT INTO Posts (Name)
VALUES (N'Assistant');TRUNCATE TABLE TeachersINSERT INTO Teachers(Name, Code, IdPost, Phone, Salary, Rise, HireDate,Surname)
VALUES (N'Sidorov ','0123456789', 1, NULL, 1070, 470, '01 .09.1992','Federov');
INSERT INTO Teachers (Name, Code, IdPost, Phone, Salary, Rise, HireDate,Surname)
VALUES (N'Ramishevsky ','4567890123', 2,' 4567890 ', 1110, 370, '09 .09.1998','Popov');
INSERT INTO Teachers (Name, Code, IdPost, Phone, Salary, Rise, HireDate,Surname)
VALUES (N'Horenko ','1234567890', 3, NULL, 2000, 230, '10 .10.2001','Kozlov');
INSERT INTO Teachers (Name, Code, IdPost, Phone, Salary, Rise, HireDate,Surname)
VALUES (N'Vibrovsky ','2345678901', 4, NULL, 4000, 170, '01 .09.2003','Mikhailov');
INSERT INTO Teachers (Name, Code, IdPost, Phone, Salary, Rise, HireDate,Surname)
VALUES ( N'Voropaev ', NULL, 4, NULL, 1500, 150, '02 .09.2002','Vasiliev');
INSERT INTO Teachers ( Name, Code, IdPost, Phone, Salary, Rise, HireDate,Surname)
VALUES ( N'Kuzintsev ','5678901234', 3,' 4567890 ', 3000, 270, '01 .01.1991','Morozov');--16. Create a view:
--16.1. All job titles.
CREATE VIEW JobTitles
AS
SELECT * FROM Posts

--16.2. All the names of teachers.
CREATE VIEW TeachersName
AS
SELECT Teachers.Name FROM Teachers

--16.3. The identifier, the name of the teacher, his position, the general s / n (sort by s \ n).
CREATE VIEW TeachersInfo
AS
SELECT Teachers.Id,Teachers.Name AS TeacherName,Posts.Name FROM Teachers INNER JOIN Posts
ON Teachers.IdPost=Posts.Id

--16.4. Identification number, surname, telephone number (only those who have a phone
--number).
CREATE VIEW Info
AS
SELECT Id,Surname,Phone FROM Teachers
WHERE Phone IS NOT NULL

--16.5. Surname, position, date of admission in the format [dd/mm/yy].
CREATE VIEW AdmissionFormat
AS
SELECT Surname,Posts.Name,FORMAT(HireDate,'dd/mm/yy')AS [Date] FROM Teachers INNER JOIN Posts
ON Teachers.IdPost=Posts.Id

--16.6. Surname, position, date of receipt in the format [dd month_text yyyy]CREATE VIEW ReceiptFormat
AS
SELECT Surname,Posts.Name,FORMAT(HireDate,'dd month_text yyyy')AS [Date] FROM Teachers INNER JOIN Posts
ON Teachers.IdPost=Posts.Id

