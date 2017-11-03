---------------------------------------
drop sequence ATTEMPT_SUBMISSION_SEQ;
drop sequence Question_SEQ;
drop sequence EXERCISE_SEQ;
 drop trigger ATTEMPT_SUBMISSION_PK_Trigger;
 drop trigger EXERCISE_PK_Trigger;
 drop trigger Question_PK_Trigger;
drop trigger check_is_grad;
 
 drop table TA;
drop table COURSE_STUDENT;
drop table SUBMISSION_RESULT;
drop table ATTEMPT_SUBMISSION;
drop table QUESTION_PARAM_ANSWERS;
drop table ANSWER;
drop table PARAMETER;
drop table QUESTION_BANK;
drop table EXERCISE_QUESTION;
drop table QUESTION;
drop table exercise;
Drop table COURSE_topic;
Drop table topic;
Drop table COURSE;
Drop table student;
Drop table professor;
drop table ROLE;
drop table MENU_OPTIONS;

--------Start from here-----------
-----------
CREATE TABLE MENU_OPTIONS 
(
  ROLE VARCHAR(1) NOT NULL 
  , MENU_NAME VARCHAR(100) NOT NULL
, COL_NAME VARCHAR(100) NOT NULL 
 , DISPLAY_ORDER NUMBER NOT NULL 
 , SHOWN_ALWAYS NUMBER NOT NULL
, CONSTRAINT MENU_OPTIONS_PK PRIMARY KEY 
  (
    ROLE 
  , COL_NAME 
  , MENU_NAME 
  )
);


CREATE TABLE ROLE 
(
  USER_ID VARCHAR(20) NOT NULL 
, ROLE VARCHAR(5) NOT NULL 
, PASSWORD VARCHAR(20) NOT NULL 
, CONSTRAINT ROLE_PK PRIMARY KEY 
  (
    USER_ID 
  
  )
   
);
CREATE TABLE STUDENT 
(
  STUDENT_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(100) NOT NULL 
, IS_GRAD NUMBER NOT NULL 
, CONSTRAINT STUDENT_PK PRIMARY KEY 
  (
    STUDENT_ID 
  )
  
);

CREATE TABLE PROFESSOR 
(
  PROFESSOR_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(100) NOT NULL 
, CONSTRAINT PROFESSOR_PK PRIMARY KEY 
  (
    PROFESSOR_ID 
  )
   
);

CREATE TABLE COURSE 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, COURSE_NAME VARCHAR(100) NOT NULL 
, START_DATE DATE NOT NULL 
, END_DATE DATE NOT NULL 
, PROFESSOR_ID VARCHAR(20) 
, CONSTRAINT COURSE_PK PRIMARY KEY 
  (
    COURSE_ID 
  )
,CONSTRAINT COURSE_FK1 FOREIGN KEY
(
  PROFESSOR_ID 
)
REFERENCES PROFESSOR
(
  PROFESSOR_ID 
)
ON DELETE SET NULL
   
);

CREATE TABLE TOPIC 
(
  TOPIC_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(200) NOT NULL 
, CONSTRAINT TOPIC_PK PRIMARY KEY 
  (
    TOPIC_ID 
  )
   
);
----------------------------------------------------------------

CREATE TABLE COURSE_TOPIC 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, TOPIC_ID VARCHAR(20) NOT NULL 
, CONSTRAINT COURSE_TOPIC_PK PRIMARY KEY 
  (
    COURSE_ID 
  , TOPIC_ID 
  )
,CONSTRAINT COURSE_TOPIC_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE 
,CONSTRAINT COURSE_TOPIC_FK2 FOREIGN KEY
(
  TOPIC_ID 
)
REFERENCES TOPIC
(
  TOPIC_ID 
)
ON DELETE CASCADE
);
----------------------------------------
CREATE SEQUENCE  EXERCISE_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 ;
CREATE TABLE EXERCISE 
(
 EXERCISE_ID NUMBER NOT NULL 
, COURSE_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(100) 
, DEADLINE DATE 
, TOTAL_QUESTIONS NUMBER 
, RETRIES NUMBER 
, START_DATE DATE 
, END_DATE DATE 
, POINTS NUMBER 
, PENALTY NUMBER 
, SCORING_POLICY VARCHAR(20) 
, SC_MODE VARCHAR(20) 
, CONSTRAINT EXERCISE_PK PRIMARY KEY 
  (
    EXERCISE_ID 
  )
  ,CONSTRAINT EXERCISE_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE SET NULL
   
);
---------------------------------------------------------


