-- Mermaid live: https://www.mermaidchart.com/app/projects/d901974d-c9cf-4514-a666-6663d2e76f3b/diagrams/ecf577e3-9b5f-4539-8031-4c3b3749c058/version/v0.1/edit
-- Documentation: https://mermaid.js.org/syntax/entityRelationshipDiagram.html
-- Markdown: https://www.markdownguide.org/

-- Find all courses and grades, given student's first and last names
SELECT "name", "grade"
FROM "courses"
JOIN "grades" ON "courses"."id" = "grades"."course_id"
JOIN "students" ON "grades"."student_id" = "students"."id"
WHERE "first_name" = 'Carter' AND "last_name" = 'Zenke';


-- Show student's GPA given student's first and last name
SELECT AVG("grade") AS "GPA"
FROM "grades"
WHERE "student_id" = (
    SELECT "id" FROM "students"
    WHERE "first_name" = 'Carter' AND "last_name" = 'Zenke'
);


-- Show the names of all courses that are taught in a particular program
SELECT "name" FROM "courses"
WHERE "id" IN (
    SELECT "course_id" FROM "outlines"
    WHERE "program_id" = (
        SELECT "id" FROM "programs"
        WHERE "name" = 'Computer Science'
    )
);


-- Show student ID and grade level given student first and last name
SELECT "student_id", "grade_level"
FROM "students"
WHERE "first_name" = 'Carter' AND "last_name" = 'Zenke';


-- Show all codes and names for all programs for the year 2023
SELECT "code", "name"
FROM "programs"
WHERE "year" = 2023;


-- Add a new department
INSERT INTO "departments" ("name")
VALUES ("Department of Information Technology");


-- Add a new teacher
INSERT INTO "teachers" ("teacher_id", "first_name", "last_name", "username", "password", "department_id", "phone", "email", "address",
                        "date_of_birth")
VALUES ('DAV001', 'David', 'Malan', 'Dalan', 'admin', 1, '+4442288627228', 'davidmalan@harvard.edu', 'Harvard University', '1970-01-01');


-- Add a new program
INSERT INTO "programs" ("code", "name", "description", "department_id",  "head_id", "year")
VALUES ('CS', 'Computer Science', 'An indept study of Computer Science and its Technology', 1, 1, 2023);


-- Add a new student
INSERT INTO "students" ("student_id", "first_name", "last_name", "username", "password", "grade_level", "program_id", "gender",
                        "nationality", "phone", "email", "address", "date_of_birth", "previous_school")
VALUES
('104B', 'Carter', 'Zenke', 'Carke', 'password', '100', 1, 'M', 'USA', '+14005667098', 'carterzenke@havard.edu', 'Havard University',
 '1993-07-27', 'Havard High School');


-- Add a new course
INSERT INTO "courses" ("code", "name", "description", "semester", "year", "department_id")
VALUES ('CS50x', 'Introduction to Computer Science', 'An intensive introduction into the fundamentals of Computer Science', 'fall', 2023, 1);


-- Add a new non-teaching staff
INSERT INTO "non_teaching_staff"
("staff_id", "first_name", "last_name", "username", "password", "role", "phone", "email", "address", "department_id")
VALUES
('CLEM001', 'Clement', 'Gyasi', 'Cimao', 'cimao51', 'Secretary', '+233552689996', 'cimao52@yahoo.com', 'Harvard University', 1);


-- Add a new organisation
INSERT INTO "organisations" ("name")
VALUES ("Basketball");


-- Add a new guardian
INSERT INTO "guardians" ("name", "address", "phone", "email")
VALUES ('Brian Yu', 'Los Angeles', '+24536333098', 'brianyu@harvard.edu');


-- Show all the courses studied by the student
SELECT "name" FROM "courses"
WHERE "id" IN (
    SELECT "course_id" FROM "outline"
    WHERE "program_id" = (
        SELECT "program_id" FROM "students"
        WHERE "first_name" = 'Carter' AND "last_name" = 'Zenke'
    )
);
