CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE DOMAIN Rating SMALLINT CHECK (VALUE > 0 AND VALUE <=5);

CREATE TYPE Feedback AS (
    student_id uuid,
    rating Rating,
    feedback TEXT    
);

CREATE TABLE IF NOT EXISTS student (
    student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS subject (
    subject_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subject TEXT NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS teacher (
    teacher_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    email TEXT
);

ALTER TABLE student
ADD COLUMN email TEXT;

CREATE TABLE IF NOT EXISTS course (
    course_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "name" TEXT NOT NULL,
    description TEXT,
    subject_id UUID REFERENCES subject(subject_id),  -- CREATE FOREIGN KEY FROM subject TABLE
    teacher_id UUID REFERENCES teacher(teacher_id),
    feedback feedback[]  -- references the FEEDBACK type we created above
);

CREATE TABLE IF NOT EXISTS enrollment (
    course_id UUID REFERENCES course(course_id),
    student_id UUID REFERENCES student(student_id),
    enrollment_date DATE NOT NULL,
    CONSTRAINT pk_enrollment PRIMARY KEY (course_id, student_id)
);

INSERT INTO teacher (     -- insert a teacher
    first_name,
    last_name,
    email,
    date_of_birth
) VALUES (
    'Preslav',
    'Petkov',
    'pp@pp.com',
    '1.1.1990'::DATE    
);

INSERT INTO course (
    "name",
    description
    
) VALUES (
    'SQL',
    'language'
);

UPDATE course    
SET subject_id = '2e0702f1-4b36-41a6-a498-129e395e3e4e'  -- manually setting the subject id taken from the subject table
WHERE subject_id IS NULL;

ALTER TABLE course ALTER COLUMN subject_id SET NOT NULL; -- updating subject_id to not be null since it was before the previous statement

UPDATE course
SET teacher_id = 'd3c08475-6946-480e-980b-b97ab6ed36e2'
WHERE teacher_id IS NULL;

ALTER TABLE course ALTER COLUMN teacher_id SET NOT NULL;

INSERT INTO enrollment (
  student_id,
  course_id,
  enrollment_date  
) VALUES (
    '30cfae52-30cf-4992-8ec4-ac4f5b5f2730',
    '49bf35f8-be42-4683-9f1b-f6a15295df63',
    now()::date
);

-- create feedback table

CREATE TABLE IF NOT EXISTS feedback (
    student_id uuid NOT NULL REFERENCES student(student_id),
    course_id uuid NOT NULL REFERENCES course(course_id),
    feedback TEXT,
    rating Rating,
    CONSTRAINT pk_feedback PRIMARY KEY (student_id, course_id)
);

INSERT INTO feedback (
    student_id,
    course_id,
    feedback,
    rating
    
) VALUES (
    '30cfae52-30cf-4992-8ec4-ac4f5b5f2730',
    '49bf35f8-be42-4683-9f1b-f6a15295df63',
    'This is feedback.',
    5
);