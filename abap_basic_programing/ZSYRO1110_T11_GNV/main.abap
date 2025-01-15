*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T11_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T11_GNV.


TYPES: BEGIN OF ty_sflight,
         carrid      TYPE sflight-carrid,
         connid      TYPE sflight-connid,
         fldate      TYPE sflight-fldate,
         price       TYPE sflight-price,
         currency    TYPE sflight-currency,
         planetype   TYPE sflight-planetype,
         seatsmax    TYPE sflight-seatsmax,
         seatsocc    TYPE sflight-seatsocc,
         paymentsum  TYPE sflight-paymentsum,  "This is typically CURR13
       END OF ty_sflight.

* Data declarations
DATA: gt_flight_std   TYPE STANDARD TABLE OF ty_sflight,
      gt_flight_sort  TYPE SORTED TABLE OF ty_sflight
                      WITH UNIQUE KEY carrid connid fldate,
      gt_flight_hash  TYPE HASHED TABLE OF ty_sflight
                      WITH UNIQUE KEY carrid connid fldate,
      gs_flight      TYPE ty_sflight,
      lv_lines       TYPE i.

START-OF-SELECTION.
  "Fill data exactly as shown in the image
  CLEAR gs_flight.
  gs_flight-carrid = 'AA'.     gs_flight-connid = '0017'.
  gs_flight-fldate = '20130525'. gs_flight-price = '0.00'.
  gs_flight-currency = 'USD'.    gs_flight-planetype = '146-300'.
  gs_flight-seatsmax = '30'.     gs_flight-seatsocc = '30'.
  gs_flight-paymentsum = '0.00'.
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'AA'.     gs_flight-connid = '0017'.
  gs_flight-fldate = '20130626'. gs_flight-price = '422.94'.
  gs_flight-currency = 'USD'.    gs_flight-planetype = '747-400'.
  gs_flight-seatsmax = '385'.    gs_flight-seatsocc = '250'.
  gs_flight-paymentsum = '195174.31'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'AA'.     gs_flight-connid = '0017'.
  gs_flight-fldate = '20130724'. gs_flight-price = '422.94'.
  gs_flight-currency = 'USD'.    gs_flight-planetype = '747-400'.
  gs_flight-seatsmax = '385'.    gs_flight-seatsocc = '100'.
  gs_flight-paymentsum = '159143.24'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'AA'.     gs_flight-connid = '0017'.
  gs_flight-fldate = '20130821'. gs_flight-price = '0.00'.
  gs_flight-currency = 'USD'.    gs_flight-planetype = '146-200'.
  gs_flight-seatsmax = '112'.    gs_flight-seatsocc = '80'.
  gs_flight-paymentsum = '0.00'.
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'JL'.     gs_flight-connid = '0407'.
  gs_flight-fldate = '20140502'. gs_flight-price = '106.136'.
  gs_flight-currency = 'JPY'.    gs_flight-planetype = 'DC-10-10'.
  gs_flight-seatsmax = '380'.    gs_flight-seatsocc = '4'.
  gs_flight-paymentsum = '10393893'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'JL'.     gs_flight-connid = '0407'.
  gs_flight-fldate = '20140530'. gs_flight-price = '106.136'.
  gs_flight-currency = 'JPY'.    gs_flight-planetype = 'DC-10-10'.
  gs_flight-seatsmax = '380'.    gs_flight-seatsocc = '4'.
  gs_flight-paymentsum = '20668'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'JL'.     gs_flight-connid = '0408'.
  gs_flight-fldate = '20130505'. gs_flight-price = '106.136'.
  gs_flight-currency = 'JPY'.    gs_flight-planetype = '747-400'.
  gs_flight-seatsmax = '385'.    gs_flight-seatsocc = '4'.
  gs_flight-paymentsum = '47964956'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'UA'.     gs_flight-connid = '0941'.
  gs_flight-fldate = '20130627'. gs_flight-price = '879.82'.
  gs_flight-currency = 'USD'.    gs_flight-planetype = 'A319'.
  gs_flight-seatsmax = '220'.    gs_flight-seatsocc = '4'.
  gs_flight-paymentsum = '225128.76'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.

  CLEAR gs_flight.
  gs_flight-carrid = 'UA'.     gs_flight-connid = '3517'.
  gs_flight-fldate = '20140526'. gs_flight-price = '611.01'.
  gs_flight-currency = 'USD'.    gs_flight-planetype = '747-400'.
  gs_flight-seatsmax = '385'.    gs_flight-seatsocc = '4'.
  gs_flight-paymentsum = '18513.63'.  "Removed comma
  APPEND gs_flight TO gt_flight_std.
