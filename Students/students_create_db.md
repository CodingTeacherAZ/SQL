psql --username=freecodecamp --dbname=postgres;

-- Create the students database
CREATE DATABASE students;

-- Switch to the students database
\c students;

-- Create the students table
CREATE TABLE students(
    student_ID SERIAL PRIMARY KEY, 	
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    major_id INT,
    gpa NUMERIC(2,1)
);

-- Create the majors table
CREATE TABLE majors(
    major_id SERIAL PRIMARY KEY,
    major VARCHAR(50) NOT NULL
);

-- Add foreign key to the students table
ALTER TABLE students
ADD FOREIGN KEY (major_id)
REFERENCES majors(major_id);

-- Create the courses table
CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course VARCHAR(100) NOT NULL
);

-- Create the majors_courses table
CREATE TABLE majors_courses(
    major_id INT,
    course_id INT
);

-- Add foreign key constraints to majors_courses
ALTER TABLE majors_courses
ADD FOREIGN KEY (major_id)
REFERENCES majors(major_id);

ALTER TABLE majors_courses
ADD FOREIGN KEY (course_id)
REFERENCES courses(course_id);

-- Add a composite primary key to majors_courses
ALTER TABLE majors_courses 
ADD PRIMARY KEY(major_id, course_id);



##!/bin/bash


# Script to insert data from courses.csv and students.csv into students database
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"


# clear the database first
echo $($PSQL "TRUNCATE students, majors, courses, majors_courses")


#Loop through the courses.csv file and 
# assign comma-space separated data to MAJOR and COURSE
cat courses.csv | while IFS="," read MAJOR COURSE


do
if [[ $MAJOR != major ]]
 then
   # get major_id
   MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
   # if not found
   if [[ -z $MAJOR_ID ]]
   then
     # insert major
     INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES ('$MAJOR');")
     if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
     then
       echo Inserted into majors, $MAJOR
     fi


     # get new major_id
     MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")


   fi
   # get course_id
   COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
   # if not found
   if [[ -z $COURSE_ID ]]
   then
     # insert course
     INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES ('$COURSE');")
     if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]
     then
       echo Inserted into courses, $COURSE
     fi


     # get new course_id
     COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
   fi


   # insert into majors_courses
   INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id, course_id) VALUES($MAJOR_ID, $COURSE_ID)")
   if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]
     then
       echo Inserted into majors_courses, $MAJOR : $COURSE
     fi
 fi
done


cat students.csv | while IFS="," read FIRST LAST MAJOR GPA;
do
 if [[ $FIRST != first_name ]]
 then
   # get major_id
   MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
  
  
   # if not found
   if [[ -z $MAJOR_ID ]]
   then
     # set to null
     MAJOR_ID=null
   fi


   # insert student
   INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO students(first_name, last_name, major_id, gpa) VALUES('$FIRST', '$LAST', $MAJOR_ID, $GPA)")
   if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
     then
       echo Inserted into students, $FIRST $LAST
     fi
 fi
done





PART 2
#!/bin/bash
# Info about my computer science students from students database
echo -e "\n~~ My Computer Science Students ~~\n"
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"




echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE gpa = 4.0;")"


echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:"


echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE last_name >= 'R' AND (gpa > 3.8 OR gpa < 2.0);")"


echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo "$($PSQL "SELECT course FROM courses WHERE course < 'D'")"


echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"
echo "$($PSQL "SELECT last_name FROM students WHERE last_name ILIKE '%sa%' OR last_name LIKE '%r_'")"


echo -e "\nFirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' or they have a GPA greater than 3.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE major_id IS NULL AND (first_name LIKE 'D%' OR gpa > 3.0)")"


echo -e "\nCourse name of the first five courses, in reverse alphabetical order, that have an 'e' as the second letter or end with an 's':"
echo "$($PSQL "SELECT course FROM courses WHERE (course LIKE '_e%' OR course LIKE '%s') ORDER BY course DESC LIMIT 5")"


echo -e "\nAverage GPA of all students rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(gpa),2) FROM students")"


echo -e "\nMajor ID, total number of students in a column named 'number_of_students', and average GPA rounded to two decimal places in a column name 'average_gpa', for each major ID in the students table having a student count greater than 1:"
echo "$($PSQL "SELECT major_id as major_id, COUNT(*) AS number_of_students, ROUND(AVG(gpa),2) AS average_gpa FROM students GROUP BY major_id HAVING COUNT(*) > 1; ")"


echo -e "\nList of majors, in alphabetical order, that either no student is taking or has a student whose first name contains a case insensitive 'ma':"
echo "$($PSQL "SELECT major FROM majors FULL JOIN students ON majors.major_id = students.major_id WHERE first_name ILIKE '%ma%' OR first_name IS NULL ORDER BY major;")"


echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo "$($PSQL "SELECT DISTINCT(course) FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING (major_id) FULL JOIN courses USING (course_id) WHERE last_name IS NULL OR last_name = 'Hilpert' ORDER BY course DESC;")"


echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
echo "$($PSQL "SELECT courses.course FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING (major_id) FULL JOIN courses USING (course_id)  GROUP BY courses.course HAVING COUNT(students.last_name) = 1 ORDER BY course;")"
