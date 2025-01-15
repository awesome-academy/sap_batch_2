*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T12_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T12_GNV.

* Data declarations
DATA: gt_sflight TYPE STANDARD TABLE OF sflight,
      gt_sbook   TYPE STANDARD TABLE OF sbook,
      gs_sflight TYPE sflight,
      gs_sbook   TYPE sbook.

*----------------------------------------------------------------------*
* Fill SFLIGHT data and modify August entries
*----------------------------------------------------------------------*
START-OF-SELECTION.
  " First, fill the initial SFLIGHT data
  CLEAR gs_sflight.
  gs_sflight-carrid    = 'JL'.
  gs_sflight-connid    = '407'.
  gs_sflight-planetype = 'DC-10-10'.
  gs_sflight-seatsmax  = '380'.
  gs_sflight-currency  = 'JPY'.
  gs_sflight-price     = '100000'.

  " Create entries for each date (20 July to 08 August)
  DO 20 TIMES.
    gs_sflight-fldate = '20200720'.  " Start date
    gs_sflight-fldate = gs_sflight-fldate + sy-index - 1.

    " For August entries, update price and seatsmax
    IF gs_sflight-fldate+4(2) = '08'.
      gs_sflight-price = '150000'.
      gs_sflight-seatsmax = '300'.
    ENDIF.

    APPEND gs_sflight TO gt_sflight.
  ENDDO.

  " Display SFLIGHT data
  WRITE: / 'SFLIGHT Data:'.
  ULINE.
  FORMAT COLOR COL_HEADING.
  WRITE: /3 'CARRID', 10 'CONNID', 20 'FLDATE', 35 'PRICE',
         45 'CURR', 55 'PLANETYPE', 70 'SEATSMAX'.
  FORMAT COLOR OFF.
  ULINE.

  LOOP AT gt_sflight INTO gs_sflight.
    WRITE: / gs_sflight-carrid,
             gs_sflight-connid,
             gs_sflight-fldate DD/MM/YYYY,
             gs_sflight-price,
             gs_sflight-currency,
             gs_sflight-planetype,
             gs_sflight-seatsmax.
  ENDLOOP.

*----------------------------------------------------------------------*
* Create SBOOK entries for August flights
*----------------------------------------------------------------------*
  SKIP 2.
  WRITE: / 'SBOOK Data for August Flights:'.
  ULINE.
  FORMAT COLOR COL_HEADING.
  WRITE: /3 'CARRID', 10 'CONNID', 20 'FLDATE', 35 'BOOKID',
         45 'CUSTOMID', 60 'CLASS', 70 'LUGGWEIGHT'.
  FORMAT COLOR OFF.
  ULINE.

  " Create SBOOK entries only for August flights
  LOOP AT gt_sflight INTO gs_sflight WHERE fldate+4(2) = '08'.
    CLEAR gs_sbook.
    " Move matching fields from SFLIGHT to SBOOK
    MOVE-CORRESPONDING gs_sflight TO gs_sbook.

    " Fill SBOOK-specific fields
    gs_sbook-bookid     = sy-tabix.           " Generate booking ID
    gs_sbook-customid   = 'CUST00' && sy-tabix. " Generate customer ID
    gs_sbook-class      = 'Y'.                " Economy class
    gs_sbook-luggweight = 20.                 " Sample luggage weight

    APPEND gs_sbook TO gt_sbook.

    WRITE: / gs_sbook-carrid,
             gs_sbook-connid,
             gs_sbook-fldate DD/MM/YYYY,
             gs_sbook-bookid LEFT-JUSTIFIED,
             gs_sbook-customid,
             gs_sbook-class,
             gs_sbook-luggweight.
  ENDLOOP.