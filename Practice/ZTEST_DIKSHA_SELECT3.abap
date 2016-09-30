*&---------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_SELECT3
*&---------------------------------------------------------------------*
*& Author: Diksha
*& [1] Create a table that lists name and salary of employee
*& [2] Multiply salary and output the resulting data of the table
*&---------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_SELECT3.

TABLES ZETEST2.

DATA: IT_ZETEST2 LIKE ZETEST2 OCCURS 0 WITH HEADER LINE.
DATA RESULT LIKE ZETEST2-SALARY.

SELECT-OPTIONS: W_SNO FOR ZETEST2-SNO.

SELECT * FROM ZETEST2 INTO CORRESPONDING FIELDS OF TABLE IT_ZETEST2 WHERE SNO IN W_SNO.

LOOP AT IT_ZETEST2.
   "RESULT = IT_ZETEST2-SALARY.
   "RESULT = RESULT * 3.
    RESULT = IT_ZETEST2-SALARY * 3.
    WRITE : IT_ZETEST2-SNO, ' ', IT_ZETEST2-NAME, ' ', IT_ZETEST2-SALARY, ' ', RESULT.
    NEW-LINE.
ENDLOOP.