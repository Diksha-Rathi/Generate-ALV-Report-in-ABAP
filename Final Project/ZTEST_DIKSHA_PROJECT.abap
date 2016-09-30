*&---------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_PROJECT
*&---------------------------------------------------------------------*
*& Created on: 24-06-2016
*& Author: Diksha
*&---------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_PROJECT.

TABLES: ZTEST_DEPARTMENT, ZTEST_COURSE, ZTEST_INSTRUCTOR.

TYPE-POOLS: slis.  " SLIS contains the ALV data types

TYPES: BEGIN OF ty_dept,
        dept_name TYPE ZTEST_DEPARTMENT-DEPT_NAME,
        budget TYPE ZTEST_DEPARTMENT-BUDGET,
       END OF ty_dept,

       BEGIN OF ty_course,
         course_id TYPE ZTEST_COURSE-COURSE_ID,
         title TYPE ZTEST_COURSE-TITLE,
         dept_name TYPE ZTEST_COURSE-DEPT_NAME,
       END OF ty_course,

       BEGIN OF ty_instructor,
         name TYPE ZTEST_INSTRUCTOR-NAME,
         dept_name TYPE ZTEST_INSTRUCTOR-DEPT_NAME,
         salary TYPE ZTEST_INSTRUCTOR-SALARY,
         course_id TYPE ZTEST_INSTRUCTOR-COURSE_ID,
       END OF ty_instructor,

       BEGIN OF ty_out,
        sel,
        dept_name TYPE ZTEST_DEPARTMENT-DEPT_NAME,
        budget TYPE ZTEST_DEPARTMENT-BUDGET,
        course_id TYPE ZTEST_COURSE-COURSE_ID,
        title TYPE ZTEST_COURSE-TITLE,
        name TYPE ZTEST_INSTRUCTOR-NAME,
        salary TYPE ZTEST_INSTRUCTOR-SALARY,
       END OF ty_out.

DATA: wa_dept TYPE ty_dept,
      wa_course TYPE ty_course,
      wa_instructor TYPE ty_instructor,
      wa_out  TYPE ty_out,
      it_dept TYPE STANDARD TABLE OF ty_dept,
      it_course TYPE STANDARD TABLE OF ty_course,
      it_instructor TYPE STANDARD TABLE OF ty_instructor,
      it_out  TYPE STANDARD TABLE OF ty_out.

*DATA: wa_fcat_out TYPE slis_fieldcat_alv,
*      it_fcat_out TYPE slis_t_fieldcat_alv,
*      wa_layout   TYPE slis_layout_alv,
*      wa_top      TYPE slis_listheader,
*      it_top      TYPE slis_t_listheader.

*DATA: IT_DEPARTMENT LIKE ZTEST_DEPARTMENT OCCURS 0 WITH HEADER LINE,
*      IT_COURSE LIKE ZTEST_COURSE OCCURS 0 WITH HEADER LINE,
*      IT_INSTRUCTOR LIKE ZTEST_INSTRUCTOR OCCURS 0 WITH HEADER LINE,
*

DATA: it_fieldcat  TYPE slis_t_fieldcat_alv, "used for internal table
      wa_fieldcat  TYPE slis_fieldcat_alv. "used for work area

PARAMETERS: WA_DNAME LIKE ZTEST_DEPARTMENT-DEPT_NAME MATCHCODE OBJECT ZTEST_DNAME.

PERFORM get_budget .
PERFORM get_course .
PERFORM get_instructor .
PERFORM prepare_output .
PERFORM display_alv .

FORM get_budget .

SELECT dept_name budget
FROM ZTEST_DEPARTMENT INTO TABLE it_dept
WHERE DEPT_NAME = WA_DNAME .

ENDFORM .

FORM get_course .

SELECT course_id title dept_name
FROM ZTEST_COURSE INTO TABLE it_course
WHERE DEPT_NAME = WA_DNAME .

ENDFORM .

FORM get_instructor .

SELECT name dept_name salary course_id
FROM ZTEST_INSTRUCTOR INTO TABLE it_instructor
WHERE DEPT_NAME = WA_DNAME .

ENDFORM .

FORM prepare_output .

 LOOP AT it_dept INTO wa_dept.
   wa_out-dept_name = wa_dept-dept_name.
   wa_out-budget = wa_dept-budget.

   LOOP AT it_course INTO wa_course
   WHERE dept_name = wa_dept-dept_name.
     wa_out-course_id = wa_course-course_id.
     wa_out-title = wa_course-title.

     LOOP AT it_instructor INTO wa_instructor
     WHERE dept_name = wa_dept-dept_name
       AND course_id = wa_course-course_id.
          wa_out-name = wa_instructor-name.
          wa_out-salary = wa_instructor-salary.

          APPEND wa_out TO it_out.
          CLEAR: wa_out, wa_instructor.

     ENDLOOP.
     CLEAR wa_course.
   ENDLOOP.
    CLEAR wa_dept .
 ENDLOOP.

ENDFORM .

*SELECT * FROM ZTEST_DEPARTMENT INTO CORRESPONDING FIELDS OF TABLE IT_DEPARTMENT WHERE DEPT_NAME = WA_DNAME.

* Build field catalog *

FORM display_alv .

  wa_fieldcat-fieldname  = 'DEPT_NAME'.    " Fieldname in the data table
  wa_fieldcat-seltext_m  = 'Department Name'.   " Column description in the output
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'BUDGET'.
  wa_fieldcat-seltext_m  = 'Department Budget'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'COURSE_ID'.
  wa_fieldcat-seltext_m  = 'Course ID of Courses'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  =  'TITLE'.
  wa_fieldcat-seltext_m  = 'Title of the Course'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'NAME'.
  wa_fieldcat-seltext_m  = 'Instructor(s) Name'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'SALARY'.
  wa_fieldcat-seltext_m  = 'Instructor(s) Salary'.
  APPEND wa_fieldcat TO it_fieldcat.

* Pass data and field catalog to ALV function module to display ALV list *

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = it_fieldcat
    TABLES
      t_outtab      = it_out "internal table with the data to be output
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM .