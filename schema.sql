CREATE TABLE "students" (
    "id" INTEGER,
    "student_id" TEXT NOT NULL UNIQUE,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "grade_level" TEXT NOT NULL,
    "program_id" INTEGER,
    "gender" TEXT NOT NULL CHECK("gender" IN('M', 'F')),
    "nationality" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "date_of_birth" NUMERIC NOT NULL,
    "started" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "previous_school" TEXT NOT NULL,
    "fees" REAL NOT NULL DEFAULT 50000 CHECK("fees" >= 0),
    "photograph" BLOB,
    PRIMARY KEY("id"),
    FOREIGN KEY("program_id") REFERENCES "programs"("id")
);


CREATE TABLE "teachers" (
    "id" INTEGER,
    "teacher_id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "department_id" INTEGER,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "date_of_birth" NUMERIC NOT NULL,
    "started" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "photograph" BLOB,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"("id")
);


CREATE TABLE "programs" (
    "id" INTEGER,
    "code" TEXT NOT NULL UNIQUE,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "department_id" INTEGER,
    "head_id" INTEGER,
    "year" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"("id"),
    FOREIGN KEY("head_id") REFERENCES "teachers"("id")
);


CREATE TABLE "courses" (
    "id" INTEGER,
    "code" TEXT NOT NULL UNIQUE,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "semester" TEXT CHECK("semester" IN ('fall', 'winter', 'spring', 'summer')),
    "year" INTEGER NOT NULL,
    "department_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"("id")
);


CREATE TABLE "departments" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);


CREATE TABLE "non_teaching_staff" (
    "id" INTEGER,
    "staff_id" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "department_id" INTEGER,
    "photograph" BLOB,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"("id")
);


CREATE TABLE "organisations" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "started" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);


CREATE TABLE "guardians" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    PRIMARY KEY("id")
);


CREATE TABLE "classes" (
    "teacher_id" INTEGER,
    "course_id" INTEGER,
    PRIMARY KEY("teacher_id", "course_id"),
    FOREIGN KEY("teacher_id") REFERENCES "teachers"("id"),
    FOREIGN KEY("course_id") REFERENCES "courses"("id")
);


CREATE TABLE "grades" (
    "student_id" INTEGER,
    "course_id" INTEGER,
    "grade" REAL NOT NULL DEFAULT 0 CHECK("grade" BETWEEN 0 AND 100),
    PRIMARY KEY("course_id", "student_id"),
    FOREIGN KEY("course_id") REFERENCES "courses"("id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id")
);


CREATE TABLE "outlines" (
    "program_id" INTEGER,
    "course_id" INTEGER,
    PRIMARY KEY("course_id", "program_id"),
    FOREIGN KEY("course_id") REFERENCES "courses"("id"),
    FOREIGN KEY("program_id") REFERENCES "programs"("id")
);

CREATE TABLE "memberships" (
    "student_id" INTEGER,
    "organisation_id" INTEGER,
    "role" TEXT NOT NULL,
    PRIMARY KEY("student_id", "organisation_id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("organisation_id") REFERENCES "organisations"("id")
);


CREATE TABLE "relationships" (
    "student_id" INTEGER,
    "guardian_id" INTEGER,
    PRIMARY KEY("student_id", "guardian_id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("guardian_id") REFERENCES "guardians"("id")
);


-- Create VIEW for all 2023 courses
CREATE VIEW "2023" AS
SELECT "code", "name"
FROM "programs"
WHERE "year" = 2023;

-- Indexes to speed common searches
CREATE INDEX "student_name_index" ON "students" ("first_name", "last_name");
CREATE INDEX "grade_index" ON "grades"("student_id", "course_id");
CREATE INDEX "program_name_index" ON "programs" ("name");
CREATE INDEX "outline_index" ON "outlines" ("program_id", "course_id");
CREATE INDEX "year_index" ON "programs"("year")
    WHERE "year" = 2023;

