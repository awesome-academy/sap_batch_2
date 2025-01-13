*&---------------------------------------------------------------------*
*& Report ZPG_OOP2_PY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_oop2_py.

* Define the main class
CLASS lcl_flight_report DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_airline_code TYPE sflight-carrid
                            it_connid_rng   TYPE ztt_flconn_range_py,
      run.
  PRIVATE SECTION.
    DATA: mv_airline_code TYPE sflight-carrid,
          mt_connid_rng   TYPE ztt_flconn_range_py,
          mt_flight_data  TYPE ztt_flight_py,
          mv_total_price  TYPE sflight-price.

    METHODS:
      validate_airline_code,
      fetch_flight_data,
      display_flight_report.
ENDCLASS.

* Implement the main class
CLASS lcl_flight_report IMPLEMENTATION.
  METHOD constructor.
    mv_airline_code = iv_airline_code.
    mt_connid_rng = it_connid_rng.
  ENDMETHOD.

  METHOD validate_airline_code.
    SELECT SINGLE carrid FROM zyairl3t WHERE carrid = @mv_airline_code INTO @DATA(lv_airline).
    IF lv_airline IS INITIAL.
      MESSAGE 'Airline Code is not exists. Please input again.'(001) TYPE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD fetch_flight_data.
    SELECT sflight~carrid,
           sflight~connid,
           sflight~fldate,
           sflight~price,
           sflight~currency,
           sflight~seatsmax,
           sflight~seatsocc,
           sflight~seatsmax_b,
           sflight~seatsocc_b,
           sflight~seatsmax_f,
           sflight~seatsocc_f,
           scarr~carrname
      FROM zyfl3t AS sflight
      JOIN scarr ON scarr~carrid = sflight~carrid
      WHERE sflight~carrid = @mv_airline_code AND sflight~connid IN @mt_connid_rng
      INTO CORRESPONDING FIELDS OF TABLE @mt_flight_data.

    IF mt_flight_data IS INITIAL.
      MESSAGE e001(zmsg_error_py) WITH 'Flight'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.

  METHOD display_flight_report.
    WRITE: 'Airline Code', 15 'Airline name', 30 'Flight Number', 46 'Flight date', 58 'Price', 82 'Eco Vacant', 94 'Business Vacant', 111 'First Vacant'.
    SKIP 1.
    ULINE 1.

    LOOP AT mt_flight_data INTO DATA(ls_flight) GROUP BY ( carrid = ls_flight-carrid connid = ls_flight-connid ).
      CLEAR mv_total_price.
      LOOP AT GROUP ls_flight INTO DATA(ls_item).
        DATA(lv_vs_eco) = ls_item-seatsmax - ls_item-seatsocc.
        DATA(lv_vs_busi) = ls_item-seatsmax_b - ls_item-seatsocc_b.
        DATA(lv_vs_first) = ls_item-seatsmax_f - ls_item-seatsocc_f.
        mv_total_price = mv_total_price + ls_item-price.
        WRITE: / ls_item-carrid, 15 ls_item-carrname, 30 ls_item-connid, 46 ls_item-fldate, 58 ls_item-price CURRENCY ls_item-currency, 82 lv_vs_eco, 94 lv_vs_busi, 111 lv_vs_first.
      ENDLOOP.
      WRITE: / 'Total price: ', mv_total_price CURRENCY ls_item-currency.
      SKIP 1.
      ULINE 1.
    ENDLOOP.
  ENDMETHOD.

  METHOD run.
    validate_airline_code( ).
    fetch_flight_data( ).
    display_flight_report( ).
  ENDMETHOD.
ENDCLASS.

TABLES: sflight.

* Selection screen definition
PARAMETERS: p_air TYPE sflight-carrid OBLIGATORY.
SELECT-OPTIONS: s_conn FOR sflight-connid NO-EXTENSION.

* Start of the program
START-OF-SELECTION.
  DATA: lo_flight_report TYPE REF TO lcl_flight_report.

  CREATE OBJECT lo_flight_report
    EXPORTING
      iv_airline_code = p_air
      it_connid_rng   = s_conn[].

  lo_flight_report->run( ).
