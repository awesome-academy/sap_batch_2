*&---------------------------------------------------------------------*
*& Report ZSYR8410
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR8410.

DATA: lt_sflight TYPE TABLE OF sflight,
      ls_sflight TYPE sflight,
      lt_sbook TYPE TABLE OF sbook,
      ls_sbook TYPE sbook,
      lv_date TYPE d VALUE '20200720'.

" 12.1
DO 20 TIMES.
  ls_sflight-carrid = 'JL'.
  ls_sflight-connid = '407'.
  ls_sflight-fldate = lv_date.
  ls_sflight-price = '100000'.
  ls_sflight-currency = 'JPY'.
  ls_sflight-planetype = 'DC-10-10'.
  ls_sflight-seatsmax = 380.
  ls_sflight-seatsocc = 0.
  APPEND ls_sflight TO lt_sflight.

  lv_date = lv_date + 1.
ENDDO.

WRITE: 'Task 1: Standard internal table'.
WRITE: / 'CARRID',8 'CONNID', 15 'FLDATE', 30 'PRICE', 46 'CURRENCY', 55 'PLANETYPE', 65 'SEATSMAX'.
LOOP AT lt_sflight INTO ls_sflight.
  WRITE: / ls_sflight-carrid, 8 ls_sflight-connid, 15 ls_sflight-fldate,
           25 ls_sflight-price, 46 ls_sflight-currency, 55 ls_sflight-planetype, 65 ls_sflight-seatsmax.
ENDLOOP.
ULINE.

" 12.2
WRITE: 'Task 2: From 1st aug 2020, change data of Japan Airlines'.
WRITE: / 'CARRID',8 'CONNID', 15 'FLDATE', 30 'PRICE', 46 'CURRENCY', 55 'PLANETYPE', 65 'SEATSMAX'.
LOOP AT lt_sflight INTO ls_sflight WHERE fldate >= '20200801'.
  ls_sflight-price = '150000'.
  ls_sflight-seatsmax = 300.
  MODIFY lt_sflight FROM ls_sflight.

  WRITE: / ls_sflight-carrid, 8 ls_sflight-connid, 15 ls_sflight-fldate,
           25 ls_sflight-price, 46 ls_sflight-currency, 55 ls_sflight-planetype, 65 ls_sflight-seatsmax.
ENDLOOP.
ULINE.

" 12.3
LOOP AT lt_sflight INTO ls_sflight WHERE fldate >= '20200801' AND fldate <= '20200831'.
  ls_sbook-carrid = ls_sflight-carrid.
  ls_sbook-connid = ls_sflight-connid.
  ls_sbook-fldate = ls_sflight-fldate.
  ls_sbook-class = ls_sflight-planetype.
  ls_sbook-luggweight = ls_sflight-seatsmax.
  APPEND ls_sbook TO lt_sbook.
ENDLOOP.

WRITE: 'Task 3: Standard internal table with line type is SBOOK'.
LOOP AT lt_sbook INTO ls_sbook.
  WRITE: / ls_sbook-carrid, ls_sbook-connid, ls_sbook-fldate, ls_sbook-class, ls_sbook-luggweight.
ENDLOOP.