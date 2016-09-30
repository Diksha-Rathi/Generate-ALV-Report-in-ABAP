*&---------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_ALV01
*&---------------------------------------------------------------------*
*& Author: Diksha
*& Display ALV report using a single table
*&---------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_ALV01.

TABLES ZETEST2.

TYPE-POOLS: slis.  " SLIS contains the ALV data types

DATA: IT_ZETEST2 LIKE ZETEST2 OCCURS 0 WITH HEADER LINE.
DATA: it_fieldcat  TYPE slis_t_fieldcat_alv, "used for internal table
      wa_fieldcat  TYPE slis_fieldcat_alv. "used for work area

SELECT-OPTIONS: WA_NAME FOR ZETEST2-NAME MATCHCODE OBJECT ZTEST_DIKSHA.

SELECT * FROM ZETEST2 INTO CORRESPONDING FIELDS OF TABLE IT_ZETEST2 WHERE NAME IN WA_NAME.

* Build field catalog *

  wa_fieldcat-fieldname  = 'SNO'.    " Fieldname in the data table
  wa_fieldcat-seltext_m  = 'S. No.'.   " Column description in the output
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'NAME'.
  wa_fieldcat-seltext_m  = 'Name of the Employee'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'SALARY'.
  wa_fieldcat-seltext_m  = 'Salary'.
  APPEND wa_fieldcat TO it_fieldcat.

* Pass data and field catalog to ALV function module to display ALV list *
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = it_fieldcat
    TABLES
      t_outtab      = IT_ZETEST2 "internal table with the data to be output
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.