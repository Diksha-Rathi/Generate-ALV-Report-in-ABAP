*&------------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_SELECT1
*&------------------------------------------------------------------------*
*& Author: Diksha
*& Retrieve data from existing table USR02 using PARAMETER (sinlge input)
*&------------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_SELECT1.

TABLES USR02.

DATA: IT_TAB1 LIKE USR02 OCCURS 0 WITH HEADER LINE.

PARAMETERS: P_BNAME LIKE USR02-BNAME.

"SELECT-OPTIONS: S_BNAME FOR USR02-BNAME.

SELECT * FROM USR02 INTO CORRESPONDING FIELDS OF TABLE IT_TAB1 WHERE BNAME IN S_BNAME.
  LOOP AT IT_TAB1 .
    WRITE : IT_TAB1-BNAME , ' ' , IT_TAB1-GLTGV.
NEW-LINE.

ENDLOOP.