*&-------------------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_SELECT4
*&-------------------------------------------------------------------------------*
*& Author: Diksha
*& Use SELECT-OPTION and PARAMETER with F4 Help object
*& ZTEST_DIKSHA is the F4 help object in the following program
*&-------------------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_SELECT4.

TABLES ZETEST2.

DATA: IT_ZETEST1 LIKE ZETEST2 OCCURS 0 WITH HEADER LINE.
DATA: IT_ZETEST2 LIKE ZETEST2 OCCURS 0 WITH HEADER LINE.

* for displaying result for a single input *

PARAMETERS: WA_NAME1 LIKE ZETEST2-NAME MATCHCODE OBJECT ZTEST_DIKSHA.

WRITE: 'Result for sinle input query'.
NEW-LINE.

SELECT * FROM ZETEST2 INTO CORRESPONDING FIELDS OF TABLE IT_ZETEST1 WHERE NAME = WA_NAME1.

LOOP AT IT_ZETEST1.
    WRITE : IT_ZETEST1-SNO, ' ', IT_ZETEST1-NAME, ' ', IT_ZETEST1-SALARY.
    NEW-LINE.
ENDLOOP.

* for displaying values between a range *

SELECT-OPTIONS: WA_NAME FOR ZETEST2-NAME MATCHCODE OBJECT ZTEST_DIKSHA.


WRITE: 'Result(s) for a range of input queries'.
NEW-LINE.

SELECT * FROM ZETEST2 INTO CORRESPONDING FIELDS OF TABLE IT_ZETEST2 WHERE NAME IN WA_NAME.

LOOP AT IT_ZETEST2.
    WRITE : IT_ZETEST2-SNO, ' ', IT_ZETEST2-NAME, ' ', IT_ZETEST2-SALARY.
    NEW-LINE.
ENDLOOP.