----------------------------------------------------------
CREATE SEQUENCE  QUESTION_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 ;
-----------------------------------------------------------
CREATE TABLE QUESTION 
(
  QUESTION_ID NUMBER NOT NULL 
, QUESTION_TEXT VARCHAR(200) NOT NULL 
, DIFFICULTY_LEVEL NUMBER NOT NULL 
, HINT VARCHAR(200) 
, EXPLANATION VARCHAR(200) 
, TOPIC_ID VARCHAR(20) 
, CONSTRAINT QUESTION_PK PRIMARY KEY 
  (
    QUESTION_ID 
  )
  ,CONSTRAINT QUESTION_FK1 FOREIGN KEY
(
  TOPIC_ID 
)
REFERENCES TOPIC
(
  TOPIC_ID 
)
ON DELETE SET NULL
,CONSTRAINT QUESTION_CHK1 CHECK 
(difficulty_level >=1 and difficulty_level <=6 )
);
--------

--------------------
CREATE TABLE EXERCISE_QUESTION 
(
  EXERCISE_ID NUMBER NOT NULL 
, QUESTION_ID NUMBER NOT NULL 
, CONSTRAINT EXERCISE_QUESTION_PK PRIMARY KEY 
  (
    EXERCISE_ID 
  , QUESTION_ID 
  )
  ,CONSTRAINT EXERCISE_QUESTION_FK1 FOREIGN KEY
(
  EXERCISE_ID 
)
REFERENCES EXERCISE
(
  EXERCISE_ID 
),CONSTRAINT EXERCISE_QUESTION_FK2 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE 
   );

----------------------

CREATE TABLE QUESTION_BANK 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, QUESTION_ID NUMBER NOT NULL 
, CONSTRAINT QUESTION_BANK_PK PRIMARY KEY 
  (
    COURSE_ID 
  , QUESTION_ID 
  )
  ,CONSTRAINT QUESTION_BANK_FK1 FOREIGN KEY
(
COURSE_ID
  )
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE 
,CONSTRAINT QUESTION_BANK_FK2 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE
   
);
-------------------

CREATE TABLE PARAMETER 
(
  PARAM_ID VARCHAR(20) NOT NULL 
, VALUE VARCHAR(100) 
, CONSTRAINT PARAMETER_PK PRIMARY KEY 
  (
    PARAM_ID 
  )
   
);
------------------------
CREATE TABLE ANSWER 
(
  ANSWER_ID VARCHAR(20) NOT NULL 
, VALUE VARCHAR(100) 
, CONSTRAINT ANSWER_PK PRIMARY KEY 
  (
    ANSWER_ID 
  )
   
);

CREATE TABLE QUESTION_PARAM_ANSWERS 
(
  QUESTION_ID NUMBER NOT NULL 
, PARAM_ID VARCHAR(20) NOT NULL 
, ANSWER_ID VARCHAR(20) NOT NULL 
, CORRECT NUMBER 
, CONSTRAINT QUESTION_PARAM_ANSWERS_PK PRIMARY KEY 
  (
    QUESTION_ID 
  , PARAM_ID 
  , ANSWER_ID 
  )
  , CONSTRAINT QUESTION_PARAM_ANSWERS_FK1 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE
,CONSTRAINT QUESTION_PARAM_ANSWERS_FK2 FOREIGN KEY
(
  ANSWER_ID 
)
REFERENCES ANSWER
(
  ANSWER_ID 
)
ON DELETE CASCADE
,CONSTRAINT QUESTION_PARAM_ANSWERS_FK3 FOREIGN KEY
(
  PARAM_ID 
)
REFERENCES PARAMETER
(
  PARAM_ID 
)
ON DELETE CASCADE
);

---drop table ATTEMPT_SUBMISSION------------------------------------
-------------------
CREATE SEQUENCE  ATTEMPT_SUBMISSION_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 ;
--------------------
CREATE TABLE ATTEMPT_SUBMISSION 
(
  ATTEMPT_ID NUMBER NOT NULL  
, EXERCISE_ID NUMBER NOT NULL 
, STUDENT_ID VARCHAR(20) NOT NULL 
, SUBMISSION_TIME TIMESTAMP NOT NULL 
, POINTS NUMBER 
, NUMBER_OF_ATTEMPTS NUMBER 
, CONSTRAINT ATTEMPT_SUBMISSION_PK PRIMARY KEY 
  (
  ATTEMPT_ID
  )
  ,CONSTRAINT ATTEMPT_SUBMISSION_FK1 FOREIGN KEY
(
  EXERCISE_ID 
)
REFERENCES EXERCISE
(
  EXERCISE_ID 
)

,CONSTRAINT ATTEMPT_SUBMISSION_FK2 FOREIGN KEY
(
  STUDENT_ID 
)
REFERENCES STUDENT
(
  STUDENT_ID 
)

);
---------------

