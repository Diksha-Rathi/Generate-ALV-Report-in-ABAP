*&-----------------------------------------------------------------------------------------------*
*& Report  ZTEST_DIKSHA_SELECT2
*&-----------------------------------------------------------------------------------------------*
*& Author: Diksha
*& Retrieve and output data from existing table SFLIGHT using SELECT-OPTION (range of input(s))
*&-----------------------------------------------------------------------------------------------*

REPORT  ZTEST_DIKSHA_SELECT2.

TABLES SFLIGHT.

DATA: IT_SFLIGHT LIKE SFLIGHT OCCURS 0 WITH HEADER LINE.

SELECT-OPTIONS: W_CARRID FOR SFLIGHT-CARRID.

SELECT * FROM SFLIGHT INTO CORRESPONDING FIELDS OF TABLE IT_SFLIGHT WHERE CARRID IN W_CARRID.

LOOP AT IT_SFLIGHT .
    WRITE : IT_SFLIGHT-MANDT, ' ', IT_SFLIGHT-CARRID, ' ', IT_SFLIGHT-CONNID , ' ', IT_SFLIGHT-FLDATE , ' ', IT_SFLIGHT-PRICE , ' ', IT_SFLIGHT-CURRENCY , ' ', IT_SFLIGHT-PLANETYPE , ' ', IT_SFLIGHT-SEATSMAX, ' ', IT_SFLIGHT-SEATSOCC.
    NEW-LINE.
ENDLOOP.