*----------------------------------------------------------------------*
* Exercise 2: Sort and display
*----------------------------------------------------------------------*
  SORT gt_flight_std BY carrid connid ASCENDING
                        fldate DESCENDING.

  WRITE: / 'Sorted Results:'.
  ULINE.
  WRITE: /3 'CARRID', 10 'CONNID', 20 'FLDATE', 35 'PRICE',
         45 'CURR', 55 'PLANETYPE', 70 'SMAX', 80 'SOCC', 90 'PAYMENTSUM'.
  ULINE.

  LOOP AT gt_flight_std INTO gs_flight.
    WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate DD/MM/YYYY,
             gs_flight-price,
             gs_flight-currency,
             gs_flight-planetype,
             gs_flight-seatsmax,
             gs_flight-seatsocc,
             gs_flight-paymentsum.
  ENDLOOP.

*----------------------------------------------------------------------*
* Exercise 3: Delete JL records before 30/05/2014
*----------------------------------------------------------------------*
  SKIP 2.
  WRITE: / 'After deletion of JL records before 30/05/2014:'.
  ULINE.

  DELETE gt_flight_std WHERE carrid = 'JL'
                        AND fldate < '20140530'.

  LOOP AT gt_flight_std INTO gs_flight.
    WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate DD/MM/YYYY,
             gs_flight-price,
             gs_flight-currency,
             gs_flight-planetype,
             gs_flight-seatsmax,
             gs_flight-seatsocc,
             gs_flight-paymentsum.
  ENDLOOP.

*----------------------------------------------------------------------*
* Exercise 4: Read index 7
*----------------------------------------------------------------------*
  SKIP 2.
  WRITE: / 'Record at index 7:'.
  ULINE.

  READ TABLE gt_flight_std INDEX 7 INTO gs_flight.
  IF sy-subrc = 0.
    WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate DD/MM/YYYY,
             gs_flight-price,
             gs_flight-currency,
             gs_flight-planetype,
             gs_flight-seatsmax,
             gs_flight-seatsocc,
             gs_flight-paymentsum.
  ELSE.
    WRITE: / 'No record found at index 7'.
  ENDIF.

*----------------------------------------------------------------------*
* Exercise 5 & 6: Sorted table and key search
*----------------------------------------------------------------------*
  "Fill sorted table
  gt_flight_sort = gt_flight_std.

  SKIP 2.
  WRITE: / 'Records for AA-17:'.
  ULINE.

  READ TABLE gt_flight_sort WITH KEY carrid = 'AA'
                                    connid = '0017'
                                    INTO gs_flight.
  IF sy-subrc = 0.
    WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate DD/MM/YYYY,
             gs_flight-price,
             gs_flight-currency,
             gs_flight-planetype,
             gs_flight-seatsmax,
             gs_flight-seatsocc,
             gs_flight-paymentsum.
  ELSE.
    MESSAGE 'No records found for AA-17' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

*----------------------------------------------------------------------*
* Exercise 7 & 8: Hash table and count UA flights in 2014
*----------------------------------------------------------------------*
  "Fill hash table
  gt_flight_hash = gt_flight_std.

  SKIP 2.
  WRITE: / 'Count of UA flights in 2014:'.
  ULINE.

  lv_lines = LINES( gt_flight_hash ).

  LOOP AT gt_flight_hash INTO gs_flight WHERE carrid = 'UA'
                                         AND fldate >= '20140101'
                                         AND fldate <= '20141231'.
    ADD 1 TO lv_lines.
  ENDLOOP.

  WRITE: / lv_lines, 'record(s) found'.