----------------------------------------------------------------------
CREATE TABLE SUBMISSION_RESULT 
(
  ATTEMPT_ID NUMBER NOT NULL 
, QUESTION_ID NUMBER NOT NULL 
, PARAM_ID VARCHAR(20) NOT NULL 
, ANSWER_ID VARCHAR(20) 
, CORRECT NUMBER 
, CONSTRAINT SUBMISSION_RESULT_PK PRIMARY KEY 
  (
    ATTEMPT_ID 
  , QUESTION_ID 
  , PARAM_ID 
  )
  ,CONSTRAINT SUBMISSION_RESULT_FK1 FOREIGN KEY
(
  ATTEMPT_ID 
)
REFERENCES ATTEMPT_SUBMISSION
(
  ATTEMPT_ID 
)
ON DELETE CASCADE
, CONSTRAINT SUBMISSION_RESULT_FK2 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE
,CONSTRAINT SUBMISSION_RESULT_FK3 FOREIGN KEY
(
  PARAM_ID 
)
REFERENCES PARAMETER
(
  PARAM_ID 
)
ON DELETE CASCADE
,CONSTRAINT SUBMISSION_RESULT_FK4 FOREIGN KEY
(
  ANSWER_ID 
)
REFERENCES ANSWER
(
  ANSWER_ID 
)
ON DELETE CASCADE
);
----------------------------------------------------------------
CREATE TABLE COURSE_STUDENT 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, STUDENT_ID VARCHAR(20) NOT NULL 
, CONSTRAINT COURSE_STUDENT_PK PRIMARY KEY 
  (
    COURSE_ID 
  , STUDENT_ID 
  )
  ,CONSTRAINT COURSE_STUDENT_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE
, CONSTRAINT COURSE_STUDENT_FK2 FOREIGN KEY
(
  STUDENT_ID 
)
REFERENCES STUDENT
(
  STUDENT_ID 
)
ON DELETE CASCADE
);
--------drop table TA-----------------------------------

CREATE TABLE TA 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, STUDENT_ID VARCHAR(20) NOT NULL 
, CONSTRAINT TA_PK PRIMARY KEY 
  (
    COURSE_ID 
  , STUDENT_ID 
  )
  , CONSTRAINT TA_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE

,CONSTRAINT TA_FK2 FOREIGN KEY
(
  STUDENT_ID 
)
REFERENCES STUDENT
(
  STUDENT_ID 
)
ON DELETE CASCADE
);


------------------------------------------------
-- drop trigger check_is_grad
-----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER check_is_grad
  BEFORE INSERT OR UPDATE ON TA
  FOR EACH ROW
DECLARE
  isGrad number;
BEGIN
select is_grad into isGrad from student s where s.STUDENT_ID = :NEW.STUDENT_ID and rownum = 1;
if ( isGrad <> 1)
--if ( :NEW.STUDENT_ID >= 1)
then 
Raise_Application_Error(-20000, 'Undergrads cannot be TA');
--insert into tp values(1);
END IF;
END;
/ 
ALTER TRIGGER check_is_grad ENABLE;

CREATE OR REPLACE TRIGGER EXERCISE_PK_Trigger 
   before insert on  EXERCISE
   for each row 
begin  
   if inserting then 
      if :NEW.EXERCISE_ID is null then 
         select EXERCISE_SEQ.nextval into :NEW.EXERCISE_ID from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER EXERCISE_PK_Trigger ENABLE;

CREATE OR REPLACE TRIGGER Question_PK_Trigger 
   before insert on  Question
   for each row 
begin  
   if inserting then 
      if :NEW.QUESTION_ID is null then 
         select QUESTION_SEQ.nextval into :NEW.QUESTION_ID from dual; 
      end if; 
   end if; 
end;
/ 
ALTER TRIGGER Question_PK_Trigger ENABLE;

CREATE OR REPLACE TRIGGER ATTEMPT_SUBMISSION_PK_Trigger 
   before insert on  ATTEMPT_SUBMISSION
   for each row 
begin  
   if inserting then 
      if :NEW.ATTEMPT_ID is null then 
         select ATTEMPT_SUBMISSION_SEQ.nextval into :NEW.ATTEMPT_ID from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER ATTEMPT_SUBMISSION_PK_Trigger ENABLE;