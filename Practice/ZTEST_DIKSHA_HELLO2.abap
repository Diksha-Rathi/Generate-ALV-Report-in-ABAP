*&---------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_HELLO2
*&---------------------------------------------------------------------*
*& Author: Diksha
*& Output all numbers between two given numbers
*&---------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_HELLO2.

PARAMETERS:PARA1(2) TYPE P .
PARAMETERS:PARA2(2) TYPE P .

DATA NUM1 TYPE i.
DATA  NUM2 TYPE I.

NUM1 = PARA1.
NUM2 = PARA2.

WHILE  NUM1 < NUM2 .
  WRITE: NUM1.
  NUM1 = NUM1 + 1.
ENDWHILE.